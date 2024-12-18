Prompt Creando sinonimos privados para sobre OPEN.LDCBI_LDC_SEGMENT_SUSC
BEGIN
    -- OSF-3383
    pkg_Utilidades.prCrearSinonimos(upper('LDCBI_LDC_SEGMENT_SUSC'), 'OPEN');
END;
/