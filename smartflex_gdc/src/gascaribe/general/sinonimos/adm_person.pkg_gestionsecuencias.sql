Prompt Creando sinonimos privados para sobre ADM_PERSON.PKG_GESTIONSECUENCIAS
BEGIN
    pkg_Utilidades.prCrearSinonimos(upper('PKG_GESTIONSECUENCIAS'), 'ADM_PERSON');
END;
/