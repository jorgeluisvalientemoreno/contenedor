CREATE OR REPLACE PACKAGE ADM_PERSON.pkg_ge_items_seriado IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_ge_items_seriado
      Autor       :   Jorge Valiente
      Fecha       :   01-02-2024
      Descripcion :   Paquete con los metodos CRUD para manejo de informacion
                      sobre la entidad las tablas ge_items_seriado
      Modificaciones  :
      Autor       Fecha       Caso    Descripcion
  *******************************************************************************/

  -- Retona Identificador del ultimo caso que hizo cambios en este archivo
  FUNCTION fsbVersion RETURN VARCHAR2;

  --recibe el identificacion del item y la serie del elemento de medicion.
  PROCEDURE prcRetirarUnidadOperativa(inuItems_id in number,
                                      idbSerie    in varchar2);

END pkg_ge_items_seriado;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.pkg_ge_items_seriado IS

  -- Identificador del ultimo caso que hizo cambios
  csbVersion VARCHAR2(15) := 'OSF-1805';

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';

  FUNCTION fsbVersion RETURN VARCHAR2 IS
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete
    Autor           : Jorge Valiente
    Fecha           : 01-02-2024
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  PROCEDURE prcRetirarUnidadOperativa(inuItems_id in number,
                                      idbSerie    in varchar2) IS
  
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcRetirarUnidadOperativa
    Descripcion     : Retira la unidad operativa de un item seriado.
    Autor           : Jorge Valiente
    Fecha           : 01-02-2024
    
    Parametros de Entrada
    inuproduct_id     Codigo del producto
    
    Parametros de Salida
    isbrcProduct      Registro de la tabla Producto
    
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    ***************************************************************************/
  
    csbMT_NAME VARCHAR2(100) := csbSP_NAME || '.prcRetirarUnidadOperativa';
    nuError    NUMBER; -- se almacena codigo de error
    sbError    VARCHAR2(2000); -- se almacena descripcion del error
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    update ge_items_seriado gis
       set gis.operating_unit_id = null
     where gis.items_id = inuItems_id
       and gis.serie = idbSerie;
  
    ut_trace.trace('Retira unidad operativa del item seriado: ' ||
                   idbSerie,
                   pkg_traza.cnuNivelTrzDef);
 
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
    
  END;

END pkg_ge_items_seriado;
/

BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_GE_ITEMS_SERIADO', 'ADM_PERSON');
END;
/