PROMPT Crea Sinonimo a tabla LD_PRODAPPLYSUSPEND para LDCCREATETRAMITERECONEXIONXML
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_PRODAPPLYSUSPEND FOR LD_PRODAPPLYSUSPEND';
END;
/