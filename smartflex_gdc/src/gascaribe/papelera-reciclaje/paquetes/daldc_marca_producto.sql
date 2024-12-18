SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento DALDC_MARCA_PRODUCTO
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
            UPPER(object_name) = 'DALDC_MARCA_PRODUCTO'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE DALDC_MARCA_PRODUCTO';
    END IF;
    
    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'DALDC_MARCA_PRODUCTO'
    AND OWNER = 'ADM_PERSON';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.DALDC_MARCA_PRODUCTO FORCE';
    END IF; 
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento DALDC_MARCA_PRODUCTO - ' || sqlerrm);
END;
/
