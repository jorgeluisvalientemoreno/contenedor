PROMPT Crea sinonimo objeto dependiente LD_SEGMEN_SUPPLIER
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_SEGMEN_SUPPLIER FOR LD_SEGMEN_SUPPLIER';
END;
/