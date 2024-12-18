create or replace procedure personalizaciones.prcActivaProductoSuspendido is
  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : prcActivaProductoSuspendido
  Descripcion     : Procedimiento para Activar producto y/o servicio susppendido
  Autor           : Jorge Valiente
  Fecha           : 18/03/2024 
  
  Parametros de Entrada
  
  Parametros de Salida
  
  Modificaciones  :
  Autor       Fecha       Caso     Descripcion
  ***************************************************************************/

  -- Nombre de este metodo
  nuOrden       number;
  dtFechaFinEje date;

  csbMetodo   VARCHAR2(70) := 'prcActivaProductoSuspendido';
  nuErrorCode NUMBER; -- se almacena codigo de error
  sbMensError VARCHAR2(2000); -- se almacena descripcion del error  

BEGIN

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

  nuOrden := PKG_BCORDENES.FNUOBTENEROTINSTANCIALEGAL; -- Obtenemos la orden que se esta legalizando
  pkg_traza.trace('Orden: ' || nuOrden, pkg_traza.cnuNivelTrzDef);

  dtFechaFinEje := pkg_bcordenes.fdtObtieneFechaEjecuFin(nuOrden);
  pkg_traza.trace('Fecha Final Ejecucion: ' || dtFechaFinEje,
                  pkg_traza.cnuNivelTrzDef);

  oal_activaproductosuspendido(inuOrden            => nuOrden,
                               inuCausal           => null,
                               inuPersona          => null,
                               idtFechIniEje       => null,
                               idtFechaFinEje      => dtFechaFinEje,
                               isbDatosAdic        => null,
                               isbActividades      => null,
                               isbItemsElementos   => null,
                               isbLecturaElementos => null,
                               isbComentariosOrden => null);

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
  WHEN pkg_Error.Controlled_Error THEN
    pkg_Error.getError(nuErrorCode, sbMensError);
    pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERC);
    RAISE pkg_Error.Controlled_Error;
  
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(nuErrorCode, sbMensError);
    pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERR);
    RAISE pkg_Error.Controlled_Error;
  
end prcActivaProductoSuspendido;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PRCACTIVAPRODUCTOSUSPENDIDO',
                                   'PERSONALIZACIONES');
END;
/
