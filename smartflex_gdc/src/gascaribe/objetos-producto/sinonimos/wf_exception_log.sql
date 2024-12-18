PROMPT Crea sinonimos privados para adm_person.WF_EXCEPTION_LOG
BEGIN
  pkg_utilidades.prCrearSinonimos(upper('WF_EXCEPTION_LOG'),'OPEN');
END;
/