Prompt Creando sinonimos privados para sobre adm_person.pkg_ge_items_documento
BEGIN
    -- OSF-4245
    pkg_Utilidades.prCrearSinonimos(upper('pkg_ge_items_documento'), upper('adm_person'));
END;
/