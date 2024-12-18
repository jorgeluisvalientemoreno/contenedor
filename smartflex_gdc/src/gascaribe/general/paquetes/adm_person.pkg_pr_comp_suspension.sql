CREATE OR REPLACE PACKAGE adm_person.pkg_pr_comp_suspension IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_pr_comp_suspension
      Autor            :      Jorge Valiente
      Fecha            :      18/03/2024      
      Descripcion      :      Paquete para realizar CRUD sobre la entidad pr_comp_suspension   
      Modificaciones   :      
      Autor       Fecha       Caso    Descripcion
  
  *******************************************************************************/

  -- Retona Identificador del ultimo caso que hizo cambios en este archivo
  FUNCTION fsbVersion RETURN VARCHAR2;

  --Actualiza la fecha final indicando hasta donde estuvo suspendido el componente del producto
  PROCEDURE prcActualizaFechaFinal(inuCodigoComponente    number,
                                   dtFechaFinalSuspension date);

  --Inactiva el componente suspendido del producto con la fecha final de ejecucion de la orden legalizada
  PROCEDURE prcInactivaSuspension(inuCodigoComponente    number,
                                  dtFechaFinalSuspension date);

END pkg_pr_comp_suspension;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_pr_comp_suspension IS

  -- Identificador del ultimo caso que hizo cambios
  csbVersion VARCHAR2(15) := 'OSF-2477';

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : fsbVersion
  Descripcion     : Retona la ultima modificacion que hizo cambios en el paquete
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
  Programa        : prcActualizaFechaFinal
  Descripcion     : Actualiza la fecha final indicando hasta donde estuvo suspendido el componente del producto
  Autor           : Jorge Valiente
  Fecha           : 18/03/2024 
  
  Parametros de Entrada
  inuSesunuse Codido del servicio 
  inuSesuesco Codigo del estado de corte
  
  Parametros de Salida
  
  Modificaciones  :
  Autor       Fecha       Caso     Descripcion
  ***************************************************************************/
  PROCEDURE prcActualizaFechaFinal(inuCodigoComponente    number,
                                   dtFechaFinalSuspension date) IS
    -- Nombre de este metodo
    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'prcActualizaFechaFinal';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error
  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    UPDATE PR_COMP_SUSPENSION
       SET INACTIVE_DATE = dtFechaFinalSuspension
     WHERE COMP_SUSPENSION_ID = inuCodigoComponente
       AND ACTIVE = 'Y';
  
    pkg_traza.trace('El componente de suspension ' || inuCodigoComponente ||
                    ' se actualiza a la fecha final de suspension ' ||
                    dtFechaFinalSuspension,
                    pkg_traza.cnuNivelTrzDef);
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
    
  END prcActualizaFechaFinal;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : prcInactivaSuspension
  Descripcion     : Inactiva el componente suspendido del producto con la fecha final de ejecucion de la orden legalizada
  Autor           : Jorge Valiente
  Fecha           : 18/03/2024 
  
  Parametros de Entrada
  inuProducto   Codido del producto 
  sbActivo      La suspension esta o no activa YES[Y], NO[N]
  
  Parametros de Salida
  
  Modificaciones  :
  Autor       Fecha       Caso     Descripcion
  ***************************************************************************/
  PROCEDURE prcInactivaSuspension(inuCodigoComponente    number,
                                  dtFechaFinalSuspension date) IS
    -- Nombre de este metodo
    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'prcInactivaSuspension';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error
  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    UPDATE PR_COMP_SUSPENSION
       SET ACTIVE = 'N', INACTIVE_DATE = dtFechaFinalSuspension
     WHERE COMP_SUSPENSION_ID = inuCodigoComponente;
  
    pkg_traza.trace('El componente ' || inuCodigoComponente ||
                    ' dejo de estar suspendido el ' ||
                    dtFechaFinalSuspension,
                    pkg_traza.cnuNivelTrzDef);
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
    
  END prcInactivaSuspension;

END pkg_pr_comp_suspension;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_PR_COMP_SUSPENSION', 'ADM_PERSON');
END;
/
