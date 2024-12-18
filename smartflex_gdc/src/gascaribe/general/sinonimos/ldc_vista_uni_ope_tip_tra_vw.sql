Prompt Creando sinonimos privados para sobre OPEN.LDC_VISTA_UNI_OPE_TIP_TRA_VW
BEGIN
    -- OSF-3383
    pkg_Utilidades.prCrearSinonimos(upper('LDC_VISTA_UNI_OPE_TIP_TRA_VW'), 'OPEN');
END;
/