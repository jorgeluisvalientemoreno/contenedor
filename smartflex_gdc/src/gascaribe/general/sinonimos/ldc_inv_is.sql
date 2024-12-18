Prompt Creando sinonimos privados para sobre OPEN.LDC_INV_IS
BEGIN
    -- OSF-3450
    pkg_Utilidades.prCrearSinonimos(upper('LDC_INV_IS'), 'OPEN');
END;
/