PROMPT Crea sinonimo objeto dependiente OR_TASKTYPE_ADD_DATA
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.OR_TASKTYPE_ADD_DATA FOR OR_TASKTYPE_ADD_DATA';
END;
/
