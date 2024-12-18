SET SERVEROUTPUT ON;
PROMPT Borrado sinonimo PK_LDCLODPD
DECLARE
    nuconta NUMBER;
    nucontaSyn NUMBER;
    
BEGIN
        
    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'PK_LDCLODPD'
    AND OWNER = 'PERSONALIZACIONES';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM PERSONALIZACIONES.PK_LDCLODPD FORCE';
    END IF;   
    
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento PK_LDCLODPD - ' || sqlerrm);
END;
/
