Prompt Creando sinonimos privados para sobre multiempresa.pkg_ciclo_facturaion
BEGIN
    -- OSF-3987
    pkg_Utilidades.prCrearSinonimos(upper('pkg_ciclo_facturacion'), upper('multiempresa'));
END;
/