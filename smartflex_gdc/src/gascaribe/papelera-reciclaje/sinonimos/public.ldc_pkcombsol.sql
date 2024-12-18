SET SERVEROUTPUT ON;
PROMPT Borrado sinonimo LDC_PKCOMBSOL
DECLARE
    
    nucontaSyn NUMBER;
    
BEGIN
    
    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'LDC_PKCOMBSOL'
    AND OWNER = 'PUBLIC';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM LDC_PKCOMBSOL FORCE';
    END IF;   
    
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el sinónimo LDC_PKCOMBSOL - ' || sqlerrm);
END;
/
