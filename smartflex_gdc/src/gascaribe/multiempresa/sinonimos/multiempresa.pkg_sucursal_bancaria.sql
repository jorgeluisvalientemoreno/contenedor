Prompt Creando sinonimos privados para sobre multiempresa.pkg_sucursal_bancaria
BEGIN
    -- OSF-4134
    pkg_Utilidades.prCrearSinonimos(upper('pkg_sucursal_bancaria'), upper('multiempresa'));
END;
/