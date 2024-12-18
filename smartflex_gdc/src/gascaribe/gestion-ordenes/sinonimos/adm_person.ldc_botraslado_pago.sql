Prompt Creando sinonimos privados para sobre ADM_PERSON.LDC_BOTRASLADO_PAGO
BEGIN
    pkg_Utilidades.prCrearSinonimos(upper('LDC_BOTRASLADO_PAGO'), 'ADM_PERSON');
END;
/