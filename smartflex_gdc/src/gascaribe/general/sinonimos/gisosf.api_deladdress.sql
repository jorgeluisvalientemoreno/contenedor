BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM GISOSF.API_DELADDRESS FOR ADM_PERSON.API_DELADDRESS';
END;
/