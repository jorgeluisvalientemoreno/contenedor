PROMPT Crea sinonimo objeto dependiente LDC_CAUS_PACK_TYPE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_CAUS_PACK_TYPE FOR LDC_CAUS_PACK_TYPE';
END;
/