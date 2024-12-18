column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Girón
EMPRESA:        MVM Ingeniería de Software
FECHA:          Junio 2023
JIRA:           OSF-1231

Sincronización de ciclos, primero a contrato  y luego a servicios suscritos
Borrado de cargos -1, ajuste consumos y lecturas

    
    Archivo de entrada 
    ===================
    NA            
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    
    20/06/2023 - jcatuchemvm
    Creación
    
***********************************************************/
declare
    --Constantes para el datafix
    csbCaso         constant varchar2(20)               := 'OSF1231';
    cnususccicl     constant suscripc.susccicl%type     := 1801;
    csbformato      constant varchar2(25)               := 'dd/mm/yyyy hh24:mi:ss';
    
    --Cursores para extracción de data
    cursor cudata is 
    select  /*+ index (s IX_SERVSUSC30) use_nl (s e c) index ( e IX_CONFESCO01) index ( c pk_suscripc ) */ susccodi,
    (select ciclcodi||'-'||cicldesc from ciclo where ciclcodi = susccicl) susccicl,susccicl ciclcodi,
    sesunuse,
    (select servcodi||'-'||servdesc from servicio where servcodi = sesuserv) sesuserv,
    (select escocodi||'-'||escodesc from estacort where escocodi = sesuesco) sesuesco,
    (select ciclcodi||'-'||cicldesc from ciclo where ciclcodi = sesucicl) sesucicl,sesucicl nucicl,
    (select cicocodi||'-'||cicodesc from ciclcons where cicocodi = sesucico) sesucico,sesucico cicocodi,suscnupr,
    (
      select count(*)  from cargos where cargnuse = s.sesunuse and cargcuco = -1
    ) cargos_1
    from servsusc s,confesco e,suscripc c
    where sesuserv = 7014
    and coecserv = sesuserv
    and coeccodi = sesuesco
    and coecfact = 'S'
    and sesususc = susccodi
    and sesucicl != susccicl
    --validación John Bayuelo, se descartan categorias industriales
    and (sesucicl != 9999 and susccicl != 9999)
    and sesucate != 3
    --order by sesususc
    ;
    
      
    cursor cuservn_fact is
    select /*+ index ( e pk_confesco) */
    susccodi,sesunuse,sesuserv,sesuesco,coecfact,suscnupr,sesucico,susccicl,sesucicl,
    nvl((
      select /*+ index ( a IX_SERVSUSC12 ) use_nl (a d) index ( d IX_CONFESCO01) */ unique first_value (a.sesucicl) over (order by sesunuse desc) 
      from servsusc a, confesco d
      where coecserv = a.sesuserv 
      and coeccodi = a.sesuesco 
      and coecfact = 'S' 
      and a.sesuserv = 7014 
      and a.sesususc = c.susccodi 
    ),c.susccicl) sesucicl_7014,
    (
      select count(*)  from cargos where cargnuse = s.sesunuse and cargcuco = -1
      and cargfecr > add_months(sysdate,-2)
    ) cargos_1
    from servsusc s,confesco e, suscripc c
    where 1 = 1
    and 
    (
      sesuserv != 7014 or 
      (sesuserv = 7014 and coecfact = 'N')
    )
    and coecserv = sesuserv
    and coeccodi = sesuesco
    and sesucicl != susccicl
    and sesususc = susccodi
    and susccodi > 0
    --validación John Bayuelo, se descartan categorias industriales
    and (sesucicl != 9999 and susccicl != 9999)
    and sesucate != 3
    and 
    nvl((
      select sesucate
      from servsusc a, confesco d
      where coecserv = a.sesuserv 
      and coeccodi = a.sesuesco 
      and coecfact = 'S' 
      and a.sesuserv = 7014 
      and a.sesususc = c.susccodi 
      and a.sesucate = 3
      and rownum = 1
    ),-1) = -1
    --order by susccodi
    ;
    
    cursor cucico is
    select sesunuse,sesususc,sesuserv,sesuesco,coecfact,sesucicl,sesucico
    from servsusc,confesco
    where sesucicl != sesucico
    and coecserv = sesuserv
    and coeccodi = sesuesco
    --validación John Bayuelo
    and (sesucicl != 9999 and sesucico != 9999)
    ;
    
    type tytbConts is table of suscripc.susccicl%type index by binary_integer;
    tbConts     tytbConts;      
    
    type tytbProds is table of servsusc.sesucicl%type index by binary_integer;
    tbProds     tytbProds;  
    
    s_out       varchar2(2000);
    dtfecha     date;
    nurowcount  number;
    nuok        number;
    nucont      number;
    nuerr       number;
    sberror     varchar2(2000);
    nuerror     number;
    sbcabecera  varchar2(2000);
    sbActualiza varchar2(2000);
    sbActualizaC varchar2(2000);
    sbcicl      varchar2(100); --ciclo.cicldesc%type;
    sbcico      varchar2(100); --ciclcons.cicodesc%type;
    sbcict      varchar2(100); --ciclo.cicldesc%type;
    nucico      ciclcons.cicocodi%type;
    nucicl      ciclo.ciclcodi%type;
    nucico2     ciclcons.cicocodi%type;
    nucicl2     ciclo.ciclcodi%type;
    nuupdcico   number;
    nuupdclnf   number;
    nupefa      number;
    nupecs      number;
    
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
    pkg_error.setapplication(csbCaso);
    dbms_output.put_line(csbCaso||': Sincronización ciclo contratos, productos y ciclos de consumo');
    
    dtfecha := sysdate;
    nuok := 0;
    nuerr := 0;
    nucont := 0;
    nuupdcico := 0;
    nuupdclnf := 0;
    
    --Inicialización para actualización
    tbConts(6228237) := 8214;
    tbProds(7059030) := 1507;
    tbProds(50075446) := 308;
    tbProds(51667450) := 8314;
    
    sbcabecera := 'Contrato|Sesunuse|Sesuserv|Sesuesco|Suscnupr|Cargos_1|Susccicl_ant|Sesucicl_ant|Sesucico_ant|Susccicl_act|Sesucicl_act|Sesucico_act|ActualizaCont|ActualizaServ';    
    dbms_output.put_line('=========================Actualización ciclo contrato producto gas ==============================');
    dbms_output.put_line(sbcabecera);
    
    for rcdata in cudata loop
      if rcdata.suscnupr > 0 or rcdata.cargos_1 > 0 then
        sbActualiza := 'Contrato en facturación o con cargos -1 ['||rcdata.suscnupr||']['||rcdata.cargos_1||']';
        sbActualizaC := 'N';
        sbcict := rcdata.susccicl;
        sbcicl := rcdata.sesucicl;
        sbcico := rcdata.sesucico;
      else
        sbActualizaC := 'N';
        if tbConts.exists(rcdata.susccodi) and rcdata.ciclcodi != tbConts(rcdata.susccodi) then
          begin
            pktblSuscripc.UPCYCLE(rcdata.susccodi,tbConts(rcdata.susccodi));
            commit;
            
            select  
            (select ciclcodi||'-'||cicldesc from ciclo where ciclcodi = susccicl), susccicl into sbcict,nucicl
            from suscripc where susccodi = rcdata.susccodi;
            
            if nucicl = tbConts(rcdata.susccodi) then
                sbActualizaC := 'S';
                nucont := nucont + 1;
            else
              sbcict := rcdata.susccicl;
              nucicl := rcdata.ciclcodi;
            end if;
          exception
            when login_denied then
              pkg_error.getError(nuerror,sberror);
              sbActualizaC := 'Error sincronizacion ciclo a contrato '||sberror;
              nuerr := nuerr + 1;
              sbcict := rcdata.susccicl;
              nucicl := rcdata.ciclcodi;
              rollback;
            when others then
              sbActualizaC := 'Error sincronizacion ciclo a contrato '||sqlerrm;
              nuerr := nuerr + 1;
              sbcict := rcdata.susccicl;
              nucicl := rcdata.ciclcodi;
              rollback;
          end;  
        else
            sbActualizaC := 'Ya sincronizado';
            sbcict := rcdata.susccicl;
            nucicl := rcdata.ciclcodi;
        end if;

        sbActualiza := 'N';            
        if rcdata.nucicl != nucicl then
            
          begin
    
            nucico := Pktblciclo.Fnugetciclcico(nucicl);
            pkBCServsusc.UPDINDSERVNUMBERCYCLES(rcdata.sesunuse,nucicl,nucico);
            
            commit;
            
            select  
            (select ciclcodi||'-'||cicldesc from ciclo where ciclcodi = sesucicl), sesucicl,
            (select cicocodi||'-'||cicodesc from ciclcons where cicocodi = sesucico), sesucico into sbcicl,nucicl2,sbcico,nucico2
            from servsusc where sesunuse = rcdata.sesunuse;
            
            if nucicl = nucicl2 and nucico = nucico2 then
              sbActualiza := 'S';
              nuok := nuok + 1;
            else
              sbcicl := rcdata.sesucicl;
              sbcico := rcdata.sesucico;
            end if;
          
          exception 
            when login_denied then
              pkg_error.getError(nuerror,sberror);
              sbActualiza := 'Error sincronizacion ciclo a producto '||sberror;
              nuerr := nuerr + 1;
              sbcicl := rcdata.sesucicl;
              sbcico := rcdata.sesucico;
              rollback;
            when others then
              sbActualiza := 'Error sincronizacion ciclo a producto'||sqlerrm;
              nuerr := nuerr + 1;
              sbcicl := rcdata.sesucicl;
              sbcico := rcdata.sesucico;
              rollback;
          end;
            
        else
            sbActualiza := 'Ya sincronizado';
            sbcicl := rcdata.sesucicl;
            sbcico := rcdata.sesucico;
        end if; 

      end if;
      
      s_out := rcdata.susccodi;
      s_out := s_out||'|'||rcdata.sesunuse;
      s_out := s_out||'|'||rcdata.sesuserv;
      s_out := s_out||'|'||rcdata.sesuesco;
      s_out := s_out||'|'||rcdata.suscnupr;
      s_out := s_out||'|'||rcdata.cargos_1;
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
    
    sbcabecera :=  'Susccodi|Sesunuse|Sesuserv|Sesuesco|Coecfact|Suscnupr|Cargos_1|Sesucico|Susccicl|Sesucicl_ant|Sesucicl_act|Actualiza';
    dbms_output.put_line('======================== Actualización ciclo facturación serv no facturables o no gas ===============================');
    dbms_output.put_line(sbcabecera);
    
    for rcdata in cuservn_fact loop
      begin
        sbActualiza := 'N';
        
        if rcdata.suscnupr > 0 then
          sbActualiza := 'Contrato en facturación o con cargos -1 ['||rcdata.suscnupr||']['||rcdata.cargos_1||']';
          nuerr := nuerr + 1;
          nucicl := rcdata.sesucicl;
        else
          nucicl := rcdata.sesucicl_7014;
          pktblservsusc.Updsesucicl(rcdata.sesunuse,nucicl);
          commit;
          sbActualiza := 'S';
          nuupdclnf := nuupdclnf + 1;
          
        end if;  
        
      exception
        when login_denied then
          pkg_error.getError(nuerror,sberror);
          sbActualiza := 'Error sincronizacion ciclo no facturables '||sberror;
          nuerr := nuerr + 1;
          nucicl := rcdata.sesucicl;
          rollback;
        when others then
          sbActualiza := 'Error sincronizacion ciclo no facturables '||sqlerrm;
          nuerr := nuerr + 1;
          nucicl := rcdata.sesucicl;
          rollback;
      end;
      
      s_out := rcdata.susccodi;
      s_out := s_out||'|'||rcdata.sesunuse;
      s_out := s_out||'|'||rcdata.sesuserv;
      s_out := s_out||'|'||rcdata.sesuesco;
      s_out := s_out||'|'||rcdata.coecfact;
      s_out := s_out||'|'||rcdata.suscnupr;
      s_out := s_out||'|'||rcdata.cargos_1;
      s_out := s_out||'|'||rcdata.sesucico;
      s_out := s_out||'|'||rcdata.susccicl;
      s_out := s_out||'|'||rcdata.sesucicl;
      s_out := s_out||'|'||nucicl;
      s_out := s_out||'|'||sbActualiza;
      
      dbms_output.put_line(s_out);  
    end loop;
    
    sbcabecera :=  'Sesunuse|Sesususc|Sesuserv|Sesuserv|Sesuesco|Coecfact|Sesucicl|Sesucico_ant|Sesucico_act|Actualiza';
    dbms_output.put_line('======================== Actualización ciclo consumo ===============================');
    dbms_output.put_line(sbcabecera);
    
    for rcdata in cucico loop
      begin
        sbActualiza := 'N';
        nucico := Pktblciclo.Fnugetciclcico(rcdata.sesucicl);
        pktblservsusc.Updsesucico(rcdata.sesunuse,nucico);
        
        commit;
        
        sbActualiza := 'S';
        nuupdcico := nuupdcico + 1;

      
      exception 
        when login_denied then
          pkg_error.getError(nuerror,sberror);
          sbActualiza := 'Error sincronizacion cico '||sberror;
          nuerr := nuerr + 1;
          nucico := rcdata.sesucico;
          rollback;
        when others then
          sbActualiza := 'Error sincronizacion cico '||sqlerrm;
          nuerr := nuerr + 1;
          nucico := rcdata.sesucico;
          rollback;
      end;
      
      s_out := rcdata.sesunuse;
      s_out := s_out||'|'||rcdata.sesususc;
      s_out := s_out||'|'||rcdata.sesuserv;
      s_out := s_out||'|'||rcdata.sesuesco;
      s_out := s_out||'|'||rcdata.coecfact;
      s_out := s_out||'|'||rcdata.sesucicl;
      s_out := s_out||'|'||rcdata.sesucico;
      s_out := s_out||'|'||nucico;
      s_out := s_out||'|'||sbActualiza;
      
      dbms_output.put_line(s_out);      
      
    end loop;

    dbms_output.put_line('=====================================================');
    dbms_output.put_line('Fin Sincronziacion ciclos');
    dbms_output.put_line('Cantidad Contratos Actualizados: '||nucont);
    dbms_output.put_line('Cantidad Productos Actualizados: '||nuok);
    dbms_output.put_line('Cantidad Ciclos Actualizados Nfact-Ngas: '||nuupdclnf);
    dbms_output.put_line('Cantidad Cicos Actualizados: '||nuupdcico);
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
      dbms_output.put_line('Cantidad Ciclos Actualizados Nfact-Ngas: '||nuupdclnf);
      dbms_output.put_line('Cantidad Cicos Actualizados: '||nuupdcico);
      dbms_output.put_line('Cantidad Registros con Error: '||nuerr);
      dbms_output.put_line('Tiempo Total: '||fnc_rs_CalculaTiempo(dtfecha,sysdate));
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/