PROMPT Crea Sinonimo a funciOn fdtfecha
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM fdtfecha FOR ADM_PERSON.fdtfecha';
END;
/