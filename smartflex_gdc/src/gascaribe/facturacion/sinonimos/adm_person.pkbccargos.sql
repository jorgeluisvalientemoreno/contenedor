PROMPT Crea sinonimo objeto dependiente PKBCCARGOS
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.PKBCCARGOS FOR PKBCCARGOS';
END;
/