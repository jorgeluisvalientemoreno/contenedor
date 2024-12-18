SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDC_PKDATAFIXUPDEDDOCU
DECLARE
    nuconta NUMBER;
    nucontaSyn NUMBER;
BEGIN
    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'LDC_PKDATAFIXUPDEDDOCU'
    AND OWNER = 'ADM_PERSON';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.LDC_PKDATAFIXUPDEDDOCU FORCE';
    END IF;  
    
    --Valida existencia de objeto
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDC_PKDATAFIXUPDEDDOCU'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP package LDC_PKDATAFIXUPDEDDOCU';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_PKDATAFIXUPDEDDOCU - ' || sqlerrm);
END;
/
