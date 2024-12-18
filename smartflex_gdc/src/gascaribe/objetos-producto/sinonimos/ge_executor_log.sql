PROMPT Crea sinonimos privados para adm_person.ge_executot_log
BEGIN
  pkg_utilidades.prCrearSinonimos(upper('GE_EXECUTOR_LOG'),'OPEN');
END;
/