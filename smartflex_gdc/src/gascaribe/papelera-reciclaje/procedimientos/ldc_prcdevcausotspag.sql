SET SERVEROUTPUT ON;
PROMPT BORRAR FUNCION ldc_prcdevcausotspag
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            LOWER(object_name) = 'ldc_prcdevcausotspag'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE ldc_prcdevcausotspag';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar la funcion ldc_prcdevcausotspag, ' || sqlerrm);
END;
/