SET SERVEROUTPUT ON;
PROMPT BORRAR FUNCION ldc_retornaflagasounidper
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            LOWER(object_name) = 'ldc_retornaflagasounidper'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP FUNCTION ldc_retornaflagasounidper';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar la función ldc_retornaflagasounidper, ' || sqlerrm);
END;
/