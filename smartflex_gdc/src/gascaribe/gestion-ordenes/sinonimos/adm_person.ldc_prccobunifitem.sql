PROMPT Crea sinonimo a la funciOn ldc_prccobunifitem
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_prccobunifitem FOR ADM_PERSON.ldc_prccobunifitem';
END;
/