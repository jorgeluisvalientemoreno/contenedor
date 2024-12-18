Prompt Creando sinonimos privados para sobre OPEN.DAGE_ITEMS_DOCUMENTO
BEGIN
    -- OSF-3450
    pkg_Utilidades.prCrearSinonimos(upper('DAGE_ITEMS_DOCUMENTO'), 'OPEN');
END;
/