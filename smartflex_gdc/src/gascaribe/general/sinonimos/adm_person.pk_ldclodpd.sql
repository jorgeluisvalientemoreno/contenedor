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
    AND OWNER = 'ADM_PERSON';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.PK_LDCLODPD FORCE';
    END IF;   
    
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento PK_LDCLODPD - ' || sqlerrm);
END;
/
