Prompt Creando sinonimos privados para sobre adm_person.pkg_ge_item_classif.sql
BEGIN
    -- OSF-4042
    pkg_Utilidades.prCrearSinonimos(upper('pkg_ge_item_classif'), upper('adm_person'));
END;
/