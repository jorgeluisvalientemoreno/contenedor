column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
    cursor cudata is 
    select /*+ index ( c IX_CARGOS02 ) */ --IX_CARG_NUSE_CUCO_CONC
    cargcuco,cargnuse,cargconc,concdesc,cargsign,
    decode(cargsign,'CR',-1*cargvalo,'PA',-1*cargvalo,'AS',-1*cargvalo,cargvalo) cargvalo,cargpefa,cargdoso,cargcodo,cargtipr,cargunid,cargpeco,cargfecr,
    cargprog,proccodi,procdesc,c.rowid row_id
    from cargos c,concepto,procesos
    where 1 = 1
    and cargcuco = -1
    and cargnuse = 50972229
    and cargconc = conccodi
    and proccons = cargprog
    ;
    
    cursor cucuenta is
    select cucocodi,cucosacu,
    (
        select sum( case cargsign when 'CR' then -1*cargvalo else cargvalo end) valor
        from cargos
        where cargnuse = cuconuse 
        and cargcuco = cucocodi
    ) new_cucosacu
    from cuencobr
    where cucocodi = 3027335893;
    
    rccuenta    cucuenta%rowtype;

    nuRowcount  number;
    s_out       varchar2(2000);
    dtfecha     date;
    nuok        number;
    nucta       number;
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
    nucta := 0;
    dbms_output.put_line('Borrado de cargos duplicados ldc_mantenimiento_notas_dif');
    dbms_output.put_line('=======================================================');
    dbms_output.put_line('RowId|Producto|Cuenta|Concepto|Valor|DocSoporte|Proceso|Borrado');
    
    for rcdata in cudata loop
  
        delete cargos c 
        where c.rowid = rcdata.row_id
        and cargnuse = 50972229
        and cargcuco = -1;
        
        nuRowcount := sql%rowcount;
        
        s_out := rcdata.row_id;
        s_out := s_out||'|'||rcdata.cargnuse;
        s_out := s_out||'|'||rcdata.cargcuco;
        s_out := s_out||'|'||rcdata.cargconc||'-'||rcdata.concdesc;
        s_out := s_out||'|'||rcdata.cargvalo;
        s_out := s_out||'|'||rcdata.cargdoso;
        s_out := s_out||'|'||rcdata.proccodi||'-'||rcdata.procdesc;
        
        if nuRowcount > 0 then
            s_out := s_out||'|Borrado';
            dbms_output.put_line(s_out);  
            nuok := nuok + 1;  
        else 
            s_out := s_out||'|No Borrado';
            dbms_output.put_line(s_out);    
            nuerr := nuerr + 1; 
        end if;
        
        commit;
        
    end loop;
    
    dbms_output.put_line('------------------------');
    dbms_output.put_line('Actualizacion saldo pendiente cuenta 3027335893');
    dbms_output.put_line('=======================================================');
    dbms_output.put_line('Cuenta|saldo_ant|saldo_act|actualizado|Observacion');
    
    rccuenta := null;
    open cucuenta;
    fetch cucuenta into rccuenta;
    close cucuenta;
    
    if rccuenta.cucocodi is not null then
        if (rccuenta.cucosacu is null and rccuenta.new_cucosacu is null) or (rccuenta.cucosacu = rccuenta.new_cucosacu) then
            s_out := rccuenta.cucocodi||'|'||rccuenta.cucosacu||'|'||rccuenta.new_cucosacu||'|N|Saldo ya actualizado';
        elsif rccuenta.new_cucosacu = 0 then
            update cuencobr
            set cucosacu = null
            where cucocodi = rccuenta.cucocodi;
            
            nuRowcount := sql%rowcount;
            
            if nuRowcount > 0 then
                s_out := rccuenta.cucocodi||'|'||rccuenta.cucosacu||'||S|Saldo actualizado';
                nucta := nucta + 1;
            else
                s_out := rccuenta.cucocodi||'|'||rccuenta.cucosacu||'||N|Saldo no actualizado';
            end if;
        else 
            update cuencobr
            set cucosacu = rccuenta.new_cucosacu
            where cucocodi = rccuenta.cucocodi;
            
            nuRowcount := sql%rowcount;
            if nuRowcount > 0 then
                s_out := rccuenta.cucocodi||'|'||rccuenta.cucosacu||'|'||rccuenta.new_cucosacu||'|S|Saldo actualizado';
                nucta := nucta + 1;
            else
                s_out := rccuenta.cucocodi||'|'||rccuenta.cucosacu||'|'||rccuenta.new_cucosacu||'|N|Saldo no actualizado';
            end if;
            
        end if;        
    else 
        s_out := '|||N|Cuenta no encontrada';
        
    end if;

   commit;
   dbms_output.put_line(s_out);    

    
    dbms_output.put_line('=====================================================');
    dbms_output.put_line('Fin Borrado de cargos duplicados ldc_mantenimiento_notas_dif');
    dbms_output.put_line('Cantidad Registros Borrados: '||nuok);
    dbms_output.put_line('Cantidad Cuentas actualizadas: '||nucta);
    dbms_output.put_line('Cantidad Registros con Error: '||nuerr);
    dbms_output.put_line('Tiempo Total: '||fnc_rs_CalculaTiempo(dtfecha,sysdate));
    
exception
    when others then
        sberror := sqlerrm;
        nuerror := sqlcode;
        
        dbms_output.put_line('=====================================================');
        dbms_output.put_line('Fin Borrado de cargos duplicados con Excepcion ldc_mantenimiento_notas_dif ['||nuerror||'-'||sberror||']');
        dbms_output.put_line('Cantidad Registros Borrados: '||nuok);
        dbms_output.put_line('Cantidad Cuentas actualizadas: '||nucta);
        dbms_output.put_line('Cantidad Registros con Error: '||nuerr);
        dbms_output.put_line('Tiempo Total: '||fnc_rs_CalculaTiempo(dtfecha,sysdate));
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/