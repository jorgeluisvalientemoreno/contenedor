SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento PRC_UD_CLOB_ED_DOCUMENT
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'PRC_UD_CLOB_ED_DOCUMENT'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE PRC_UD_CLOB_ED_DOCUMENT';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento PRC_UD_CLOB_ED_DOCUMENT - ' || sqlerrm);
END;
/
