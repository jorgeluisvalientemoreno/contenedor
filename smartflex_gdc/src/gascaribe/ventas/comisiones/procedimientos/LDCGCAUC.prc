SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LDCGCAUC
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDCGCAUC'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE LDCGCAUC';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDCGCAUC - ' || sqlerrm);
END;
/
