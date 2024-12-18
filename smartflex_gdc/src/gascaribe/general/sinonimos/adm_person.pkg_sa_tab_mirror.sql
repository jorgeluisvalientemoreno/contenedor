BEGIN
    -- OSF-3164
    pkg_Utilidades.prCrearSinonimos( UPPER('pkg_sa_tab_mirror'), UPPER('adm_person'));
END;
/