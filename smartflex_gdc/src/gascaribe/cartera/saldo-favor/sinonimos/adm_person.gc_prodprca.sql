PROMPT Crea sinonimo objeto dependiente GC_PRODPRCA
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.GC_PRODPRCA FOR GC_PRODPRCA';
END;
/
