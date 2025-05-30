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
DEFINE CASO=OSF-3567

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
JIRA:           OSF-3567

Descripción

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    06/11/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    csbCaso             constant varchar2(20)   := 'OSF3567';
    csbTitulo           constant varchar2(2000) := csbCaso||': Ampliación fecha de inicio vigencia tarifas de impuestos';
    csbFormato          constant varchar2(25)   := 'DD/MM/YYYY HH24:MI:SS';
    cdtFecha            constant date           := sysdate;
    
    cursor cudata is
    SELECT conccodi, concdesc, concdefa,cotcserv,cotccons,tacocons,to_date('01012000','ddmmyyyy') fecha_inicial,
    (   
        select count(*)
        FROM ta_vigetaco 
        WHERE vitctaco = tacocons
    ) cantidad,
    (   
        select min(vitcfein)
        FROM ta_vigetaco 
        WHERE vitctaco = tacocons
        and vitcvige = 'S'
    ) vitcfein,
    (   
        select min(vitccons)
        FROM ta_vigetaco 
        WHERE vitctaco = tacocons
        and vitcvige = 'S'
    ) vitccons
    FROM concepto  ,ta_conftaco  ,  ta_tariconc 
    WHERE  concticl = 4
    AND conccodi = cotcconc
    AND cotcvige = 'S'
    AND tacocotc = cotccons;
    
    
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
    
    sbcabecera := 'Concepto|Servicio|Tarifa|Vigencia|Cantidad|FechaInicial_ant|FechaInicial_act|Error';
    dbms_output.put_line(csbTitulo);
    dbms_output.put_line('================================================');
    dbms_output.put_line(sbcabecera);
    
    begin
           
        for rc in cudata loop
            begin 
                nucontador := nucontador + 1;
                
                s_out := rc.conccodi||'-'||rc.concdesc;
                s_out := s_out||'|'||rc.cotcserv;
                s_out := s_out||'|'||rc.tacocons;
                s_out := s_out||'|'||rc.vitccons;
                s_out := s_out||'|'||rc.cantidad;
                s_out := s_out||'|'||rc.vitcfein;
                
                if rc.cantidad > 1 then
                    sbcomentario := 'Tarifa con más de una vigencia activa ['||rc.cantidad||']['||rc.vitcfein||']';
                    raise raise_continuar;
                elsif rc.cantidad = 0 then
                    sbcomentario := 'Tarifa sin vigencias activas';
                    raise raise_continuar;
                elsif rc.vitcfein = rc.fecha_inicial then
                    sbcomentario := 'Tarifa ya tiene la vigencia inicial actualizada ['||rc.vitcfein||']';
                    raise raise_continuar;
                elsif rc.vitcfein < rc.fecha_inicial then
                    sbcomentario := 'Tarifa ya tiene una vigencia inicial menor ['||rc.vitcfein||']';
                    raise raise_continuar;
                end if;
                
                update ta_vigetaco 
                set vitcfein = rc.fecha_inicial
                where vitccons = rc.vitccons
                and vitcvige = 'S'
                and vitctaco = rc.tacocons
                ;
                
                nuRowcount := sql%rowcount;
                
                if nuRowcount != 1 then
                    sbcomentario := 'Actualización de vigencia inicial diferenta a la esperada ['||nuRowcount||']';
                    raise raise_continuar;
                end if;
                
                s_out := s_out||'|'||rc.fecha_inicial;
                s_out := s_out||'|'||'Ok';
                dbms_output.put_line(s_out);
                nuok := nuok + 1;
                
                commit;
                
              
            exception
                when raise_continuar then
                    rollback;
                    nuerr := nuerr + 1;
                    s_out := s_out||'|'||rc.vitcfein;
                    s_out := s_out||'|'||sbcomentario;
                    dbms_output.put_line(s_out);
                when others then
                    rollback;
                    nuerr := nuerr + 1;
                    pkg_error.geterror(nuerror,sberror);
                    sbcomentario := 'Error en ajuste vigencia inicial tarifa. Error '||sberror;
                    s_out := s_out||'|'||rc.vitcfein;
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
            s_out  := '||||||';
            s_out := s_out||'|'||sbcomentario;
            dbms_output.put_line(s_out);
            
    end;
    dbms_output.put_line('================================================');
    dbms_output.put_line('Fin gestión caso '||csbCaso);
    dbms_output.put_line('Cantidad de vigencias gestionadas: '||nucontador);
    dbms_output.put_line('Cantidad de vigencias actualizadas: '||nuok);
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
