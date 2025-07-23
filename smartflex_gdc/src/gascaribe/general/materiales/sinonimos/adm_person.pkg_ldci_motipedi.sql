Prompt Creando sinonimos privados para sobre adm_person.pkg_ldci_motipedi
BEGIN
    -- OSF-4259
    pkg_Utilidades.prCrearSinonimos(upper('pkg_ldci_motipedi'), upper('adm_person'));
    
    EXECUTE IMMEDIATE('CREATE OR REPLACE SYNONYM MULTIEMPRESA.pkg_ldci_motipedi FOR adm_person.pkg_ldci_motipedi');
END;
/