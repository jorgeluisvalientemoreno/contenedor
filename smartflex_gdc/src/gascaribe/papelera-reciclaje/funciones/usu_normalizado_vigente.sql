SET SERVEROUTPUT ON;
PROMPT BORRAR FUNCION usu_normalizado_vigente
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            LOWER(object_name) = 'usu_normalizado_vigente'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP FUNCTION usu_normalizado_vigente';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar la función usu_normalizado_vigente, ' || sqlerrm);
END;
/