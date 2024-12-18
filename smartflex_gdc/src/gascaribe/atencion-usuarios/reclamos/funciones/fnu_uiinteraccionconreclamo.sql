create or replace function fnu_UIInteraccionConReclamo(inuSolicitudInteraccion number)
  return number is
  /*****************************************************************
  Propiedad intelectual de GDC.
  
  Unidad         : fnu_UIInteraccionConReclamo
  Descripcion    : Metodo para vlidar si existe tipo de solicitud y medio de recepcion asociados a una interaccion
  Autor          : Jorge Valiente
  Fecha          : 25-01-2024
  Caso           : OSF-2194
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/

  csbSP_NAME CONSTANT VARCHAR2(35) := 'fnu_UIInteraccionConReclamo';

  nuExiste number := 0;

  nuError NUMBER; -- se almacena codigo de error
  sbError VARCHAR2(2000); -- se almacena descripcion del error

begin

  pkg_traza.trace(csbSP_NAME,
                  pkg_traza.cnuNivelTrzDef,
                  pkg_traza.csbINICIO);

  pkg_traza.trace('Solicitud Interaccion: ' || inuSolicitudInteraccion,
                  pkg_traza.cnuNivelTrzDef);

  nuExiste := fnu_InteraccionConReclamo(inuSolicitudInteraccion);

  pkg_traza.trace('Retorna: ' || nuExiste);

  pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  return nuExiste;

EXCEPTION
  WHEN pkg_error.CONTROLLED_ERROR THEN
    pkg_Error.getError(nuError, sbError);
    pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbSP_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERC);
    return nuExiste;
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(nuError, sbError);
    pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbSP_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERR);
    return nuExiste;
  
end;
/

BEGIN
  pkg_utilidades.prAplicarPermisos('FNU_UIINTERACCIONCONRECLAMO', 'OPEN');
END;
/