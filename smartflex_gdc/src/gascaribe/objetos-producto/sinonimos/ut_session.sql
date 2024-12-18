PROMPT Crea sinonimos privados para adm_person.ut_session
BEGIN
  pkg_utilidades.prCrearSinonimos(upper('ut_session'),'OPEN');
END;
/