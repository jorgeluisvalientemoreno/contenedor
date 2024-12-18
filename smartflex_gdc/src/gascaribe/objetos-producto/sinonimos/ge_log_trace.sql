PROMPT ARCHIVO ge_log_trace.sql
PROMPT CREA SINONIMO TABLA GE_LOG_TRACE
BEGIN
  pkg_utilidades.prCrearSinonimos('GE_LOG_TRACE','OPEN');
END;
/