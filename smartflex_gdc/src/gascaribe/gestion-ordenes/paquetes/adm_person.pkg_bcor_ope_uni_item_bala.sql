CREATE OR REPLACE PACKAGE adm_person.pkg_bcor_ope_uni_item_bala IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_bcor_ope_uni_item_bala
      Autor       :   Jorge Valiente
      Fecha       :   05-Abril-2024
      Descripcion :   Paquete para realizar CRUD sobre la entidad or_ope_uni_item_bala
  
      Modificaciones   
      -----------------------------------------------------------------------
      Autor       Fecha       Caso       Descripcion
  *******************************************************************************/

  -- Retona Identificador del ultimo caso que hizo cambios en este archivo
  FUNCTION fsbVersion RETURN VARCHAR2;

  -- Retona la cantidad de transito entrante en la bodega de la unidad operativa
  FUNCTION fnuTotalTransitoEntrante(inuUnidadOperativa number) RETURN number;

  -- Retona la cantidad de transito saliente en la bodega de la unidad operativa
  FUNCTION fnuTotalTransitoSalida(inuUnidadOperativa number) RETURN number;

END pkg_bcor_ope_uni_item_bala;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bcor_ope_uni_item_bala IS

  -- Identificador del ultimo caso que hizo cambios
  csbVersion VARCHAR2(15) := 'OSF-2552';

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : fsbVersion
  Descripcion     : Retona la ultima WO que hizo cambios en el paquete
  Autor           : Jorge Valiente
  Fecha           : 05-Abril-2024
  
  Modificaciones   
  -----------------------------------------------------------------------
  Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  FUNCTION fsbVersion RETURN VARCHAR2 IS
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : fnuTotalTransitoEntrante
  Descripcion     : Retona la cantidad de transito entrante en la bodega de la unidad operativa
  Autor           : Jorge Valiente
  Fecha           : 05-Abril-2024
  
  Modificaciones   
  -----------------------------------------------------------------------
  Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  FUNCTION fnuTotalTransitoEntrante(inuUnidadOperativa number) RETURN number IS
  
    -- Nombre de ste mEtodo
    csbMetodo   VARCHAR2(70) := csbSP_NAME || '.fnuTotalTransitoEntrante';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error  
  
    cursor cuTransitoEntrante is
      select nvl(sum(oouib.transit_in), 0)
        from or_ope_uni_item_bala oouib
       where oouib.operating_unit_id = inuUnidadOperativa;
  
    nuTransitoEntrante number;
  
  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    pkg_traza.trace('Unidad Operativa: ' || inuUnidadOperativa,
                    pkg_traza.cnuNivelTrzDef);
  
    OPEN cuTransitoEntrante;
    FETCH cuTransitoEntrante
      INTO nuTransitoEntrante;
    CLOSE cuTransitoEntrante;
  
    pkg_traza.trace('Cantidad de Transito Entrante en Bodega: ' ||
                    nuTransitoEntrante,
                    pkg_traza.cnuNivelTrzDef);
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
    RETURN nuTransitoEntrante;
  
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      return null;
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      return null;
    
  END fnuTotalTransitoEntrante;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : fnuTotalTransitoEntrante
  Descripcion     : Retona la cantidad de transito saliente en la bodega de la unidad operativa
  Autor           : Jorge Valiente
  Fecha           : 05-Abril-2024
  
  Modificaciones   
  -----------------------------------------------------------------------
  Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  FUNCTION fnuTotalTransitoSalida(inuUnidadOperativa number) RETURN number IS
  
    -- Nombre de ste mEtodo
    csbMetodo   VARCHAR2(70) := csbSP_NAME || '.fnuTotalTransitoSalida';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error  
  
    cursor cuTransitoSalida is
      select nvl(sum(oouib.transit_out), 0)
        from or_ope_uni_item_bala oouib
       where oouib.operating_unit_id = inuUnidadOperativa;
  
    nuTransitoSalida number;
  
  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    pkg_traza.trace('Unidad Operativa: ' || inuUnidadOperativa,
                    pkg_traza.cnuNivelTrzDef);
  
    OPEN cuTransitoSalida;
    FETCH cuTransitoSalida
      INTO nuTransitoSalida;
    CLOSE cuTransitoSalida;
  
    pkg_traza.trace('Cantidad de Transito Salida en Bodega: ' ||
                    nuTransitoSalida,
                    pkg_traza.cnuNivelTrzDef);
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
    RETURN nuTransitoSalida;
  
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      return null;
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      return null;
    
  END fnuTotalTransitoSalida;

END pkg_bcor_ope_uni_item_bala;
/
begin
  PKG_UTILIDADES.PRAPLICARPERMISOS('PKG_BCOR_OPE_UNI_ITEM_BALA',
                                   'ADM_PERSON');
end;
/
