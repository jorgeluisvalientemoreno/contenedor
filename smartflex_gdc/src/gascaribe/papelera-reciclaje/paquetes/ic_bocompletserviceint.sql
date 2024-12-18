SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento IC_BOCOMPLETSERVICEINT
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'IC_BOCOMPLETSERVICEINT'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE IC_BOCOMPLETSERVICEINT';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento IC_BOCOMPLETSERVICEINT - ' || sqlerrm);
END;
/
