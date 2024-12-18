SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento DALD_BILL_PENDING_PAYMENT
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'DALD_BILL_PENDING_PAYMENT'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE DALD_BILL_PENDING_PAYMENT';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento DALD_BILL_PENDING_PAYMENT - ' || sqlerrm);
END;
/
