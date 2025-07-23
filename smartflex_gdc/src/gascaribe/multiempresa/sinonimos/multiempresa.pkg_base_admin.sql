Prompt Creando sinonimos privados para sobre multiempresa.pkg_base_admin
BEGIN
    -- OSF-3988
    pkg_Utilidades.prCrearSinonimos(upper('pkg_base_admin'), upper('multiempresa'));
END;
/