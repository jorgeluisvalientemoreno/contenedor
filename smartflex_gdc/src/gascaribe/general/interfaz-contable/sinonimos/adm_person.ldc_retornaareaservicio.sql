PROMPT CREA SINONIMO LDC_RETORNAAREASERVICIO
BEGIN
 EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_RETORNAAREASERVICIO FOR ADM_PERSON.LDC_RETORNAAREASERVICIO';
END;
/