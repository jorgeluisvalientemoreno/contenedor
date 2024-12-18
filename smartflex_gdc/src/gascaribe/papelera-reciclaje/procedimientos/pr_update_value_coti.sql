SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento PR_UPDATE_VALUE_COTI
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'PR_UPDATE_VALUE_COTI'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE PR_UPDATE_VALUE_COTI';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento PR_UPDATE_VALUE_COTI - ' || sqlerrm);
END;
/
