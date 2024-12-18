Prompt Creando sinonimos privados para sobre OPEN.LDCBI_CC_FINANCING_REQUEST
BEGIN
    -- OSF-3450
    pkg_Utilidades.prCrearSinonimos(upper('LDCBI_CC_FINANCING_REQUEST'), 'OPEN');
END;
/