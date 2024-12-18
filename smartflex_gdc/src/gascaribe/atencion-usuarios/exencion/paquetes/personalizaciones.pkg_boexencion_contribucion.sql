CREATE OR REPLACE PACKAGE personalizaciones.pkg_boexencion_contribucion IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_boexencion_contribucion
      Autor          : Jorge Valiente  
      Fecha          : 06/03/2024  
      Descripcion    : Paquete relcaionada con la exencion  
      Modificaciones :
      Autor       Fecha       Caso    Descripcion
  
  *******************************************************************************/

  -- Retona Identificador del ultimo caso que hizo cambios en este archivo
  FUNCTION fsbVersion RETURN VARCHAR2;

  -- Valida Tipo Exencion definido en la solicitud configurado en el parametro TIPO_EXENCION_COBRO_A_FACTURAR
  FUNCTION fnuValidaTipoExencionSolicitud(inuSolicutd number) RETURN number;

END pkg_boexencion_contribucion;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_boexencion_contribucion IS

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

  /*****************************************************************
  Propiedad intelectual de GDC.
  
  Unidad         : fnuValidaTipoExencionSolicitud
  Descripcion    : Servicio para validar si el tipo exencion definido en la solicitud 
                   esta definido en el nuevo parametro TIPO_EXENCION_COBRO_A_FACTURAR
                   para generar promocion
  Autor          : Jorge Valiente
  Fecha          : 28-02-2024
  Caso           : OSF-2414
  
  Parametros     Tipo      Descripcion
  ============   =====      ===================
  inuSolicutd    Entrada    Codigo de solicitud
  nuExiste       Salida     1 - Existe tipo exencion en el parametro
  nuExiste       Salida     0 - No Existe tipo exencion en el parametro
  
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/
  FUNCTION fnuValidaTipoExencionSolicitud(inuSolicutd number) RETURN NUMBER IS
  
    csbMetodo CONSTANT VARCHAR2(100) := csbSP_NAME ||
                                        'fnuValidaTipoExencionSolicitud'; --nombre del metodo
    nuExiste NUMBER := 0;
  
    onuErrorCode    number;
    osbErrorMessage varchar2(4000);
  
    sbTipoExencionCobroFacturar varchar2(4000) := null;
  
    nuTipoExencionSolicitud number;
  
    cursor cuExisteTipoExencion is
      select count(1)
        from dual
       where nuTipoExencionSolicitud in
             (SELECT to_number(regexp_substr(sbTipoExencionCobroFacturar,
                                             '[^,]+',
                                             1,
                                             LEVEL)) AS TipoExencionCobroFacturar
                FROM dual
              CONNECT BY regexp_substr(sbTipoExencionCobroFacturar,
                                       '[^,]+',
                                       1,
                                       LEVEL) IS NOT NULL);
  
  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    pkg_traza.trace('Solicitud: ' || inuSolicutd, pkg_traza.cnuNivelTrzDef);
  
    nuTipoExencionSolicitud := pkg_bcexencion_contribucion.fnuObtenerTipoExencion(inuSolicutd);
    pkg_traza.trace('Tipo Exencion [' || nuTipoExencionSolicitud ||
                    '] definido en la solicitud ' || inuSolicutd,
                    pkg_traza.cnuNivelTrzDef);
  
    sbTipoExencionCobroFacturar := pkg_bcld_parameter.fsbObtieneValorCadena('TIPO_EXENCION_COBRO_A_FACTURAR');
  
    open cuExisteTipoExencion;
    fetch cuExisteTipoExencion
      into nuExiste;
    close cuExisteTipoExencion;
  
    pkg_traza.trace('Existe: ' || nuExiste, pkg_traza.cnuNivelTrzDef);
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
    RETURN(nvl(nuExiste, 0));
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('Error: ' || OsbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      RETURN 0;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('Error: ' || OsbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RETURN 0;
  END fnuValidaTipoExencionSolicitud;

END pkg_boexencion_contribucion;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BOEXENCION_CONTRIBUCION',
                                   'PERSONALIZACIONES');
END;
/
