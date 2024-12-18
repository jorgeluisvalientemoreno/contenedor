SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento PGK_LDCAUTO1
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'PGK_LDCAUTO1'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP package PGK_LDCAUTO1';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento PGK_LDCAUTO1 - ' || sqlerrm);
END;
/
