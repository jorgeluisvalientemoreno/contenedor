SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento DALD_POLICY_EXCLUSION
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'DALD_POLICY_EXCLUSION'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE DALD_POLICY_EXCLUSION';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento DALD_POLICY_EXCLUSION - ' || sqlerrm);
END;
/
