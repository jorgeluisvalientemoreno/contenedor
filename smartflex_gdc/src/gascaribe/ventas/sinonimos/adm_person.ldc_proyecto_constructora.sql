PROMPT Crea sinonimo objeto dependiente LDC_PROYECTO_CONSTRUCTORA
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_PROYECTO_CONSTRUCTORA FOR LDC_PROYECTO_CONSTRUCTORA';
END;
/
