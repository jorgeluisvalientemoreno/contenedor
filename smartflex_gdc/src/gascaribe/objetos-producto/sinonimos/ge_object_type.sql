
PROMPT CREA SINONIMO GE_OBJECT_TYPE
BEGIN
  pkg_utilidades.prCrearSinonimos('GE_OBJECT_TYPE','OPEN');
END;
/




PROMPT Asignación de permisos para el paquete GE_OBJECT_TYPE
begin
  pkg_utilidades.prAplicarPermisos('GE_OBJECT_TYPE', 'OPEN');
end;
/
