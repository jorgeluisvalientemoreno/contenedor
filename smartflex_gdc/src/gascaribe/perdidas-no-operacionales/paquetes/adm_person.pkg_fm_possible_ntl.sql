CREATE OR REPLACE PACKAGE adm_person.pkg_fm_possible_ntl IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_fm_possible_ntl
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

  Procedure prcActualizarEstado(inuPossible_Ntl_Id number,
                                isbStatus          varchar2);

END pkg_fm_possible_ntl;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_fm_possible_ntl IS

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
    Jorge Valiente         29-01-2024     OSF-1993   Creacion
  ***************************************************************************/
  FUNCTION fsbVersion RETURN VARCHAR2 IS
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcActualizarEstado
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
      Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
  Procedure prcActualizarEstado(inuPossible_Ntl_Id number,
                                isbStatus          varchar2) IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcActualizarEstado';
  
    sbError VARCHAR2(4000);
    nuError NUMBER;
  
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  
    pkg_traza.trace('Codigo Proyecto PNO: ' || inuPossible_Ntl_Id,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Nuevo Estado aplicado: ' || isbStatus,
                    pkg_traza.cnuNivelTrzDef);
  
    update fm_possible_ntl
       set status = isbStatus
     where possible_ntl_id = inuPossible_Ntl_Id;
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  
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
  END prcActualizarEstado;
END pkg_fm_possible_ntl;
/

BEGIN
      pkg_utilidades.prAplicarPermisos('PKG_FM_POSSIBLE_NTL', 'ADM_PERSON');
END;
/    