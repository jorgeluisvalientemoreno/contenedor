PROMPT Crea sinonimo objeto dependiente SEQ_LD_MOVE_SUB
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.SEQ_LD_MOVE_SUB FOR SEQ_LD_MOVE_SUB';
END;
/