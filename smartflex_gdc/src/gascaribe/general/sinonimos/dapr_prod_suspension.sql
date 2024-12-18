Prompt Creando sinonimos privados para sobre OPEN.DAPR_PROD_SUSPENSION
BEGIN
    -- OSF-3383
    pkg_Utilidades.prCrearSinonimos(upper('DAPR_PROD_SUSPENSION'), 'OPEN');
END;
/