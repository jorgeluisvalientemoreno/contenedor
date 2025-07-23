BEGIN
    -- OSF-4294
    pkg_Utilidades.prCrearSinonimos( UPPER('pkg_paraFact'), UPPER('adm_person'));
END;
/