PROMPT Crea Sinonimo a tabla LD_FNB_WARRANTY
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_FNB_WARRANTY FOR LD_FNB_WARRANTY';
END;
/