DECLARE

    -- OSF-3164
    nuError    NUMBER;
    sbError VARCHAR2(4000);

    csbObjeto        CONSTANT VARCHAR2(70) :=   upper('job_actualiza_sa_tab');
    csbEsquema       CONSTANT VARCHAR2(30) :=   'ADM_PERSON';
    csbTipoObjeto    CONSTANT VARCHAR2(30) :=   'JOB';

    CURSOR cuDBA_Objects
    IS
    SELECT *
    FROM DBA_Objects
    WHERE owner = UPPER(csbEsquema) 
    AND object_name = UPPER(csbObjeto)
    AND object_type = UPPER(csbTipoObjeto);   

    TYPE tyDBA_Objects IS TABLE OF cuDBA_Objects%ROWTYPE INDEX BY BINARY_INTEGER;
    tbDBA_Objects tyDBA_Objects;

BEGIN

    OPEN cuDBA_Objects;
    FETCH cuDBA_Objects BULK COLLECT INTO tbDBA_Objects;
    CLOSE cuDBA_Objects;

    IF tbDBA_Objects.COUNT > 0 THEN
        dbms_output.put_line('INFO: Ya existe ' || csbTipoObjeto || ' [' || csbEsquema || '.' || csbObjeto ||']');    
    ELSE
    
        pkg_SCHEDULER.CREATE_JOB
         (
            job_name        => 	csbObjeto,
            job_type        => 'PLSQL_BLOCK',
            job_action      => 'BEGIN ldc_pksatabmirror.practualizasa_tab_job; END;',
            Repeat_Interval => 'FREQ=DAILY;BYHOUR=1;BYMINUTE=0;BYSECOND=0',
            auto_drop       => FALSE,
            enabled         => TRUE,
            comments        => 'Job inserta o actualiza la información en SA_TAB con la información de SA_TAB_MIRROR',
            codeError 		=> nuError,
            messageError 	=> sbError
        );

        IF nuError = 0 then	
            dbms_output.put_line('INFO: ' || csbTipoObjeto || ' [' || csbEsquema || '.' || csbObjeto ||'] Creado con éxito');
            COMMIT;	
        ELSE
            dbms_output.put_line('ERROR: '|| csbTipoObjeto ||' [' || csbEsquema || '.' || csbObjeto ||'] Error Creación [' ||sbError || ']' );
            ROLLBACK;
        END IF;        
    END IF;

EXCEPTION
    WHEN pkg_Error.CONTROLLED_ERROR then
        pkg_Error.getError(nuError, sbError);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('error onuError: ' || nuError);
        dbms_output.put_line('error osbErrorMess: ' || sbError);
        ROLLBACK;
    WHEN OTHERS then
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        dbms_output.put_line('ERROR OTHERS ');
        dbms_output.put_line('error onuError: ' || nuError);
        dbms_output.put_line('error osbErrorMess: ' || sbError);
        ROLLBACK;
END;
/