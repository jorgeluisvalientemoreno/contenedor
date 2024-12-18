SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento DL_COMMON_VARIABLES
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'DL_COMMON_VARIABLES'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE DL_COMMON_VARIABLES';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento DL_COMMON_VARIABLES - ' || sqlerrm);
END;
/
