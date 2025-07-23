BEGIN
    -- OSF-4186
    pkg_Utilidades.prCrearSinonimos( UPPER('pkg_mo_suspension'), UPPER('adm_person'));
END;
/