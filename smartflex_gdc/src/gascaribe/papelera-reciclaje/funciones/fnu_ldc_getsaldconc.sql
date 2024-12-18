SET SERVEROUTPUT ON;
PROMPT BORRAR FUNCION fnu_ldc_getsaldconc
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            LOWER(object_name) = 'fnu_ldc_getsaldconc'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP FUNCTION fnu_ldc_getsaldconc';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar la función fnu_ldc_getsaldconc, ' || sqlerrm);
END;
/