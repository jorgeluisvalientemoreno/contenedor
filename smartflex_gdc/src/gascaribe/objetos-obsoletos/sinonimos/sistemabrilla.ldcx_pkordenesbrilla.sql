SET SERVEROUTPUT ON;
PROMPT Borrado sinonimo LDCX_PKORDENESBRILLA
DECLARE
    nuconta NUMBER;
    nucontaSyn NUMBER;
    
BEGIN
        
    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'LDCX_PKORDENESBRILLA'
    AND OWNER = 'SISTEMABRILLA';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM SISTEMABRILLA.LDCX_PKORDENESBRILLA FORCE';
    END IF;   
    
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDCX_PKORDENESBRILLA - ' || sqlerrm);
END;
/
