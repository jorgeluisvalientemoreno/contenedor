Prompt Creando sinonimos privados para OPEN.ge_organizat_area
BEGIN
    -- OSF-4010
    pkg_Utilidades.prCrearSinonimos(upper('ge_organizat_area'), upper('OPEN'));
END;
/
Prompt Creando sinonimo privado en MULTIEMPRESA para OPEN.ge_organizat_area
BEGIN
    -- OSF-4010
    EXECUTE IMMEDIATE ( 'CREATE OR REPLACE SYNONYM MULTIEMPRESA.ge_organizat_area FOR OPEN.ge_organizat_area' );
END;
/