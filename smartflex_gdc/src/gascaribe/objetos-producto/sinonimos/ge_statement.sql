PROMPT CREA SINONIMO GE_STATEMENT
BEGIN
  pkg_utilidades.prCrearSinonimos('GE_STATEMENT','OPEN');
END;
/
PROMPT Asignación de permisos para el paquete GE_STATEMENT
begin
  pkg_utilidades.prAplicarPermisos('GE_STATEMENT', 'OPEN');
end;
/
