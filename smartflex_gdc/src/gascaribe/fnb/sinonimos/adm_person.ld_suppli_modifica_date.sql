PROMPT Crea sinonimo objeto dependiente LD_SUPPLI_MODIFICA_DATE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_SUPPLI_MODIFICA_DATE FOR LD_SUPPLI_MODIFICA_DATE';
END;
/