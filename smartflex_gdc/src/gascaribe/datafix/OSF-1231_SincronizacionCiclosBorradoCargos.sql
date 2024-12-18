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
    cnususccodi     constant suscripc.susccodi%type     := 67357073;
    cnusesunuse     constant servsusc.sesunuse%type     := 52534132;
    cnususccicl     constant suscripc.susccicl%type     := 1801;
    csbformato      constant varchar2(25)               := 'dd/mm/yyyy hh24:mi:ss';
    
    --Cursor para extracción de data
    cursor cudata is 
    select susccodi,
    (select ciclcodi||'-'||cicldesc from ciclo where ciclcodi = susccicl) susccicl,susccicl ciclcodi,
    sesunuse,
    (select servcodi||'-'||servdesc from servicio where servcodi = sesuserv) sesuserv,
    (select escocodi||'-'||escodesc from estacort where escocodi = sesuesco) sesuesco,
    (select ciclcodi||'-'||cicldesc from ciclo where ciclcodi = sesucicl) sesucicl,sesucicl nucicl,
    (select cicocodi||'-'||cicodesc from ciclcons where cicocodi = sesucico) sesucico,sesucico cicocodi
    from suscripc,servsusc
    where susccodi = cnususccodi
    and sesususc = susccodi
    order by susccodi;
    
    cursor cucargos is
    select c.*,rowid row_id 
    from cargos c
    where cargnuse = cnusesunuse
    and cargcuco = -1
    and cargpefa = 105165
    ;
    
    cursor cuconsumos is
    select c.*,rowid row_id  
    from conssesu c
    where cosssesu = cnusesunuse
    and cosspecs in (104879,104475)
    and cossflli = 'S'
    order by cossfere desc
    ;
            
    cursor culecturas is
    select l.*,rowid row_id  
    from lectelme l
    where leemsesu = cnusesunuse
    and leempefa in (105165,104357,105569)
    order by leemcons
    ;
    
    
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
    sbcicl      ciclo.cicldesc%type;
    sbcico      ciclcons.cicodesc%type;
    sbcict      ciclo.cicldesc%type;
    nucico      ciclcons.cicocodi%type;
    nucicl      ciclo.ciclcodi%type;
    nucargos    number;
    nuconsumos  number;
    nulecturas  number;
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
    dtfecha := sysdate;
    nuok := 0;
    nuerr := 0;
    nucont := 0;
    nucargos := 0;
    nuconsumos := 0;
    nulecturas := 0;
    
    
    sbcabecera := 'Contrato|Sesunuse|Sesuserv|Sesuesco|Susccicl_ant|Sesucicl_ant|Sesucico_ant|Susccicl_act|Sesucicl_act|Sesucico_act|ActualizaCont|ActualizaServ';
    dbms_output.put_line('OSF-1231: Sincronización ciclo contratos, productos, borrado de cargos, ajuste consumos y lecturas');
    dbms_output.put_line('=======================================================');
    dbms_output.put_line(sbcabecera);
    
    for rcdata in cudata loop
    
        
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
    
    sbcabecera :=  'Cuenta|Producto|Concepto|Signo|Valor|Causa|Cargdoso|Cargcodo|Programa|Fecha|Pefa|Peco|Borrado';
    dbms_output.put_line('======================== Borrado de cargos ===============================');
    dbms_output.put_line(sbcabecera);
    
    for rcdata in cucargos loop
        sbActualiza := 'N';
        
        delete cargos 
        where rowid = rcdata.row_id
        and cargnuse = cnusesunuse;
        
        nurowcount := sql%rowcount;  
        if nurowcount > 0 then
            sbActualiza := 'S';
            nucargos := nucargos +1;
            commit;
        end if;
        
        s_out := rcdata.cargcuco;
        s_out := s_out||'|'||rcdata.cargnuse;
        s_out := s_out||'|'||rcdata.cargconc;
        s_out := s_out||'|'||rcdata.cargsign;
        s_out := s_out||'|'||rcdata.cargvalo;
        s_out := s_out||'|'||rcdata.cargcaca;
        s_out := s_out||'|'||rcdata.cargdoso;
        s_out := s_out||'|'||rcdata.cargcodo;
        s_out := s_out||'|'||rcdata.cargprog;
        s_out := s_out||'|'||to_char(rcdata.cargfecr,csbformato);
        s_out := s_out||'|'||rcdata.cargpefa;
        s_out := s_out||'|'||rcdata.cargpeco;
        s_out := s_out||'|'||sbActualiza;

        dbms_output.put_line(s_out);
        
    end loop;
    
    sbcabecera :=  'Producto|Pefa|Peco|Consumo|Elemento|Metodo|DiasConsumo|Fecha|CossCons_ant|Facturado_ant|CossCons_act|Facturado_act|Actualizado';
    dbms_output.put_line('======================== Actualización Consumos ===============================');
    dbms_output.put_line(sbcabecera);
    
    for rcdata in cuconsumos loop
        sbActualiza := rcdata.cosscons||'|S|N';
        
        update conssesu
        set cossflli = 'N', cosscons = null
        where rowid = rcdata.row_id
        and cosssesu = cnusesunuse;
        
        nurowcount := sql%rowcount;  
        if nurowcount > 0 then
            sbActualiza := '|N|S';
            nuconsumos := nuconsumos + 1;
            commit;
        end if;
        
        s_out := rcdata.cosssesu;
        s_out := s_out||'|'||rcdata.cosspefa;
        s_out := s_out||'|'||rcdata.cosspecs;
        s_out := s_out||'|'||rcdata.cosscoca;
        s_out := s_out||'|'||rcdata.cosselme;
        s_out := s_out||'|'||rcdata.cossmecc;
        s_out := s_out||'|'||rcdata.cossdico;
        s_out := s_out||'|'||to_char(rcdata.cossfere,csbformato);
        s_out := s_out||'|'||rcdata.cosscons;
        s_out := s_out||'|'||rcdata.cossflli;
        s_out := s_out||'|'||sbActualiza;

        dbms_output.put_line(s_out);
        
    end loop;
    
    sbcabecera :=  'Producto|Leemcons|Leemlean|Leemleto|Leemoble|Leemfele|Leemdocu|Leempefa_ant|Leempcs_ant|Leempefa_act|Leempecs_act|Actualizado';
    dbms_output.put_line('======================== Actualización Lecturas ===============================');
    dbms_output.put_line(sbcabecera);
    
    for rcdata in culecturas loop
        sbActualiza := rcdata.leempefa||'|'||rcdata.leempecs||'|N';
        
        if rcdata.leempefa = 104357 then
        
          nupefa := 104096;
          nupecs := 104071;
          
        elsif rcdata.leempefa = 105569 then
          
          nupefa := 105308;
          nupecs := 105283;
           
        
        else
          if rcdata.leempecs = 104879 then
        
            nupefa := 104904;
            
          elsif rcdata.leempecs = 104475 then
          
            nupefa := 104500;
            
          elsif rcdata.leempecs = 104071 then
          
            nupefa := 104096;
          
          end if;
          
          nupecs := rcdata.leempecs;
           
        end if;
        
        update lectelme
        set leempefa = nupefa, leempecs = nupecs
        where rowid = rcdata.row_id
        and leemsesu = cnusesunuse;
        
        nurowcount := sql%rowcount;  
        if nurowcount > 0 then
            sbActualiza := nupefa||'|'||nupecs||'|S';
            nulecturas := nulecturas + 1;
            commit;
        end if;
      
        
        s_out := rcdata.leemsesu;
        s_out := s_out||'|'||rcdata.leemcons;
        s_out := s_out||'|'||rcdata.leemlean;
        s_out := s_out||'|'||rcdata.leemleto;
        s_out := s_out||'|'||rcdata.leemoble;
        s_out := s_out||'|'||to_char(rcdata.leemfele,csbformato);
        s_out := s_out||'|'||rcdata.leemdocu;        
        s_out := s_out||'|'||rcdata.leempefa;
        s_out := s_out||'|'||rcdata.leempecs;
        s_out := s_out||'|'||sbActualiza;

        dbms_output.put_line(s_out);
        
    end loop;
    
    dbms_output.put_line('=====================================================');
    dbms_output.put_line('Fin Sincronziacion ciclos');
    dbms_output.put_line('Cantidad Contratos Actualizados: '||nucont);
    dbms_output.put_line('Cantidad Productos Actualizados: '||nuok);
    dbms_output.put_line('Cantidad Cargos borrados: '||nucargos);
    dbms_output.put_line('Cantidad Consumos actualizados: '||nuconsumos);
    dbms_output.put_line('Cantidad Lecturas actualizados: '||nulecturas);
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
        dbms_output.put_line('Cantidad Cargos borrados: '||nucargos);
        dbms_output.put_line('Cantidad Consumos actualizados: '||nuconsumos);
        dbms_output.put_line('Cantidad Lecturas actualizados: '||nulecturas);
        dbms_output.put_line('Cantidad Registros con Error: '||nuerr);
        dbms_output.put_line('Tiempo Total: '||fnc_rs_CalculaTiempo(dtfecha,sysdate));
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/