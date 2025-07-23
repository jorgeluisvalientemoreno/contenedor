Prompt Creando sinonimos privados para adm_person.pkg_ldci_transoma
BEGIN
    -- OSF-4259
    pkg_Utilidades.prCrearSinonimos(upper('pkg_ldci_transoma'), upper('adm_person'));
    
    dbms_output.put_line('Creando sinonimo privado en MULTIEMPRESA para adm_person.pkg_ldci_transoma');
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM multiempresa.pkg_ldci_transoma FOR adm_person.pkg_ldci_transoma';

END;
/