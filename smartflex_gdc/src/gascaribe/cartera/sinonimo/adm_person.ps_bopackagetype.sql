PROMPT Crea Sinonimo a paquete PS_BOPACKAGETYPE para LDC_UIATENDEVSALDOFAVOR_PROC
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.PS_BOPACKAGETYPE FOR PS_BOPACKAGETYPE';
END;
/