PROMPT Crea sinonimo objeto dependiente LDC_ITEM_OBJ
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_ITEM_OBJ FOR LDC_ITEM_OBJ';
END;
/
