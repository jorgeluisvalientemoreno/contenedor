Prompt Creando sinonimos privados para sobre adm_person.pkg_concilia
BEGIN
    -- OSF-3893
    pkg_Utilidades.prCrearSinonimos(upper('pkg_concilia'), upper('adm_person'));
END;
/