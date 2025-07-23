Prompt Creando sinonimos privados para sobre multiempresa.sucursal_bancaria
BEGIN
    -- OSF-4134
    pkg_Utilidades.prCrearSinonimos(upper('sucursal_bancaria'), upper('multiempresa'));
END;
/