Prompt Creando sinonimos privados para sobre OPEN.rc_detatrba
BEGIN
    -- OSF-3893
    pkg_Utilidades.prCrearSinonimos(upper('rc_detatrba'), 'OPEN');
END;
/