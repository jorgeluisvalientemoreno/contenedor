create or replace package personalizaciones.pkg_bcldc_pararepe is

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : pkg_bcldc_pararepe
    Descripcion     : Paquete para obtener DATA de la entidad ldc_pararepe
    Autor           : Jorge Valiente
    Fecha           : 15-04-2024
  
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

END pkg_bcldc_pararepe;
/
create or replace package body personalizaciones.pkg_bcldc_pararepe is

  csbSP_NAME CONSTANT VARCHAR2(32) := $$PLSQL_UNIT || '.';

  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : fsbObtieneValorCadena
      Descripcion     : funcion que devuelve valor cadena del codigo del parametro ingresado
      Autor           : Jorge Valiente
      Fecha           : 15-04-2024
  
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
  
    sbValor ldc_pararepe.paravast%type;
  
    CURSOR cuGetValorParametro IS
      SELECT ldc_pararepe.paravast
        FROM ldc_pararepe
       WHERE ldc_pararepe.parecodi = isbNombreParametro;
  
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
  
    pkg_traza.trace('Valor Cadena: ' || sbValor, pkg_traza.cnuNivelTrzDef);
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
      Fecha           : 15-04-2024
  
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
  
    nuValor ldc_pararepe.parevanu%type;
  
    CURSOR cuGetValorParametro IS
      SELECT ldc_pararepe.parevanu
        FROM ldc_pararepe
       WHERE ldc_pararepe.parecodi = isbNombreParametro;
  
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
  
    pkg_traza.trace('Valor Numerico: ' || nuValor,
                    pkg_traza.cnuNivelTrzDef);
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

END pkg_bcldc_pararepe;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BCLDC_PARAREPE',
                                   'PERSONALIZACIONES');
END;
/
