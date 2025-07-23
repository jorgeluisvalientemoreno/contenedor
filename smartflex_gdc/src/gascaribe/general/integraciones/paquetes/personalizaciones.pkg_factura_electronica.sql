create or replace PACKAGE personalizaciones.pkg_factura_electronica IS
   
   subtype styFacturaElectronica  is  factura_electronica%rowtype;
   PROCEDURE prInsertarFactElec( iregFacturaEle IN  styFacturaElectronica,
                                 onuError       OUT NUMBER,
                                 osbError       OUT VARCHAR2);
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsertarFactElec
    Descripcion     : proceso que inserta en la tabla factura electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 21-12-2023

    Parametros de Entrada
      iregFacturaEle        registro de factura electronica
    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       21-12-2023   OSF-1916    Creacion
  ***************************************************************************/ 
   
   PROCEDURE prActualizaFactElec ( inuConsFael         IN  factura_electronica.consfael%type,
                                   inuContrato         IN  factura_electronica.contrato%type default null,
                                   idtFechaEnvio       IN  factura_electronica.fecha_envio%type default null,
                                   idtFechaRespuesta   IN  factura_electronica.fecha_respuesta%type default null,
                                   iclXmlFactelect     IN  factura_electronica.xml_factelect%type,
                                   iclXmlRespuesta     IN  factura_electronica.xml_respuesta%type default null,
                                   isbMensajeRespuesta IN  factura_electronica.mensaje_respuesta%type default null,
                                   inuIntento          IN  factura_electronica.numero_intento%type,
                                   inuEstado           IN  factura_electronica.estado%type,
                                   onuError            OUT NUMBER,
                                   osbError            OUT VARCHAR2);
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaFactElec
    Descripcion     : proceso para actualizar informacion de envio de factura electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 13-12-2023

    Parametros de Entrada
      inuConsFael        consecutivo de factura electronica
      inuContrato        codigo del contrato
      idtFechaEnvio      fecha de envio
      idtFechaRespuesta  fecha de respuesta
      iclXmlFactelect    xml de solicitud
      iclXmlRespuesta    xml de respuesta
      isbMensajeRespuesta mensaje de respuesta
      inuIntento          numero de intento
      inuEstado           estado
    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       13-12-2023   OSF-1916    Creacion
  ***************************************************************************/ 

  FUNCTION frcGetInfoFactElec ( inuConsFael   IN  factura_electronica.consfael%type default -1,
                                isbEstado     IN  VARCHAR2,
                                inuMaxIntento IN factura_electronica.numero_intento%type,
                                onuError      OUT NUMBER,
                                osbError      OUT VARCHAR2) RETURN constants_per.tyrefcursor;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcGetInfoFactElec
    Descripcion     : funcion que devuelve informacion de facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 13-12-2023

    Parametros de Entrada
      inuConsFael        consecutivo de factura electronica 
      isbEstado          estado de factura electronica  
      inuMaxIntento      numero de intento
    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       13-12-2023   OSF-1916    Creacion
  ***************************************************************************/

