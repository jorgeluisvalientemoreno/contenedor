SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento GDO_REPORTECONSUMOS
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'GDO_REPORTECONSUMOS'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP package GDO_REPORTECONSUMOS';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento GDO_REPORTECONSUMOS - ' || sqlerrm);
END;
/
