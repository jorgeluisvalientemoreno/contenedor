SET SERVEROUTPUT ON;
PROMPT BORRAR FUNCION fnucuotainicialcom
DECLARE
    nucontaObj NUMBER;
    nucontaSyn NUMBER;
BEGIN
    --Valida existencia del objeto
    SELECT
         COUNT(*)
    INTO nucontaObj
    FROM dba_objects
    WHERE
            LOWER(object_name) = 'fnucuotainicialcom'
        AND owner = 'OPEN'
        AND object_type <> 'SYNONYM';

    IF nucontaObj > 0 THEN
        EXECUTE IMMEDIATE 'DROP FUNCTION fnucuotainicialcom';
    END IF;
    
    --Valida exstencia del sinonimo
    SELECT
        COUNT(*)
    INTO nucontaSyn
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'FNUCUOTAINICIALCOM'
    AND OWNER = 'ADM_PERSON';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.FNUCUOTAINICIALCOM FORCE';
    END IF;
    
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo realizar borrado para la fnucuotainicialcom, ' || sqlerrm);
END;
/