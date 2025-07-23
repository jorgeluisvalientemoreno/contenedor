Prompt Creando sinonimos privados para sobre multiempresa.pkg_contratista
BEGIN
    -- OSF-3970
    pkg_Utilidades.prCrearSinonimos(upper('pkg_contratista'), upper('multiempresa'));
END;
/