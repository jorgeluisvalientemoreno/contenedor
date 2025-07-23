Prompt Creando sinonimos privados 
BEGIN
    -- OSF-3970
    pkg_Utilidades.prCrearSinonimos(upper('OR_LOG_ORDER_ACTION'), upper('OPEN'));
END;
/