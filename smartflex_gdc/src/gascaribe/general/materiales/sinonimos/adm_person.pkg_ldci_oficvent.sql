Prompt Creando sinonimos privados para sobre adm_person.pkg_ldci_oficvent
BEGIN
    -- OSF-4259
    pkg_Utilidades.prCrearSinonimos(upper('pkg_ldci_oficvent'), upper('adm_person'));
    
    EXECUTE IMMEDIATE('CREATE OR REPLACE SYNONYM MULTIEMPRESA.pkg_ldci_oficvent FOR adm_person.pkg_ldci_oficvent');
    
END;
/