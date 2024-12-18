SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento GDO_MATRIZTRANSDETERIO
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'GDO_MATRIZTRANSDETERIO'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE GDO_MATRIZTRANSDETERIO';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento GDO_MATRIZTRANSDETERIO - ' || sqlerrm);
END;
/
