SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento EXPRESAR_EN_LETRAS
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'EXPRESAR_EN_LETRAS'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE EXPRESAR_EN_LETRAS';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento EXPRESAR_EN_LETRAS - ' || sqlerrm);
END;
/
