PROMPT Crea Sinonimo a Tabla SA_TAB_MIRROR
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.SA_TAB_MIRROR FOR  SA_TAB_MIRROR';
END;
/