CREATE OR REPLACE PACKAGE personalizaciones.PKG_BoBloqueo_Ordenes IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frfOrdenes
    Descripcion     : proceso que retorna informacion para PB PBBLOR
  
    Autor           : Jorge Luis Valiente Moreno
    Fecha           : 11-12-2023
  
    Parametros de Entrada
  
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       11-12-2023   OSF-2030    Creacion
  ***************************************************************************/
  FUNCTION frfOrdenes(inuTipoTrabajo number,
                      isbOrdenes     varchar2,
                      inuSolicitud   number) RETURN constants_per.tyrefcursor;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcBloqueoOrden
    Descripcion     : proceso que procesa la informacion para PB PBBLOR
  
    Autor           : Jorge Luis Valiente Moreno
    Fecha           : 11-12-2023
  
    Parametros de Entrada
        isbPk          Identificador de la orden.
        inuCurrent     Registro actual.
        inuTotal       Total de registros
    Parametros de Salida
        onuErrorCode   Codigo de error.
        osbErrorMess   Mensaje de error.
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
    LJLB       11-12-2023   OSF-2030    Creacion
  ***************************************************************************/
  PROCEDURE prcBloqueoOrden(inuOrden            IN NUMBER,
                            inuCodigoComentario NUMBER,
                            isbComentario       VARCHAR2,
                            inuCodigoCausal     NUMBER);

END PKG_BoBloqueo_Ordenes;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.PKG_BoBloqueo_Ordenes IS

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion VARCHAR2(15) := 'OSF-2030';

  FUNCTION fsbVersion RETURN VARCHAR2 IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : fsbVersion
      Descripcion     : Retona el identificador del ultimo caso que hizo cambios
      Autor           : Jorge Luis Valiente Moreno
      Fecha           : 11-12-2023
    
      Modificaciones  :
      Autor       Fecha       Caso       Descripcion
      LJLB       16-11-2023   OSF-2030    Creacion
    ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  FUNCTION frfOrdenes(inuTipoTrabajo NUMBER,
                      isbOrdenes     VARCHAR2,
                      inuSolicitud   NUMBER)
    RETURN constants_per.tyrefcursor IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : frfOrdenes
      Descripcion     : proceso que retorna informacion de ordenes para PB PBBLOR
    
      Autor           : Jorge Luis Valiente Moreno
      Fecha           : 11-12-2023
    
      Parametros de Entrada
    
      Parametros de Salida
    
      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso       Descripcion
    ***************************************************************************/
    csbMT_NAME          VARCHAR2(70) := csbSP_NAME || '.frfOrdenes';
    nuError             NUMBER;
    sberror             VARCHAR2(4000);
    rfOrdenes           constants_per.tyrefcursor;
  
  BEGIN
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    pkg_traza.trace('Codigo Tipo de trabajo: ' || inuTipoTrabajo,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Ordenes: ' || isbOrdenes, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Solicitud: ' || inuSolicitud,
                    pkg_traza.cnuNivelTrzDef);
  
    rfOrdenes := PKG_BcBloqueo_Ordenes.frfOrdenes(inuTipoTrabajo,
                                                  isbOrdenes,
                                                  inuSolicitud);
  
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

  PROCEDURE prcBloqueoOrden(inuOrden            IN NUMBER,
                            inuCodigoComentario NUMBER,
                            isbComentario       VARCHAR2,
                            inuCodigoCausal     NUMBER) IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcBloqueoOrden
      Descripcion     : proceso que procesa la informacion para PB PBBLOR
    
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
  
    onuErrorCode    number;
    osbErrorMessage varchar2(4000);
  
  BEGIN
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    pkg_traza.trace('Orden: ' || inuOrden, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Codigo Comentario: ' || inuCodigoComentario,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Comentario: ' || isbComentario,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Codigo Causal: ' || inuCodigoCausal,
                    pkg_traza.cnuNivelTrzDef);
  
    API_LOCKORDER(inuOrden,
                  inuCodigoComentario,
                  isbComentario,
                  sysdate,
                  onuErrorCode,
                  osbErrorMessage);

    if onuErrorCode != 0 then
      pkg_error.setErrorMessage(onuErrorCode, osbErrorMessage);
    end if;
  
    pkg_or_order.prc_actualizacausalorden(inuOrden,
                                          inuCodigoCausal,
                                          onuErrorCode,
                                          osbErrorMessage);
  
    if onuErrorCode != 0 then
      pkg_error.setErrorMessage(onuErrorCode, osbErrorMessage);
    end if;
  
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

END PKG_BoBloqueo_Ordenes;
/
