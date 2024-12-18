PROMPT Crea sinonimos privados para adm_person.wf_instance
BEGIN
  pkg_utilidades.prCrearSinonimos(upper('wf_instance'),'OPEN');
END;
/