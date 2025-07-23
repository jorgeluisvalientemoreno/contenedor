Prompt Creando sinonimos privados para sobre multiempresa.pkg_contrato
BEGIN
    -- OSF-3956
    pkg_Utilidades.prCrearSinonimos(upper('pkg_contrato'), upper('multiempresa'));
END;
/