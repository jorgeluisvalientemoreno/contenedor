PROMPT Crea sinonimo objeto dependiente LDC_PLANTEMP
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_PLANTEMP FOR LDC_PLANTEMP';
END;
/
