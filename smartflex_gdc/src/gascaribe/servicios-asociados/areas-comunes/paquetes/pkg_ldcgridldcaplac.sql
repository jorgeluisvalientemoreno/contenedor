SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento PKG_LDCGRIDLDCAPLAC
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'PKG_LDCGRIDLDCAPLAC'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP package PKG_LDCGRIDLDCAPLAC';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento PKG_LDCGRIDLDCAPLAC - ' || sqlerrm);
END;
/
