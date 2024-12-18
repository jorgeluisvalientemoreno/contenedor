Prompt Creando sinonimos privados para sobre OPEN.LDCBI_LDC_PRODTATT
BEGIN
    -- OSF-3383
    pkg_Utilidades.prCrearSinonimos(upper('LDCBI_LDC_PRODTATT'), 'OPEN');
END;
/