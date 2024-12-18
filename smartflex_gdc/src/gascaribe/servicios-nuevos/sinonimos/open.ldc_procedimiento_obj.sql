PROMPT CREA SINONIMO LDC_PROCEDIMIENTO_OBJ
begin
  pkg_utilidades.prCrearSinonimos('LDC_PROCEDIMIENTO_OBJ','OPEN');
END;
/
PROMPT Asignación de permisos para el paquete LDC_PROCEDIMIENTO_OBJ
begin
  pkg_utilidades.prAplicarPermisos('LDC_PROCEDIMIENTO_OBJ', 'OPEN');
end;
/
