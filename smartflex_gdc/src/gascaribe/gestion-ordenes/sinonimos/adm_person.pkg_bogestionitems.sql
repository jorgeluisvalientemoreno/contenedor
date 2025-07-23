Prompt Creando sinonimos privados para sobre adm_person.pkg_bogestionitems
BEGIN
    -- OSF-4042
    pkg_Utilidades.prCrearSinonimos(upper('pkg_bogestionitems'), upper('adm_person'));
END;
/