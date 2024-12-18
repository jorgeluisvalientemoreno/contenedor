SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDCFTABLE_PROCESAR
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDCFTABLE_PROCESAR'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE LDCFTABLE_PROCESAR';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDCFTABLE_PROCESAR - ' || sqlerrm);
END;
/
