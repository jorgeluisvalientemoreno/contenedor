Prompt Creando sinonimos privados para sobre adm_person.pkg_ldc_ciercome
BEGIN
    -- OSF-4042
    pkg_Utilidades.prCrearSinonimos(upper('pkg_ldc_ciercome'), upper('adm_person'));
END;
/