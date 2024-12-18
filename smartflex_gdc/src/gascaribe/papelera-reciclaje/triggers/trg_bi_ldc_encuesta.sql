SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento TRG_BI_LDC_ENCUESTA
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'TRG_BI_LDC_ENCUESTA'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP TRIGGER TRG_BI_LDC_ENCUESTA';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento TRG_BI_LDC_ENCUESTA - ' || sqlerrm);
END;
/
