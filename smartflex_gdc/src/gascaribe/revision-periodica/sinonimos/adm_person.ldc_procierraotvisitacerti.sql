PROMPT Crea sinonimo objeto dependiente LDC_PROCIERRAOTVISITACERTI
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PROCIERRAOTVISITACERTI FOR ADM_PERSON.LDC_PROCIERRAOTVISITACERTI';
END;
/