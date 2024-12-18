SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDC_VAL_CAUS_APELACION
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDC_VAL_CAUS_APELACION'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE LDC_VAL_CAUS_APELACION';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_VAL_CAUS_APELACION - ' || sqlerrm);
END;
/
