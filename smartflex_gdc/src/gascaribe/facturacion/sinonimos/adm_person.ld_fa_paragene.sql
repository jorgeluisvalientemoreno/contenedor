PROMPT Crea Sinonimo a tabla ld_fa_paragene
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_FA_PARAGENE FOR LD_FA_PARAGENE';
END;
/