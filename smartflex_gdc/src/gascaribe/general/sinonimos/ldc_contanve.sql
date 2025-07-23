Prompt Creando sinonimos privados para sobre OPEN.ldc_contanve
BEGIN
    -- OSF-3893
    pkg_Utilidades.prCrearSinonimos(upper('ldc_contanve'), 'OPEN');
END;
/