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
DEFINE CASO=OSF-4094

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
ELABORADO POR:  Juan Gabriel Catuche Girón
EMPRESA:        MVM Ingenieria de Software
FECHA:          Marzo 2025 
JIRA:           OSF-4094

Descripción

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    11/03/2022 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    csbCaso             constant varchar2(20)   := 'OSF4094';
    csbTitulo           constant varchar2(2000) := csbCaso||': Actualización ciclo y periodo a lecturas y consumos';
    csbFormato          constant varchar2(25)   := 'DD/MM/YYYY HH24:MI:SS';
    cdtFecha            constant date           := sysdate;
    
    cnuPefa             number := 114370;
    cnuPecs             number := 114325;
    cnuPefaAnt          number := 114491;
    cnuCont             number := 48137260;
    
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
    nuLect              number;
    nuCons              number;
    
    cursor cudata is
    select susccodi,susccicl,sesunuse,sesuserv,sesuesco,sesucicl,sesucico
    from suscripc,servsusc
    where sesususc = susccodi
    and susccodi = cnuCont
    and susccicl != sesucicl;
    
    
    
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
    nuLect      := 0;
    nuCons      := 0;
    
    sbcabecera := 'Sesususc|Susccicl|Sesunuse|Sesucicl_ant|Sesucicl_act|Sesucico_ant|Sesucico_act|Comentario|Error';
    dbms_output.put_line(csbTitulo);
    dbms_output.put_line('================================================');
    dbms_output.put_line(sbcabecera);
    
    begin
          
        for rc in cudata loop
            begin 
                    
                nucontador := nucontador + 1;
                
                update conssesu 
                set cosspefa = cnuPefa, cosspecs = cnuPecs
                where cosssesu = rc.sesunuse and cosspefa = cnuPefaAnt;
                
                nuRowcount := sql%rowcount;
                if nuRowcount <= 0 then
                    sbcomentario :=  'No se realizó la actualización de periodos en conssesu|NA';
                    raise raise_continuar;
                end if;
                
                nuCons := nuCons + nuRowcount;
                
                update lectelme
                set leempefa = cnuPefa, leempecs = cnuPecs
                where leemsesu = rc.sesunuse and leempefa = cnuPefaAnt;
                
                nuRowcount := sql%rowcount;
                if nuRowcount <= 0 then
                    sbcomentario :=  'No se realizó la actualización de periodos en lectelme|NA';
                    raise raise_continuar;
                end if;
                
                nuLect := nuLect + nuRowcount;
            
                s_out := rc.susccodi;
                s_out := s_out||'|'||rc.susccicl;
                s_out := s_out||'|'||rc.sesunuse;
                s_out := s_out||'|'||rc.sesucicl;
                
                update servsusc
                set sesucicl = rc.susccicl,sesucico = rc.susccicl
                where sesunuse = rc.sesunuse and sesucicl = rc.sesucicl;
                
                nuRowcount := sql%rowcount;
                if nuRowcount != 1 then
                    s_out := s_out||'|'||rc.sesucicl;
                    s_out := s_out||'|'||rc.sesucico;
                    s_out := s_out||'|'||rc.sesucico;
                    sbcomentario :=  'Cantidad de actualización de servsusc diferente a la esperada|NA';
                    raise raise_continuar;
                end if;
                    
                s_out := s_out||'|'||rc.susccicl;
                s_out := s_out||'|'||rc.sesucico;
                s_out := s_out||'|'||rc.susccicl;   
                s_out := s_out||'|'||'Ok|NA';
                    
                nuok := nuok + 1;
                    
                commit;
                    
                dbms_output.put_line(s_out);
                
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
                    sbcomentario := 'Error en actualización categoria subcategoria. Error '||sberror;
                    s_out := s_out||'|'||sbcomentario;
                    dbms_output.put_line(s_out);
            end;
            
        end loop;
        
        if nucontador = 0 then
            sbcomentario := 'Sin datos para gestión';
            nuerr := nuerr + 1;
            s_out  := '|||||';
            s_out := s_out||'|'||sbcomentario;
            dbms_output.put_line(s_out);
        end if;
    
    exception
        when others then
            rollback;
            nuerr := nuerr + 1;
            sbcomentario := 'Error desconocido: '||sqlerrm;
            s_out  := '|||||';
            s_out := s_out||'|'||sbcomentario;
            dbms_output.put_line(s_out);
            
    end;
    dbms_output.put_line('================================================');
    dbms_output.put_line('Fin gestión caso '||csbCaso);
    dbms_output.put_line('Cantidad de Productos actualizados: '||nuok);
    dbms_output.put_line('Cantidad de Consumos actualizados: '||nuCons);
    dbms_output.put_line('Cantidad de Lecturas actualizados: '||nuLect);
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
