PROMPT CREA SINONIMO LDC_PROCCONSULTAACTASABIERTAS
BEGIN
 EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PROCCONSULTAACTASABIERTAS FOR ADM_PERSON.LDC_PROCCONSULTAACTASABIERTAS';
END;
/