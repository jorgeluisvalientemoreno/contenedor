Prompt Creando sinonimos privados para sobre OPEN.LDC_MONTO_ACTA
BEGIN
    -- OSF-3450
    pkg_Utilidades.prCrearSinonimos(upper('LDC_MONTO_ACTA'), 'OPEN');
END;
/