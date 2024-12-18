PROMPT Crea sinonimo a la funciOn obtenersaldored
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM obtenersaldored FOR ADM_PERSON.obtenersaldored';
END;
/