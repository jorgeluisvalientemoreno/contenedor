SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDC_ITEM_DESPLAZAMIENTO
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDC_ITEM_DESPLAZAMIENTO'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE LDC_ITEM_DESPLAZAMIENTO';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_ITEM_DESPLAZAMIENTO - ' || sqlerrm);
END;
/
