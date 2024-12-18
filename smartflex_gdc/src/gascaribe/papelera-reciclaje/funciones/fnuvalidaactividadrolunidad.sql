SET SERVEROUTPUT ON;
PROMPT BORRAR FUNCION fnuvalidaactividadrolunidad
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            LOWER(object_name) = 'fnuvalidaactividadrolunidad'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP FUNCTION fnuvalidaactividadrolunidad';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar la funci�n fnuvalidaactividadrolunidad, ' || sqlerrm);
END;
/