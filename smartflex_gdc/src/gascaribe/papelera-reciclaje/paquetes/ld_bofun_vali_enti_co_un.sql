SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LD_BOFUN_VALI_ENTI_CO_UN
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LD_BOFUN_VALI_ENTI_CO_UN'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE LD_BOFUN_VALI_ENTI_CO_UN';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LD_BOFUN_VALI_ENTI_CO_UN - ' || sqlerrm);
END;
/
