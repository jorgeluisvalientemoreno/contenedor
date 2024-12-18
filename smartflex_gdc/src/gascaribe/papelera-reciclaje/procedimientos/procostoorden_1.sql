SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento PROCOSTOORDEN_1
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'PROCOSTOORDEN_1'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE PROCOSTOORDEN_1';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento PROCOSTOORDEN_1 - ' || sqlerrm);
END;
/
