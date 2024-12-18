column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Girón
EMPRESA:        MVM Ingeniería de Software
FECHA:          Febrero 2023
JIRA:           OSF-931

Sincronización de ciclos, primero a contrato  y luego a servicios suscritos

    
    Archivo de entrada 
    ===================
    NA            
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    
    28/02/2023 - jcatuchemvm
    Creación
    
***********************************************************/
declare
    --Constantes para el datafix
    cnususccodi     constant suscripc.susccodi%type     := 1175553;
    cnususccicl     constant suscripc.susccicl%type     := 901;
    
    --Cursor para extracción de data
    cursor cudata is 
    select susccodi,
    (select ciclcodi||'-'||cicldesc from ciclo where ciclcodi = susccicl) susccicl,susccicl ciclcodi,
    sesunuse,
    (select servcodi||'-'||servdesc from servicio where servcodi = sesuserv) sesuserv,
    LDC_dsServsusc.fsbGetEscoDesc(sesunuse,1) sesuesco,
    (select ciclcodi||'-'||cicldesc from ciclo where ciclcodi = sesucicl) sesucicl,sesucicl nucicl,
    (select cicocodi||'-'||cicodesc from ciclcons where cicocodi = sesucico) sesucico,sesucico cicocodi,
    row_number() over (partition by susccodi order by sesunuse) marca
    from suscripc,servsusc
    where susccodi = cnususccodi
    and sesususc = susccodi
    order by susccodi;
    
    
    
    s_out       varchar2(2000);
    dtfecha     date;
    nuok        number;
    nucont      number;
    nuerr       number;
    sberror     varchar2(2000);
    nuerror     number;
    sbcabecera  varchar2(2000);
    sbActualiza varchar2(2000);
    sbActualizaC varchar2(2000);
    sbcicl      ciclo.cicldesc%type;
    sbcico      ciclcons.cicodesc%type;
    sbcict      ciclo.cicldesc%type;
    nucico      ciclcons.cicocodi%type;
    nucicl      ciclo.ciclcodi%type;
    
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
    nucont := 0;
    
    
    sbcabecera := 'Contrato|Sesunuse|Sesuserv|Sesuesco|Susccicl_ant|Sesucicl_ant|Sesucico_ant|Susccicl_act|Sesucicl_act|Sesucico_act|ActualizaCont|ActualizaServ';
    dbms_output.put_line('OSF-931: Sincronización ciclo contratos y productos');
    dbms_output.put_line('=======================================================');
    dbms_output.put_line(sbcabecera);
    
    for rcdata in cudata loop
    
        if rcdata.marca = 1 then
            sbActualizaC := 'N';
            if rcdata.ciclcodi != cnususccicl then
                pktblSuscripc.UPCYCLE(cnususccodi,cnususccicl);
                commit;
                
                select  
                (select ciclcodi||'-'||cicldesc from ciclo where ciclcodi = susccicl), susccicl into sbcict,nucicl
                from suscripc where susccodi = rcdata.susccodi;
                
                if nucicl = cnususccicl then
                    sbActualizaC := 'S';
                    nucont := nucont + 1;
                end if;
                
            else
                sbActualizaC := 'Ya sincronizado';
                sbcict := rcdata.susccicl;
            end if;
        end if;
    
        sbActualiza := 'N';
            
        if rcdata.nucicl != cnususccicl then
            
            begin
        
                nucico := Pktblciclo.Fnugetciclcico(cnususccicl);
                pkBCServsusc.UPDINDSERVNUMBERCYCLES(rcdata.sesunuse,cnususccicl,nucico);
                
                commit;
                
                select  
                (select ciclcodi||'-'||cicldesc from ciclo where ciclcodi = sesucicl), sesucicl,
                (select cicocodi||'-'||cicodesc from ciclcons where cicocodi = sesucico), sesucico into sbcicl,nucicl,sbcico,nucico
                from servsusc where sesunuse = rcdata.sesunuse;
                
                if nucicl = cnususccicl and nucico = cnususccicl then
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
        s_out := s_out||'|'||rcdata.sesunuse;
        s_out := s_out||'|'||rcdata.sesuserv;
        s_out := s_out||'|'||rcdata.sesuesco;
        s_out := s_out||'|'||rcdata.susccicl;
        s_out := s_out||'|'||rcdata.sesucicl;
        s_out := s_out||'|'||rcdata.sesucico;
        s_out := s_out||'|'||sbcict;
        s_out := s_out||'|'||sbcicl;
        s_out := s_out||'|'||sbcico;
        s_out := s_out||'|'||sbActualizaC;
        s_out := s_out||'|'||sbActualiza;
        
        dbms_output.put_line(s_out);
        
    end loop;
    
    dbms_output.put_line('=====================================================');
    dbms_output.put_line('Fin Sincronziacion ciclos');
    dbms_output.put_line('Cantidad Contratos Actualizados: '||nucont);
    dbms_output.put_line('Cantidad Productos Actualizados: '||nuok);
    dbms_output.put_line('Cantidad Registros con Error: '||nuerr);
    dbms_output.put_line('Tiempo Total: '||fnc_rs_CalculaTiempo(dtfecha,sysdate));
    
exception
    when others then
        sberror := sqlerrm;
        nuerror := sqlcode;
        
        dbms_output.put_line('=====================================================');
        dbms_output.put_line('Fin Sincronizacion ciclos error ['||nuerror||'-'||sberror||']');
        dbms_output.put_line('Cantidad Contratos Actualizados: '||nucont);
        dbms_output.put_line('Cantidad Productos Actualizados: '||nuok);
        dbms_output.put_line('Cantidad Registros con Error: '||nuerr);
        dbms_output.put_line('Tiempo Total: '||fnc_rs_CalculaTiempo(dtfecha,sysdate));
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/