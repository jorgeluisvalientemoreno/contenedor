PROMPT Crea sinonimo objeto dependiente PKTBLIC_MOVIMIEN
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.PKTBLIC_MOVIMIEN FOR PKTBLIC_MOVIMIEN';
END;
/