SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento PKG_BOGESTION_FLUJOS
DECLARE
    nuconta NUMBER;
    nucontaSyn NUMBER;
BEGIN
    
    --Valida existencia de objeto    
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'PKG_BOGESTION_FLUJOS'
        AND owner = 'PERSONALIZACIONES'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP package PERSONALIZACIONES.PKG_BOGESTION_FLUJOS';
    END IF;
    
    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'PKG_BOGESTION_FLUJOS'
    AND OWNER = 'PERSONALIZACIONES';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM PERSONALIZACIONES.PKG_BOGESTION_FLUJOS FORCE';
        EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.PKG_BOGESTION_FLUJOS FORCE';
    END IF;  
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento PERSONALIZACIONES.PKG_BOGESTION_FLUJOS - ' || sqlerrm);
END;
/
