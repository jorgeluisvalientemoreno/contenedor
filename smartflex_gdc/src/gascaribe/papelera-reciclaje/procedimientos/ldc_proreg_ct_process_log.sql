SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDC_PROREG_CT_PROCESS_LOG
DECLARE
    nuconta NUMBER;
    nucontaSyn NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDC_PROREG_CT_PROCESS_LOG'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE LDC_PROREG_CT_PROCESS_LOG';
    END IF;
    
    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'LDC_PROREG_CT_PROCESS_LOG'
    AND OWNER = 'ADM_PERSON';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.LDC_PROREG_CT_PROCESS_LOG FORCE';
    END IF;
        
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_PROREG_CT_PROCESS_LOG - ' || sqlerrm);
END;
/