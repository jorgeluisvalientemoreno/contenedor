PROMPT Crea sinonimos privados para adm_person.mo_package_chng_log
BEGIN
  pkg_utilidades.prCrearSinonimos(upper('mo_package_chng_log'),'OPEN');
END;
/