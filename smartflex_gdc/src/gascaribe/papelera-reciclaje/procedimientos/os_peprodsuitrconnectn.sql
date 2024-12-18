SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento OS_PEPRODSUITRCONNECTN
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
            UPPER(object_name) = 'OS_PEPRODSUITRCONNECTN'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE OS_PEPRODSUITRCONNECTN';
    END IF;
    
    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'OS_PEPRODSUITRCONNECTN'
    AND OWNER = 'ADM_PERSON';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.OS_PEPRODSUITRCONNECTN FORCE';
    END IF;  
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento OS_PEPRODSUITRCONNECTN - ' || sqlerrm);
END;
/
