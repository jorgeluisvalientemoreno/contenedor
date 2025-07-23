Prompt Creando sinonimos privados para sobre ADM_PERSON.pkg_GestionPagos
BEGIN
    -- OSF-3893
    pkg_Utilidades.prCrearSinonimos(upper('pkg_GestionPagos'), 'ADM_PERSON');
END;
/