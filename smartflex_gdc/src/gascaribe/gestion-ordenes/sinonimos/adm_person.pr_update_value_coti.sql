PROMPT Crea sinonimo objeto dependiente PR_UPDATE_VALUE_COTI
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM PR_UPDATE_VALUE_COTI FOR ADM_PERSON.PR_UPDATE_VALUE_COTI';
END;
/