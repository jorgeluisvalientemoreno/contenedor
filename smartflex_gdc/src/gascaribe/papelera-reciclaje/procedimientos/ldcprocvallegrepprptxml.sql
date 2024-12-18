SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDCPROCVALLEGREPPRPTXML
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDCPROCVALLEGREPPRPTXML'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE LDCPROCVALLEGREPPRPTXML';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDCPROCVALLEGREPPRPTXML - ' || sqlerrm);
END;
/
