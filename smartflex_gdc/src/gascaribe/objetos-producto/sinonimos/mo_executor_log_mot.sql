PROMPT Crea sinonimos privados para adm_person.MO_EXECUTOR_LOG_MOT
BEGIN
  pkg_utilidades.prCrearSinonimos(upper('MO_EXECUTOR_LOG_MOT'),'OPEN');
END;
/