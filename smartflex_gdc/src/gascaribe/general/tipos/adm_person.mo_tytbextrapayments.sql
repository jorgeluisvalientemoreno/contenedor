PROMPT Crea TYPE MO_TYTBEXTRAPAYMENTS
DECLARE
    nuconta NUMBER;
BEGIN
    
    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nuconta 
    FROM dba_objects
    WHERE UPPER(object_name) = 'MO_TYTBEXTRAPAYMENTS'
    AND OWNER = 'ADM_PERSON'
    AND OBJECT_TYPE = 'TYPE';
    
    IF nuconta > 0 THEN
        EXECUTE IMMEDIATE 'DROP TYPE ADM_PERSON.MO_TYTBEXTRAPAYMENTS FORCE';
    END IF; 
END;
/
GRANT EXECUTE ON MO_TYTBEXTRAPAYMENTS TO ADM_PERSON;
/
GRANT EXECUTE ON MO_TYTBEXTRAPAYMENTS TO PERSONALIZACIONES;
/
