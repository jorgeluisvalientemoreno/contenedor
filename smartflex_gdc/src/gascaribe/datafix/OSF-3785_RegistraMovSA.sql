set serveroutput on size unlimited
set linesize 1000
set timing on
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

COLUMN instancia new_val instancia format a20;
COLUMN fecha_ejec new_val fecha_ejec format a20;
COLUMN esquema new_val esquema format a20;
COLUMN ejecutado_por new_val ejecutado_por format a20;
COLUMN usuario_so new_val usuario_so format a35;
COLUMN fecha_fin new_val fecha_fin format a25
DEFINE CASO=OSF-3785

SELECT SYS_CONTEXT('USERENV', 'DB_NAME') instancia,
   TO_CHAR(SYSDATE, 'yyyymmdd_hh24miss') fecha_ejec,
   SYS_CONTEXT('USERENV','CURRENT_SCHEMA') esquema,
   USER ejecutado_por,
   SYS_CONTEXT('USERENV', 'OS_USER') usuario_so
FROM DUAL;

PROMPT
PROMPT =========================================
PROMPT  ****   Información de Ejecución    ****
PROMPT =========================================
PROMPT Instancia        : &instancia
PROMPT Fecha ejecución  : &fecha_ejec
PROMPT Usuario DB       : &ejecutado_por
PROMPT Usuario O.S      : &usuario_so
PROMPT Esquema          : &esquema
PROMPT CASO             : &CASO
PROMPT =========================================
PROMPT

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"
/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Noviembre 2024 
JIRA:           OSF-3785

Descripción

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    xx/11/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    csbCaso             constant varchar2(20)   := 'OSF3785';
    csbTitulo           constant varchar2(2000) := csbCaso||': Registra movimiento de saldo a favor y actualiza estados';
    csbFormato          constant varchar2(25)   := 'DD/MM/YYYY HH24:MI:SS';
    cdtFecha            constant date           := sysdate;
    cnuSafacons         constant number         :=  2420559;
    
    cursor cudata is
    select 
    s.*,
    (
        select sum(mosfvalo)
        from movisafa
        where mosfsafa = safacons
    ) mosfvalo,
    cargcuco,cargsign,cargvalo,cargdoso,cargcodo,
    (select mask from sa_user where user_id = cargusua) cargusua,
    (select proccodi from procesos where proccons = cargprog) cargprog,
    cargfecr,
    count(*) over (partition by safacons) total,
    rownum fila
    from saldfavo s,cargos 
    where safasesu = 51598176
    and safacons = cnuSafacons
    and cargnuse = safasesu
    and cargprog = 70
    and trunc(cargfecr) = to_date('20122024','ddmmyyyy')
    and cargsign = 'AS'
    and not exists
    (
        select 'x' 
        from movisafa
        where mosfsafa = safacons
        and mosfcuco = cargcuco
        and abs(mosfvalo) = cargvalo
        and trunc(mosffech) = trunc(cargfecr)
    )
    order by cargfecr;
    
    cursor cucontratos (inususc in number) is
    select susccodi,suscsafa,
    (
        select sum(mosfvalo)
        from movisafa,saldfavo,servsusc
        where safacons = mosfsafa
        and safasesu = sesunuse
        and sesususc = susccodi
    ) suscsafareal
    from suscripc 
    where susccodi = inususc;
    
    rccontratos cucontratos%rowtype;
    
    cursor cuproductos (inusesu in number) is
    select sesunuse,sesususc,sesusafa,
    (
        select sum(mosfvalo)
        from movisafa,saldfavo
        where safacons = mosfsafa
        and safasesu = sesunuse
    ) sesusafareal
    from servsusc 
    where sesunuse = inusesu;
    
    rcproductos cuproductos%rowtype;
    
    
    sberror             varchar2(2000);
    nuerror             number;
    raise_continuar     exception;
    
    s_out               varchar2(2000);
    sbcabecera          varchar2(2000);
    sbcomentario        varchar2(2000);
    nucontador          number;
    nurowcount          number;
    nuok                number;
    nuerr               number;
    rcmovisafa      movisafa%rowtype;
    numosfcons      movisafa.mosfcons%type;
    
    
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
    
    
    
