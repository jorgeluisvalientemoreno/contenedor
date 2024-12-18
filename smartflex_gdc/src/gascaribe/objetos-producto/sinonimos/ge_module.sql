PROMPT CREA SINONIMO GE_MODULE
BEGIN
  pkg_utilidades.prCrearSinonimos('GE_MODULE','OPEN');
END;
/

PROMPT Asignación de permisos para el paquete GE_MODULE
begin
  pkg_utilidades.prAplicarPermisos('GE_MODULE', 'OPEN');
end;
/
