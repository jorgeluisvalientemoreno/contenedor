Prompt Creando sinonimos privados para sobre OPEN.VW_MATERIALES
BEGIN
    -- OSF-4204
    pkg_Utilidades.prCrearSinonimos(upper('VW_MATERIALES'), upper('OPEN'));
END;
/