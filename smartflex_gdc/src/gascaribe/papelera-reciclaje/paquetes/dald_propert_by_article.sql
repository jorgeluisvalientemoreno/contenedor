SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento DALD_PROPERT_BY_ARTICLE
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'DALD_PROPERT_BY_ARTICLE'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE DALD_PROPERT_BY_ARTICLE';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento DALD_PROPERT_BY_ARTICLE - ' || sqlerrm);
END;
/
