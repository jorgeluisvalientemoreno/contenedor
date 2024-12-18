Prompt Creando sinonimos privados para ADM_PERSON.PKG_LDC_ITEMS_AUDIT
BEGIN
    pkg_Utilidades.prCrearSinonimos(upper('PKG_LDC_ITEMS_AUDIT'), 'ADM_PERSON');
END;
/