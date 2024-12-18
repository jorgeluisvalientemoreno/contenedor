SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDC_VALMEDI_ORDCARGOCONEC
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDC_VALMEDI_ORDCARGOCONEC'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE LDC_VALMEDI_ORDCARGOCONEC';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_VALMEDI_ORDCARGOCONEC - ' || sqlerrm);
END;
/
