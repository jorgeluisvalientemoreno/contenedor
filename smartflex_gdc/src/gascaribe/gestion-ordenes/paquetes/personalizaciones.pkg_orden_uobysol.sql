CREATE OR REPLACE PACKAGE PERSONALIZACIONES.pkg_orden_uobysol IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_orden_uobysol
      Autor       :   Jorge Valiente
      Fecha       :   27/08/2024
      Descripcion :  Paquete para administrar las ordenes del proceso de asignacion automatica en UOBYSOL
  
      Modificaciones  :
      Autor       Fecha       Caso    Descripcion
  *******************************************************************************/
  --CURSORES

  --TIPOS/SUBTIPOS

  --Eliminar registro de la orden asignada por el proceso de asignacion automatica
  PROCEDURE prcEliminarOrden(inuOrden number);

  --Actualizar mensaje de error de proque no se asignada la orden por el proceso de asignacion automatica
  PROCEDURE prcActualizaObservacion(inuOrden number, sbMensaje varchar2);

END pkg_orden_uobysol;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.pkg_orden_uobysol IS

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : prcEliminarOrden
  Descripcion     : Eliminar registro de la orden asignada por el proceso de asignacion automatica
  Autor           : Jorge Valiente
  Fecha           : 27-08-2024
  
  Parametros de Entrada
  
  Parametros de Salida
  
  Modificaciones  :
  Autor       Fecha       Caso     Descripcion
  ***************************************************************************/
  PROCEDURE prcEliminarOrden(inuOrden number) IS
  
    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'prcEliminarOrden';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error
  BEGIN
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    pkg_traza.trace('Orden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
  
    DELETE ldc_order WHERE ORDER_ID = inuOrden;
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('sberror: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('sberror: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;                      
  END prcEliminarOrden;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : prcActualizaObservacion
  Descripcion     : Actualizar mensaje de error de proque no se asignada la orden por el proceso de asignacion automatica
  Autor           : Jorge Valiente
  Fecha           : 07-03-2024
  
  Parametros de Entrada
  
  Parametros de Salida
  
  Modificaciones  :
  Autor       Fecha       Caso     Descripcion
  ***************************************************************************/
  PROCEDURE prcActualizaObservacion(inuOrden number, sbMensaje varchar2) is
  
    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'prcActualizaObservacion';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error
  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    UPDATE ldc_order SET ORDEOBSE = sbMensaje WHERE ORDER_ID = inuOrden;
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('sberror: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('sberror: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
  End prcActualizaObservacion;

END pkg_orden_uobysol;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_ORDEN_UOBYSOL',
                                   'PERSONALIZACIONES');
END;
/
