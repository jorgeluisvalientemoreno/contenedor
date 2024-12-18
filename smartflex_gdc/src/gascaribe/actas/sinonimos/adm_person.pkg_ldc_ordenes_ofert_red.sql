Prompt Creando sinonimos privados para ADM_PERSON.PKG_LDC_ORDENES_OFERT_RED
BEGIN
    pkg_Utilidades.prCrearSinonimos(upper('PKG_LDC_ORDENES_OFERT_RED'), 'ADM_PERSON');
END;
/