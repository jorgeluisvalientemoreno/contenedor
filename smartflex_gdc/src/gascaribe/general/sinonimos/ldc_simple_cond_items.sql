Prompt Creando sinonimos privados para sobre OPEN.LDC_SIMPLE_COND_ITEMS
BEGIN
    -- OSF-3383
    pkg_Utilidades.prCrearSinonimos(upper('LDC_SIMPLE_COND_ITEMS'), 'OPEN');
END;
/