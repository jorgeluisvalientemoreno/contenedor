PROMPT Crea sinonimo objeto dependiente GE_CIVIL_STATE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.GE_CIVIL_STATE FOR GE_CIVIL_STATE';
END;
/
