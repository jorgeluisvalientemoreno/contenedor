create or replace PACKAGE personalizaciones.pkg_bcregistropno IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_bcregistropno
      Autor       :   Jorge Valiente
      Fecha       :   16-05-2025
      Descripcion :   Paquete con las consultas generales para PNO
      Modificaciones  :
      Autor       Fecha       Caso    Descripcion    
  *******************************************************************************/

  -- Retona Identificador del ultimo caso que hizo cambios en este archivo
  FUNCTION fsbVersion RETURN VARCHAR2;

  --Servicio para establecer la existencia de una orden en un tipo de trabajo en un prodcuto registdao en PNO
  FUNCTION fsbExisteOTProducto(inuTipoTrabajo NUMBER, inuProducto NUMBER)
    RETURN VARCHAR2;

  --Servicio para establecer la existencia de una orden en un tipo de trabajo, causal y fecha en un prodcuto registdao en PNO
  FUNCTION fsbExisteOTCausalReincidente(inuTipoTrabajo NUMBER,
                                        inuCausal      NUMBER,
                                        idtFecha       DATE,
                                        inuProducto    NUMBER)
    RETURN VARCHAR2;

END pkg_bcregistropno;
/
create or replace PACKAGE BODY personalizaciones.pkg_bcregistropno IS

  -- Constantes para el control de la traza
  csbUnidad CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  cnuNVLTRC CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;
  csbInicio CONSTANT VARCHAR2(4) := pkg_traza.fsbINICIO;
  csbFin    CONSTANT VARCHAR2(4) := pkg_traza.fsbFIN;

  -- Identificador del ultimo caso que hizo cambios
  csbVersion VARCHAR2(15) := 'OSF-4318';

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : fsbVersion
  Descripcion     : Retona la ultima WO que hizo cambios en el paquete
  Autor           : Jorge Valiente
  Fecha           : 30/05/2025
  Modificaciones  :
  Autor       Fecha       Caso    Descripcion
  
  ***************************************************************************/
  FUNCTION fsbVersion RETURN VARCHAR2 IS
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : fsbExisteOTProducto
  Descripcion     : Servicio para establecer la existencia de una orden en un tipo de trabajo en un prodcuto registdao en PNO
  Autor           : Jorge Valiente
  Fecha           : 16/05/2025
  
  Parametros 
    Entrada:
      Tipo de trabajo
      producto
  
    Salida:
      S - Si existe
      N - No Existe
  
  Modificaciones  :
  Autor       Fecha       Caso     Descripcion
  ***************************************************************************/
  FUNCTION fsbExisteOTProducto(inuTipoTrabajo NUMBER, inuProducto NUMBER)
    RETURN VARCHAR2 IS
    -- Nombre de este metodo
    csbMT_NAME  VARCHAR2(70) := csbUnidad || 'fsbExisteOTProducto';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error
  
    sbExisteOT VARCHAR2(1) := 'N';
  
    CURSOR cuOTProducto IS
      select count(1)
        from Or_Order_Activity ooa
        LEFT JOIN Or_Order oo
          on oo.order_id = ooa.order_id
       WHERE ooa.task_type_id = inuTipoTrabajo
         and ooa.product_id = inuProducto;
  
    nuOTProducto NUMBER;
  
  BEGIN
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
  
    pkg_traza.trace('Tipo Trabajo: ' || inuTipoTrabajo, cnuNVLTRC);
    pkg_traza.trace('Producto: ' || inuProducto, cnuNVLTRC);

    IF (cuOTProducto%ISOPEN) THEN
      CLOSE cuOTProducto;
    END IF;

    OPEN cuOTProducto;
    FETCH cuOTProducto
      INTO nuOTProducto;
    CLOSE cuOTProducto;
  
    IF nuOTProducto > 0 THEN
      sbExisteOT := 'S';
    END IF;
  
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbFin);
  
    RETURN sbExisteOT;
  
  EXCEPTION
  
    --Validación de error controlado
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      RETURN sbExisteOT;
    
    --Validación de error no controlado
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RETURN sbExisteOT;
    
  END fsbExisteOTProducto;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : fsbExisteOTCausalReincidente
  Descripcion     : Servicio para establecer la existencia de una orden en un tipo de trabajo, causal y fecha en un prodcuto registdao en PNO
  Autor           : Jorge Valiente
  Fecha           : 16/05/2025
  
  Parametros 
    Entrada:
      Tipo de trabajo
      producto
  
    Salida:
      S - Si existe
      N - No Existe
  
  Modificaciones  :
  Autor       Fecha       Caso     Descripcion
  ***************************************************************************/
  FUNCTION fsbExisteOTCausalReincidente(inuTipoTrabajo NUMBER,
                                        inuCausal      NUMBER,
                                        idtFecha       DATE,
                                        inuProducto    NUMBER)
    RETURN VARCHAR2 IS
    -- Nombre de este metodo
    csbMT_NAME  VARCHAR2(70) := csbUnidad || 'fsbExisteOTCausalReincidente';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error
  
    sbExisteOT VARCHAR2(1) := 'N';
  
    CURSOR cuOTProducto IS
      select count(1)
        from Or_Order_Activity ooa
        LEFT JOIN Or_Order oo
          on oo.order_id = ooa.order_id
       WHERE ooa.task_type_id = inuTipoTrabajo
         and oo.causal_id = inuCausal
         and TRUNC(oo.created_date) >= TRUNC(idtFecha)
         and ooa.product_id = inuProducto;
  
    nuOTProducto NUMBER;
  
  BEGIN
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
  
    pkg_traza.trace('Tipo Trabajo: ' || inuTipoTrabajo, cnuNVLTRC);
    pkg_traza.trace('Causal: ' || inuCausal, cnuNVLTRC);
    pkg_traza.trace('Fecha: ' || idtFecha, cnuNVLTRC);
    pkg_traza.trace('Producto: ' || inuProducto, cnuNVLTRC);

    IF (cuOTProducto%ISOPEN) THEN
      CLOSE cuOTProducto;
    END IF;

    OPEN cuOTProducto;
    FETCH cuOTProducto
      INTO nuOTProducto;
    CLOSE cuOTProducto;
  
    IF nuOTProducto > 0 THEN
      sbExisteOT := 'S';
    END IF;
  
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbFin);
  
    RETURN sbExisteOT;
  
  EXCEPTION
  
    --Validación de error controlado
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      RETURN sbExisteOT;
    
    --Validación de error no controlado
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RETURN sbExisteOT;
    
  END fsbExisteOTCausalReincidente;

END pkg_bcregistropno;
/
begin
  pkg_utilidades.prAplicarPermisos(upper('pkg_bcregistropno'),
                                   upper('PERSONALIZACIONES'));
end;
/
