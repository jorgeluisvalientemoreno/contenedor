Prompt Creando sinonimos privados para sobre OPEN.LDC_REGINFAUD
BEGIN
    -- OSF-3383
    pkg_Utilidades.prCrearSinonimos(upper('LDC_REGINFAUD'), 'OPEN');
END;
/