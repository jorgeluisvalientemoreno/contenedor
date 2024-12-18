PROMPT Crea sinonimos privados para adm_person.pkgManejoSolicitudes
BEGIN
  pkg_utilidades.prCrearSinonimos(upper('pkgManejoSolicitudes'),'ADM_PERSON');
END;
/