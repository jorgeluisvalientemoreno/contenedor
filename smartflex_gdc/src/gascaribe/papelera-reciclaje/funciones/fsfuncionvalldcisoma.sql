SET SERVEROUTPUT ON;
PROMPT BORRAR FUNCION fsfuncionvalldcisoma
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            LOWER(object_name) = 'fsfuncionvalldcisoma'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP FUNCTION fsfuncionvalldcisoma';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar la funci�n fsfuncionvalldcisoma, ' || sqlerrm);
END;
/