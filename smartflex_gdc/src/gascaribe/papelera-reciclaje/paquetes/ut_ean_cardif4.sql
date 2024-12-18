SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento UT_EAN_CARDIF4
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'UT_EAN_CARDIF4'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE UT_EAN_CARDIF4';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento UT_EAN_CARDIF4 - ' || sqlerrm);
END;
/
