PROMPT Crea sinonimo objeto dependiente LDC_ITEMSCOTIMETRAJE_ADIC
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_ITEMSCOTIMETRAJE_ADIC FOR LDC_ITEMSCOTIMETRAJE_ADIC';
END;
/