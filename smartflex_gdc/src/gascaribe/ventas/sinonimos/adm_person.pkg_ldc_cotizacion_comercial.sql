Prompt Creando sinonimos privados para sobre adm_person.pkg_ldc_cotizacion_comercial
BEGIN
    -- OSF-4608
    pkg_Utilidades.prCrearSinonimos(upper('pkg_ldc_cotizacion_comercial'), upper('adm_person'));
END;
/