SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDC_REGISTER_DATOS_ACTUALIZAR
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDC_REGISTER_DATOS_ACTUALIZAR'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE LDC_REGISTER_DATOS_ACTUALIZAR';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_REGISTER_DATOS_ACTUALIZAR - ' || sqlerrm);
END;
/