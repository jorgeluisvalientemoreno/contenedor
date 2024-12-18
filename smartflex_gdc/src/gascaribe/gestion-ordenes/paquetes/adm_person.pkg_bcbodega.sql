CREATE OR REPLACE PACKAGE adm_person.pkg_bcbodega IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_bcbodega
      Autor       :   Jorge Valiente
      Fecha       :   21-05-2024
      Descripcion :   Paquete para realizar consulta a las bodegas asociadas
  
      Modificaciones   
      -----------------------------------------------------------------------
      Autor       Fecha       Caso       Descripcion
  *******************************************************************************/

  -- Retona Identificador del ultimo caso que hizo cambios en este archivo
  FUNCTION fsbVersion RETURN VARCHAR2;

  -- Retona la cantidad de transito entrante en la bodega de la unidad operativa
  FUNCTION fnuObtieneTransitoEntConCosto(inuUnidadOperativa number) RETURN number;

END pkg_bcbodega;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bcbodega IS

  -- Identificador del ultimo caso que hizo cambios
  csbVersion VARCHAR2(15) := 'OSF-2727';

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : fsbVersion
  Descripcion     : Retona la ultima WO que hizo cambios en el paquete
  Autor           : Jorge Valiente
  Fecha           : 21-05-2024
  
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
  Programa        : fnuObtieneTransitoEntConCosto
  Descripcion     : Retona la cantidad de transito entrante en movimiento en la bodega de la unidad operativa
  Autor           : Jorge Valiente
  Fecha           : 21-05-2024
  
  Modificaciones   
  -----------------------------------------------------------------------
  Autor           Fecha       Caso       Descripcion
  ***************************************************************************/
  FUNCTION fnuObtieneTransitoEntConCosto(inuUnidadOperativa number) RETURN number IS
  
    -- Nombre de ste mEtodo
    csbMetodo   VARCHAR2(70) := csbSP_NAME || '.fnuObtieneTransitoEntConCosto';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error  
  
    cursor cuTransitoEntrante is
      SELECT nvl(sum(ouibm.amount),0)
        FROM open.or_uni_item_bala_mov ouibm
       WHERE ouibm.operating_unit_id = inuUnidadOperativa
         AND ouibm.movement_type = 'N'
         AND ouibm.item_moveme_caus_id IN (20, 6)
         AND ouibm.support_document = ' '
         AND nvl(ouibm.total_value, 0) > 0;
  
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
    
  END fnuObtieneTransitoEntConCosto;

END pkg_bcbodega;
/
begin
  PKG_UTILIDADES.PRAPLICARPERMISOS('PKG_BCBODEGA', 'ADM_PERSON');
end;
/
