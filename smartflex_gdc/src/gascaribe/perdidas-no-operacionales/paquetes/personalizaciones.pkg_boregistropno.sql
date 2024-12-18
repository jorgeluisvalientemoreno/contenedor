CREATE OR REPLACE PACKAGE personalizaciones.pkg_boregistropno IS
  /*******************************************************************************
  
      Propiedad Intelectual de Gases del Caribe
      Programa        : pkg_boregistropno
      Descripcion     : Paquete para establecer servicios con relacion a ordenes y/o proyectos de PNO
      Autor           : Jorge Valiente
      Fecha           : 27/02/2024
      Modificaciones  :
      Autor       Fecha       Caso        Descripcion
  
  *******************************************************************************/

  -- Retona Identificador del ultimo caso que hizo cambios en este archivo
  FUNCTION fsbVersion RETURN VARCHAR2;

  -- Retorna Categoria del producto
  FUNCTION fnuCantidadOTSinLegalizar(inuProducto        IN number,
                                     inuCodigoDireccion IN number,
                                     inuTipoProducto    IN number,
                                     isbEstadoOTPNO     Varchar2,
                                     isbTipoTrabajoPNO  Varchar2)
    RETURN number;

END pkg_boregistropno;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_boregistropno IS

  -- Identificador del ultimo caso que hizo cambios
  csbVersion VARCHAR2(15) := 'OSF-2364';

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  nuError NUMBER;
  sberror VARCHAR2(4000);

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : fsbVersion
  Descripcion     : Retona la ultima WO que hizo cambios en el paquete
  Autor           : 
  Fecha           : 
  Modificaciones  :
  Autor       Fecha       Caso    Descripcion
  
  ***************************************************************************/
  FUNCTION fsbVersion RETURN VARCHAR2 IS
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : fnuCantidadOTSinLegalizar
  Descripcion     : Retorna cantidad de ordenes PNO sin legalizar
  Autor           : Jorge Valiente
  Fecha           : 27/02/2024
  Modificaciones  :
  Autor       Fecha       Caso        Descripcion
  
  ***************************************************************************/
  FUNCTION fnuCantidadOTSinLegalizar(inuProducto        IN number,
                                     inuCodigoDireccion IN number,
                                     inuTipoProducto    IN number,
                                     isbEstadoOTPNO     Varchar2,
                                     isbTipoTrabajoPNO  Varchar2)
    RETURN number IS
  
    -- Nombre de ste mEtodo
    csbMT_NAME VARCHAR2(70) := csbSP_NAME || '.fnuCantidadOTSinLegalizar';
  
    nuOTSinLegalizar number := 0;
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    pkg_traza.trace('Producto: ' || inuProducto, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Codigo Direccion: ' || inuCodigoDireccion,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Tipo Producto: ' || inuTipoProducto,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Estado de orden a validar en PNO: ' || isbEstadoOTPNO,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Tipo de Trabajo de orden a validar en PNO: ' ||
                    isbTipoTrabajoPNO,
                    pkg_traza.cnuNivelTrzDef);
  
    nuOTSinLegalizar := pkg_bcordenespno.fnuCantidadOTSinLegalizar(inuProducto,
                                                                   inuCodigoDireccion,
                                                                   inuTipoProducto,
                                                                   isbEstadoOTPNO,
                                                                   isbTipoTrabajoPNO);
    pkg_traza.trace('Cantidad de OT PNO Sin Legalizar: ' ||
                    nuOTSinLegalizar,
                    pkg_traza.cnuNivelTrzDef);
  
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
    RETURN nuOTSinLegalizar;
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('Error: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('Error: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
    
  END fnuCantidadOTSinLegalizar;

END pkg_boregistropno;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BOREGISTROPNO', 'PERSONALIZACIONES');
END;
/
