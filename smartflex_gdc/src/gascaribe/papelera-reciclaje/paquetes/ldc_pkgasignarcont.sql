SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDC_PKGASIGNARCONT
DECLARE
    nuconta NUMBER;
    nucontaSyn NUMBER;
BEGIN
    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'LDC_PKGASIGNARCONT'
    AND OWNER = 'ADM_PERSON';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.LDC_PKGASIGNARCONT FORCE';
    END IF;   
    
    --valida la existencia del obj
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDC_PKGASIGNARCONT'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE LDC_PKGASIGNARCONT';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_PKGASIGNARCONT - ' || sqlerrm);
END;
/
