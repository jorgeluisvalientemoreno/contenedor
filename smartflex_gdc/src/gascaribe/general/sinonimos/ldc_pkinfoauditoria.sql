Prompt Creando sinonimos privados para sobre OPEN.LDC_PKINFOAUDITORIA
BEGIN
    -- OSF-3383
    pkg_Utilidades.prCrearSinonimos(upper('LDC_PKINFOAUDITORIA'), 'OPEN');
END;
/