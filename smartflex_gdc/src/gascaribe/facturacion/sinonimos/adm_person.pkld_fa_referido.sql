PROMPT Crea sinonimo objeto PKLD_FA_REFERIDO
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM PKLD_FA_REFERIDO FOR ADM_PERSON.PKLD_FA_REFERIDO';
END;
/