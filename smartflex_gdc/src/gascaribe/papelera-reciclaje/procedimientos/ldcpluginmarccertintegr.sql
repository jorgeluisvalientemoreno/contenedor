SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDCPLUGINMARCCERTINTEGR
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDCPLUGINMARCCERTINTEGR'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE LDCPLUGINMARCCERTINTEGR';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDCPLUGINMARCCERTINTEGR - ' || sqlerrm);
END;
/
