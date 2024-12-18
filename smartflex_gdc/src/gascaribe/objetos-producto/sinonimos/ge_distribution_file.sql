PROMPT CREA SINONIMO GE_DISTRIBUTION_FILE
BEGIN
  pkg_utilidades.prCrearSinonimos('GE_DISTRIBUTION_FILE','OPEN');
END;
/
PROMPT Asignación de permisos para el paquete GE_DISTRIBUTION_FILE
begin
  pkg_utilidades.prAplicarPermisos('GE_DISTRIBUTION_FILE', 'OPEN');
end;
/
