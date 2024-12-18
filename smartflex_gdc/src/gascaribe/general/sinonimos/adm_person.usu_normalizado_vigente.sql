PROMPT Crea sinonimo a la funciOn usu_normalizado_vigente
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM usu_normalizado_vigente FOR ADM_PERSON.usu_normalizado_vigente';
END;
/