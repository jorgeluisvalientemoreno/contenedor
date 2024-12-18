SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LD_BOREADINGORDERDATA
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LD_BOREADINGORDERDATA'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP package LD_BOREADINGORDERDATA';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LD_BOREADINGORDERDATA - ' || sqlerrm);
END;
/
