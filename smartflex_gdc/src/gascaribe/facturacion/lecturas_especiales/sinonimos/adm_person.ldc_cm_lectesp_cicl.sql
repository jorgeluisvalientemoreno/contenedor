PROMPT Crea sinonimo objeto dependiente LDC_CM_LECTESP_CICL
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_CM_LECTESP_CICL FOR LDC_CM_LECTESP_CICL';
END;
/