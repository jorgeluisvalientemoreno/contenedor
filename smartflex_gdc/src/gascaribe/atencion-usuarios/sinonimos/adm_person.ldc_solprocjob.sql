PROMPT Crea Sinonimo a tabla ldc_solprocjob
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.ldc_solprocjob FOR ldc_solprocjob';
END;
/