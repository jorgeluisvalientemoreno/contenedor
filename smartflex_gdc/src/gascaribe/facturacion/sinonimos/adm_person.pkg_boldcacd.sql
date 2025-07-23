Prompt Creando sinonimos privados para sobre adm_person.pkg_boldcacd
BEGIN
    -- OSF-3694
    pkg_Utilidades.prCrearSinonimos(upper('pkg_boldcacd'), upper('adm_person'));
END;
/