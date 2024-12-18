Prompt Creando sinonimos privados para sobre OPEN.LDC_CONT_PLAN_COND
BEGIN
    -- OSF-3450
    pkg_Utilidades.prCrearSinonimos(upper('LDC_CONT_PLAN_COND'), 'OPEN');
END;
/