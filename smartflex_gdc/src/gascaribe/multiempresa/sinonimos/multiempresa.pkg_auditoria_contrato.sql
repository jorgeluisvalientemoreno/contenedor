Prompt Creando sinonimos privados para sobre multiempresa.pkg_auditoria_contrato
BEGIN
    -- OSF-3956
    pkg_Utilidades.prCrearSinonimos(upper('pkg_auditoria_contrato'), upper('multiempresa'));
END;
/