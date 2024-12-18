SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDC_PROCONTROL_DUPLICADO
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDC_PROCONTROL_DUPLICADO'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE LDC_PROCONTROL_DUPLICADO';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_PROCONTROL_DUPLICADO - ' || sqlerrm);
END;
/
