PROMPT Crea sinonimo objeto dependiente LDC_NOTAS_MASIVAS
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_NOTAS_MASIVAS FOR LDC_NOTAS_MASIVAS';
END;
/