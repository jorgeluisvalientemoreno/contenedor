PROMPT GRANT objeto dependiente LDCFA_TYOBCERTSTATEMENT
BEGIN
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON LDCFA_TYOBCERTSTATEMENT TO ADM_PERSON';
END;
/