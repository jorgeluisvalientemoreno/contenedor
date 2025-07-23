Prompt Creando sinonimos privados para sobre personalizaciones.pkg_bcserviciosnuevos
BEGIN
    -- OSF-3828
    pkg_Utilidades.prCrearSinonimos(upper('pkg_bcserviciosnuevos'), 'PERSONALIZACIONES');
END;
/