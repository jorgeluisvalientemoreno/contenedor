Prompt Creando sinonimos privados para sobre OPEN.LDC_TARIFAS_OTGEPACONT
BEGIN
    -- OSF-3383
    pkg_Utilidades.prCrearSinonimos(upper('LDC_TARIFAS_OTGEPACONT'), 'OPEN');
END;
/