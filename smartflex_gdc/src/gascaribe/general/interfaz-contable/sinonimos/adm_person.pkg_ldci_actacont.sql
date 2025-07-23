Prompt Creando sinonimos privados para sobre adm_person.pkg_ldci_actacont
BEGIN
-- OSF-3879
pkg_Utilidades.prCrearSinonimos(upper('pkg_ldci_actacont'), upper('adm_person'));
END;
/