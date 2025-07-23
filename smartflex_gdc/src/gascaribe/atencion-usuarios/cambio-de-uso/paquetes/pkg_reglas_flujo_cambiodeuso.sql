CREATE OR REPLACE PACKAGE pkg_reglas_flujo_cambiodeuso IS

  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_reglas_flujo_cambiodeuso
      Autor       : Jorge Valiente  
      Fecha       : 25/033/2025  
      Descripcion : Paquete para servicios asociados al flujo de cambio de uso  
      Modificaciones  :
      
      Autor       Fecha       Caso    Descripcion  
  *******************************************************************************/

  --servicio para atender solicitud.
  PROCEDURE prcAccionAtencionSolicitud;

END pkg_reglas_flujo_cambiodeuso;
/
CREATE OR REPLACE PACKAGE BODY pkg_reglas_flujo_cambiodeuso IS

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcAccionAtencionSolicitud
    Descripcion     : servicio para atender solicitud.
    Autor           : Jorge Valiente
    Fecha           : 18-02-2025
  
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  nuNVLTRDEF CONSTANT NUMBER(2) := pkg_traza.cnuNivelTrzDef;

  PROCEDURE prcAccionAtencionSolicitud IS
    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'prcAccionAtencionSolicitud';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error 
  
    nuSolicitud NUMBER;
    nuAccion    NUMBER := 60;
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, nuNVLTRDEF, pkg_traza.csbINICIO);
  
    nuSolicitud := MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();
  
    pkg_traza.trace('Solicitud: ' || nuSolicitud, nuNVLTRDEF);
    pkg_traza.trace('Accion: ' || nuAccion, nuNVLTRDEF);
  
    pkg_boGestionSolicitudes.prcAtenderSolicitud(nuSolicitud, nuAccion);
  
    pkg_traza.trace(csbMetodo, nuNVLTRDEF, pkg_traza.csbFIN);
  
  EXCEPTION
  
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, nuNVLTRDEF);
      pkg_traza.trace(csbMetodo, nuNVLTRDEF, pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, nuNVLTRDEF);
      pkg_traza.trace(csbMetodo, nuNVLTRDEF, pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
  END prcAccionAtencionSolicitud;

END pkg_reglas_flujo_cambiodeuso;
/
