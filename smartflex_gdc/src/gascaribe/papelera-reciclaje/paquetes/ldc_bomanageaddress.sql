SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDC_BOMANAGEADDRESS
DECLARE
    nuconta NUMBER;
    nucontaSyn NUMBER;
    
BEGIN
    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'LDC_BOMANAGEADDRESS'
    AND OWNER = 'ADM_PERSON';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.LDC_BOMANAGEADDRESS FORCE';
    END IF;   
    
    --valida la existencia del obj
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDC_BOMANAGEADDRESS'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE LDC_BOMANAGEADDRESS';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_BOMANAGEADDRESS - ' || sqlerrm);
END;
/
