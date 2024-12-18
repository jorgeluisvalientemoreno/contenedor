SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDCI_VALIDA_CERTIF_OIA
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDCI_VALIDA_CERTIF_OIA'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE LDCI_VALIDA_CERTIF_OIA';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDCI_VALIDA_CERTIF_OIA - ' || sqlerrm);
END;
/
