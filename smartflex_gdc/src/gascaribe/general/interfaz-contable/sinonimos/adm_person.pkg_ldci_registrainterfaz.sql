Prompt Creando sinonimos privados para sobre adm_person.pkg_ldci_registrainterfaz
BEGIN
    -- OSF-3879
    pkg_Utilidades.prCrearSinonimos(upper('pkg_ldci_registrainterfaz'), UPPER('adm_person'));
END;
/