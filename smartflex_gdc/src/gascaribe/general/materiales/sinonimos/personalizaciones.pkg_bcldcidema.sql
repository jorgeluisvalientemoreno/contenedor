Prompt Creando sinonimos privados para sobre personalizaciones.pkg_bcldcidema
BEGIN
    -- OSF-4259
    pkg_Utilidades.prCrearSinonimos(upper('pkg_bcldcidema'), upper('personalizaciones'));
    
    EXECUTE immediate ('CREATE OR REPLACE SYNONYM multiempresa.pkg_bcldcidema FOR personalizaciones.pkg_bcldcidema');
END;
/