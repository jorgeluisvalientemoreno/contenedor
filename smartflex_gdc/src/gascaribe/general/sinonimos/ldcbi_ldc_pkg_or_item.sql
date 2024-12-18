Prompt Creando sinonimos privados para sobre OPEN.LDCBI_LDC_PKG_OR_ITEM
BEGIN
    -- OSF-3383
    pkg_Utilidades.prCrearSinonimos(upper('LDCBI_LDC_PKG_OR_ITEM'), 'OPEN');
END;
/