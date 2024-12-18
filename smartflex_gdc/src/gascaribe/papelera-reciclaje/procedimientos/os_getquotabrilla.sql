SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento OS_GETQUOTABRILLA
DECLARE
    nuconta NUMBER;
    
    CURSOR CUSYN IS
    SELECT *    
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'OS_GETQUOTABRILLA'
    AND OWNER IN ('GISPETI','GISOSF');
    
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'OS_GETQUOTABRILLA'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE OS_GETQUOTABRILLA';
    END IF;
    
    --Valida exstencia del sinonimo
    FOR rec IN CUSYN LOOP        
        EXECUTE IMMEDIATE 'DROP SYNONYM '||rec.owner||'.OS_GETQUOTABRILLA FORCE';        
    END LOOP;
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento OS_GETQUOTABRILLA - ' || sqlerrm);
END;
/
