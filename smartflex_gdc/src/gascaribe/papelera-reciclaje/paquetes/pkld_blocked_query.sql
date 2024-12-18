SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento PKLD_BLOCKED_QUERY
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'PKLD_BLOCKED_QUERY'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE PKLD_BLOCKED_QUERY';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento PKLD_BLOCKED_QUERY - ' || sqlerrm);
END;
/
