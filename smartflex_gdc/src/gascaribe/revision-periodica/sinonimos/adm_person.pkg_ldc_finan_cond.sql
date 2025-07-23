BEGIN
    -- OSF-4336
    pkg_Utilidades.prCrearSinonimos( UPPER('pkg_ldc_finan_cond'), UPPER('adm_person'));
END;
/