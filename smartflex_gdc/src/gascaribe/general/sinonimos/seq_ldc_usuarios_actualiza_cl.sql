Prompt Creando sinonimos privados para ADM_PERSON sobre OPEN.SEQ_LDC_USUARIOS_ACTUALIZA_CL
BEGIN
    -- OSF-3453
    pkg_Utilidades.prCrearSinonimos('SEQ_LDC_USUARIOS_ACTUALIZA_CL', 'OPEN');
END;
/
