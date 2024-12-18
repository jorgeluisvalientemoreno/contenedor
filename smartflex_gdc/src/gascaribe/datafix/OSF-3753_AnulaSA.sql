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
DEFINE CASO=OSF-3753

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
FECHA:          Diciembre 2024 
JIRA:           OSF-3753

Descripción

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    21/11/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    csbCaso             constant varchar2(20)   := 'OSF3753';
    csbTitulo           constant varchar2(2000) := csbCaso||': Anulación de saldo a favor sin cargos que lo soporten';
    csbFormato          constant varchar2(25)   := 'DD/MM/YYYY HH24:MI:SS';
    cdtFecha            constant date           := sysdate;
    
    cursor cudata is
    select susccodi,sesunuse,sesuserv,sesuesco,suscsafa,sesusafa,safacons,
    safavalo,
    (
        select sum(mosfvalo)
        from movisafa
        where mosfsafa = safacons
    ) totalSApendiente
    from suscripc,servsusc,saldfavo
    where susccodi = 1110231
    and sesususc = susccodi
    and sesunuse = 49110231
    and safasesu(+) = sesunuse
    ;
    
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
    select sesunuse,sesusafa,
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
    nuCuentaCobro       number;
    
    
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
    
    sbcabecera := 'Contrato|Producto|Tipo|Estado|safacons|suscsafa_ant|sesusafa_ant|suscsafa_act|sesusafa_act|Error';
    dbms_output.put_line(csbTitulo);
    dbms_output.put_line('================================================');
    dbms_output.put_line(sbcabecera);
    
    begin
           
        for rc in cudata loop
            begin 
                nucontador := nucontador + 1;
                
                s_out := rc.susccodi;
                s_out := s_out||'|'||rc.sesunuse;
                s_out := s_out||'|'||rc.sesuserv;
                s_out := s_out||'|'||rc.sesuesco;
                s_out := s_out||'|'||rc.safacons;
                s_out := s_out||'|'||rc.suscsafa;
                s_out := s_out||'|'||rc.sesusafa;
                
                --validación
                if rc.safacons is null then
                    sbcomentario := 'Producto sin saldo a favor';
                    raise raise_continuar;
                elsif rc.totalsapendiente != rc.safavalo then
                    sbcomentario := 'Saldo a favor ya aplicado';
                    raise raise_continuar;
                end if;
            
                --borrado movimientos saldo a favor
                delete movisafa 
                where mosfsafa = rc.safacons
                and mosfsesu = rc.sesunuse;
                
                nuRowcount := sql%rowcount;
                
                if nuRowcount != 1 then
                    sbcomentario := 'Borrado de movimientos de saldo a favor diferente al esperado ['||nuRowcount||']';
                    raise raise_continuar;
                end if;
                
                --borrado saldo a favor
                delete saldfavo
                where safacons = rc.safacons
                and safasesu = rc.sesunuse;
                
                nuRowcount := sql%rowcount;
                
                if nuRowcount != 1 then
                    sbcomentario := 'Borrado de saldo a favor diferente al esperado ['||nuRowcount||']';
                    raise raise_continuar;
                end if;
                
                --actualización saldo a favor producto
                if cuproductos%isopen then close cuproductos; end if;
                rcproductos := null;
                open cuproductos(rc.sesunuse);
                fetch cuproductos into rcproductos;
                close cuproductos;
                
                update servsusc
                set sesusafa = nvl(rcproductos.sesusafareal,0)
                where sesunuse = rc.sesunuse;
                
                nuRowcount := sql%rowcount;
                
                if nuRowcount != 1 then
                    sbcomentario := 'Actualización de saldo a favor del producto diferente al esperado ['||nuRowcount||']';
                    raise raise_continuar;
                end if;
                
                --actualización saldo a favor contrato
                if cucontratos%isopen then close cucontratos; end if;
                rccontratos := null;
                open cucontratos(rc.susccodi);
                fetch cucontratos into rccontratos;
                close cucontratos;
                
                update suscripc
                set suscsafa = nvl(rccontratos.suscsafareal,0)
                where susccodi = rc.susccodi;
                
                nuRowcount := sql%rowcount;
                
                if nuRowcount != 1 then
                    sbcomentario := 'Actualización de saldo a favor del contrato  diferente al esperado ['||nuRowcount||']';
                    raise raise_continuar;
                end if;
                
                
               
                s_out := s_out||'|'||nvl(rccontratos.suscsafareal,0);
                s_out := s_out||'|'||nvl(rcproductos.sesusafareal,0);
                s_out := s_out||'|'||'Ok';
                
                dbms_output.put_line(s_out);
                nuok := nuok + 1;
                
                commit;
                
              
            exception
                when raise_continuar then
                    rollback;
                    nuerr := nuerr + 1;
                    s_out := s_out||'|'||rc.suscsafa;
                    s_out := s_out||'|'||rc.sesusafa;
                    s_out := s_out||'|'||sbcomentario;
                    dbms_output.put_line(s_out);
                when others then
                    rollback;
                    nuerr := nuerr + 1;
                    pkg_error.seterror;
                    pkg_error.geterror(nuerror,sberror);
                    sbcomentario := 'Error en borrado de saldo a favor producto '||rc.sesunuse||'. Error '||sberror;
                    s_out := s_out||'|'||rc.suscsafa;
                    s_out := s_out||'|'||rc.sesusafa;
                    s_out := s_out||'|'||sbcomentario;
                    dbms_output.put_line(s_out);
            end;
            
      
        end loop;
        
        
        if nucontador = 0 then
            sbcomentario := 'Sin datos para gestión';
            nuerr := nuerr + 1;
            s_out  := '||||||||';
            s_out := s_out||'|'||sbcomentario;
            dbms_output.put_line(s_out);
        end if;
    
    exception
        when others then
            rollback;
            nuerr := nuerr + 1;
            sbcomentario := 'Error desconocido: '||sqlerrm;
            s_out  := '||||||||';
            s_out := s_out||'|'||sbcomentario;
            dbms_output.put_line(s_out);
            
    end;
    dbms_output.put_line('================================================');
    dbms_output.put_line('Fin gestión caso '||csbCaso);
    dbms_output.put_line('Cantidad de saldos a favor borrados: '||nuok);
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
