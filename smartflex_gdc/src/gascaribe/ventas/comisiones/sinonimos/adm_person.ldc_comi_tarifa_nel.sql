PROMPT Crea sinonimo objeto dependiente LDC_COMI_TARIFA_NEL
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_COMI_TARIFA_NEL FOR LDC_COMI_TARIFA_NEL';
END;
/