SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LD_BORTAINTERACCION
DECLARE
    nuconta NUMBER;
    nucontaSyn NUMBER;
BEGIN
    
    --Valida existencia de objeto    
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LD_BORTAINTERACCION'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP package OPEN.LD_BORTAINTERACCION';
    END IF;
    
    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'LD_BORTAINTERACCION'
    AND OWNER = 'OPEN';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM OPEN.LD_BORTAINTERACCION FORCE';
        EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.LD_BORTAINTERACCION FORCE';
    END IF;  
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento OPEN.LD_BORTAINTERACCION - ' || sqlerrm);
END;
/
