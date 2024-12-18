SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento DALD_CUPON_CAUSAL
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'DALD_CUPON_CAUSAL'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE DALD_CUPON_CAUSAL';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento DALD_CUPON_CAUSAL - ' || sqlerrm);
END;
/
