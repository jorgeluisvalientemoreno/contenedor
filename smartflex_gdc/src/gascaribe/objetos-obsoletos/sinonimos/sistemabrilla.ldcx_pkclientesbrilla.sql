SET SERVEROUTPUT ON;
PROMPT Borrado sinonimo LDCX_PKCLIENTESBRILLA
DECLARE
    nuconta NUMBER;
    nucontaSyn NUMBER;
    
BEGIN
        
    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'LDCX_PKCLIENTESBRILLA'
    AND OWNER = 'SISTEMABRILLA';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM SISTEMABRILLA.LDCX_PKCLIENTESBRILLA FORCE';
    END IF;   
    
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDCX_PKCLIENTESBRILLA - ' || sqlerrm);
END;
/
