Prompt Creando sinonimos privados para sobre OPEN.LDCBI_AB_SEGMENTS
BEGIN
    -- OSF-3450
    pkg_Utilidades.prCrearSinonimos(upper('LDCBI_AB_SEGMENTS'), 'OPEN');
END;
/