PROMPT Crea Sinonimo a tabla LD_PROMISSORY para la funcion FSBGETFNBINFO
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_PROMISSORY FOR LD_PROMISSORY';
END;
/