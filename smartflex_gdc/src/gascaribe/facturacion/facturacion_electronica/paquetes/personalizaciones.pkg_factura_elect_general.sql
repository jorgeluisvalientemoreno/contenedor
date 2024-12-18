CREATE OR REPLACE PACKAGE personalizaciones.PKG_FACTURA_ELECT_GENERAL IS
   subtype styFacturaElectronicaGen  is  factura_elect_general%rowtype;
   PROCEDURE prInsertarFactElecGen( iregFacturaEle IN  styFacturaElectronicaGen,
                                    onuError       OUT NUMBER,
                                    osbError       OUT VARCHAR2);
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsertarFactElecGen
    Descripcion     : proceso que inserta en la tabla factura electronica general

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 17-01-2024

    Parametros de Entrada
      iregFacturaEle        registro de factura electronica
    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       17-01-2024   OSF-2158    Creacion
  ***************************************************************************/
   PROCEDURE prActualizarFactElecGen( inuCodigo_lote         IN factura_elect_general.codigo_lote%TYPE,
                                      inuTipoDocumento       IN factura_elect_general.tipo_documento%TYPE,
                                      inuConsfael            IN factura_elect_general.consfael%TYPE,
                                      inuEstado              IN factura_elect_general.estado%TYPE,
                                      isbRuta                IN factura_elect_general.ruta_reparto%TYPE,
                                      iclTextoEnviado        IN factura_elect_general.texto_enviado%TYPE,
                                      iclTextoContigencia   IN factura_elect_general.texto_contigencia%TYPE,
                                      iclTexto_spool         IN factura_elect_general.texto_spool%TYPE,                                      
                                      isbFacturaElectronica  IN factura_elect_general.factura_electronica%TYPE,
                                      isbEmitirFactura      IN factura_elect_general.emitir_factura%TYPE,
                                      inuOrdenFuncion       IN  factura_elect_general.orden_funcion%TYPE,
                                      onuError               OUT NUMBER,
                                      osbError               OUT VARCHAR2);
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizarFactElecGen
    Descripcion     : proceso que actualiza estado y texto enviado en la tabla factura electronica general

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 17-01-2024

    Parametros de Entrada
      inuCodigo_lote        codigo de lote
      inuTipoDocumento      tipo de documento
      inuConsfael           consecutivo facturacion electronica
      inuEstado             estado del registro
      isbRuta               ruta reparto
      iclTextoEnviado       texto enviado
      iclTextoContigencia   texto contigencia
      iclTexto_spool        texto spool
      isbFacturaElectronica  factura electronica
      isbEmitirFactura       emitir factura
      inuOrdenFuncion        orden funcion
    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       17-01-2024   OSF-2158    Creacion
  ***************************************************************************/
   PROCEDURE prActualizarFactElecGen( inuCodigo_lote         IN factura_elect_general.codigo_lote%TYPE,
                                      inuTipoDocumento      IN factura_elect_general.tipo_documento%TYPE,
                                      inuDocumento          IN factura_elect_general.documento%TYPE,  
                                      inuEstado              IN factura_elect_general.estado%TYPE);
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizarFactElecGen
    Descripcion     : proceso que actualiza estado y texto enviado en la tabla factura electronica general

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 17-01-2024

    Parametros de Entrada
      inuCodigo_lote        codigo de lote
      inuTipoDocumento      tipo de documento
      inuDocumento          documento 
      inuEstado             estado del registro
   Parametros de Salida

   Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       17-01-2024   OSF-2158    Creacion
  ***************************************************************************/
  FUNCTION frcgetRecord	( inuCodigo_lote    IN factura_elect_general.codigo_lote%TYPE,
                          inuTipoDocumento  IN factura_elect_general.tipo_documento%TYPE,
                          inuConsfael       IN factura_elect_general.consfael%TYPE,
                          onuError          OUT NUMBER,
                          osbError          OUT VARCHAR2)  RETURN styFacturaElectronicaGen;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizarFactElecGen
    Descripcion     : proceso que actualiza estado y texto enviado en la tabla factura electronica general

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 17-01-2024

    Parametros de Entrada
      inuCodigo_lote        codigo de lote
      inuTipoDocumento      tipo de documento
      inuConsfael           consecutivo facturacion electronica
    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       17-01-2024   OSF-2158    Creacion
  ***************************************************************************/
