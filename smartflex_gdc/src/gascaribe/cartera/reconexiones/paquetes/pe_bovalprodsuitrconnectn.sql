SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento PE_BOVALPRODSUITRCONNECTN
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'PE_BOVALPRODSUITRCONNECTN'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE PE_BOVALPRODSUITRCONNECTN';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento PE_BOVALPRODSUITRCONNECTN - ' || sqlerrm);
END;
/
