Prompt Creando sinonimos privados para sobre OPEN.ldci_intemmit
BEGIN
    -- OSF-4259
    pkg_Utilidades.prCrearSinonimos(upper('ldci_intemmit'), upper('OPEN'));
END;
/