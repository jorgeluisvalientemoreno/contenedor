PROMPT Crea Sinonimo a tabla LD_GENDER
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_GENDER FOR LD_GENDER';
END;
/