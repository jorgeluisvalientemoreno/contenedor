Prompt Otorgando permiso de ejecucion a ADM_PERSON sobre OPEN.UT_TRACE
BEGIN
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON OPEN.pkboprocctrlbyservicemgr TO ADM_PERSON';
END;
/