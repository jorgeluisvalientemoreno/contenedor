PROMPT Crea sinonimo objeto dependiente PKBOPAGOANTICIPADO
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.PKBOPAGOANTICIPADO FOR PKBOPAGOANTICIPADO';
END;
/
