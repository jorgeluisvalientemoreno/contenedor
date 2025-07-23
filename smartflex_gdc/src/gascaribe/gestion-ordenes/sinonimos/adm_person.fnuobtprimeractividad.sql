Prompt Creando sinonimos privados para sobre ADM_PERSON.fnuObtPrimerActividad
BEGIN
    -- OSF-2204
    pkg_Utilidades.prCrearSinonimos(upper('fnuObtPrimerActividad'), 'ADM_PERSON');
END;
/