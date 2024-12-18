SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento ADM_PERSON.LDC_CONSULTACERTVIGTEC
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDC_CONSULTACERTVIGTEC'
        AND owner = 'ADM_PERSON'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP FUNCTION ADM_PERSON.LDC_CONSULTACERTVIGTEC';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar la función ADM_PERSON.LDC_CONSULTACERTVIGTEC - ' || sqlerrm);
END;
/
