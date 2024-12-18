Prompt Creando sinonimos privados para sobre OPEN.LDCBI_LDC_PROD_COMERC_SECTOR
BEGIN
    -- OSF-3383
    pkg_Utilidades.prCrearSinonimos(upper('LDCBI_LDC_PROD_COMERC_SECTOR'), 'OPEN');
END;
/