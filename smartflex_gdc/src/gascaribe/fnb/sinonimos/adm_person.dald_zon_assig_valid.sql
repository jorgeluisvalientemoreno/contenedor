PROMPT Crea sinonimo objeto DALD_ZON_ASSIG_VALID
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALD_ZON_ASSIG_VALID FOR ADM_PERSON.DALD_ZON_ASSIG_VALID';
END;
/