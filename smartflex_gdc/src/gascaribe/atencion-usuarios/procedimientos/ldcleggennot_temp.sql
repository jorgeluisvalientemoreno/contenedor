SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDCLEGGENNOT_TEMP
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDCLEGGENNOT_TEMP'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE LDCLEGGENNOT_TEMP';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDCLEGGENNOT_TEMP - ' || sqlerrm);
END;
/
