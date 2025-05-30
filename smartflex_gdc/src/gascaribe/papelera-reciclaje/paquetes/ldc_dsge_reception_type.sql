SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDC_DSGE_RECEPTION_TYPE
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
            UPPER(object_name) = 'LDC_DSGE_RECEPTION_TYPE'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE LDC_DSGE_RECEPTION_TYPE';
    END IF;
    
    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'LDC_DSGE_RECEPTION_TYPE'
    AND OWNER = 'ADM_PERSON';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.LDC_DSGE_RECEPTION_TYPE FORCE';
    END IF; 
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_DSGE_RECEPTION_TYPE - ' || sqlerrm);
END;
/
