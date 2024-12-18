Prompt Creando sinonimos privados para sobre OPEN.LDC_AUDI_TASKACTCOSTPROM
BEGIN
    -- OSF-3383
    pkg_Utilidades.prCrearSinonimos(upper('LDC_AUDI_TASKACTCOSTPROM'), 'OPEN');
END;
/