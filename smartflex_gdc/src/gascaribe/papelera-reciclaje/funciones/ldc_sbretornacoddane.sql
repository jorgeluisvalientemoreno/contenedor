SET SERVEROUTPUT ON;
PROMPT BORRAR FUNCION ldc_sbretornacoddane
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            LOWER(object_name) = 'ldc_sbretornacoddane'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP FUNCTION ldc_sbretornacoddane';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar la funci�n ldc_sbretornacoddane, ' || sqlerrm);
END;
/