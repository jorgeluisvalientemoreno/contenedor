Prompt Creando sinonimos privados para sobre OPEN.LDC_LOG_PRODEXCLRP
BEGIN
    -- OSF-3383
    pkg_Utilidades.prCrearSinonimos(upper('LDC_LOG_PRODEXCLRP'), 'OPEN');
END;
/