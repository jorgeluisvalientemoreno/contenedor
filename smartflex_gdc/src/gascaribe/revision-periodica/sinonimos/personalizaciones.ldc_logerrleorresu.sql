PROMPT CREA SINONIMO LDC_LOGERRLEORRESU
BEGIN
  pkg_utilidades.prCrearSinonimos('LDC_LOGERRLEORRESU','PERSONALIZACIONES');
END;
/

PROMPT Asignación de permisos para el paquete LDC_LOGERRLEORRESU
begin
  pkg_utilidades.prAplicarPermisos('LDC_LOGERRLEORRESU', 'PERSONALIZACIONES');
end;
/
