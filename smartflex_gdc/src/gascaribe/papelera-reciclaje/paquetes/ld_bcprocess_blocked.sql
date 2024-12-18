SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LD_BCPROCESS_BLOCKED
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LD_BCPROCESS_BLOCKED'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE LD_BCPROCESS_BLOCKED';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LD_BCPROCESS_BLOCKED - ' || sqlerrm);
END;
/
