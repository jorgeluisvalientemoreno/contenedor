Prompt Creando sinonimos privados para sobre OPEN.LDC_RGCOMA_LOG
BEGIN
    -- OSF-3383
    pkg_Utilidades.prCrearSinonimos(upper('LDC_RGCOMA_LOG'), 'OPEN');
END;
/