PROMPT Crea Sinonimo a tabla ldc_actualiza_sa_tab
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.ldc_actualiza_sa_tab FOR ldc_actualiza_sa_tab';
END;
/