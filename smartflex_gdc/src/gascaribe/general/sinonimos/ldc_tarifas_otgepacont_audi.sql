Prompt Creando sinonimos privados para sobre OPEN.LDC_TARIFAS_OTGEPACONT_AUDI
BEGIN
    -- OSF-3383
    pkg_Utilidades.prCrearSinonimos(upper('LDC_TARIFAS_OTGEPACONT_AUDI'), 'OPEN');
END;
/