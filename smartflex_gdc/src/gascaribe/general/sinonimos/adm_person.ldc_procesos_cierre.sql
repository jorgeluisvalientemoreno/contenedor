PROMPT Crea Sinonimo a Tabla LDC_PROCESOS_CIERRE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_PROCESOS_CIERRE FOR LDC_PROCESOS_CIERRE';
END;
/