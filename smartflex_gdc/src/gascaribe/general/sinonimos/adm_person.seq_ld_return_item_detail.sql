PROMPT Crea sinonimo objeto dependiente SEQ_LD_RETURN_ITEM_DETAIL
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.SEQ_LD_RETURN_ITEM_DETAIL FOR SEQ_LD_RETURN_ITEM_DETAIL';
END;
/
