Prompt Creando sinonimos privados para sobre ADM_PERSON.api_deladdress
BEGIN
    pkg_Utilidades.prCrearSinonimos(upper('api_deladdress'), 'ADM_PERSON');
END;
/