SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDCI_PROUPDOBSTATUSCERTOIAWS
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDCI_PROUPDOBSTATUSCERTOIAWS'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE LDCI_PROUPDOBSTATUSCERTOIAWS';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDCI_PROUPDOBSTATUSCERTOIAWS - ' || sqlerrm);
END;
/
