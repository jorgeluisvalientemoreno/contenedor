PROMPT Crea sinonimo a la funciOn nutraeutllectfact
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM nutraeutllectfact FOR ADM_PERSON.nutraeutllectfact';
END;
/