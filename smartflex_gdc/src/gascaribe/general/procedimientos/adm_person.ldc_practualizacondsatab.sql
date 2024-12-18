CREATE OR REPLACE PROCEDURE adm_person.ldc_practualizacondsatab
IS
    /*****************************************************************
    Procedimiento   :   LDC_prActualizaCondition_SA_TAB
    Descripcion     :   Procedimiento que se encarga de actualizar la
                        condición de visualización de un proceso.

    Autor           : Álvaro Zapata
    Fecha           : 06-Nov-2013

    Parametros         Descripcion
    ============  ===================
    Entrada:
            inuOrder_id     id de la orden
            inuAction_id    id de la acción que se realiza

    ============
    Retorno:

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    =========       =========           ====================
    16/04/2024      PAcosta             OSF-2532: Se crea el objeto en el esquema adm_person 
    ******************************************************************/    

    sbtabname           sa_tab.tab_name%TYPE;
    sbprocessname       sa_tab.process_name%TYPE;
    sbaplicaexec        sa_tab.aplica_executable%TYPE;
    sbprocess           sa_tab.process_name%TYPE;

    nuerrorcode NUMBER;
    sberrormessage VARCHAR2(4000);

    ---ejecutar procedimiento en donde se tiene en cuenta las cuasales
    CURSOR cuactualiza_sa_tab IS
    SELECT tab_name, process_name, aplica_executable, actualiza
    FROM   ldc_actualiza_sa_tab b
    WHERE  activo='S';
    
    sbproced VARCHAR2(1000);
BEGIN

--- Por cada registro encotnrado en el cursor, actualizará el campo condition de sa_tab
    FOR fuente IN cuactualiza_sa_tab LOOP
    
        sbtabname:= fuente.tab_name;
        sbprocessname:= fuente.process_name;
        sbaplicaexec:= fuente.aplica_executable;
        sbproced:= fuente.actualiza;
        sbproced := 'UPDATE ' || 'SA_TAB ' || 'SET '|| 'CONDITION =' ||''''|| sbproced ||'''';
        sbproced :=sbproced|| ' WHERE TAB_NAME = '||''''||sbtabname||''''||CHR(13)||'AND PROCESS_NAME ='||''''||sbprocessname||''''||CHR(13)||'AND APLICA_EXECUTABLE ='||''''||sbaplicaexec||''''||';'||CHR(13)|| ' COMMIT;';
        --                Sbproced := 'UPDATE ' || 'SA_TAB ' || 'SET '|| 'CONDITION =' ||''''|| Sbproced ||'''' || ' WHERE TAB_ID = '||NumCodTab||';'||CHR(13)|| ' COMMIT;';
        sbproced := 'BEGIN '||sbproced||' END;';
        
        --DBMS_OUTPUT.put_line(Sbproced);        
        EXECUTE IMMEDIATE (sbproced);
    
    END LOOP;

EXCEPTION
    WHEN ex.controlled_error THEN
        ERRORS.seterror;
        RAISE ex.controlled_error;    
    WHEN OTHERS THEN
        dbms_output.put_line('Error 2---'|| to_char(SQLCODE)||' Mensaje '||sqlerrm);
        seterrordesc('Error LDC_prActualizaCondSATAB--'|| to_char(SQLCODE)||' Mensaje '||sqlerrm);
        ERRORS.seterror;
        RAISE ex.controlled_error;
END ldc_practualizacondsatab;
/
PROMPT Otorgando permisos de ejecucion a LDC_prActualizaCondSATAB
BEGIN
  pkg_utilidades.praplicarpermisos('LDC_prActualizaCondSATAB','ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre ldc_practualizacondsatab para reportes
GRANT EXECUTE ON adm_person.ldc_practualizacondsatab TO rexereportes;
/