SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento DALDC_DETALLE_MET_COTIZ
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'DALDC_DETALLE_MET_COTIZ'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE DALDC_DETALLE_MET_COTIZ';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento DALDC_DETALLE_MET_COTIZ - ' || sqlerrm);
END;
/
