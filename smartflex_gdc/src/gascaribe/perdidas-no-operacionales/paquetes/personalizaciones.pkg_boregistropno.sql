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


  --Validar proceso para validar actividad seleccionada en PNO y estabelcer si es reincidente
  PROCEDURE prcValida_Actividad(inuActividad NUMBER, inuProducto NUMBER);
  
END pkg_boregistropno;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_boregistropno IS

  -- Identificador del ultimo caso que hizo cambios
  csbVersion VARCHAR2(15) := 'OSF-2364';

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  cnuNVLTRC  CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;
  csbInicio  CONSTANT VARCHAR2(4) := pkg_traza.fsbINICIO;
  csbFin     CONSTANT VARCHAR2(4) := pkg_traza.fsbFIN;
    
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

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : prcValida_Actividad
  Descripcion     : proceso para validar actividad seleccionada en PNO y estabelcer si es reincidente
  Autor           : Jorge Valiente
  Fecha           : 16/05/2025
  
  Parametros 
    Entrada:
      Código actividad
      Código producto
  
  Modificaciones  :
  Autor       Fecha       Caso     Descripcion
  ***************************************************************************/
  PROCEDURE prcValida_Actividad(inuActividad NUMBER, inuProducto NUMBER) IS
    -- Nombre de este metodo
    csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'prcValida_Actividad';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error
  
    nuCategoria NUMBER;
  
    --Variables logica residencial
    nuCATEGORIA_RESIDENCIAL        NUMBER := pkg_parametros.fnuGetValorNumerico('CATEGORIA_RESIDENCIAL');
    nuTIP_TRA_PLIEGO_DE_CARGOS     NUMBER := pkg_parametros.fnuGetValorNumerico('TIPO_TRABAJO_PLIEGO_DE_CARGOS_PNO');
    sbExisteOT                     VARCHAR2(1) := 'N';
    nuExiste                       NUMBER;
    sbACTIVIDADES_REINCIDENTES_PNO VARCHAR(4000) := pkg_parametros.fsbGetValorCadena('ACTIVIDADES_REINCIDENTES_PNO');
  
    --Varaibel logica No Residencial
    sbTITR_CAUSAL_REINCIDENTES_PNO VARCHAR2(4000) := pkg_parametros.fsbGetValorCadena('TIPO_TRABAJO_CAUSAL_REINCIDENTES_PNO');
    dtFECHA_INCIO_PNO_RESIDENCIAL  DATE := TRUNC(pkg_parametros.fdtGetValorFecha('FECHA_INICIO_VALIDACION_PNO'));
  
    rfDataParametro constants_per.tyrefcursor;
  
    sbTipoTrabajo NUMBER;
    sbCausal      NUMBER;
  
  BEGIN
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
  
    pkg_traza.trace('Actividad: ' || inuActividad, cnuNVLTRC);
    pkg_traza.trace('Producto: ' || inuProducto, cnuNVLTRC);
  
    nuCategoria := pkg_bcproducto.fnuCategoria(inuProducto);
    pkg_traza.trace('Categoria: ' || nuCategoria, cnuNVLTRC);
  
    IF nuCATEGORIA_RESIDENCIAL = nuCategoria THEN
      pkg_traza.trace('Residencial', cnuNVLTRC);
      pkg_traza.trace('TIPO_TRABAJO_CAUSAL_REINCIDENTES_PNO: ' ||
                      sbTITR_CAUSAL_REINCIDENTES_PNO,
                      cnuNVLTRC);
    
      rfDataParametro := pkg_boutilidadescadenas.frfObtDataCon3Separadores(sbTITR_CAUSAL_REINCIDENTES_PNO,
                                                                           '|',
                                                                           ';',
                                                                           ',');
    
      LOOP
        FETCH rfDataParametro
          INTO sbTipoTrabajo, sbCausal;
      
        pkg_traza.trace('Tipo de Trabajo: ' || sbTipoTrabajo ||
                        ' - Causal: ' || sbCausal,
                        cnuNVLTRC);
      
        sbExisteOT := PKG_BCREGISTROPNO.fsbExisteOTCausalReincidente(TO_NUMBER(sbTipoTrabajo),
                                                                     TO_NUMBER(sbCausal),
                                                                     dtFECHA_INCIO_PNO_RESIDENCIAL,
                                                                     inuProducto);
        EXIT WHEN rfDataParametro%NOTFOUND OR sbExisteOT = 'S';
      END LOOP;
      CLOSE rfDataParametro;
    
      pkg_traza.trace('Existe OT: ' || sbExisteOT, cnuNVLTRC);
      IF sbExisteOT = 'S' THEN
        nuExiste := pkg_parametros.fnuValidaSiExisteCadena('ACTIVIDADES_REINCIDENTES_PNO',
                                                           ',',
                                                           inuActividad);
      
        IF nuExiste = 0 THEN
          pkg_error.setErrorMessage(isbMsgErrr => 'La(s) actividad(es) valida(s) para reincidentes son (' ||
                                                  sbACTIVIDADES_REINCIDENTES_PNO || ')');
        end if;
      END IF;
    
    ELSE
      pkg_traza.trace('No Residencial', cnuNVLTRC);
      sbExisteOT := PKG_BCREGISTROPNO.fsbExisteOTProducto(nuTIP_TRA_PLIEGO_DE_CARGOS,
                                                          inuProducto);
      pkg_traza.trace('Existe OT: ' || sbExisteOT, cnuNVLTRC);
      IF sbExisteOT = 'S' THEN
        nuExiste := pkg_parametros.fnuValidaSiExisteCadena('ACTIVIDADES_NO_REINCIDENTES_PNO',
                                                           ',',
                                                           inuActividad);
        pkg_traza.trace('Existe Actividad: ' || nuExiste, cnuNVLTRC);
        IF nuExiste > 0 THEN
          pkg_error.setErrorMessage(isbMsgErrr => 'La(s) actividad(es) valida(s) para reincidentes son (' ||
                                                  sbACTIVIDADES_REINCIDENTES_PNO || ')');
        END IF;
      END IF;
    END IF;
  
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbFin);
  
  EXCEPTION
  
    --Validación de error controlado
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      RAISE pkg_Error.Controlled_Error;
    
    --Validación de error no controlado
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
    
  END prcValida_Actividad;

END pkg_boregistropno;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BOREGISTROPNO', 'PERSONALIZACIONES');
END;
/
