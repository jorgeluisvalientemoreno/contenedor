SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento GE_BODAOPACKAGEGENERATOR
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'GE_BODAOPACKAGEGENERATOR'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE GE_BODAOPACKAGEGENERATOR';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento GE_BODAOPACKAGEGENERATOR - ' || sqlerrm);
END;
/
