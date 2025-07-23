Prompt Creando sinonimos privados para sobre personalizaciones.pkg_bofinanciacion
BEGIN
    -- OSF-3893
    pkg_Utilidades.prCrearSinonimos(upper('pkg_bofinanciacion'), upper('personalizaciones'));
END;
/