Prompt Creando sinonimos privados para sobre multiempresa.contrato
BEGIN
    -- OSF-3956
    pkg_Utilidades.prCrearSinonimos(upper('contrato'), upper('multiempresa'));
END;
/