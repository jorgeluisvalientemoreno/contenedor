PROMPT Crea sinonimos privados para ADM_PERSON.fnu_LecturaSugerida
BEGIN
  pkg_utilidades.prCrearSinonimos(upper('fnu_LecturaSugerida'),'ADM_PERSON'); 
END;
/