PROMPT Crea sinonimo objeto dependiente LDC_REGPROGESAC
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_REGPROGESAC FOR ADM_PERSON.LDC_REGPROGESAC';
END;
/