Prompt Creando sinonimos privados para sobre adm_person.pkg_bogestioncertificados
BEGIN
    -- OSF-3828
    pkg_Utilidades.prCrearSinonimos(upper('pkg_bogestioncertificados'), upper('adm_person'));
END;
/