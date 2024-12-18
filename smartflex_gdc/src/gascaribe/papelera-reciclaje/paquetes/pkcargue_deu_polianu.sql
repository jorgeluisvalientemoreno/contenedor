SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento PKCARGUE_DEU_POLIANU
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'PKCARGUE_DEU_POLIANU'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE PKCARGUE_DEU_POLIANU';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento PKCARGUE_DEU_POLIANU - ' || sqlerrm);
END;
/
