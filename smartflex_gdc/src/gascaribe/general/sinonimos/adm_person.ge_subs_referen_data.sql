PROMPT Crea sinonimo objeto dependiente GE_SUBS_REFEREN_DATA
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.GE_SUBS_REFEREN_DATA FOR GE_SUBS_REFEREN_DATA';
END;
/