SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDCPLUGINMARCREPAINTEGR
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDCPLUGINMARCREPAINTEGR'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE LDCPLUGINMARCREPAINTEGR';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDCPLUGINMARCREPAINTEGR - ' || sqlerrm);
END;
/
