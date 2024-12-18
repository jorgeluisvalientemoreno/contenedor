PROMPT Crea Sinonimo a tabla ldc_osf_castconc
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.ldc_osf_castconc FOR ldc_osf_castconc';
END;
/