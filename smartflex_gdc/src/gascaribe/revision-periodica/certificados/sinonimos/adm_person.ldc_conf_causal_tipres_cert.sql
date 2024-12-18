PROMPT Crea sinonimo objeto dependiente ldc_conf_causal_tipres_cert
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.ldc_conf_causal_tipres_cert FOR ldc_conf_causal_tipres_cert';
END;
/
