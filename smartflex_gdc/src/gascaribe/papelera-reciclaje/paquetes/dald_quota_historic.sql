SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento DALD_QUOTA_HISTORIC
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
            UPPER(object_name) = 'DALD_QUOTA_HISTORIC'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE DALD_QUOTA_HISTORIC';
    END IF;
    
    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'DALD_QUOTA_HISTORIC'
    AND OWNER = 'ADM_PERSON';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.DALD_QUOTA_HISTORIC FORCE';
    END IF;   
    
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento DALD_QUOTA_HISTORIC - ' || sqlerrm);
END;
/
