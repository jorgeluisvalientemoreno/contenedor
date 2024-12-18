SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDC_OS_INSADDRESS
DECLARE
    nuconta NUMBER;    
    
    CURSOR CUSYN IS
    SELECT *    
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'LDC_OS_INSADDRESS'
    AND OWNER IN ('GISPETI','GISOSF');
    
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDC_OS_INSADDRESS'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE LDC_OS_INSADDRESS';
    END IF;
    
    --Valida exstencia del sinonimo
    FOR rec IN CUSYN LOOP        
        EXECUTE IMMEDIATE 'DROP SYNONYM '||rec.owner||'.LDC_OS_INSADDRESS FORCE';        
    END LOOP;          
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_OS_INSADDRESS - ' || sqlerrm);
END;
/
