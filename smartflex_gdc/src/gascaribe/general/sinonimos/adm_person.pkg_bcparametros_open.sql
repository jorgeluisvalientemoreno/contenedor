PROMPT Crea sinonimos privados para ADM_PERSON.pkg_bcparametros_open
BEGIN
  pkg_utilidades.prCrearSinonimos(upper('pkg_bcparametros_open'),'ADM_PERSON');
END;
/