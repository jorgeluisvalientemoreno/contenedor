SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDC_FUNCIONES_PARA_ORMS
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDC_FUNCIONES_PARA_ORMS'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE LDC_FUNCIONES_PARA_ORMS';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_FUNCIONES_PARA_ORMS - ' || sqlerrm);
END;
/
