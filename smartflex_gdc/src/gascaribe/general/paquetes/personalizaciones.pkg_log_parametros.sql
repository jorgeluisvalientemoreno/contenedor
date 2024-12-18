create or replace PACKAGE personalizaciones.pkg_log_parametros IS
   subtype styLogParametros  is  log_parametros%rowtype;
   FUNCTION fsbVersion RETURN VARCHAR2;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 20-08-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      20-08-2024   OSF-3140    Creacion
  ***************************************************************************/
  
   PROCEDURE prInsertarLogParametro( iregLogParametros  IN  styLogParametros);
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsertarLogParametro
    Descripcion     : proceso que inserta en la tabla de log de parametros

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 20-08-2024

    Parametros de Entrada
      iregLogParametros        registro de log de parametros
    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       20-08-2024   OSF-3140    Creacion
  ***************************************************************************/
END pkg_log_parametros;
/
create or replace PACKAGE BODY personalizaciones.pkg_log_parametros IS
   -- Constantes para el control de la traza
   csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
   -- Identificador del ultimo caso que hizo cambios
   csbVersion     CONSTANT VARCHAR2(15) := 'OSF-3140';
   
   FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 20-08-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      20-08-2024   OSF-3140    Creacion
  ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;
  
   PROCEDURE prInsertarLogParametro( iregLogParametros  IN  styLogParametros) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsertarLogParametro
    Descripcion     : proceso que inserta en la tabla de log de parametros

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 20-08-2024

    Parametros de Entrada
      iregLogParametros        registro de log de parametros
    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       20-08-2024   OSF-3140    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prInsertarLogParametro';
    nuError  NUMBER;
    sbError  VARCHAR2(4000);
    
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
   INSERT INTO personalizaciones.log_parametros (
                                                    codigo,
                                                    valor_numerico_actual,
                                                    valor_numerico_ante,
                                                    valor_cadena_actual,
                                                    valor_cadena_ante,
                                                    valor_fecha_actual,
                                                    valor_fecha_ante,
                                                    proceso_actual,
                                                    proceso_ante,
                                                    estado_actual,
                                                    estado_ante,
                                                    obligatorio_actual,
                                                    obligatorio_ante,
                                                    fecha_registro,
                                                    usuario,
                                                    terminal
                                        ) VALUES (
                                            iregLogParametros.codigo,
                                            iregLogParametros.valor_numerico_actual,
                                            iregLogParametros.valor_numerico_ante,
                                            iregLogParametros.valor_cadena_actual,
                                            iregLogParametros.valor_cadena_ante,
                                            iregLogParametros.valor_fecha_actual,
                                            iregLogParametros.valor_fecha_ante,
                                            iregLogParametros.proceso_actual,
                                            iregLogParametros.proceso_ante,
                                            iregLogParametros.estado_actual,
                                            iregLogParametros.estado_ante,
                                            iregLogParametros.obligatorio_actual,
                                            iregLogParametros.obligatorio_ante,
                                            iregLogParametros.fecha_registro,
                                            iregLogParametros.usuario,
                                            iregLogParametros.terminal );
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError, sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       raise pkg_error.CONTROLLED_ERROR; 
  END prInsertarLogParametro;
END pkg_log_parametros;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_LOG_PARAMETROS','PERSONALIZACIONES');
END;
/
