PROMPT Crea Sinonimo a tabla LD_CONSE_HISTORIC_SALES
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_CONSE_HISTORIC_SALES FOR LD_CONSE_HISTORIC_SALES';
END;
/