PROMPT Crea Sinonimo a paquete DAAB_ADDRESS para la funcion FSBGETFNBINFO
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.DAAB_ADDRESS FOR DAAB_ADDRESS';
END;
/