create or replace package personalizaciones.pkg_bcld_parameter is

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : pkg_bcld_parameter
    Descripcion     : Paquete para obtener DATA de la entidad LD_PARAMETER
    Autor           : Jorge Valiente
    Fecha           : 06-03-2024
  
    Parametros de Entrada
  
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/

  --funcion que devuelve valor cadena del codigo del parametro ingresado
  FUNCTION fsbObtieneValorCadena(isbNombreParametro IN varchar2)
    return varchar2;

  --uncion que devuelve valor numerico del codigo del parametro ingresado    
  FUNCTION fnuObtieneValorNumerico(isbNombreParametro IN varchar2)
    return number;

END pkg_bcld_parameter;
/
create or replace package body personalizaciones.pkg_bcld_parameter is

  csbSP_NAME CONSTANT VARCHAR2(32) := $$PLSQL_UNIT || '.';

  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : fsbObtieneValorCadena
      Descripcion     : funcion que devuelve valor cadena del codigo del parametro ingresado
      Autor           : Jorge Valiente
      Fecha           : 06-03-2024

      Parametros              Tipo      Descripcion
      ============            =====      ===================
      isbNombreParametro      Entrada    Codigo Parametro
      sbValor                 Salida     Valor del parametro
  
      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
  FUNCTION fsbObtieneValorCadena(isbNombreParametro IN varchar2)
    return varchar2 IS
  
    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'fsbObtieneValorCadena';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error 
  
    sbValor ld_parameter.value_chain%type;
  
    CURSOR cuGetValorParametro IS
      SELECT ld_parameter.value_chain
        FROM ld_parameter
       WHERE ld_parameter.parameter_id = isbNombreParametro;
  
  BEGIN
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    IF cuGetValorParametro%ISOPEN THEN
      CLOSE cuGetValorParametro;
    END IF;
  
    OPEN cuGetValorParametro;
    FETCH cuGetValorParametro
      INTO sbValor;
    CLOSE cuGetValorParametro;
  
    pkg_traza.trace('Valor numerico: ' || sbValor,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
    RETURN sbValor;
  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
    
      RETURN sbValor;
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
    
      RETURN sbValor;
  END fsbObtieneValorCadena;

  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : fnuObtieneValorNumerico
      Descripcion     : funcion que devuelve valor numerico del codigo del parametro ingresado
      Autor           : Jorge Valiente
      Fecha           : 06-03-2024
  
      Parametros              Tipo      Descripcion
      ============            =====      ===================
      isbNombreParametro      Entrada    Codigo Parametro
      nuValor                 Salida     Valor del parametro
      
      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
  FUNCTION fnuObtieneValorNumerico(isbNombreParametro IN varchar2)
    return number is
  
    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'fnuObtieneValorNumerico';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error 
  
    nuValor ld_parameter.numeric_value%type;
  
    CURSOR cuGetValorParametro IS
      SELECT ld_parameter.numeric_value
        FROM ld_parameter
       WHERE ld_parameter.parameter_id = isbNombreParametro;
  
  BEGIN
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    IF cuGetValorParametro%ISOPEN THEN
      CLOSE cuGetValorParametro;
    END IF;
  
    OPEN cuGetValorParametro;
    FETCH cuGetValorParametro
      INTO nuValor;
    CLOSE cuGetValorParametro;
  
    pkg_traza.trace('Valor cadena: ' || nuValor, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN nuValor;
  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
    
      RETURN nuValor;
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
    
      RETURN nuValor;
  END fnuObtieneValorNumerico;

END pkg_bcld_parameter;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BCLD_PARAMETER',
                                   'PERSONALIZACIONES');
END;
/
PROMPT OTORGA PERMISOS a REXEREPORTES sobre el paquete PKG_BCLD_PARAMETER
GRANT EXECUTE ON PERSONALIZACIONES.PKG_BCLD_PARAMETER TO REXEREPORTES;
/