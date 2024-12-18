SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LD_BOUTILFLOW
DECLARE
    nuconta NUMBER;
    nucontaSyn NUMBER;
BEGIN
    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'LD_BOUTILFLOW'
    AND OWNER = 'ADM_PERSON';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.LD_BOUTILFLOW FORCE';
    END IF;   
    
    --valida la existencia del obj
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LD_BOUTILFLOW'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE LD_BOUTILFLOW';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LD_BOUTILFLOW - ' || sqlerrm);
END;
/
