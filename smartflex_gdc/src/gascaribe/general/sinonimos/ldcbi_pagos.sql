Prompt Creando sinonimos privados para ADM_PERSON sobre OPEN.LDCBI_PAGOS
BEGIN
    -- OSF-3453
    pkg_Utilidades.prCrearSinonimos('LDCBI_PAGOS', 'OPEN');
END;
/
