PROMPT Crea sinonimo objeto DALDCI_TRSOITEM
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALDCI_TRSOITEM FOR ADM_PERSON.DALDCI_TRSOITEM';
END;
/