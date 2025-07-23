Prompt Creando sinonimos privados para sobre OPEN.LDC_LOG_ITEMS_MODIF_SIN_ACTA
BEGIN
    -- OSF-4042
    pkg_Utilidades.prCrearSinonimos(upper('LDC_LOG_ITEMS_MODIF_SIN_ACTA'), upper('OPEN'));
END;
/