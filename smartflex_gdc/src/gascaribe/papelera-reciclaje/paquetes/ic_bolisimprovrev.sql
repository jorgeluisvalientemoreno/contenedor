SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento IC_BOLISIMPROVREV
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'IC_BOLISIMPROVREV'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE IC_BOLISIMPROVREV';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento IC_BOLISIMPROVREV - ' || sqlerrm);
END;
/
