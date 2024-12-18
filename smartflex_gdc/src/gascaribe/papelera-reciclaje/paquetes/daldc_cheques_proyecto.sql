SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento DALDC_CHEQUES_PROYECTO
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'DALDC_CHEQUES_PROYECTO'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE DALDC_CHEQUES_PROYECTO';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento DALDC_CHEQUES_PROYECTO - ' || sqlerrm);
END;
/
