PROMPT CREA SINONIMO LDC_PRUOCERTIFICACION
BEGIN
 EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PRUOCERTIFICACION FOR ADM_PERSON.LDC_PRUOCERTIFICACION';
END;
/