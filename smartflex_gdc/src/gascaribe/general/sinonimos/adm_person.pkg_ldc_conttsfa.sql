Prompt Creando sinonimos privados para sobre adm_person.pkg_ldc_conttsfa
BEGIN
    -- OSF-3893
    pkg_Utilidades.prCrearSinonimos(upper('pkg_ldc_conttsfa'), 'ADM_PERSON');
END;
/