SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDCX_PKCLIENTESBRILLA
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDCX_PKCLIENTESBRILLA'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE LDCX_PKCLIENTESBRILLA';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDCX_PKCLIENTESBRILLA - ' || sqlerrm);
END;
/