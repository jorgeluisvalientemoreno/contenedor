PROMPT Crea sinonimos privados para open.pkg_scheduler
BEGIN
  pkg_utilidades.prCrearSinonimos(upper('pkg_scheduler'),'ADM_PERSON');
END;
/