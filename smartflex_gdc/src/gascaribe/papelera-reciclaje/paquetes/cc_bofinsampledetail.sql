SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento CC_BOFINSAMPLEDETAIL
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'CC_BOFINSAMPLEDETAIL'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE CC_BOFINSAMPLEDETAIL';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento CC_BOFINSAMPLEDETAIL - ' || sqlerrm);
END;
/
