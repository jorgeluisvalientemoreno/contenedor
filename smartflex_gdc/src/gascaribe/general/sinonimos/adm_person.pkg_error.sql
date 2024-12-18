PROMPT Crea sinonimos privados para ADM_PERSON.Pkg_Error
BEGIN
  pkg_utilidades.prCrearSinonimos(upper('Pkg_Error'),'ADM_PERSON');
END;
/