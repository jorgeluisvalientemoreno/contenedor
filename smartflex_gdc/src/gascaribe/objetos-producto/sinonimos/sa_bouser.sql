PROMPT Crea sinonimos privados para adm_person.sa_bouser
BEGIN
  pkg_utilidades.prCrearSinonimos(upper('sa_bouser'),'OPEN');
END;
/