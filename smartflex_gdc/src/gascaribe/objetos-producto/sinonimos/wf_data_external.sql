PROMPT Crea sinonimos privados para adm_person.WF_DATA_EXTERNAL
BEGIN
  pkg_utilidades.prCrearSinonimos(upper('WF_DATA_EXTERNAL'),'OPEN');
END;
/