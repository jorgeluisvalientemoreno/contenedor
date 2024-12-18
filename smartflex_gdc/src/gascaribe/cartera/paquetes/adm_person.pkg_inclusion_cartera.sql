CREATE OR REPLACE PACKAGE adm_person.pkg_inclusion_cartera IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_inclusion_cartera
      Autor       :   
      Fecha       :   
      Descripcion :   
      Modificaciones  :
      Autor       Fecha       Caso    Descripcion
  
  *******************************************************************************/

  --Validar que el cursor cuRecord este cerrado
  PROCEDURE prcCancelaInclucion(inuProducto number);

END pkg_inclusion_cartera;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_inclusion_cartera IS

  -- Identificador del ultimo caso que hizo cambios
  csbVersion VARCHAR2(15) := 'OSF-2477';

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';

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
  Programa        : prcCancelaInclucion
  Descripcion     : Servicio para cancelar inclusion de producto
  Autor           : Jorge Valiente
  Fecha           : 24-04-2024
  
  Parametros de Entrada
  
  Parametros de Salida
  
  Modificaciones  :
  Autor       Fecha       Caso     Descripcion
  ***************************************************************************/
  PROCEDURE prcCancelaInclucion(inuProducto number) IS
    -- Nombre de este metodo
    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'prcCancelaInclucion';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error
  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    update inclcoco icc
       set icc.inccfeca = sysdate
     where icc.inccsesu = inuProducto
       and icc.inccfeca is null;
       
    pkg_producto.prcActualizaInclusion(inuProducto, null); 
  
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
  END prcCancelaInclucion;

END pkg_inclusion_cartera;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_INCLUSION_CARTERA', 'ADM_PERSON');
END;
/
