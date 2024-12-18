SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento GDO_REPORCOMPVINCULACION
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'GDO_REPORCOMPVINCULACION'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE GDO_REPORCOMPVINCULACION';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento GDO_REPORCOMPVINCULACION - ' || sqlerrm);
END;
/
