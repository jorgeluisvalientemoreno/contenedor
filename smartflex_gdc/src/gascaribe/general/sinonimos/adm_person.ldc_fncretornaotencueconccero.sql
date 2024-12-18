SET SERVEROUTPUT ON;
PROMPT Borrado sinonimo LDC_FNCRETORNAOTENCUECONCCERO
DECLARE
    nuconta NUMBER;
    nucontaSyn NUMBER;
    
BEGIN
    
     --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'LDC_FNCRETORNAOTENCUECONCCERO'
    AND OWNER = 'OPEN';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM LDC_FNCRETORNAOTENCUECONCCERO FORCE';
    END IF;   
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_FNCRETORNAOTENCUECONCCERO - ' || sqlerrm);
END;
/