BEGIN
    -- OSF-3828
    pkg_Utilidades.prCrearSinonimos( UPPER('pkg_LDC_PLAZOS_CERT'), UPPER('adm_person'));
END;
/