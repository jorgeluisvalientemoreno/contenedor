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
DEFINE CASO=OSF-4540

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
FECHA:          Junio 2025 
JIRA:           OSF-4540

Descripción

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    13/06/2025 - jcatuche
    Creación
    
***********************************************************/
DECLARE
    csbCaso             constant varchar2(20)   := 'OSF4540';
    csbTitulo           constant varchar2(2000) := csbCaso||': Actualiza fecha de promoción';
    csbFormato          constant varchar2(25)   := 'DD/MM/YYYY HH24:MI:SS';
    cdtFecha            constant date           := sysdate;
    cnuFechaUpd         constant date           := to_date('21/10/2025 16:25:09','dd/mm/yyyy hh24:mi:ss');
    
    cursor cudata is
    select * 
    FROM PR_PROMOTION 
    WHERE PRODUCT_ID = 1999616
    and promotion_id = 545213
    and cancellation_date is null;
    
   
    
    
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
    nuok        := 0;
    nuerr       := 0;
    
    
    sbcabecera := 'Promocion|Producto|Vigencia_ant|Viencia_act|Gestión';
    dbms_output.put_line(csbTitulo);
    dbms_output.put_line('================================================');
    dbms_output.put_line(sbcabecera);
    
    begin
           
        for rc in cudata loop
             
            nucontador := nucontador + 1;
            
            begin 
            
                s_out := rc.promotion_id;
                s_out := s_out||'|'||rc.product_id;
                s_out := s_out||'|'||rc.final_date;
                
                if rc.final_date = cnuFechaUpd then
                    s_out := s_out||'|'||rc.final_date;
                    sbcomentario := 'Fecha ya actualizada';
                    raise raise_continuar;
                elsif rc.initial_date >= cnuFechaUpd then
                    s_out := s_out||'|'||rc.final_date;
                    sbcomentario := 'La nueva fecha final debe ser mayor a la fecha inicial ['||cnuFechaUpd||'-'||rc.initial_date||']';
                    raise raise_continuar;
                end if;
                
                update PR_PROMOTION
                set final_date = cnuFechaUpd
                where promotion_id = rc.promotion_id
                and product_id = rc.product_id;
                
                nuRowcount := sql%rowcount;
            
                if nuRowcount != 1 then
                    s_out := s_out||'|'||rc.final_date;
                    sbcomentario := 'Actualización de fecha de promoción diferente al esperado ['||nuRowcount||']';
                    raise raise_continuar;
                end if;
                
                s_out := s_out||'|'||cnuFechaUpd;
                s_out := s_out||'|'||'Ok';
                dbms_output.put_line(s_out);
                
                nuok := nuok + 1;
                
                commit;
                
            exception
                when raise_continuar then
                    rollback;
                    nuerr := nuerr + 1;
                    s_out := s_out||'|'||sbcomentario;
                    dbms_output.put_line(s_out);
                when others then
                    rollback;
                    s_out := s_out||'|'||rc.final_date;
                    nuerr := nuerr + 1;
                    pkg_error.seterror;
                    pkg_error.geterror(nuerror,sberror);
                    sbcomentario := 'Error en actualización de fecha. Error '||sberror;
                    s_out := s_out||'|'||sbcomentario;
                    dbms_output.put_line(s_out);
            end;
        end loop;
        
        
        if nucontador = 0 then
            sbcomentario := 'Sin datos para gestión';
            nuerr := nuerr + 1;
            s_out := '|||';
            s_out := s_out||'|'||sbcomentario;
            dbms_output.put_line(s_out);
        end if;
    
    exception
        when others then
            rollback;
            nuerr := nuerr + 1;
            sbcomentario := 'Error desconocido: '||sqlerrm;
            s_out := '|||';
            s_out := s_out||'|'||sbcomentario;
            dbms_output.put_line(s_out);
            
    end;
    dbms_output.put_line('================================================');
    dbms_output.put_line('Fin gestión caso '||csbCaso);
    dbms_output.put_line('Cantidad de promociones actualizadas: '||nuok);
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
