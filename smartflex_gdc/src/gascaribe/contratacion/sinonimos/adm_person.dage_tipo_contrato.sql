PROMPT Crea sinonimo objeto dependiente DAGE_TIPO_CONTRATO
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.DAGE_TIPO_CONTRATO FOR DAGE_TIPO_CONTRATO';
END;
/