CREATE OR REPLACE PACKAGE PKG_UIPBblor IS
  FUNCTION frfOrdenes RETURN constants_per.tyrefcursor;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frfOrdenes
    Descripcion     : proceso que retorna informacion de ordenes para PB bloqord
    CASO            : OSF-2030
  
    Autor           : Jorge Luis Valiente Moreno
    Fecha           : 11-12-2023
  
    Parametros de Entrada
  
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  PROCEDURE prcBloqueoOrden(isbOrden        IN VARCHAR2,
                            inucurrent      IN NUMBER,
                            inutotal        IN NUMBER,
                            OnuErrorCode    Out number,
                            OsbErrorMessage Out varchar2);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcBloqueoOrden
    Descripcion     : proceso que procesa la informacion para PB RFEL
  
    Autor           : Jorge Luis Valiente Moreno
    Fecha           : 11-12-2023
  
    Parametros de Entrada
        isbOrden          Identificador de la orden.
        inuCurrent     Registro actual.
        inuTotal       Total de registros
    Parametros de Salida
        onuErrorCode   Codigo de error.
        osbErrorMess   Mensaje de error.
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/

END PKG_UIPBblor;
/
CREATE OR REPLACE PACKAGE BODY PKG_UIPBblor IS

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion VARCHAR2(15) := 'OSF-2030';

  FUNCTION fsbVersion RETURN VARCHAR2 IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : fsbVersion
      Descripcion     : Retona el identificador del ultimo caso que hizo cambios
      CASO            : OSF-2030
    
      Autor           : Jorge Luis Valiente Moreno
      Fecha           : 11-12-2023
    
      Modificaciones  :
      Autor       Fecha       Caso       Descripcion
    ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  FUNCTION frfOrdenes RETURN constants_per.tyrefcursor IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : frfOrdenes
      Descripcion     : proceso que retorna informacion para PB RFEL
      CASO            : OSF-2030
    
      Autor           : Jorge Luis Valiente Moreno
      Fecha           : 11-12-2023
    
      Parametros de Entrada
    
      Parametros de Salida
    
      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso       Descripcion
    ***************************************************************************/
    csbMT_NAME VARCHAR2(70) := csbSP_NAME || '.frfOrdenes';
    nuError    NUMBER;
    sberror    VARCHAR2(4000);
  
    sbTipoTrabajo ge_boinstancecontrol.stysbvalue;
    nuTipoTrabajo number;
    sbOrdenes     ge_boinstancecontrol.stysbvalue;
    sbSolicitud   ge_boinstancecontrol.stysbvalue;
    nuSolicitud   number;
  
    rfOrdenes constants_per.tyrefcursor;
  
    PROCEDURE prValidaDatos IS
      -- Nombre de este m?todo
      csbMT_NAME1 VARCHAR2(105) := csbMT_NAME || '.prValidaDatos';
    
    BEGIN
      pkg_traza.trace(csbMT_NAME1,
                      pkg_traza.cnuNivelTrzDef + 2,
                      pkg_traza.csbINICIO);
      -- se valida campos no vacios
      IF sbTipoTrabajo IS NULL THEN
        pkg_error.setErrorMessage(isbMsgErrr => 'Se debe seleccionar el Tipo de Trabajo');
      END IF;
    
      pkg_traza.trace(csbMT_NAME1,
                      pkg_traza.cnuNivelTrzDef + 2,
                      pkg_traza.csbFIN);
    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.getError(nuError, sberror);
        pkg_traza.trace('sberror: ' || sberror, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME1,
                        pkg_traza.cnuNivelTrzDef + 2,
                        pkg_traza.csbFIN_ERC);
        raise pkg_error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sberror);
        pkg_traza.trace('sberror: ' || sberror, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME1,
                        pkg_traza.cnuNivelTrzDef + 2,
                        pkg_traza.csbFIN_ERR);
        raise pkg_error.CONTROLLED_ERROR;
    END prValidaDatos;
  
  BEGIN
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    sbTipoTrabajo := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER_ACTIVITY',
                                                           'TASK_TYPE_ID');
    sbOrdenes     := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER_ACTIVITY',
                                                           'COMMENT_');
    sbSolicitud   := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER_ACTIVITY',
                                                           'PACKAGE_ID');
  
    pkg_traza.trace('Tipo de trabajo: ' || sbTipoTrabajo,
                    pkg_traza.cnuNivelTrzDef);
  
    prValidaDatos;
  
    nuTipoTrabajo := to_number(sbTipoTrabajo);
    nuSolicitud   := to_number(sbSolicitud);
  
    rfOrdenes := PKG_BOBLOQUEO_ORDENES.frfOrdenes(nuTipoTrabajo,
                                                  sbOrdenes,
                                                  nuSolicitud);
  
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN rfOrdenes;
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('sberror: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('sberror: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
  END frfOrdenes;

  PROCEDURE prcBloqueoOrden(isbOrden        IN VARCHAR2,
                            inucurrent      IN NUMBER,
                            inutotal        IN NUMBER,
                            OnuErrorCode    Out number,
                            OsbErrorMessage Out varchar2) IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcBloqueoOrden
      Descripcion     : proceso que procesa la informacion para PB RFEL
    
      Autor           : Jorge Luis Valiente Moreno
      Fecha           : 11-12-2023
    
      Parametros de Entrada
          isbOrden          Identificador de la orden.
          inuCurrent     Registro actual.
          inuTotal       Total de registros
      Parametros de Salida
          onuErrorCode   Codigo de error.
          osbErrorMess   Mensaje de error.
      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso       Descripcion
    ***************************************************************************/
    -- Nombre de este m?todo
    csbMT_NAME VARCHAR2(105) := csbSP_NAME || '.prcBloqueoOrden';
  
    nuOrden               NUMBER;
    sbCodigoComentario    ge_boinstancecontrol.stysbvalue;
    nuCodigoComentario    NUMBER;
    sbCodigoCausalBloqueo ge_boinstancecontrol.stysbvalue;
    nuCodigoCausalBloqueo NUMBER;
    sbComentario          ge_boinstancecontrol.stysbvalue;
  
  BEGIN
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
    pkg_traza.trace('isbOrden: ' || isbOrden || ' inucurrent: ' ||
                    inucurrent || ' inutotal: ' || inutotal,
                    pkg_traza.cnuNivelTrzDef);
  
    nuOrden               := to_number(isbOrden);
    sbCodigoComentario    := ge_boinstancecontrol.fsbgetfieldvalue('GE_COMMENT_TYPE',
                                                                   'COMMENT_TYPE_ID');
    nuCodigoComentario    := to_number(sbCodigoComentario);
    sbCodigoCausalBloqueo := ge_boinstancecontrol.fsbgetfieldvalue('GE_CAUSAL',
                                                                   'CAUSAL_ID');
    nuCodigoCausalBloqueo := to_number(sbCodigoCausalBloqueo);
    sbComentario          := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER_COMMENT',
                                                                   'ORDER_COMMENT');
  
    PKG_BOBLOQUEO_ORDENES.prcBloqueoOrden(nuOrden,
                                          nuCodigoComentario,
                                          sbComentario,
                                          nuCodigoCausalBloqueo);
  
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('sberror: ' || OsbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('sberror: ' || OsbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
  END prcBloqueoOrden;

END PKG_UIPBblor;
/
