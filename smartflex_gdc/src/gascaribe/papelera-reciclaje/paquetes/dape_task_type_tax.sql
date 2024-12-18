SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento DAPE_TASK_TYPE_TAX
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'DAPE_TASK_TYPE_TAX'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE DAPE_TASK_TYPE_TAX';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento DAPE_TASK_TYPE_TAX - ' || sqlerrm);
END;
/
