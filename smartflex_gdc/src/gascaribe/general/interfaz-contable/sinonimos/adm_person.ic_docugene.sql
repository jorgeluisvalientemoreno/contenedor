PROMPT Crea sinonimo objeto dependiente IC_DOCUGENE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.IC_DOCUGENE FOR IC_DOCUGENE';
END;
/