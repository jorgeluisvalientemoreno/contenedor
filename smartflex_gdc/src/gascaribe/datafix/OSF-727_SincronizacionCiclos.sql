column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Girón
EMPRESA:        MVM Ingeniería de Software
FECHA:          Noviembre 2022
JIRA:           OSF-727

Sincronización de ciclos a servicios suscritos

    
    Archivo de entrada 
    ===================
    NA            
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    
    29/11/2022 - jcatuchemvm
    Creación
    
***********************************************************/
declare
    --Constantes para el datafix
    cnususccodi     constant suscripc.susccodi%type     := 1069203;
    
    --Cursor para extracción de data
    cursor cudata is 
    select susccodi,
    (select ciclcodi||'-'||cicldesc from ciclo where ciclcodi = susccicl) susccicl,susccicl ciclcodi,
    sesunuse,
    (select servcodi||'-'||servdesc from servicio where servcodi = sesuserv) sesuserv,
    LDC_dsServsusc.fsbGetEscoDesc(sesunuse,1) sesuesco,
    (select ciclcodi||'-'||cicldesc from ciclo where ciclcodi = sesucicl) sesucicl,
    (select cicocodi||'-'||cicodesc from ciclcons where cicocodi = sesucico) sesucico,sesucico cicocodi
    from suscripc,servsusc
    where susccodi = cnususccodi
    and sesususc = susccodi;
    
    
    
    s_out       varchar2(2000);
    dtfecha     date;
    nuok        number;
    nuerr       number;
    sberror     varchar2(2000);
    nuerror     number;
    sbcabecera  varchar2(2000);
    sbActualiza varchar2(2000);
    sbcicl      ciclo.cicldesc%type;
    sbcico      ciclcons.cicodesc%type;
    nucico      ciclcons.cicocodi%type;
    
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
    
    sbcabecera := 'Contrato|Susccicl|Sesunuse|Sesuserv|Sesuesco|Sesucicl_ant|Sesucico_ant|Sesucicl_act|Sesucico_act|Actualiza';
    dbms_output.put_line('OSF-727: Sincronización ciclo productos');
    dbms_output.put_line('=======================================================');
    dbms_output.put_line(sbcabecera);
    
    for rcdata in cudata loop
    
        sbActualiza := 'N';
            
        if rcdata.susccicl != rcdata.sesucicl then
            
            begin
        
                nucico := Pktblciclo.Fnugetciclcico(rcdata.ciclcodi);
                pkBCServsusc.UPDINDSERVNUMBERCYCLES(rcdata.sesunuse,rcdata.ciclcodi,nucico);
                
                commit;
                
                select  
                (select ciclcodi||'-'||cicldesc from ciclo where ciclcodi = sesucicl),
                (select cicocodi||'-'||cicodesc from ciclcons where cicocodi = sesucico) into sbcicl,sbcico
                from servsusc where sesunuse = rcdata.sesunuse;
                
                if rcdata.susccicl = sbcicl and rcdata.susccicl = sbcico then
                    sbActualiza := 'S';
                    nuok := nuok + 1;
                end if;
            
            exception 
                when others then
                    nuerr := nuerr + 1;
                    sbActualiza := 'Error sincronizacion ciclo '||sqlerrm;
                    sbcicl := rcdata.sesucicl;
                    sbcico := rcdata.sesucico;
                    rollback;
            end;
            
        else
            sbActualiza := 'Ya sincronizado';
            sbcicl := rcdata.sesucicl;
            sbcico := rcdata.sesucico;
        end if; 
        
        s_out := rcdata.susccodi;
        s_out := s_out||'|'||rcdata.susccicl;
        s_out := s_out||'|'||rcdata.sesunuse;
        s_out := s_out||'|'||rcdata.sesuserv;
        s_out := s_out||'|'||rcdata.sesuesco;
        s_out := s_out||'|'||rcdata.sesucicl;
        s_out := s_out||'|'||rcdata.sesucico;
        s_out := s_out||'|'||sbcicl;
        s_out := s_out||'|'||sbcico;
        s_out := s_out||'|'||sbActualiza;
        
        dbms_output.put_line(s_out);
        
    end loop;
    
    dbms_output.put_line('=====================================================');
    dbms_output.put_line('Fin Sincronziacion ciclos');
    dbms_output.put_line('Cantidad Registros Actualizados: '||nuok);
    dbms_output.put_line('Cantidad Registros con Error: '||nuerr);
    dbms_output.put_line('Tiempo Total: '||fnc_rs_CalculaTiempo(dtfecha,sysdate));
    
exception
    when others then
        sberror := sqlerrm;
        nuerror := sqlcode;
        
        dbms_output.put_line('=====================================================');
        dbms_output.put_line('Fin Sincronizacion ciclos error ['||nuerror||'-'||sberror||']');
        dbms_output.put_line('Cantidad Registros Borrados: '||nuok);
        dbms_output.put_line('Cantidad Registros con Error: '||nuerr);
        dbms_output.put_line('Tiempo Total: '||fnc_rs_CalculaTiempo(dtfecha,sysdate));
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/