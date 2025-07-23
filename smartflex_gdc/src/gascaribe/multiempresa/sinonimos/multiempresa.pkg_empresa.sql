Prompt Creando sinonimos privados para sobre multiempresa.pkg_empresa
BEGIN
    -- OSF-3940
    pkg_Utilidades.prCrearSinonimos(upper('pkg_empresa'), upper('multiempresa'));
END;
/