PROMPT Crea sinonimo objeto dependiente PE_TASK_TYPE_TAX
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.PE_TASK_TYPE_TAX FOR PE_TASK_TYPE_TAX';
END;
/