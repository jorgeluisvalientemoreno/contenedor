Prompt Creando sinonimos privados para sobre vw_empresa
BEGIN
    -- OSF-4084
    pkg_Utilidades.prCrearSinonimos(upper('vw_empresa'), upper('open'));
END;
/