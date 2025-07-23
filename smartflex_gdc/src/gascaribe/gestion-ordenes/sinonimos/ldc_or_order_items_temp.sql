Prompt Creando sinonimos privados para sobre OPEN.LDC_OR_ORDER_ITEMS_TEMP
BEGIN
    -- OSF-4042
    pkg_Utilidades.prCrearSinonimos(upper('LDC_OR_ORDER_ITEMS_TEMP'), upper('OPEN'));
END;
/
