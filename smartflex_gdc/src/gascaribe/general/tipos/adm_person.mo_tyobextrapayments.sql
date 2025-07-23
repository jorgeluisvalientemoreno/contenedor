PROMPT Crea TYPE MO_TYOBEXTRAPAYMENTS
DECLARE
    nucontaSyn NUMBER;
    nuExisTp   NUMBER;
BEGIN

    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'MO_TYOBEXTRAPAYMENTS'
    AND OWNER = 'ADM_PERSON';

    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.MO_TYOBEXTRAPAYMENTS FORCE';
    END IF; 

    --valida si el tipo ya esta creado
    SELECT COUNT(*)
    INTO nuExisTp
    FROM
        dba_objects
    WHERE
        UPPER(object_name) = 'MO_TYOBEXTRAPAYMENTS'
        AND OWNER = 'ADM_PERSON'
        AND OBJECT_TYPE = 'TYPE';

    IF nuExisTp > 0 THEN
        EXECUTE IMMEDIATE   'DROP TYPE ADM_PERSON.MO_TYOBEXTRAPAYMENTS FORCE';
    END IF;                        
END;
/
GRANT EXECUTE ON MO_TYOBEXTRAPAYMENTS TO ADM_PERSON;
/
GRANT EXECUTE ON MO_TYOBEXTRAPAYMENTS TO PERSONALIZACIONES;
/