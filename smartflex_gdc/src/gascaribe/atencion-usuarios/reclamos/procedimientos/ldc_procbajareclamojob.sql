PROMPT Borrando procedimiento ldc_procbajareclamojob
DECLARE
    CURSOR cuDba_Objects
    IS
    SELECT object_name
    FROM dba_objects
    WHERE object_name = upper('ldc_procbajareclamojob')
    AND owner = 'OPEN'; 

    rcDba_Objects cuDba_Objects%ROWTYPE;

BEGIN

    OPEN cuDba_Objects;
    FETCH cuDba_Objects INTO rcDba_Objects;
    CLOSE cuDba_Objects;
    
    IF rcDba_Objects.object_name IS NOT NULL THEN    
        EXECUTE IMMEDIATE 'DROP PROCEDURE OPEN.ldc_procbajareclamojob';
        DBMS_OUTPUT.PUT_LINE( 'BORRADO el PROCEDIMIENTO OPEN.ldc_procbajareclamojob' );
    ELSE
        DBMS_OUTPUT.PUT_LINE( 'No exite el PROCEDIMIENTO OPEN.ldc_procbajareclamojob' );        
    END IF;
    
END;
/