PROMPT Crea sinonimo objeto dependiente LDC_ACTCALLCENTER
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_ACTCALLCENTER FOR LDC_ACTCALLCENTER';
END;
/
