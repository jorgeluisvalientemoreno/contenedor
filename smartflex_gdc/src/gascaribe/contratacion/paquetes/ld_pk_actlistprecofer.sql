SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LD_PK_ACTLISTPRECOFER
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LD_PK_ACTLISTPRECOFER'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE LD_PK_ACTLISTPRECOFER';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LD_PK_ACTLISTPRECOFER - ' || sqlerrm);
END;
/
