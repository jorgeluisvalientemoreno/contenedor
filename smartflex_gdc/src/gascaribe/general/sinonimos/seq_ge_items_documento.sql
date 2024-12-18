Prompt Creando sinonimos privados para sobre OPEN.SEQ_GE_ITEMS_DOCUMENTO
BEGIN
    -- OSF-3450
    pkg_Utilidades.prCrearSinonimos(upper('SEQ_GE_ITEMS_DOCUMENTO'), 'OPEN');
END;
/