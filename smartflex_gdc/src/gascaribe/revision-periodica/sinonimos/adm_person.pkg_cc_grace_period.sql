BEGIN
    -- OSF-4336
    pkg_Utilidades.prCrearSinonimos( UPPER('pkg_cc_grace_period'), UPPER('adm_person'));
END;
/