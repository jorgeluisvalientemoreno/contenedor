PROMPT Crea Sinonimo a Tabla GE_SCHOOL_DEGREE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.GE_SCHOOL_DEGREE FOR  GE_SCHOOL_DEGREE';
END;
/