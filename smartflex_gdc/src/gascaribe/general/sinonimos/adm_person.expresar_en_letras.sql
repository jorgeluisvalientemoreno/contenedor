PROMPT Crea sinonimo objeto EXPRESAR_EN_LETRAS
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM EXPRESAR_EN_LETRAS FOR ADM_PERSON.EXPRESAR_EN_LETRAS';
END;
/