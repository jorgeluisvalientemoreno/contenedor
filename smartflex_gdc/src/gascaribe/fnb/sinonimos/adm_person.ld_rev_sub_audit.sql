PROMPT Crea sinonimo objeto dependiente LD_REV_SUB_AUDIT
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_REV_SUB_AUDIT FOR LD_REV_SUB_AUDIT';
END;
/
