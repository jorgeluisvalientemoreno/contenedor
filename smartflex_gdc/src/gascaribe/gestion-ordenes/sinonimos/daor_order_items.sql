Prompt Creando sinonimos privados para sobre OPEN.DAOR_ORDER_ITEMS
BEGIN
    -- OSF-4042
    pkg_Utilidades.prCrearSinonimos(upper('DAOR_ORDER_ITEMS'), upper('OPEN'));
END;
/
