PROMPT Crea TYPE MO_TYTBEXTRAPAYMENTS
DECLARE
    nucontaSyn NUMBER;
BEGIN
    
    --Valida exstencia del sinonimo
    SELECT COUNT(*)
    INTO nucontaSyn 
    FROM dba_synonyms
    WHERE UPPER(synonym_name) = 'MO_TYTBEXTRAPAYMENTS'
    AND OWNER = 'ADM_PERSON';
    
    IF nucontaSyn > 0 THEN
        EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.MO_TYTBEXTRAPAYMENTS FORCE';
    END IF; 

    EXECUTE IMMEDIATE 'create or replace TYPE adm_person.mo_tytbExtraPayments AS TABLE OF mo_tyobExtraPayments';
END;
/
