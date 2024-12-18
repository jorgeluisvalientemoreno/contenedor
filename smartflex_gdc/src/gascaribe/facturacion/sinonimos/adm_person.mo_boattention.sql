PROMPT Crea Sinonimo a tabla mo_boattention
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.mo_boattention FOR mo_boattention';
END;
/