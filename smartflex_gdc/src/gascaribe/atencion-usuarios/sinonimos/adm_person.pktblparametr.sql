PROMPT Crea sinonimo objeto dependiente PKTBLPARAMETR
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.PKTBLPARAMETR FOR PKTBLPARAMETR';
END;
/
