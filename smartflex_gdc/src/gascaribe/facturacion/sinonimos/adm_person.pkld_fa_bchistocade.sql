PROMPT Crea sinonimo objeto PKLD_FA_BCHISTOCADE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM PKLD_FA_BCHISTOCADE FOR ADM_PERSON.PKLD_FA_BCHISTOCADE';
END;
/