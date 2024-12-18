SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento PE_BSGENCONTRACTOBLIG
DECLARE
    nuconta NUMBER;
    nucontaSyn NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'PE_BSGENCONTRACTOBLIG'
    AND OWNER = 'ADM_PERSON';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.PE_BSGENCONTRACTOBLIG FORCE';
    END IF;  
    
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'PE_BSGENCONTRACTOBLIG'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE PE_BSGENCONTRACTOBLIG';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento PE_BSGENCONTRACTOBLIG - ' || sqlerrm);
END;
/
