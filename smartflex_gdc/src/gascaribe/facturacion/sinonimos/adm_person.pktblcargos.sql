PROMPT Crea sinonimo objeto dependiente PKTBLCARGOS
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.PKTBLCARGOS FOR PKTBLCARGOS';
END;
/
