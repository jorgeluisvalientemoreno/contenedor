PROMPT Crea Sinonimo a tabla LDC_CONSTRUCTION_SERVICE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_CONSTRUCTION_SERVICE FOR LDC_CONSTRUCTION_SERVICE';
END;
/