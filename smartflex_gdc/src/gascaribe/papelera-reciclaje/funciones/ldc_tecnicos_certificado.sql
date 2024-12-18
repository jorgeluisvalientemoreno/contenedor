SET SERVEROUTPUT ON;
PROMPT BORRAR FUNCION ldc_tecnicos_certificado
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            LOWER(object_name) = 'ldc_tecnicos_certificado'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP FUNCTION ldc_tecnicos_certificado';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar la función ldc_tecnicos_certificado, ' || sqlerrm);
END;
/