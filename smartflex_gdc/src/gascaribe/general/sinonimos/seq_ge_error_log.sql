Prompt Creando sinonimos privados para ADM_PERSON sobre OPEN.SEQ_GE_ERROR_LOG
BEGIN
    -- OSF-3453
    pkg_Utilidades.prCrearSinonimos('SEQ_GE_ERROR_LOG', 'OPEN');
END;
/
