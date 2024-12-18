SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento DALDC_AUDIT_CUOT_PROY
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'DALDC_AUDIT_CUOT_PROY'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE DALDC_AUDIT_CUOT_PROY';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento DALDC_AUDIT_CUOT_PROY - ' || sqlerrm);
END;
/