END PKG_FACTURA_ELECT_GENERAL;

/


CREATE OR REPLACE PACKAGE BODY personalizaciones.PKG_FACTURA_ELECT_GENERAL IS
    -- Constantes para el control de la traza
   csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
   -- Identificador del ultimo caso que hizo cambios
   csbVersion     CONSTANT VARCHAR2(15) := 'OSF-2158';

   nuError NUMBER;
   sbError VARCHAR2(4000);

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

   PROCEDURE prInsertarFactElecGen( iregFacturaEle IN  styFacturaElectronicaGen,
                                    onuError       OUT NUMBER,
                                    osbError       OUT VARCHAR2) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsertarFactElecGen
    Descripcion     : proceso que inserta en la tabla factura electronica general

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 17-01-2024

    Parametros de Entrada
      iregFacturaEle        registro de factura electronica
    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       17-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prInsertarFactElecGen';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_error.prinicializaerror(onuError, osbError);
    INSERT INTO factura_elect_general ( codigo_lote,
                                        tipo_documento,
                                        consfael,
                                        contrato,
                                        documento,
                                        estado,
                                        fecha_registro,
                                        texto_enviado,
                                        texto_contigencia,
                                        texto_spool,
                                        factura_electronica,
                                        emitir_factura,
                                        ruta_reparto,
                                        orden_funcion)
      VALUES(iregFacturaEle.codigo_lote,
            iregFacturaEle.tipo_documento,
            iregFacturaEle.consfael,
            iregFacturaEle.contrato,
            iregFacturaEle.documento,
            iregFacturaEle.estado,
            iregFacturaEle.fecha_registro,
            iregFacturaEle.texto_enviado,
            iregFacturaEle.texto_contigencia,
            iregFacturaEle.texto_spool,
            iregFacturaEle.factura_electronica,
            iregFacturaEle.emitir_factura,
            iregFacturaEle.ruta_reparto,
            iregFacturaEle.orden_funcion);
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
  END prInsertarFactElecGen;
  PROCEDURE prActualizarFactElecGen( inuCodigo_lote         IN factura_elect_general.codigo_lote%TYPE,
                                      inuTipoDocumento      IN factura_elect_general.tipo_documento%TYPE,
                                      inuConsfael           IN factura_elect_general.consfael%TYPE,
                                      inuEstado             IN factura_elect_general.estado%TYPE,
                                      isbRuta               IN factura_elect_general.ruta_reparto%TYPE,
                                      iclTextoEnviado       IN factura_elect_general.texto_enviado%TYPE,
                                      iclTextoContigencia   IN factura_elect_general.texto_contigencia%TYPE,
                                      iclTexto_spool        IN factura_elect_general.texto_spool%TYPE,
                                      isbFacturaElectronica IN factura_elect_general.factura_electronica%TYPE,
                                      isbEmitirFactura      IN factura_elect_general.emitir_factura%TYPE,
                                      inuOrdenFuncion       IN  factura_elect_general.orden_funcion%TYPE,
                                      onuError              OUT NUMBER,
                                      osbError              OUT VARCHAR2) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizarFactElecGen
    Descripcion     : proceso que actualiza estado y texto enviado en la tabla factura electronica general

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 17-01-2024

    Parametros de Entrada
      inuCodigo_lote        codigo de lote
      inuTipoDocumento      tipo de documento
      inuConsfael           consecutivo facturacion electronica
      inuEstado             estado del registro
      isbRuta               ruta reparto
      iclTextoEnviado       texto enviado
      iclTextoContigencia   texto contigencia
      iclTexto_spool        texto spool
      isbFacturaElectronica  factura electronica
      isbEmitirFactura       emitir factura
      inuOrdenFuncion        orden funcion
    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       17-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prActualizarFactElecGen';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuCodigo_lote => ' || inuCodigo_lote, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuTipoDocumento => ' || inuTipoDocumento, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuConsfael => ' || inuConsfael, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuEstado => ' || inuEstado, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('isbFacturaElectronica => ' || isbFacturaElectronica, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('isbEmitirFactura => ' || isbEmitirFactura, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuOrdenFuncion => ' || inuOrdenFuncion, pkg_traza.cnuNivelTrzDef);
    pkg_error.prinicializaerror(onuError, osbError);
    UPDATE factura_elect_general SET estado = inuEstado,
                                    texto_enviado = iclTextoEnviado,
                                    texto_contigencia = iclTextoContigencia,
                                    ruta_reparto =isbRuta,
                                    texto_spool = iclTexto_spool,
                                    factura_electronica = isbFacturaElectronica,
                                    emitir_factura = isbEmitirFactura,
                                    orden_funcion = inuOrdenFuncion
    WHERE codigo_lote = inuCodigo_lote
      AND tipo_documento = inuTipoDocumento
      AND consfael = inuConsfael;

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
  END prActualizarFactElecGen;

   PROCEDURE prActualizarFactElecGen( inuCodigo_lote        IN factura_elect_general.codigo_lote%TYPE,
                                      inuTipoDocumento      IN factura_elect_general.tipo_documento%TYPE,
                                      inuDocumento          IN factura_elect_general.documento%TYPE,
                                      inuEstado             IN factura_elect_general.estado%TYPE   ) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizarFactElecGen
    Descripcion     : proceso que actualiza estado y texto enviado en la tabla factura electronica general

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 17-01-2024

    Parametros de Entrada
       inuCodigo_lote        codigo de lote
      inuTipoDocumento      tipo de documento
      inuDocumento          documento 
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       17-01-2024   OSF-2158    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prActualizarFactElecGen';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuCodigo_lote => ' || inuCodigo_lote, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuTipoDocumento => ' || inuTipoDocumento, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuDocumento => ' || inuDocumento, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuEstado => ' || inuEstado, pkg_traza.cnuNivelTrzDef);

    UPDATE factura_elect_general SET estado = inuEstado
    WHERE codigo_lote = inuCodigo_lote
      AND tipo_documento = inuTipoDocumento
      AND documento = inuDocumento;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RAISE pkg_error.CONTROLLED_ERROR;
  END prActualizarFactElecGen;
  FUNCTION frcgetRecord	( inuCodigo_lote    IN factura_elect_general.codigo_lote%TYPE,
                          inuTipoDocumento  IN factura_elect_general.tipo_documento%TYPE,
                          inuConsfael       IN factura_elect_general.consfael%TYPE,
                          onuError          OUT NUMBER,
                          osbError          OUT VARCHAR2)  RETURN styFacturaElectronicaGen IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizarFactElecGen
    Descripcion     : proceso que actualiza estado y texto enviado en la tabla factura electronica general

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 17-01-2024

    Parametros de Entrada
      inuCodigo_lote        codigo de lote
      inuTipoDocumento      tipo de documento
      inuConsfael           consecutivo facturacion electronica
    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       17-01-2024   OSF-2158    Creacion
  ***************************************************************************/
   v_styFacturaElectronicaGen styFacturaElectronicaGen;
   csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.frcgetRecord';

   CURSOR cugetInfoFactElec IS
   SELECT *
   FROM factura_elect_general
   WHERE Codigo_lote = inuCodigo_lote
     AND tipo_documento = inuTipoDocumento
     AND consfael  = inuConsfael;

   PROCEDURE prCloseCursor IS
      csbMT_NAME1      VARCHAR2(150) := csbSP_NAME || '.prCloseCursor';
   BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        IF cugetInfoFactElec%ISOPEN THEN
           CLOSE cugetInfoFactElec;
        END IF;
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prCloseCursor;

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuCodigo_lote => ' || inuCodigo_lote, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuTipoDocumento => ' || inuTipoDocumento, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuConsfael => ' || inuConsfael, pkg_traza.cnuNivelTrzDef);
    pkg_error.prinicializaerror(onuError, osbError);
    prCloseCursor;

    OPEN cugetInfoFactElec;
    FETCH cugetInfoFactElec INTO v_styFacturaElectronicaGen;
    CLOSE cugetInfoFactElec;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN v_styFacturaElectronicaGen;
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(onuError,osbError);
       prCloseCursor;
       pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(onuError,osbError);
       prCloseCursor;
       pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END frcgetRecord;
END PKG_FACTURA_ELECT_GENERAL;

/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_FACTURA_ELECT_GENERAL','PERSONALIZACIONES');
END;
/