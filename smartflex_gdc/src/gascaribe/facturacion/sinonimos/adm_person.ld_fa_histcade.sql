PROMPT Crea sinonimo objeto dependiente LD_FA_HISTCADE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_FA_HISTCADE FOR LD_FA_HISTCADE';
END;
/