SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDCPROVALDTADCERTOIA
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDCPROVALDTADCERTOIA'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE LDCPROVALDTADCERTOIA';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDCPROVALDTADCERTOIA - ' || sqlerrm);
END;
/
