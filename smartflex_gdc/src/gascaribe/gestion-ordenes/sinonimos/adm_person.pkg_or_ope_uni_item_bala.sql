Prompt Creando sinonimos privados para sobre adm_person.pkg_or_ope_uni_item_bala
BEGIN
    -- OSF-4042
    pkg_Utilidades.prCrearSinonimos(upper('pkg_or_ope_uni_item_bala'), upper('adm_person'));
END;
/