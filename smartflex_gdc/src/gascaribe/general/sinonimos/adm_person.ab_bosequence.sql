PROMPT Crea sinonimo objeto dependiente AB_BOSEQUENCE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.AB_BOSEQUENCE FOR AB_BOSEQUENCE';
END;
/