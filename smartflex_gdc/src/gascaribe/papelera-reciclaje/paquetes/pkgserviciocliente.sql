SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento PKGSERVICIOCLIENTE
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'PKGSERVICIOCLIENTE'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE PKGSERVICIOCLIENTE';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento PKGSERVICIOCLIENTE - ' || sqlerrm);
END;
/
