SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento PKLD_FA_BCMADESCPRPA
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'PKLD_FA_BCMADESCPRPA'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE PKLD_FA_BCMADESCPRPA';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento PKLD_FA_BCMADESCPRPA - ' || sqlerrm);
END;
/