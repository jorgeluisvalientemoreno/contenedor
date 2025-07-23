BEGIN
    -- OSF-3828
    pkg_Utilidades.prCrearSinonimos( UPPER('pkg_OR_OPERATING_UNIT'), UPPER('adm_person'));
END;
/
