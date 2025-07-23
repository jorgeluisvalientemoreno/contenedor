Prompt Creando sinonimos privados para sobre ADM_PERSON.LDC_CANCEL_ORDER
BEGIN
    -- OSF-3828
    pkg_Utilidades.prCrearSinonimos(upper('LDC_CANCEL_ORDER'), 'ADM_PERSON');
END;
/