BEGIN
    nucontador  := 0;
    nuok       := 0;
    nuerr       := 0;
    
    sbcabecera := 'Producto|Safacons|Cuenta|Valor|Fecha|Programa|Usuario|Mosfcons|Error';
    dbms_output.put_line(csbTitulo);
    dbms_output.put_line('================================================');
    dbms_output.put_line(sbcabecera);
    
    begin
           
        for rc in cudata loop
            begin 
                nucontador := nucontador + 1;

                s_out := rc.safasesu;
                s_out := s_out||'|'||cnuSafacons;
                s_out := s_out||'|'||rc.cargcuco;
                s_out := s_out||'|'||rc.cargvalo;
                s_out := s_out||'|'||rc.cargfecr;
                s_out := s_out||'|'||rc.cargprog;
                s_out := s_out||'|'||rc.cargusua;
                
                rcmovisafa := null;
                numosfcons := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('sq_movisafa_mosfcons');
                
                s_out := s_out||'|'||numosfcons;
                
                rcmovisafa.mosfcons := numosfcons;
                rcmovisafa.mosfsesu := rc.safasesu;
                rcmovisafa.mosfsafa := cnuSafacons;
                rcmovisafa.mosfdoso := null;
                rcmovisafa.mosffech := trunc(rc.cargfecr);
                rcmovisafa.mosfvalo := -1*rc.cargvalo;
                rcmovisafa.mosfcuco := rc.cargcuco;
                rcmovisafa.mosfnota := null;
                rcmovisafa.mosfdeta := 'AS';
                rcmovisafa.mosffecr := rc.cargfecr;
                rcmovisafa.mosfusua := rc.cargusua;
                rcmovisafa.mosfprog := rc.cargprog;
                rcmovisafa.mosfterm := pkg_session.fsbgetTerminal;
                
                Pktblmovisafa.Insrecord (rcmovisafa);
            
                s_out := s_out||'|'||'Ok';
                dbms_output.put_line(s_out);
                nuok := nuok + 1;
                
              
                if rc.total = rc.fila then
                
                    --actualización saldo a favor producto
                    if cuproductos%isopen then close cuproductos; end if;
                    rcproductos := null;
                    open cuproductos(rc.safasesu);
                    fetch cuproductos into rcproductos;
                    close cuproductos;
                    
                    update servsusc
                    set sesusafa = nvl(rcproductos.sesusafareal,0)
                    where sesunuse = rc.safasesu;
                    
                    nuRowcount := sql%rowcount;
                    
                    if nuRowcount != 1 then
                        sbcomentario := 'Actualización de saldo a favor del producto diferente al esperado ['||nuRowcount||']';
                        raise raise_continuar;
                    end if;
                    
                    --actualización saldo a favor contrato
                    if cucontratos%isopen then close cucontratos; end if;
                    rccontratos := null;
                    open cucontratos(rcproductos.sesususc);
                    fetch cucontratos into rccontratos;
                    close cucontratos;
                    
                    update suscripc
                    set suscsafa = nvl(rccontratos.suscsafareal,0)
                    where susccodi = rcproductos.sesususc;
                    
                    nuRowcount := sql%rowcount;
                    
                    if nuRowcount != 1 then
                        sbcomentario := 'Actualización de saldo a favor del contrato  diferente al esperado ['||nuRowcount||']';
                        raise raise_continuar;
                    end if;
                
                    pkg_error.setApplication(csbCaso);
                
                    update servsusc
                    set sesuesco = 1, sesuesfn = 'A'
                    where sesunuse = rc.safasesu;
                    
                end if;
                
                commit;
                
              
            exception
                when raise_continuar then
                    rollback;
                    nuerr := nuerr + 1;
                    s_out := s_out||'|'||sbcomentario;
                    dbms_output.put_line(s_out);
                when others then
                    rollback;
                    nuerr := nuerr + 1;
                    pkg_error.seterror;
                    pkg_error.geterror(nuerror,sberror);
                    sbcomentario := 'Error en registro de movimiento SA. Error '||sberror;
                    s_out := s_out||'|'||sbcomentario;
                    dbms_output.put_line(s_out);
            end;
            
      
        end loop;
        
        if nucontador = 0 then
            sbcomentario := 'Sin datos para gestión';
            nuerr := nuerr + 1;
            s_out  := '||||||';
            s_out := s_out||'|'||sbcomentario;
            dbms_output.put_line(s_out);
        end if;
    
    exception
        when others then
            rollback;
            nuerr := nuerr + 1;
            sbcomentario := 'Error desconocido: '||sqlerrm;
            s_out  := '||||';
            s_out := s_out||'|'||sbcomentario;
            dbms_output.put_line(s_out);
            
    end;
    dbms_output.put_line('================================================');
    dbms_output.put_line('Fin gestión caso '||csbCaso);
    dbms_output.put_line('Cantidad de movimientos creadas: '||nuok);
    dbms_output.put_line('Cantidad de errores: '||nuerr);  
    dbms_output.put_line('Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(sysdate,'hh24:mi:ss')||']');
    dbms_output.put_line('Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,sysdate)||']');
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;

PROMPT **** FIN EJECUCIÓN ****
PROMPT CASO             : &CASO
PROMPT Fecha fin        : &fecha_fin
PROMPT =========================================

set timing off
set serveroutput off
quit
/
