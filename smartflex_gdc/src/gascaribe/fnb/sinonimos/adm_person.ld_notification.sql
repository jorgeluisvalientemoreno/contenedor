PROMPT Crea sinonimo objeto dependiente LD_NOTIFICATION
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_NOTIFICATION FOR LD_NOTIFICATION';
END;
/
