Prompt Creando sinonimos privados para sobre SEQ_PR_COMPONENT_RETIRE
BEGIN
    -- OSF-3893
    pkg_Utilidades.prCrearSinonimos(upper('SEQ_PR_COMPONENT_RETIRE'), 'OPEN');
END;
/