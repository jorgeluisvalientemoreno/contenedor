PROMPT Crea Sinonimo a FUNCION GC_BODEBTMANAGEMENT
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.GC_BODEBTMANAGEMENT FOR GC_BODEBTMANAGEMENT';
END;
/