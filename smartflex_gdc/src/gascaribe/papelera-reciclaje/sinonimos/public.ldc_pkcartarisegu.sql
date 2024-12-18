SET SERVEROUTPUT ON;
PROMPT Borrado sinonimo LDC_PKCARTARISEGU
DECLARE
    
    nucontaSyn NUMBER;
    
BEGIN
    
    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'LDC_PKCARTARISEGU'
    AND OWNER = 'PUBLIC';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM LDC_PKCARTARISEGU FORCE';
    END IF;   
    
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el sinónimo LDC_PKCARTARISEGU - ' || sqlerrm);
END;
/
