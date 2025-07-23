Prompt Creando sinonimos privados para sobre OPEN.ldci_oficvent
BEGIN
    -- OSF-4259
    pkg_Utilidades.prCrearSinonimos(upper('ldci_oficvent'), upper('OPEN'));
END;
/