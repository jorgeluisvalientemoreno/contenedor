PROMPT Crea sinonimo objeto dependiente LD_PROD_LINE_GE_CONT
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_PROD_LINE_GE_CONT FOR LD_PROD_LINE_GE_CONT';
END;
/