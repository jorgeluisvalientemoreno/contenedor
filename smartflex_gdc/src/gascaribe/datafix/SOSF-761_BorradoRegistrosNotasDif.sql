column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
    cursor cudata is 
    select m.rowid row_id,m.*
    from ldc_mantenimiento_notas_dif m
    where m.rowid in 
    (
        'AEeukZAAaAANBrSAAC',
        'AEeukZAAaAANBrSAAD',
        'AEeukZAAaAANBrSAAG',
        'AEeukZAAaAANBrSAAH',
        'AEeukZAAaAANBrSAAI'
    )
    ;
    
    nuRowcount  number;
    s_out       varchar2(2000);
    dtfecha     date;
    nuok        number;
    nuerr       number;
    sberror     varchar2(2000);
    nuerror     number;
    nuIdWF      MO_WF_PACK_INTERFAC.WF_PACK_INTERFAC_ID%type;
    
    FUNCTION fnc_rs_CalculaTiempo
    (
        idtFechaIni IN DATE,
        idtFechaFin IN DATE
    )
    RETURN VARCHAR2
    IS
        nuTiempo NUMBER;
        nuHoras NUMBER;
        nuMinutos NUMBER;
        sbRetorno VARCHAR2( 100 );
    BEGIN
        -- Convierte los dias en segundos
        nuTiempo := ( idtFechaFin - idtFechaIni ) * 86400;
        -- Obtiene las horas
        nuHoras := TRUNC( nuTiempo / 3600 );
        -- Publica las horas
        sbRetorno := TO_CHAR( nuHoras ) ||'h ';
        -- Resta las horas para obtener los minutos
        nuTiempo := nuTiempo - ( nuHoras * 3600 );
        -- Obtiene los minutos
        nuMinutos := TRUNC( nuTiempo / 60 );
        -- Publica los minutos
        sbRetorno := sbRetorno ||TO_CHAR( nuMinutos ) ||'m ';
        -- Resta los minutos y obtiene los segundos redondeados a dos decimales
        nuTiempo := TRUNC( nuTiempo - ( nuMinutos * 60 ), 2 );
        -- Publica los segundos
        sbRetorno := sbRetorno ||TO_CHAR( nuTiempo ) ||'s';
        -- Retorna el tiempo
        RETURN( sbRetorno );
    EXCEPTION
        WHEN OTHERS THEN
            -- No se eleva excepcion, pues no es parte fundamental del proceso
            RETURN NULL;
    END fnc_rs_CalculaTiempo;
    
begin
    dtfecha := sysdate;
    nuok := 0;
    nuerr := 0;
    dbms_output.put_line('Borrado de cargos duplicados ldc_mantenimiento_notas_dif');
    dbms_output.put_line('=======================================================');
    dbms_output.put_line('RowId|Package|Producto|Cuenta|Concepto|DocSoporte|Cuotas|Plan|Session|Borrado');
    
    for rcdata in cudata loop
  
        delete ldc_mantenimiento_notas_dif  m 
        where m.rowid = rcdata.row_id
        and m.concepto_id = 112
        and m.package_id = 192610181;
        
        nuRowcount := sql%rowcount;
        
        s_out := rcdata.row_id;
        s_out := s_out||'|'||rcdata.package_id;
        s_out := s_out||'|'||rcdata.product_id;
        s_out := s_out||'|'||rcdata.cucocodi;
        s_out := s_out||'|'||rcdata.concepto_id;
        s_out := s_out||'|'||rcdata.docsoporte;
        s_out := s_out||'|'||rcdata.cuotas;
        s_out := s_out||'|'||rcdata.plan_dife;
        s_out := s_out||'|'||rcdata.sesion;
        
        if nuRowcount > 0 then
            s_out := s_out||'|'||'Borrado';
            dbms_output.put_line(s_out);  
            nuok := nuok + 1;  
        else 
            s_out := s_out||'|'||'No Borrado';
            dbms_output.put_line(s_out);    
            nuerr := nuerr + 1; 
        end if;
        
        commit;
        
    end loop;
    
    dbms_output.put_line('------------------------');
    dbms_output.put_line('Reenvio actividad -1975871644 - Registrar debito en diferido o corriente MANOT');
    
    begin
        select WF_PACK_INTERFAC_ID into nuIdWF
        from MO_WF_PACK_INTERFAC A, WF_INSTANCE B
        WHERE A.ACTIVITY_ID = B.INSTANCE_ID
        and b.instance_id = -1975871644
        and a.package_id = 192610181
        and a.status_activity_id = 4 ; 
            
        MO_BSAttendActivities.ManualSendByPack(nuIdWF,nuerror,sberror);
        
        if nuerror != 0 then
            dbms_output.put_line('Reenvio exitoso actividad -1975871644 - Registrar debito en diferido o corriente MANOT');
            commit;
        else
            dbms_output.put_line('Reenvio con error actividad -1975871644 - Registrar debito en diferido o corriente MANOT');
            dbms_output.put_line('Error: '||nuerror||'-'||sberror);
        end if;
    exception
        when others then
            sberror := sqlerrm;
            nuerror := sqlcode;
            dbms_output.put_line('No se realiza reenvio, no se encontró la actividad pendiente');
            dbms_output.put_line('Error: '||nuerror||'-'||sberror);
    end;
    
    dbms_output.put_line('=====================================================');
    dbms_output.put_line('Fin Borrado de cargos duplicados ldc_mantenimiento_notas_dif');
    dbms_output.put_line('Cantidad Registros Borrados: '||nuok);
    dbms_output.put_line('Cantidad Registros con Error: '||nuerr);
    dbms_output.put_line('Tiempo Total: '||fnc_rs_CalculaTiempo(dtfecha,sysdate));
    
exception
    when others then
        sberror := sqlerrm;
        nuerror := sqlcode;
        
        dbms_output.put_line('=====================================================');
        dbms_output.put_line('Fin Borrado de cargos duplicados con Excepcion ldc_mantenimiento_notas_dif ['||nuerror||'-'||sberror||']');
        dbms_output.put_line('Cantidad Registros Borrados: '||nuok);
        dbms_output.put_line('Cantidad Registros con Error: '||nuerr);
        dbms_output.put_line('Tiempo Total: '||fnc_rs_CalculaTiempo(dtfecha,sysdate));
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/