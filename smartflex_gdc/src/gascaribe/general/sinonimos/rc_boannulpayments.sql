Prompt Creando sinonimos privados para sobre OPEN.rc_boannulpayments
BEGIN
    -- OSF-3893
    pkg_Utilidades.prCrearSinonimos(upper('rc_boannulpayments'), 'OPEN');
END;
/