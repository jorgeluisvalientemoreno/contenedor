SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento DALDC_TIPOS_TRABAJO_COT
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'DALDC_TIPOS_TRABAJO_COT'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE DALDC_TIPOS_TRABAJO_COT';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento DALDC_TIPOS_TRABAJO_COT - ' || sqlerrm);
END;
/
