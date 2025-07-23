Prompt Creando sinonimos privados para sobre OPEN.ldci_transoma
BEGIN
    -- OSF-4259
    pkg_Utilidades.prCrearSinonimos(upper('ldci_transoma'), upper('OPEN'));
END;
/