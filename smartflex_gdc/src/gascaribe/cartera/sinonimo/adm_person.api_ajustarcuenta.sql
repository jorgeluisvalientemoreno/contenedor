PROMPT ARCHIVO adm_person.api_ajustarcuenta.sql
PROMPT CREA SINONIMO API_AJUSTARCUENTA
BEGIN
  pkg_utilidades.prCrearSinonimos('API_AJUSTARCUENTA','ADM_PERSON');
END;
/