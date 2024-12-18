Prompt Creando sinonimos privados para sobre OPEN.LDC_COMOSUSPPRODACT
BEGIN
    -- OSF-3450
    pkg_Utilidades.prCrearSinonimos(upper('LDC_COMOSUSPPRODACT'), 'OPEN');
END;
/