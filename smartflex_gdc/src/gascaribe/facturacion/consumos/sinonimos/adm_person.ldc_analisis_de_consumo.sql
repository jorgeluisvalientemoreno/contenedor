PROMPT Crea sinonimo objeto dependiente LDC_ANALISIS_DE_CONSUMO
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_ANALISIS_DE_CONSUMO FOR LDC_ANALISIS_DE_CONSUMO';
END;
/
