Prompt Creando sinonimos privados para sobre OPEN.rc_boanullpayments
BEGIN
    -- OSF-3893
    pkg_Utilidades.prCrearSinonimos(upper('rc_boanullpayments'), 'OPEN');
END;
/