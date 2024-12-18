SET SERVEROUTPUT ON;
PROMPT BORRAR FUNCION ld_fa_fnu_area_type
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            LOWER(object_name) = 'ld_fa_fnu_area_type'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP FUNCTION ld_fa_fnu_area_type';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar la función ld_fa_fnu_area_type, ' || sqlerrm);
END;
/