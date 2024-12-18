PROMPT Crea sinonimos privados para adm_person.ge_error_log
BEGIN
  pkg_utilidades.prCrearSinonimos(upper('ge_error_log'),'OPEN');
END;
/