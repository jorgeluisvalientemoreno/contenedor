PROMPT Crea Sinonimo a tabla LD_POS_SETTINGS
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_POS_SETTINGS FOR LD_POS_SETTINGS';
END;
/
