PROMPT Crea sinonimo objeto dependiente CC_BOPETITIONMGR
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.CC_BOPETITIONMGR FOR CC_BOPETITIONMGR';
END;
/