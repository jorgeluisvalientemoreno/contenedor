SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento PKTBLLDC_RESOGURE
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'PKTBLLDC_RESOGURE'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE PKTBLLDC_RESOGURE';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento PKTBLLDC_RESOGURE - ' || sqlerrm);
END;
/
