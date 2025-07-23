Prompt Creando sinonimos privados para sobre multiempresa.auditoria_contrato
BEGIN
    -- OSF-3956
    pkg_Utilidades.prCrearSinonimos(upper('auditoria_contrato'), upper('multiempresa'));
END;
/