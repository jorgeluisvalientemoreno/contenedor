SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento PR_VALID_INCLUD_MAT
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'PR_VALID_INCLUD_MAT'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE PR_VALID_INCLUD_MAT';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento PR_VALID_INCLUD_MAT - ' || sqlerrm);
END;
/
