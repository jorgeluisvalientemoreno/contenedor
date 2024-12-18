SET SERVEROUTPUT ON;
PROMPT BORRAR FUNCION ldc_tele_prefijo
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            LOWER(object_name) = 'ldc_tele_prefijo'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP FUNCTION ldc_tele_prefijo';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar la funci�n ldc_tele_prefijo, ' || sqlerrm);
END;
/