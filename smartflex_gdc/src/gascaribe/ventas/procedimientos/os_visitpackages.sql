SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento OS_VISITPACKAGES
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'OS_VISITPACKAGES'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE OS_VISITPACKAGES';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento OS_VISITPACKAGES - ' || sqlerrm);
END;
/
