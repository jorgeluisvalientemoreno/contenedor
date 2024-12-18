SET SERVEROUTPUT ON;
PROMPT Borrado sinonimo LD_FA_DETAREFE
DECLARE 
    nucontaSyn NUMBER;
    
BEGIN
      
    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'LD_FA_DETAREFE'
    AND OWNER = 'GISPETI';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM GISPETI.LD_FA_DETAREFE FORCE';
    END IF;   
    
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el sinonimo LD_FA_DETAREFE - ' || sqlerrm);
END;
/
