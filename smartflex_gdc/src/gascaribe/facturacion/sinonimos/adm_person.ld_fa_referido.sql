PROMPT Crea sinonimo objeto dependiente LD_FA_REFERIDO
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_FA_REFERIDO FOR LD_FA_REFERIDO';
END;
/