CREATE OR REPLACE PACKAGE personalizaciones.pkg_recofael_log IS
   subtype styRecofaelLog  is  Recofael_Log%rowtype;
   PROCEDURE prInsRecofaelLog( iregRecofaelLog IN  styRecofaelLog,
                                onuError       OUT NUMBER,
                                osbError       OUT VARCHAR2);
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsRecofaelLog
    Descripcion     : proceso que inserta en la tabla de log de consecutivos de facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 17-01-2024

    Parametros de Entrada
      iregRecofaelLog        registro de log de consecutivos de  factura electronica
    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       17-01-2024   OSF-2158    Creacion
  ***************************************************************************/

END pkg_recofael_log;
/


CREATE OR REPLACE PACKAGE BODY  personalizaciones.pkg_recofael_log IS
    -- Constantes para el control de la traza
   csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
   -- Identificador del ultimo caso que hizo cambios
   csbVersion     CONSTANT VARCHAR2(15) := 'OSF-4620';

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 16-11-2023

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      15-01-2024   OSF-2158    Creacion
  ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  PROCEDURE prInsRecofaelLog( iregRecofaelLog IN  styRecofaelLog,
                              onuError       OUT NUMBER,
                              osbError       OUT VARCHAR2) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsRecofaelLog
    Descripcion     : proceso que inserta en la tabla de log de consecutivos de facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 17-01-2024

    Parametros de Entrada
      iregRecofaelLog        registro de log de consecutivos de  factura electronica
    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       17-01-2024   OSF-2158    Creacion
	JSOTO	   20-06-2025   OSF-4620	Se agrega insercion de dato empresa
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prInsRecofaelLog';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    INSERT INTO recofael_log (  codigo,
                                tipo_documento_actual,
                                tipo_documento_anterior,
                                prefijo_actual,
                                prefijo_anterior,
                                resolucion_actual,
                                resolucion_anterior,
                                cons_inicial_actual,
                                cons_inicial_anterior,
                                cons_final_actual,
                                cons_final_anterior,
                                ultimo_cons_actual,
                                ultimo_cons_anterior,
                                estado_actual,
                                estado_anterior,
                                fecha_resolucion_act ,
                                fecha_resolucion_ant,
                                fecha_ini_vigencia_act,
                                fecha_ini_vigencia_ant,
                                fecha_fin_vigencia_act,
                                fecha_fin_vigencia_ant,
                                operacion,
                                fecha_registro,
                                usuario,
                                terminal,
                                empresa
                    ) VALUES (
                        iregRecofaelLog.codigo,
                        iregRecofaelLog.tipo_documento_actual,
                        iregRecofaelLog.tipo_documento_anterior,
                        iregRecofaelLog.prefijo_actual,
                        iregRecofaelLog.prefijo_anterior,
                        iregRecofaelLog.resolucion_actual,
                        iregRecofaelLog.resolucion_anterior,
                        iregRecofaelLog.cons_inicial_actual,
                        iregRecofaelLog.cons_inicial_anterior,
                        iregRecofaelLog.cons_final_actual,
                        iregRecofaelLog.cons_final_anterior,
                        iregRecofaelLog.ultimo_cons_actual,
                        iregRecofaelLog.ultimo_cons_anterior,
                        iregRecofaelLog.estado_actual,
                        iregRecofaelLog.estado_anterior,
                        iregRecofaelLog.fecha_resolucion_act ,
                        iregRecofaelLog.fecha_resolucion_ant,
                        iregRecofaelLog.fecha_ini_vigencia_act,
                        iregRecofaelLog.fecha_ini_vigencia_ant,
                        iregRecofaelLog.fecha_fin_vigencia_act,
                        iregRecofaelLog.fecha_fin_vigencia_ant,
                        iregRecofaelLog.operacion,
                        SYSDATE,
                        USER,
                        pkg_session.fsbgetTerminal,
                        iregRecofaelLog.empresa
                    );
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(onuError,osbError);
       pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(onuError,osbError);
       pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END prInsRecofaelLog;

END pkg_recofael_log;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_RECOFAEL_LOG','PERSONALIZACIONES');
END;
/