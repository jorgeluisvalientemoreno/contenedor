Prompt Creando sinonimos privados para sobre adm_person.pkg_ldc_log_items_modif_sin_ac
BEGIN
    -- OSF-4042
    pkg_Utilidades.prCrearSinonimos(upper('pkg_ldc_log_items_modif_sin_ac'), upper('adm_person'));
END;
/