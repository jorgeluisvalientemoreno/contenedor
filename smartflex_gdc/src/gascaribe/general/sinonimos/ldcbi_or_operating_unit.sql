Prompt Creando sinonimos privados para ADM_PERSON sobre OPEN.LDCBI_OR_OPERATING_UNIT
BEGIN
    -- OSF-3451
    pkg_Utilidades.prCrearSinonimos('LDCBI_OR_OPERATING_UNIT', 'OPEN');
END;
/