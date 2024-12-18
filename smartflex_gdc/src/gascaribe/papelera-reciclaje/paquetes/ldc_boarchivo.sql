SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDC_BOARCHIVO
DECLARE
    nuconta NUMBER;
    nucontaSyn NUMBER;
    
BEGIN
    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'LDC_BOARCHIVO'
    AND OWNER = 'ADM_PERSON';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.LDC_BOARCHIVO FORCE';
    END IF;   
    
    --valida la existencia del obj
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDC_BOARCHIVO'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE LDC_BOARCHIVO';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_BOARCHIVO - ' || sqlerrm);
END;
/
