PROMPT Crea sinonimo objeto dependiente PS_CLASS_SERVICE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.PS_CLASS_SERVICE FOR PS_CLASS_SERVICE';
END;
/
