SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento LD_UNIT_OPER_INDUS
DECLARE
    nuconta NUMBER;
    nucontaSyn NUMBER;
    
BEGIN
    SELECT
        COUNT(*)
    INTO nuconta
    FROM
        dba_objects
    WHERE
            UPPER(object_name) = 'LD_UNIT_OPER_INDUS'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP PACKAGE LD_UNIT_OPER_INDUS';
    END IF;
    
    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'LD_UNIT_OPER_INDUS'
    AND OWNER = 'ADM_PERSON';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.LD_UNIT_OPER_INDUS FORCE';
    END IF; 
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LD_UNIT_OPER_INDUS - ' || sqlerrm);
END;
/
