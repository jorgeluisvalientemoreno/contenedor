CREATE OR REPLACE PACKAGE adm_person.pkg_bodirecciones IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_bodirecciones
      Autor       :   Jorge Valiente
      Fecha       :   29-01-2024
      Descripcion :   Paquete con los metodos para manejo de informacion de generacion
                      de ordenes del venta de servicios de ingenieria
  
      Modificaciones  :
      Autor                   Fecha        Caso       Descripcion
      Jorge Valiente         29-01-2024    OSF-1993   Creacion
  *******************************************************************************/
  -- Retorna la causal de la orden
  FUNCTION fsbVersion RETURN VARCHAR2;

  FUNCTION fnuProductoPorDireccion(inuDireccion    number,
                                   inuTipoProducto number) RETURN number;

END pkg_bodirecciones;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bodirecciones IS

  -- Constantes para el control de la traza
  csbSP_NAME    CONSTANT VARCHAR2(100) := $$PLSQL_UNIT;
  csbNivelTraza CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;

  -- Identificador del ultimo caso que hizo cambios
  csbVersion CONSTANT VARCHAR2(15) := 'OSF-1993';

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
  
  Programa        : fsbVersion
  Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor         : Jorge Valiente
    Fecha         : 29-01-2024
  
    Modificaciones  :
    Autor                   Fecha        Caso       Descripcion
    Jorge Valiente         29-01-2024    OSF-1993   Creacion
  ***************************************************************************/
  FUNCTION fsbVersion RETURN VARCHAR2 IS
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : fnuProductoPorDireccion
      Descripcion     : funcion que valida si la actividad a generar esta
                        parametrizada por tipo de trabajo
      Autor           : Jorge Valiente
      Fecha           : 29-01-2024
      Parametros de Entrada
          inuProducto             Producto
          inuActividad         codigo de la actividad
      Parametros de Salida
      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso      Descripcion
  Jorge Valiente  06/08/2024  OSF-3076  Reemplazar el servicio PR_BOProduct.fnuPrInAddrByProdTy por el 
                                        servicio PR_BOProduct.fnugetprodbyaddrprodtype
  ***************************************************************************/
  FUNCTION fnuProductoPorDireccion(inuDireccion    number,
                                   inuTipoProducto number) RETURN number IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuProductoPorDireccion';
  
    sbError VARCHAR2(4000);
    nuError NUMBER;
  
    nuProducto number := 0;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  
    pkg_traza.trace('Codigo Direccion: ' || inuDireccion,
                    pkg_traza.cnuNivelTrzDef);
  
    nuProducto := PR_BOProduct.fnugetprodbyaddrprodtype(inuDireccion,
                                                        inuTipoProducto);
  
    RETURN nuProducto;
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      RAISE pkg_Error.Controlled_Error;
      --Validacion de error no controlado
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
  END fnuProductoPorDireccion;
END pkg_bodirecciones;
/

BEGIN
      pkg_utilidades.prAplicarPermisos('PKG_BODIRECCIONES', 'ADM_PERSON');
END;
/    