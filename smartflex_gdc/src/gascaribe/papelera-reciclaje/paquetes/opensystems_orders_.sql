SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento OPENSYSTEMS_ORDERS_
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'OPENSYSTEMS_ORDERS_'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE OPENSYSTEMS_ORDERS_';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento OPENSYSTEMS_ORDERS_ - ' || sqlerrm);
END;
/
