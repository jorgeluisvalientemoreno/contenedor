Prompt Creando sinonimos privados para sobre personalizaciones.pkg_boserviciosnuevos
BEGIN
    -- OSF-3828
    pkg_Utilidades.prCrearSinonimos(upper('pkg_boserviciosnuevos'), 'PERSONALIZACIONES');
END;
/