PROMPT Crea sinonimo objeto GDO_REPORTECONSUMOS
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM GDO_REPORTECONSUMOS FOR ADM_PERSON.GDO_REPORTECONSUMOS';
END;
/
