Prompt Creando sinonimos privados para sobre adm_person.pkg_ldc_or_order_items_temp
BEGIN
    -- OSF-4042
    pkg_Utilidades.prCrearSinonimos(upper('pkg_ldc_or_order_items_temp'), upper('adm_person'));
END;
/