PROMPT Crea sinonimo objeto FTP
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM FTP FOR ADM_PERSON.FTP';
END;
/