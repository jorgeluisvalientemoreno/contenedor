PROMPT Crea sinonimo objeto dependiente GE_BONOTIFICATION
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.GE_BONOTIFICATION FOR GE_BONOTIFICATION';
END;
/