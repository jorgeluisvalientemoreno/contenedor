CREATE OR REPLACE PACKAGE personalizaciones.pkg_lote_fact_electronica IS
   subtype styLoteFactElectronica  is  lote_fact_electronica%rowtype;
   PROCEDURE prInsLoteFactElectronica( iregLoteFacturaEle IN  styLoteFactElectronica);
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsLoteFactElectronica
    Descripcion     : proceso que inserta en la tabla lote de factura electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 08-05-2024

    Parametros de Entrada
      iregLoteFacturaEle        registro de lote de facturacion electronica
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       08-05-2024   OSF-2158    Creacion
  ***************************************************************************/
   PROCEDURE prActLoteFactElectronica( inuCodLote  IN  lote_fact_electronica.codigo_lote%type,
                                       isbEstado   IN  lote_fact_electronica.flag_terminado%type);
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizarFactElecGen
    Descripcion     : proceso que actualiza estado y texto enviado en la tabla factura electronica general

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 08-05-2024

    Parametros de Entrada
      inuCodLote            codigo de lote
      isbEstado             estado del flg terminado
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       08-05-2024   OSF-2158    Creacion
  ***************************************************************************/

   PROCEDURE prActLoteFactElectronica( inuCodLote          IN  lote_fact_electronica.codigo_lote%type,
                                       idtFechaIniProc     IN  lote_fact_electronica.fecha_inicio_proc%type,
                                       idtFechaFinProc     IN  lote_fact_electronica.fecha_inicio_proc%type);
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizarFactElecGen
    Descripcion     : proceso que actualiza estado y texto enviado en la tabla factura electronica general

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 08-05-2024

    Parametros de Entrada
      inuCodLote            codigo de lote
      idtFechaIniProc       fecha de inicio de proceso
      idtFechaFinProc       fecha fin de proceso 
    Parametros de Salida 

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       04-06-2024   OSF-2158    Creacion
  ***************************************************************************/

  PROCEDURE prActLoteFactElectronica( inuCodLote        IN  lote_fact_electronica.codigo_lote%type,
                                      inuCantRegistro   IN  lote_fact_electronica.cantidad_registro%type,
                                      inuHiloProc       IN  lote_fact_electronica.hilos_procesado%type,
                                      inuHiloFall       IN  lote_fact_electronica.hilos_fallido%type,
                                      inuIntentos       IN  lote_fact_electronica.intentos%type,
                                      isbFlagTerminado  IN  lote_fact_electronica.flag_terminado%type,
                                      isbOperacion      IN  varchar2);
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizarFactElecGen
    Descripcion     : proceso que actualiza estado y texto enviado en la tabla factura electronica general

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 08-05-2024

    Parametros de Entrada
      inuCodLote            codigo de lote
      inuCantRegistro       cantidad de registros procesados
      inuHiloProc           hilos procesados
      inuHiloFall           hilos fallidos
      inuIntentos           intentos
      isbFlagTerminado      flag de terminado
      isbOperacion          operacion I - Insertar A - Actualizar
    Parametros de Salida 

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       04-06-2024   OSF-2158    Creacion
  ***************************************************************************/
  FUNCTION frcgetRecord	( inuPerioFact      IN   lote_fact_electronica.periodo_facturacion%type DEFAULT -1,
                          isbFlagTerminado  IN   lote_fact_electronica.flag_terminado%type )  RETURN styLoteFactElectronica;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcgetRecord
    Descripcion     : proceso que retorna informacion  de lote de facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 08-05-2024

    Parametros de Entrada
      inuPerioFact          codigo del periodo de facturacion (-1 para todos)
      isbFlagTerminado      estado del proceso
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        08-05-2024  OSF-2158    Creacion
  ***************************************************************************/
END pkg_lote_fact_electronica;   

/


