SET SERVEROUTPUT ON;
PROMPT Borrado sinonimo LDCX_PKBINCAJASBRILLA
DECLARE
    nuconta NUMBER;
    nucontaSyn NUMBER;
    
BEGIN
        
    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'LDCX_PKBINCAJASBRILLA'
    AND OWNER = 'SISTEMABRILLA';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM SISTEMABRILLA.LDCX_PKBINCAJASBRILLA FORCE';
    END IF;   
    
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDCX_PKBINCAJASBRILLA - ' || sqlerrm);
END;
/
