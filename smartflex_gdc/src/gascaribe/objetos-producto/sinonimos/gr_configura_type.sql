PROMPT CREA SINONIMO GR_CONFIGURA_TYPE
BEGIN
  pkg_utilidades.prCrearSinonimos('GR_CONFIGURA_TYPE','OPEN');
END;
/
PROMPT Asignación de permisos para el paquete GR_CONFIGURA_TYPE
begin
  pkg_utilidades.prAplicarPermisos('GR_CONFIGURA_TYPE', 'OPEN');
end;
/
