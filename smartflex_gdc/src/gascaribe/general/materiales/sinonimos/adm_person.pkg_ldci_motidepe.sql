Prompt Creando sinonimos privados para sobre ADM_PERSON.pkg_ldci_motidepe
BEGIN
    -- OSF-4259
    pkg_Utilidades.prCrearSinonimos(upper('pkg_ldci_motidepe'), upper('ADM_PERSON'));

    dbms_output.put_line('Creando sinonimo privado en MULTIEMPRESA para adm_person.pkg_ldci_motidepe');
    EXECUTE IMMEDIATE('CREATE OR REPLACE SYNONYM multiempresa.pkg_ldci_motidepe FOR adm_person.pkg_ldci_motidepe');

END;
/