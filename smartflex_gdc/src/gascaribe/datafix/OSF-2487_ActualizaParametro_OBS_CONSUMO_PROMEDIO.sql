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
DEFINE CASO=OSF2487

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
FECHA:          Marzo 2024 
JIRA:           OSF-2487

Descripción

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    18/03/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    csbCaso             constant varchar2(20)   := 'OSF2487';
    csbTitulo           constant varchar2(2000) := csbCaso||': Actualización parámetro OBS_CONSUMO_PROMEDIO';
    csbFormato          constant varchar2(25)   := 'DD/MM/YYYY HH24:MI:SS';
    cdtFecha            constant date           := sysdate;
    cnuParametro        constant varchar2(200)  :=  'OBS_CONSUMO_PROMEDIO';
    
    sberror             varchar2(2000);
    nuerror             number;
    raise_continuar     exception;
    s_out               varchar2(2000);
    sbcabecera          varchar2(2000);
    sbcomentario        varchar2(2000);
    nucontador          number;
    nurowcount          number;
    nuerr               number;
    
    cursor cuParam is
    select * from PARAMETROS where codigo =  'OBS_CONSUMO_PROMEDIO';
    rcparam cuParam%rowtype;
    
    
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
    nuerr       := 0;
    
    sbcabecera := 'Parametro|Error';
    
    dbms_output.put_line(csbTitulo);
    dbms_output.put_line('================================================');
    dbms_output.put_line(sbcabecera);
    
    begin
    
        rcParam := null;
        open cuParam;
        fetch cuParam into rcParam;
        close cuParam;
        
        s_out := cnuParametro;
        s_out := s_out||'|'||rcParam.valor_cadena;
           
        MERGE INTO PARAMETROS A USING
        (
            SELECT
            cnuParametro as CODIGO,
            NULL AS VALOR_NUMERICO,
            NULL AS VALOR_FECHA,
            '8,9,38,59,71,79,80,81,82' as VALOR_CADENA,
            'Observaciones lectura validas para consumo promedio OSF-2190' as DESCRIPCION,
            16 as PROCESO
            FROM DUAL
        ) B
        ON (A.CODIGO = B.CODIGO)
        WHEN NOT MATCHED THEN 
        INSERT 
        (
            CODIGO, VALOR_NUMERICO, VALOR_FECHA, VALOR_CADENA, DESCRIPCION, PROCESO, USUARIO, TERMINAL, FECHA_CREACION
        )
        VALUES 
        (
            B.CODIGO, B.VALOR_NUMERICO, B.VALOR_FECHA, B.VALOR_CADENA, B.DESCRIPCION, B.PROCESO, USER,USERENV('TERMINAL'), SYSDATE
        )
        WHEN MATCHED THEN
        UPDATE SET 
            A.VALOR_NUMERICO        = B.VALOR_NUMERICO,
            A.VALOR_FECHA           = B.VALOR_FECHA,
            A.VALOR_CADENA          = B.VALOR_CADENA,
            A.DESCRIPCION           = B.DESCRIPCION,
            A.PROCESO               = B.PROCESO,
            A.FECHA_ACTUALIZACION   = SYSDATE
        ;
        
        nuRowcount := sql%rowcount;
        
        if nuRowcount != 1 then
            sbcomentario := 'No se realizó actualización del parámetro  '||cnuParametro||' ['||nuRowcount||']';
            raise raise_continuar;
        end if;
        
        rcParam := null;
        open cuParam;
        fetch cuParam into rcParam;
        close cuParam;
        
        s_out := s_out||'|'||rcParam.valor_cadena;
        
        commit;
        
        --diferidos 
        sbcabecera := 'Parametro|ValorAnt|ValorAct';
        dbms_output.put_line('================================================');
        dbms_output.put_line(sbcabecera);       
        dbms_output.put_line(s_out);
        nucontador  := nucontador + 1;
    
    
    exception
        when raise_continuar then
            nuerr := nuerr + 1;
            rollback;
            s_out := cnuParametro;
            s_out := s_out||'|'||sbcomentario;
            dbms_output.put_line(s_out);
            
    end;
    dbms_output.put_line('================================================');
    dbms_output.put_line('Cantidad de parametros actualizados: '||nucontador);
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
