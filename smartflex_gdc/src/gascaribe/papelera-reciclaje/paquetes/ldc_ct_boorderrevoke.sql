SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDC_CT_BOORDERREVOKE
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDC_CT_BOORDERREVOKE'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE LDC_CT_BOORDERREVOKE';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_CT_BOORDERREVOKE - ' || sqlerrm);
END;
/
