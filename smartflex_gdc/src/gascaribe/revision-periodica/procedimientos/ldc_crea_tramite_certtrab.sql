PROMPT Borrando procedimiento OPEN.ldc_crea_tramite_certtrab
DECLARE
  nuConta NUMBER;
BEGIN
    SELECT COUNT(1) INTO nuConta
    FROM DBA_OBJECTS
    WHERE OBJECT_NAME = UPPER('ldc_crea_tramite_certtrab')
    AND OWNER = 'OPEN'
    AND OBJECT_TYPE='PROCEDURE';

    IF nuConta >=1 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE OPEN.ldc_crea_tramite_certtrab';
        DBMS_OUTPUT.PUT_LINE( 'Se borró el procedimiento OPEN.ldc_crea_tramite_certtrab' );
    ELSE
        DBMS_OUTPUT.PUT_LINE( 'No existe el procedimiento OPEN.ldc_crea_tramite_certtrab' );
    END IF;
END;
/

PROMPT Borrando registro plugin OPEN.ldc_crea_tramite_certtrab
DECLARE
    
    rId     ROWID;

    CURSOR cuPlugin
    IS
    SELECT  pl.rowid rid
    FROM    open.ldc_procedimiento_obj pl
    WHERE   procedimiento = 'LDC_CREA_TRAMITE_CERTTRAB';

BEGIN
 
    OPEN cuPlugin;
    FETCH cuPlugin INTO rId;
    CLOSE cuPlugin;

    IF rId IS NOT NULL THEN
        DELETE FROM open.ldc_procedimiento_obj WHERE ROWID = rId;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE( 'Se borró plugin OPEN.ldc_crea_tramite_certtrabb' );
    ELSE
        DBMS_OUTPUT.PUT_LINE( 'No existe registro del plugin OPEN.ldc_crea_tramite_certtrab' );
    END IF;
END;
/