PROMPT Crea Sinonimo a tabla seterrordesc
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.seterrordesc FOR seterrordesc';
END;
/