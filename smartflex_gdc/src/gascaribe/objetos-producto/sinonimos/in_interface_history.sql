PROMPT Crea sinonimos privados para adm_person.IN_INTERFACE_HISTORY
BEGIN
  pkg_utilidades.prCrearSinonimos(upper('IN_INTERFACE_HISTORY'),'OPEN');
END;
/