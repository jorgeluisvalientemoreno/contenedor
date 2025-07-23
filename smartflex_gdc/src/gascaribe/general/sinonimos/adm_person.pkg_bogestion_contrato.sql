PROMPT Crea sinonimo objeto pkg_bogestion_contrato
BEGIN
    pkg_utilidades.prCrearSinonimos(upper('pkg_bogestion_contrato'), 'ADM_PERSON');
END;
/