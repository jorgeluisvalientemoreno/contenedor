Prompt Creando sinonimos privados para sobre multiempresa.pkg_materiales
BEGIN
    -- OSF-4204
    pkg_Utilidades.prCrearSinonimos(upper('pkg_materiales'), upper('multiempresa'));
END;
/