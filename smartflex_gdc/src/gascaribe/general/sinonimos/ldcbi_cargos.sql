Prompt Creando sinonimos privados para sobre OPEN.LDCBI_CARGOS
BEGIN
    -- OSF-3450
    pkg_Utilidades.prCrearSinonimos(upper('LDCBI_CARGOS'), 'OPEN');
END;
/