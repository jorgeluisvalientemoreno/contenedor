Prompt Creando sinonimos privados para sobre multiempresa.base_admin
BEGIN
    -- OSF-3988
    pkg_Utilidades.prCrearSinonimos(upper('base_admin'), upper('multiempresa'));
END;
/