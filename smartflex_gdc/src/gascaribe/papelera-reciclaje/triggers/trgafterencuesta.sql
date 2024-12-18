SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento TRGAFTERENCUESTA
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'TRGAFTERENCUESTA'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP TRIGGER TRGAFTERENCUESTA';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento TRGAFTERENCUESTA - ' || sqlerrm);
END;
/
