Prompt Creando sinonimos privados para sobre OPEN.LDC_ACT_IS
BEGIN
    -- OSF-3450
    pkg_Utilidades.prCrearSinonimos(upper('LDC_ACT_IS'), 'OPEN');
END;
/