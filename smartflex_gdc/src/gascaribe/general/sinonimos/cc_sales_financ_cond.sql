Prompt Creando sinonimos privados para sobre OPEN.cc_sales_financ_cond
BEGIN
    -- OSF-3893
    pkg_Utilidades.prCrearSinonimos(upper('cc_sales_financ_cond'), 'OPEN');
END;
/