END pkg_factura_electronica;
/
create or replace PACKAGE BODY   personalizaciones.pkg_factura_electronica IS
       -- Constantes para el control de la traza
  csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion     CONSTANT VARCHAR2(15) := 'OSF-1916';

   FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 16-11-2023

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       16-11-2023   OSF-1916    Creacion
  ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;
  
  PROCEDURE prInsertarFactElec( iregFacturaEle IN  styFacturaElectronica,
                                 onuError       OUT NUMBER,
                                 osbError       OUT VARCHAR2) IS
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsertarFactElec
    Descripcion     : proceso que inserta en la tabla factura electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 21-12-2023

    Parametros de Entrada
      iregFacturaEle        registro de factura electronica
    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       21-12-2023   OSF-1916    Creacion
  ***************************************************************************/ 
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prInsertarFactElec';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
     INSERT INTO factura_electronica ( contrato, consfael, factura, estado, fecha_registro,XML_factelect, numero_intento)
            VALUES( iregFacturaEle.contrato, 
                    iregFacturaEle.consfael, 
                    iregFacturaEle.factura, 
                    iregFacturaEle.estado, 
                    iregFacturaEle.fecha_registro,
                    iregFacturaEle.XML_factelect, 
                    iregFacturaEle.numero_intento);
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
  END prInsertarFactElec;

   PROCEDURE prActualizaFactElec ( inuConsFael         IN  factura_electronica.consfael%type,
                                   inuContrato         IN  factura_electronica.contrato%type default null,
                                   idtFechaEnvio       IN  factura_electronica.fecha_envio%type default null,
                                   idtFechaRespuesta   IN  factura_electronica.fecha_respuesta%type default null,
                                   iclXmlFactelect     IN  factura_electronica.xml_factelect%type,
                                   iclXmlRespuesta     IN  factura_electronica.xml_respuesta%type default null,
                                   isbMensajeRespuesta IN  factura_electronica.mensaje_respuesta%type default null,
                                   inuIntento          IN  factura_electronica.numero_intento%type,
                                   inuEstado           IN  factura_electronica.estado%type,
                                   onuError            OUT NUMBER,
                                   osbError            OUT VARCHAR2) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaFactElec
    Descripcion     : proceso para actualizar informacion de envio de factura electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 13-12-2023

    Parametros de Entrada
      inuConsFael        consecutivo de factura electronica
      inuContrato        codigo del contrato
      idtFechaEnvio      fecha de envio
      idtFechaRespuesta  fecha de respuesta
      iclXmlFactelect    xml de solicitud
      iclXmlRespuesta    xml de respuesta
      isbMensajeRespuesta mensaje de respuesta
      inuIntento          numero de intento
      inuEstado           estado
    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       13-12-2023   OSF-1916    Creacion
  ***************************************************************************/ 
   csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prActualizaFactElec';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuConsFael => ' || inuConsFael, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuContrato => ' || inuContrato, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('idtFechaEnvio => ' || idtFechaEnvio, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('idtFechaRespuesta => ' || idtFechaRespuesta, pkg_traza.cnuNivelTrzDef);
    pkg_error.prInicializaError(onuError, osbError);
    
    IF inuContrato IS NOT NULL THEN
        UPDATE  factura_electronica SET factura_electronica.fecha_envio = idtFechaEnvio,
                                        factura_electronica.fecha_respuesta = idtFechaRespuesta,
                                        factura_electronica.xml_factelect = iclXmlFactelect,
                                        factura_electronica.xml_respuesta =iclXmlRespuesta,
                                        factura_electronica.mensaje_respuesta = isbMensajeRespuesta,
                                        factura_electronica.numero_intento =   inuIntento,
                                        factura_electronica.estado = inuEstado
        WHERE factura_electronica.consfael = inuConsFael 
            AND factura_electronica.contrato = inuContrato ;
    ELSE
        UPDATE  factura_electronica SET  factura_electronica.xml_factelect = iclXmlFactelect,
                                         factura_electronica.numero_intento =   inuIntento,
                                         factura_electronica.estado = inuEstado
        WHERE factura_electronica.consfael = inuConsFael ;
    END IF;

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

  END prActualizaFactElec;

  FUNCTION frcGetInfoFactElec ( inuConsFael   IN  factura_electronica.consfael%type default -1,
                                isbEstado     IN  VARCHAR2,
                                inuMaxIntento IN factura_electronica.numero_intento%type,
                                onuError      OUT NUMBER,
                                osbError      OUT VARCHAR2) RETURN constants_per.tyrefcursor IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcGetInfoFactElec
    Descripcion     : funcion que devuelve informacion de facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 13-12-2023

    Parametros de Entrada
      inuConsFael        consecutivo de factura electronica 
      isbEstado          estado de factura electronica  
      inuMaxIntento      numero de intento
    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       13-12-2023   OSF-1916    Creacion
  ***************************************************************************/
   rcFactElec      constants_per.tyrefcursor;
   csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prActualizaFactElec';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuConsFael => ' || inuConsFael, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('isbEstado => ' || isbEstado, pkg_traza.cnuNivelTrzDef);

    pkg_error.prInicializaError(onuError, osbError);

    OPEN rcFactElec FOR
    SELECT *
    FROM factura_electronica
    WHERE factura_electronica.consfael =  decode(inuConsFael, -1 ,factura_electronica.consfael, inuConsFael)
     AND (factura_electronica.estado in ( select regexp_substr(isbEstado,'[^,]+', 1, level) 
                                         from dual
                                        connect by regexp_substr(isbEstado, '[^,]+', 1, level) is not null)
        OR isbEstado = '-1' )
     AND factura_electronica.numero_intento <= inuMaxIntento;

    RETURN rcFactElec;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.geterror(onuError,osbError);
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RETURN rcFactElec;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(onuError,osbError);
       pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RETURN rcFactElec;
  END frcGetInfoFactElec;
END pkg_factura_electronica;
/
BEGIN
      pkg_utilidades.prAplicarPermisos('PKG_FACTURA_ELECTRONICA', 'PERSONALIZACIONES');
END;
/    