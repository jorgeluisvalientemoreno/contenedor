SET SERVEROUTPUT ON;
PROMPT Borrado sinonimo LDC_FSBRETORNARESPPRENENCUES
DECLARE
    nuconta NUMBER;
    nucontaSyn NUMBER;
    
BEGIN
    
     --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'LDC_FSBRETORNARESPPRENENCUES'
    AND OWNER = 'OPEN';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM LDC_FSBRETORNARESPPRENENCUES FORCE';
    END IF;   
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_FSBRETORNARESPPRENENCUES - ' || sqlerrm);
END;
/