PROMPT CREA SINONIMO LDC_FNUCUENTASSALDOSPRODUCTO
BEGIN
 EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_FNUCUENTASSALDOSPRODUCTO FOR ADM_PERSON.LDC_FNUCUENTASSALDOSPRODUCTO';
END;
/