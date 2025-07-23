Prompt Creando sinonimos privados para sobre ADM_PERSON.ldc_BOUbiGeografica
BEGIN
    -- OSF-4555
    pkg_Utilidades.prCrearSinonimos(upper('ldc_BOUbiGeografica'), upper('ADM_PERSON'));
        
END;
/