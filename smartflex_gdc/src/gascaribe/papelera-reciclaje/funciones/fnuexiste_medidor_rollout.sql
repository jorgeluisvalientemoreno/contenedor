SET SERVEROUTPUT ON;
PROMPT BORRAR FUNCION fnuexiste_medidor_rollout
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            LOWER(object_name) = 'fnuexiste_medidor_rollout'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP FUNCTION fnuexiste_medidor_rollout';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar la función fnuexiste_medidor_rollout, ' || sqlerrm);
END;
/