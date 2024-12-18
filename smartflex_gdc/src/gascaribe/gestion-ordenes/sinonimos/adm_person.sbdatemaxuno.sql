PROMPT Crea sinonimo a la funciOn sbdatemaxuno
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM sbdatemaxuno FOR ADM_PERSON.sbdatemaxuno';
END;
/