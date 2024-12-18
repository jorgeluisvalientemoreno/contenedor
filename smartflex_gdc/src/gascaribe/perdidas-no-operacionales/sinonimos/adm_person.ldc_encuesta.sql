SET SERVEROUTPUT ON;
PROMPT Borrado sinonimo LDC_ENCUESTA
DECLARE
    nuconta NUMBER;
    nucontaSyn NUMBER;
    
BEGIN
    
     --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'LDC_ENCUESTA'
    AND OWNER = 'ADM_PERSON';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.LDC_ENCUESTA FORCE';
    END IF;   
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_ENCUESTA - ' || sqlerrm);
END;
/