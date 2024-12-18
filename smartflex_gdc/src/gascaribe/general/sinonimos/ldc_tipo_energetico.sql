Prompt Creando sinonimos privados para sobre OPEN.LDC_TIPO_ENERGETICO
BEGIN
    -- OSF-3383
    pkg_Utilidades.prCrearSinonimos(upper('LDC_TIPO_ENERGETICO'), 'OPEN');
END;
/