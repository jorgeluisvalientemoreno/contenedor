PROMPT Crea sinonimo objeto dependiente LDC_BOPAYMENT
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_BOPAYMENT FOR LDC_BOPAYMENT';
END;
/