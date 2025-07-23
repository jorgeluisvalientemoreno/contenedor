BEGIN
    -- OSF-4336
    pkg_Utilidades.prCrearSinonimos( UPPER('pkg_ge_unit_cost_ite_lis'), UPPER('adm_person'));
END;
/