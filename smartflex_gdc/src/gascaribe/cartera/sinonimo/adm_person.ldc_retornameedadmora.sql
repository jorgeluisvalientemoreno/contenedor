PROMPT Crea sinonimo a la funciOn ldc_retornameedadmora
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_retornameedadmora FOR ADM_PERSON.ldc_retornameedadmora';
END;
/