PROMPT CREA SINONIMO GR_CONFIG_EXPRESSION
BEGIN
  pkg_utilidades.prCrearSinonimos('GR_CONFIG_EXPRESSION','OPEN');
END;
/

PROMPT Asignación de permisos para el paquete GR_CONFIG_EXPRESSION
begin
  pkg_utilidades.prAplicarPermisos('GR_CONFIG_EXPRESSION', 'OPEN');
end;
/
