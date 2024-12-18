SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDC_AB_BOADDRESSCHANGE
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDC_AB_BOADDRESSCHANGE'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE LDC_AB_BOADDRESSCHANGE';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_AB_BOADDRESSCHANGE - ' || sqlerrm);
END;
/
