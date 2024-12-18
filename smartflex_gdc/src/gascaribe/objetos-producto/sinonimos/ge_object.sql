PROMPT CREA SINONIMO GE_OBJECT
BEGIN
  pkg_utilidades.prCrearSinonimos('GE_OBJECT','OPEN');
END;
/
PROMPT Asignación de permisos para el paquete ge_object
begin
  pkg_utilidades.prAplicarPermisos('GE_OBJECT', 'OPEN');
end;
/