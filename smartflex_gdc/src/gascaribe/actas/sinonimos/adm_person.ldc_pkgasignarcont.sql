PROMPT Crea Sinonimo a Paquete LDC_PKGASIGNARCONT
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_PKGASIGNARCONT FOR LDC_PKGASIGNARCONT';
END;
/