CREATE OR REPLACE PACKAGE BODY  personalizaciones.pkg_lote_fact_electronica IS
       -- Constantes para el control de la traza
   csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
   -- Identificador del ultimo caso que hizo cambios
   csbVersion     CONSTANT VARCHAR2(15) := 'OSF-2158';

   nuError   NUMBER;
   sbError  VARCHAR2(4000);

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

   PROCEDURE prInsLoteFactElectronica( iregLoteFacturaEle IN  styLoteFactElectronica) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsLoteFactElectronica
    Descripcion     : proceso que inserta en la tabla lote de factura electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 08-05-2024

    Parametros de Entrada
      iregLoteFacturaEle        registro de lote de facturacion electronica
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       08-05-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prInsLoteFactElectronica';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('iregLoteFacturaEle.codigo_lote => ' || iregLoteFacturaEle.codigo_lote, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('iregLoteFacturaEle.periodo_facturacion => ' || iregLoteFacturaEle.periodo_facturacion, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('iregLoteFacturaEle.anio => ' || iregLoteFacturaEle.anio, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('iregLoteFacturaEle.mes => ' || iregLoteFacturaEle.mes, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('iregLoteFacturaEle.ciclo => ' || iregLoteFacturaEle.ciclo, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('iregLoteFacturaEle.cantidad_hilos => ' || iregLoteFacturaEle.cantidad_hilos, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('iregLoteFacturaEle.fecha_inicio => ' || iregLoteFacturaEle.fecha_inicio, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('iregLoteFacturaEle.flag_terminado => ' || iregLoteFacturaEle.flag_terminado, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('iregLoteFacturaEle.tipo_documento => ' || iregLoteFacturaEle.tipo_documento, pkg_traza.cnuNivelTrzDef);

    INSERT INTO lote_fact_electronica( codigo_lote,
                                        periodo_facturacion,
                                        anio,
                                        mes,
                                        ciclo,
                                        cantidad_hilos,
                                        fecha_inicio,
                                        flag_terminado,
                                        tipo_documento)
                    VALUES( iregLoteFacturaEle.codigo_lote,
                            iregLoteFacturaEle.periodo_facturacion,
                            iregLoteFacturaEle.anio,
                            iregLoteFacturaEle.mes,
                            iregLoteFacturaEle.ciclo,
                            iregLoteFacturaEle.cantidad_hilos,
                            iregLoteFacturaEle.fecha_inicio,
                            iregLoteFacturaEle.flag_terminado,
                            iregLoteFacturaEle.tipo_documento);
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       raise pkg_error.CONTROLLED_ERROR;
  END prInsLoteFactElectronica;
  PROCEDURE prActLoteFactElectronica( inuCodLote  IN  lote_fact_electronica.codigo_lote%type,
                                       isbEstado   IN  lote_fact_electronica.flag_terminado%type) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizarFactElecGen
    Descripcion     : proceso que actualiza estado y texto enviado en la tabla factura electronica general

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 08-05-2024

    Parametros de Entrada
      inuCodLote            codigo de lote
      isbEstado             estado del flg terminado
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       08-05-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prActLoteFactElectronica';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuCodLote => ' || inuCodLote, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('isbEstado => ' || isbEstado, pkg_traza.cnuNivelTrzDef);
    UPDATE lote_fact_electronica SET    flag_terminado = isbEstado
    WHERE codigo_lote = inuCodLote;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       raise pkg_error.CONTROLLED_ERROR;
  END prActLoteFactElectronica;

   PROCEDURE prActLoteFactElectronica( inuCodLote          IN  lote_fact_electronica.codigo_lote%type,
                                       idtFechaIniProc     IN  lote_fact_electronica.fecha_inicio_proc%type,
                                       idtFechaFinProc     IN  lote_fact_electronica.fecha_inicio_proc%type) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizarFactElecGen
    Descripcion     : proceso que actualiza estado y texto enviado en la tabla factura electronica general

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 08-05-2024

    Parametros de Entrada
      inuCodLote            codigo de lote
      idtFechaIniProc       fecha de inicio de proceso
      idtFechaFinProc       fecha fin de proceso 
    Parametros de Salida 

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       04-06-2024   OSF-2158    Creacion
  ***************************************************************************/
      csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prActLoteFactElectronica';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuCodLote => ' || inuCodLote, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('idtFechaIniProc => ' || idtFechaIniProc, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('idtFechaFinProc => ' || idtFechaFinProc, pkg_traza.cnuNivelTrzDef);
    UPDATE lote_fact_electronica SET   fecha_inicio_proc =idtFechaIniProc,
                                       fecha_fin_proc = idtFechaFinProc
    WHERE codigo_lote = inuCodLote;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       raise pkg_error.CONTROLLED_ERROR;
  END prActLoteFactElectronica;
  FUNCTION frcgetRecord	( inuPerioFact      IN   lote_fact_electronica.periodo_facturacion%type DEFAULT -1,
                          isbFlagTerminado  IN   lote_fact_electronica.flag_terminado%type )  RETURN styLoteFactElectronica IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcgetRecord
    Descripcion     : proceso que retorna informacion  de lote de facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 08-05-2024

    Parametros de Entrada
      inuPerioFact          codigo del periodo de facturacion (-1 para todos)
      isbFlagTerminado      estado del proceso
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        08-05-2024  OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.frcgetRecord';
    regLoteFacturaEle   styLoteFactElectronica;

    CURSOR cuGetregistro IS
    SELECT *
    FROM lote_fact_electronica
    WHERE lote_fact_electronica.periodo_facturacion = DECODE(inuPerioFact, -1, lote_fact_electronica.periodo_facturacion, inuPerioFact)
     AND lote_fact_electronica.flag_terminado = isbFlagTerminado;

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    IF cuGetregistro%ISOPEN THEN CLOSE cuGetregistro; END IF;
    OPEN cuGetregistro;
    FETCH cuGetregistro INTO regLoteFacturaEle;
    CLOSE cuGetregistro;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN regLoteFacturaEle;
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       raise pkg_error.CONTROLLED_ERROR;
  END frcgetRecord;

   PROCEDURE prActLoteFactElectronica( inuCodLote       IN  lote_fact_electronica.codigo_lote%type,
                                      inuCantRegistro   IN  lote_fact_electronica.cantidad_registro%type,
                                      inuHiloProc       IN  lote_fact_electronica.hilos_procesado%type,
                                      inuHiloFall       IN  lote_fact_electronica.hilos_fallido%type,
                                      inuIntentos       IN  lote_fact_electronica.intentos%type,
                                      isbFlagTerminado  IN  lote_fact_electronica.flag_terminado%type,
                                      isbOperacion      IN  varchar2) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizarFactElecGen
    Descripcion     : proceso que actualiza estado y texto enviado en la tabla factura electronica general

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 08-05-2024

    Parametros de Entrada
      inuCodLote            codigo de lote
      inuCantRegistro       cantidad de registros procesados
      inuHiloProc           hilos procesados
      inuHiloFall           hilos fallidos
      inuIntentos           intentos
      isbFlagTerminado      flag de terminado
      isbOperacion          operacion I - Insertar A - Actualizar
    Parametros de Salida 

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       04-06-2024   OSF-2158    Creacion
  ***************************************************************************/
       csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prActLoteFactElectronica';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuCodLote => ' || inuCodLote, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuCantRegistro => ' || inuCantRegistro, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuHiloProc => ' || inuHiloProc, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuHiloFall => ' || inuHiloFall, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuIntentos => ' || inuIntentos, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('isbFlagTerminado => ' || isbFlagTerminado, pkg_traza.cnuNivelTrzDef); 

    UPDATE lote_fact_electronica SET cantidad_registro = case when isbOperacion = 'A' then
                                                                   inuCantRegistro
                                                              else
                                                                  nvl(cantidad_registro,0) + inuCantRegistro
                                                          end,
                                    hilos_procesado = inuHiloProc,
                                    hilos_fallido = inuHiloFall,
                                    fecha_fin = sysdate,
                                    intentos = NVL(intentos,0) + inuIntentos,
                                    flag_terminado = isbFlagTerminado
    WHERE codigo_lote = inuCodLote;


    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       raise pkg_error.CONTROLLED_ERROR;
  END prActLoteFactElectronica;
END pkg_lote_fact_electronica;


/

BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_LOTE_FACT_ELECTRONICA','PERSONALIZACIONES');
END;
/