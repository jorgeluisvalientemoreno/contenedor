CREATE OR REPLACE PACKAGE personalizaciones.pkg_bcexencion_contribucion IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_bcexencion_contribucion
      Autor          : Jorge Valiente  
      Fecha          : 06/03/2024  
      Descripcion    : Paquete relcaionada con la exencion  
      Modificaciones :
      Autor       Fecha       Caso    Descripcion
  
  *******************************************************************************/

  -- Retona Identificador del ultimo caso que hizo cambios en este archivo
  FUNCTION fsbVersion RETURN VARCHAR2;

  -- Obtener Tipo Exencion definido en la solicitud
  FUNCTION fnuObtenerTipoExencion(inuSolicitud number) RETURN number;

END pkg_bcexencion_contribucion;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bcexencion_contribucion IS

  -- Identificador del ultimo caso que hizo cambios
  csbVersion VARCHAR2(15) := 'OSF-2414';

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : fsbVersion
  Descripcion     : Retona la ultima WO que hizo cambios en el paquete
  Autor           : Jorge Valiente
  Fecha           : 06/03/2024
  Modificaciones  :
  Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
  FUNCTION fsbVersion RETURN VARCHAR2 IS
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : fnuObtenerTipoExencion
  Descripcion     : Obtener Tipo Exencion definido en la solicitud
  Autor           : Jorge Valiente
  Fecha           : 06/03/2024

  Parametros      Tipo      Descripcion
  ============    =====      ===================
  inuSolicitud    Entrada    Codigo de solicitud
  nuTipoExcencion Salida     Codigo del tipo de exencion  
  
  Modificaciones:
  Autor       Fecha       Caso        Descripcion
  ***************************************************************************/
  FUNCTION fnuObtenerTipoExencion(inuSolicitud number) RETURN number IS
  
    csbMetodo      VARCHAR2(70) := csbSP_NAME || 'fnuObtenerTipoExencion';
    nuErrorCode    NUMBER; -- se almacena codigo de error
    sbErrorMessage VARCHAR2(2000); -- se almacena descripcion del error 
  
    nuTipoExcencion NUMBER := 0;
  
    CURSOR cuTipoExcencion IS
      SELECT TIPO_EXCEP
        FROM LDC_EXCEP_COBRO_FACT
       WHERE PACKAGE_ID = inuSolicitud;
  
  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    pkg_traza.trace('Solicitud: ' || inuSolicitud,
                    pkg_traza.cnuNivelTrzDef);
  
    OPEN cuTipoExcencion;
    FETCH cuTipoExcencion
      INTO nuTipoExcencion;
    IF cuTipoExcencion%NOTFOUND THEN
      nuTipoExcencion := 0;
    END IF;
    CLOSE cuTipoExcencion;
  
    pkg_traza.trace('Tipo Exencion definido: ' || nuTipoExcencion,
                    pkg_traza.cnuNivelTrzDef);
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
    RETURN nuTipoExcencion;
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuErrorCode, sbErrorMessage);
      pkg_traza.trace('Error: ' || sbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      RETURN 0;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbErrorMessage);
      pkg_traza.trace('Error: ' || sbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RETURN 0;
    
  END fnuObtenerTipoExencion;

END pkg_bcexencion_contribucion;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BCEXENCION_CONTRIBUCION',
                                   'PERSONALIZACIONES');
END;
/
