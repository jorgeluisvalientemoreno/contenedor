BEGIN
    -- OSF-4294
    pkg_Utilidades.prCrearSinonimos( UPPER('pkg_concepto'), UPPER('adm_person'));
END;
/