PROMPT Crea sinonimo objeto dependiente LD_REP_INCO_SUB
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_REP_INCO_SUB FOR LD_REP_INCO_SUB';
END;
/