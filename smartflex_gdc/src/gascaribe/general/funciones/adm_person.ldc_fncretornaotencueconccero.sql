SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento ADM_PERSON.LDC_FNCRETORNAOTENCUECONCCERO
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LDC_FNCRETORNAOTENCUECONCCERO'
        AND owner = 'ADM_PERSON'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP FUNCTION ADM_PERSON.LDC_FNCRETORNAOTENCUECONCCERO';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento ADM_PERSON.LDC_FNCRETORNAOTENCUECONCCERO - ' || sqlerrm);
END;
/
