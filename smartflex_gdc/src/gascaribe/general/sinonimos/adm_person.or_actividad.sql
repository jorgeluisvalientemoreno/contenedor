PROMPT Crea sinonimo objeto dependiente OR_ACTIVIDAD
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.OR_ACTIVIDAD FOR OR_ACTIVIDAD';
END;
/