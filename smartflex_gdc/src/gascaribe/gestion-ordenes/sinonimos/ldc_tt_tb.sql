Prompt Creando sinonimos privados para sobre OPEN.ldc_tt_tb
BEGIN
    -- OSF-4042
    pkg_Utilidades.prCrearSinonimos(upper('ldc_tt_tb'), upper('OPEN'));
END;
/