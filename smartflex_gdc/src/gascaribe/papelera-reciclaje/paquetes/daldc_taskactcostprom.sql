SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento DALDC_TASKACTCOSTPROM
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'DALDC_TASKACTCOSTPROM'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE DALDC_TASKACTCOSTPROM';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento DALDC_TASKACTCOSTPROM - ' || sqlerrm);
END;
/
