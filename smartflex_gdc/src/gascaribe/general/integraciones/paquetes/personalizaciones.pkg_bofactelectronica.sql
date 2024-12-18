create or replace PACKAGE  personalizaciones.pkg_bofactelectronica IS

    PROCEDURE prGeneraXMl( inuFactura  IN  NUMBER,
                         inuContrato IN  NUMBER,
                         idtFechaGen IN  DATE,
                         isbProceso  IN  VARCHAR2,
                         onuError    OUT NUMBER,
                         osbError    OUT VARCHAR2);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGeneraXMl
    Descripcion     : proceso que genera el xml

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-11-2023

    Parametros de Entrada
      inuFactura      codigo de la factura
      inuContrato     codigo del contrato
      idtFechaGen     fecha de generacion de factura
      isbProceso      proceso a realizar I - Insertar A - Actualizar
    Parametros de Salida
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       17-11-2023   OSF-1916    Creacion
  ***************************************************************************/
  PROCEDURE prJobProcesarFacElec;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prJobProcesarFacElec
    Descripcion     : jobs que se encarga de generar la facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 29-11-2023

    Parametros de Entrada

    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       29-11-2023   OSF-1916    Creacion
    GDGuevara  05-06-2024   OSF-2755    - Cursor cuGetPeriodProc: Se elimina la restriccion de validar 
                                          la existencia del periodo en la tabla periodo_factelect, 
                                          en su lugar se valida su existencia antes de adicionarlo.
                                          Se elimina la restriccion LDC_PECOFACT.pegpesta = 'T'
                                        - Cursor cuGetFacturas: Se adiciona una nueva restriccion 
                                          trunc(factura.factfege) = trunc(SYSDATE) para enviar a la 
                                          DIAN solo las facturas generadas en el dia del envio.
                                          Se valida que la factura tenga cupon asociado de tipo FA
                                        - Se reemplaza dbms_output.put_line por pkg_traza.trace
  ***************************************************************************/
END PKG_BOFACTELECTRONICA;
/
create or replace PACKAGE BODY  personalizaciones.pkg_bofactelectronica IS
    -- Constantes para el control de la traza
   csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
   -- Identificador del ultimo caso que hizo cambios
   csbVersion     CONSTANT VARCHAR2(15) := 'OSF-2755';

   nuErrorInt    NUMBER;
   sbErrorInt    VARCHAR2(4000);

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

  PROCEDURE prGeneraXmlAdqu( inuFactura      IN  NUMBER,
                             oxmlAdqu        OUT CLOB,
                             osbAplicaFel    OUT VARCHAR2,
                             onuError        OUT NUMBER,
                             osbError        OUT VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGeneraXMl
    Descripcion     : proceso que genera el xml de adquirentes

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-11-2023

    Parametros de Entrada
      inuFactura      codigo dela factura
    Parametros de Salida
      osbAplicaFel    se envia SI si el cliente tiene correo
      oxmlAdqu        xml de adquirentes
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       17-11-2023   OSF-1916    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGeneraXmlAdqu';
    V_tytAdquirente   pkg_bcfactelectronica.tytAdquirente;
    csbTagPrinIni     CONSTANT VARCHAR2(100) := '<listaAdquirentes>';
    csbTagPrinFin     CONSTANT VARCHAR2(100) := '</listaAdquirentes>';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);
    pkg_error.prinicializaerror(onuError, osbError);

    pkg_bcfactelectronica.prGetInfoAdquirente ( inuFactura ,
                                                V_tytAdquirente,
                                                onuError,
                                                osbError);
    IF onuError <> 0 THEN
       pkg_error.seterrormessage(isbMsgErrr => osbError);
    END IF;

    IF V_tytAdquirente.fechagene IS NOT NULL THEN

       osbAplicaFel := CASE WHEN V_tytAdquirente.email IS NOT NULL THEN 'SI' ELSE 'NO' END;

       oxmlAdqu := csbTagPrinIni||chr(10)
                   ||'<ciudad>'||V_tytAdquirente.ciudad||'</ciudad>'||chr(10)
                   ||'<departamento>'||V_tytAdquirente.departamento||'</departamento>'||chr(10)
                   ||'<descripcionCiudad>'||V_tytAdquirente.descCiudad||'</descripcionCiudad>'||chr(10)
                   ||'<digitoverificacion>'||V_tytAdquirente.digitoVeri||'</digitoverificacion>'||chr(10)
                   ||'<direccion>'||V_tytAdquirente.direccion||'</direccion>'||chr(10)
                   ||'<email>'||V_tytAdquirente.email||'</email>'||chr(10)
                   ||'<nombreCompleto>'||V_tytAdquirente.nombreCompleto||'</nombreCompleto>'||chr(10)
                   ||'<nombredepartamento>'||V_tytAdquirente.nombreDepa||'</nombredepartamento>'||chr(10)
                   ||'<numeroIdentificacion>'||V_tytAdquirente.identificacion||'</numeroIdentificacion>'||chr(10)
                   ||'<pais>'||V_tytAdquirente.pais||'</pais>'||chr(10)
                   ||'<paisnombre>'||V_tytAdquirente.paisNombre||'</paisnombre>'||chr(10)
                   ||'<tipoIdentificacion>'||V_tytAdquirente.tipoIdentifi||'</tipoIdentificacion>'||chr(10)
                   ||'<tipoPersona>'||V_tytAdquirente.tipoPersona||'</tipoPersona>'||chr(10)
                   ||csbTagPrinFin;
   ELSE
       pkg_error.seterrormessage(isbMsgErrr => 'No existe datos para la factura ['||inuFactura||']');
   END IF;

   pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(onuError, osbError);
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuError, osbError);
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END prGeneraXmlAdqu;


  PROCEDURE prGeneraXmlDetalle( inuFactura     IN  NUMBER,
                                oxmlDetalle    OUT CLOB,
                                onuCantCargos  OUT NUMBER,
                                onuError       OUT NUMBER,
                                osbError       OUT VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGeneraXmlDetalle
    Descripcion     : proceso que genera el xml de detalle de cargo

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-11-2023

    Parametros de Entrada
      inuFactura        codigo de la factura
    Parametros de Salida
      oxmlDetalle      xml de detalle de cargos
      onuCantCargos     cantidad de cargos
      onuError          codigo del error
      osbError          mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       17-11-2023   OSF-1916    Creacion
  ***************************************************************************/
    csbMT_NAME       VARCHAR2(100) := csbSP_NAME || '.prGeneraXmlDetalle';
    V_tbltytDetalle  pkg_bcfactelectronica.tbltytDetalle;
    csbTagPrinIni    CONSTANT VARCHAR2(100) := '<listaDetalle>';
    csbTagPrinFin    CONSTANT VARCHAR2(100) := '</listaDetalle>';

    sbIndex          VARCHAR2(40);
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);
    pkg_error.prinicializaerror(onuError, osbError);

    pkg_bcfactelectronica.prGetInfoDetalle ( inuFactura,
                                             V_tbltytDetalle,
                                             onuError,
                                             osbError);
    IF onuError <> 0 THEN
       pkg_error.seterrormessage(isbMsgErrr => osbError);
    END IF;
    onuCantCargos := V_tbltytDetalle.COUNT;

    IF onuCantCargos > 0 THEN
       sbIndex := V_tbltytDetalle.FIRST;
       LOOP
           oxmlDetalle := oxmlDetalle||csbTagPrinIni||chr(10)
                    ||'<cantidad>'||V_tbltytDetalle(sbIndex).cantidad||'</cantidad>'||chr(10)
                    ||'<codigoproducto>'||V_tbltytDetalle(sbIndex).codigoproducto||'</codigoproducto>'||chr(10)
                    ||'<descripcion>'||V_tbltytDetalle(sbIndex).descripcion||'</descripcion>'||chr(10)
                    ||'<muestracomercial>'||V_tbltytDetalle(sbIndex).muestracomercial||'</muestracomercial>'||chr(10)
                    ||'<muestracomercialcodigo>'||V_tbltytDetalle(sbIndex).muestracomercialcod||'</muestracomercialcodigo>'||chr(10)
                    ||'<nombreProducto>'||V_tbltytDetalle(sbIndex).nombreProducto||'</nombreProducto>'||chr(10)
                    ||'<posicion>'||V_tbltytDetalle(sbIndex).posicion||'</posicion>'||chr(10)
                    ||'<preciosinimpuestos>'||V_tbltytDetalle(sbIndex).preciosinimpuestos||'</preciosinimpuestos>'||chr(10)
                    ||'<preciototal>'||V_tbltytDetalle(sbIndex).preciototal	||'</preciototal>'||chr(10)
                    ||'<tamanio>'||V_tbltytDetalle(sbIndex).tamanio||'</tamanio>'||chr(10)
                    ||'<tipoImpuesto>'||V_tbltytDetalle(sbIndex).tipoImpuesto||'</tipoImpuesto>'||chr(10)
                    ||'<tipocodigoproducto>'||V_tbltytDetalle(sbIndex).tipocodigoproducto||'</tipocodigoproducto>'||chr(10)
                    ||'<unidadmedida>'||V_tbltytDetalle(sbIndex).unidadmedida||'</unidadmedida>'||chr(10)
                    ||'<valorUnitarioPorCantidad>'||V_tbltytDetalle(sbIndex).valorUnitPorCantidad||'</valorUnitarioPorCantidad>'||chr(10)
                    ||'<valorunitario>'||V_tbltytDetalle(sbIndex).valorunitario||'</valorunitario>'||chr(10)
                    ||csbTagPrinFin||chr(10);

         sbIndex := V_tbltytDetalle.NEXT(sbIndex);
         EXIT WHEN sbIndex IS NULL;
       END LOOP;
   ELSE
     oxmlDetalle := csbTagPrinFin;
   END IF;

   pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(onuError, osbError);
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuError, osbError);
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END prGeneraXmlDetalle;

  PROCEDURE prGeneraXmlPagos( inuFactura  IN  NUMBER,
                              inuFechaGen IN  DATE,
                              inuContrato IN  NUMBER,
                              oxmlPagos   OUT CLOB,
                              onuError    OUT NUMBER,
                              osbError    OUT VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGeneraXmlPagos
    Descripcion     : proceso que genera el xml de pagos

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-11-2023

    Parametros de Entrada
      inuFactura        codigo de la factura
      inuFechaGen       fecha de generacion de factura
      inuContrato       codigo del contrato
    Parametros de Salida
      odtFechVenc       fecha de vencimiento
      oxmlPagos         xml de detalle de cargos
      onuError          codigo del error
      osbError          mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       17-11-2023   OSF-1916    Creacion
  ***************************************************************************/
    csbMT_NAME       VARCHAR2(100) := csbSP_NAME || '.prGeneraXmlPagos';
    V_tytPagos       pkg_bcfactelectronica.tytPagos;
    csbTagPrinIni    CONSTANT VARCHAR2(100) := '<pago>';
    csbTagPrinFin    CONSTANT VARCHAR2(100) := '</pago>';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);
    pkg_error.prinicializaerror(onuError, osbError);

    pkg_bcfactelectronica.prGetInfoPagos ( inuFactura,
                                           inuFechaGen,
                                           inuContrato,
                                           V_tytPagos,
                                           onuError ,
                                           osbError );
    IF onuError <> 0 THEN
       pkg_error.seterrormessage(isbMsgErrr => osbError);
    END IF;
    oxmlPagos := csbTagPrinIni||chr(10)
                ||'<moneda>'||V_tytPagos.moneda||'</moneda>'||chr(10)
                ||'<tipocompra>'||V_tytPagos.tipocompra||'</tipocompra>'||chr(10)
                ||'<periododepagoa>'||V_tytPagos.periododepagoa||'</periododepagoa>'||chr(10)
                ||'<fechavencimiento>'||V_tytPagos.fechavencimiento||'</fechavencimiento>'||chr(10)
                ||'<totalbaseconimpuestos>'||V_tytPagos.totBaseConImpuestos||'</totalbaseconimpuestos>'||chr(10)
                ||'<totalbaseimponible>'||V_tytPagos.totalbaseimponible||'</totalbaseimponible>'||chr(10)
                ||'<totalfactura>'||V_tytPagos.totalfactura||'</totalfactura>'||chr(10)
                ||'<totalimportebruto>'||V_tytPagos.totalimportebruto||'</totalimportebruto>'||chr(10)
                ||csbTagPrinFin;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(onuError, osbError);
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuError, osbError);
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END prGeneraXmlPagos;


  PROCEDURE prGeneraXmlCodBarra( inuFactura     IN  NUMBER,                                 
                                 oxmlCodBarra   OUT CLOB,
                                 onuError       OUT NUMBER,
                                 osbError       OUT VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGeneraXmlCodBarra
    Descripcion     : proceso que genera el xml de lista de codigo de barra

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-11-2023

    Parametros de Entrada
      inuFactura        codigo de la factura
    Parametros de Salida
      oxmlCodBarra      xml de detalle de cargos
      onuError          codigo del error
      osbError          mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       17-11-2023   OSF-1916    Creacion
  ***************************************************************************/
    csbMT_NAME          VARCHAR2(100) := csbSP_NAME || '.prGeneraXmlCodBarra';
    V_tytCodigoBarra    pkg_bcfactelectronica.tytCodigoBarra;
    csbTagPrinIni       CONSTANT VARCHAR2(100) := '<listaCodigoBarras>';
    csbTagPrinFin       CONSTANT VARCHAR2(100) := '</listaCodigoBarras>';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);
    pkg_error.prinicializaerror(onuError, osbError);

    pkg_bcfactelectronica.prGetInfoCodigoBarra ( inuFactura,
                                                 V_tytCodigoBarra,
                                                 onuError ,
                                                 osbError );
    IF onuError <> 0 THEN
       pkg_error.seterrormessage(isbMsgErrr => osbError);
    END IF;
    oxmlCodBarra := csbTagPrinIni||chr(10)
                ||'<cadenaACodificar>'||V_tytCodigoBarra.cadenaACodificar||'</cadenaACodificar>'||chr(10)
                ||'<tipoModelo>'||V_tytCodigoBarra.tipoModelo||'</tipoModelo>'||chr(10)
                ||'<orden>'||V_tytCodigoBarra.orden||'</orden>'||chr(10)
                ||'<tipoCodificacion>'||V_tytCodigoBarra.tipoCodificacion||'</tipoCodificacion>'||chr(10)
                ||'<descripcion>'||V_tytCodigoBarra.descripcion||'</descripcion>'||chr(10)
                ||'<fecha>'||V_tytCodigoBarra.fecha||'</fecha>'||chr(10)
                ||csbTagPrinFin;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(onuError, osbError);
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuError, osbError);
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END prGeneraXmlCodBarra;

  PROCEDURE prGeneraXMl( inuFactura  IN  NUMBER,
                         inuContrato IN  NUMBER,
                         idtFechaGen IN  DATE,
                         isbProceso  IN  VARCHAR2,
                         onuError    OUT NUMBER,
                         osbError    OUT VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGeneraXMl
    Descripcion     : proceso que genera el xml

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-11-2023

    Parametros de Entrada
      inuFactura      codigo de la factura
      inuContrato     codigo del contrato
      idtFechaGen     fecha de generacion de factura
      isbProceso      proceso a realizar I - Insertar A - Actualizar
    Parametros de Salida
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       17-11-2023   OSF-1916    Creacion
    DSALTARIN  10-05-2024   OSF-2705    Se agrega el tag fechaexpedicion el cual envia 
                                        la misma fecha de generación
  ***************************************************************************/
    csbMT_NAME     VARCHAR2(100) := csbSP_NAME || '.prGeneraXMl';

    csbTagPrinIni    CONSTANT VARCHAR2(100) := '<felCabezaDocumento>';
    csbTagPrinFin    CONSTANT VARCHAR2(100) := '</felCabezaDocumento>';
    csbEncabezadoIni CONSTANT VARCHAR2(200) := '<?xml version="1.0" encoding="UTF-8"?>'||chr(10)
        ||'<ns1:enviarDocumento>';
    csbEncabezadoFin CONSTANT VARCHAR2(100) :='</ns1:enviarDocumento>';

    oxmlAdqu       CLOB;
    oxmlPagos      CLOB;
    oxmlCodBarra   CLOB;
    oxmlDetalle    CLOB;
    xmlPeticion    CLOB;
    sbAPlicaFel    VARCHAR2(2);
    odtFechaVenc   DATE;
    nuCantCargos   NUMBER;
    nuIdPlantilla  NUMBER := pkg_parametros.fnugetvalornumerico('PLANTILLA_FACTELECT');
    sbPassword     VARCHAR2(200) := pkg_parametros.fsbgetvalorcadena('PASSWORD_FACTELECT');
    sbUsuario      VARCHAR2(200) := pkg_parametros.fsbgetvalorcadena('USUARIO_FACTELECT');
    sbToken        VARCHAR2(200) := pkg_parametros.fsbgetvalorcadena('TOKEN_FACTELECT');
    nuConsNumeAut  NUMBER := pkg_parametros.fnugetvalornumerico('CONS_NUMEAUTO_FACTELECT');
    nuConsecuFact  NUMBER ;
    v_styFacturaElectronica     pkg_factura_electronica.styFacturaElectronica;
    CURSOR cuGetIdConsFact IS
    SELECT consnume
    FROM consecut
    WHERE conscodi = nuConsNumeAut;

    CURSOR cuGetNufiFact IS
    SELECT factura.factnufi
    FROM factura
    WHERE factcodi = inuFactura;

    PROCEDURE prInicializar IS
      csbMT_NAME1     VARCHAR2(100) := csbMT_NAME || '.prInicializar';
    BEGIN
       pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
       oxmlAdqu     := EMPTY_CLOB();
       oxmlPagos    := EMPTY_CLOB();
       oxmlDetalle  := EMPTY_CLOB();
       xmlPeticion  := EMPTY_CLOB();
       oxmlCodBarra := EMPTY_CLOB();
       sbAPlicaFel  := 'NO';
       v_styFacturaElectronica := null;
       nuCantCargos := 0;
       odtFechaVenc := NULL;
       nuConsecuFact := NULL;
       pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prInicializar;
    PROCEDURE prCloseCursor IS
      csbMT_NAME1     VARCHAR2(100) := csbMT_NAME || '.prCloseCursor';
    BEGIN
     pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
     IF cuGetIdConsFact%ISOPEN THEN
        CLOSE cuGetIdConsFact;
     END IF;

     IF cuGetNufiFact%ISOPEN THEN
        CLOSE cuGetNufiFact;
     END IF;
     pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
          pkg_Error.getError(nuErrorInt, sbErrorInt);
          pkg_traza.trace(' sbErrorInt => ' || sbErrorInt, pkg_traza.cnuNivelTrzDef);
          pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
          pkg_Error.setError;
          pkg_Error.getError(nuErrorInt, sbErrorInt);
          pkg_traza.trace(' sbErrorInt => ' || sbErrorInt, pkg_traza.cnuNivelTrzDef);
          pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END prCloseCursor;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);
    pkg_error.prinicializaerror(onuError, osbError);
    prInicializar;

    --se consulta informacion del adquiriente
    prGeneraXmlAdqu( inuFactura ,
                     oxmlAdqu,
                     sbAPlicaFel,
                     onuError,
                     osbError  );
    IF onuError <> 0 THEN
       RETURN;
    END IF;
    --se consulta informacion del detalle de la factura
    prGeneraXmlDetalle( inuFactura ,
                        oxmlDetalle,
                        nuCantCargos,
                        onuError,
                        osbError  );
    IF onuError <> 0 THEN
       RETURN;
    END IF;

    --se consulta informacion del detalle de la factura
    prGeneraXmlPagos( inuFactura ,
                      idtFechaGen,
                      inuContrato,
                      oxmlPagos,
                      onuError,
                      osbError  );
    IF onuError <> 0 THEN
       RETURN;
    END IF;


    prGeneraXmlCodBarra( inuFactura,                                 
                         oxmlCodBarra,
                         onuError,
                         osbError);

    IF onuError <> 0 THEN
       RETURN;
    END IF;

    IF isbProceso = 'I' THEN
        OPEN cuGetIdConsFact;
        FETCH cuGetIdConsFact INTO nuConsecuFact;
        IF cuGetIdConsFact%NOTFOUND THEN
           CLOSE cuGetIdConsFact;
           pkg_error.seterrormessage(isbMsgErrr => 'No existe consecutivo de numeracion autorizada');
        END IF;
        CLOSE cuGetIdConsFact;
    ELSE
      OPEN cuGetNufiFact;
      FETCH cuGetNufiFact INTO nuConsecuFact;
      CLOSE cuGetNufiFact;
    END IF;



    xmlPeticion := csbEncabezadoIni||chr(10)||
                   csbTagPrinIni||chr(10)||
                   '<aplicafel>'||sbAPlicaFel||'</aplicafel>'||chr(10)||
                   '<cantidadLineas>'||nuCantCargos||'</cantidadLineas>'||chr(10)||
                   '<codigoPlantillaPdf>'||nuIdPlantilla||'</codigoPlantillaPdf>'||chr(10)||
                   '<prefijo>'||pkg_bcfactelectronica.csbPrefijo||'</prefijo>'||chr(10)||
                   '<tipoOperacion>'||pkg_bcfactelectronica.csbTipoOperacion||'</tipoOperacion>'||chr(10)||
                   '<tipodocumento>'||pkg_bcfactelectronica.csbTipoDocumento||'</tipodocumento>'||chr(10)||
                   '<idEmpresa>'||pkg_bcfactelectronica.csbIdEmpresa||'</idEmpresa>'||chr(10)||
                   '<usuario>'||sbUsuario||'</usuario>'||chr(10)||
                   '<contrasenia>'||sbPassword||'</contrasenia>'||chr(10)||
                   '<token>'||sbToken||'</token>'||chr(10)||
                   '<codigovendedor/>'||chr(10)||
                   '<consecutivo>'||nuConsecuFact||'</consecutivo>'||chr(10)||
                   '<fechaexpedicion>'||to_char(idtFechaGen, 'yyyy-MM-dd')||'T'||to_char(idtFechaGen,'HH:mm:ss')||'</fechaexpedicion>'||chr(10)||
                   '<fechafacturacion>'||to_char(idtFechaGen, 'yyyy-MM-dd')||'T'||to_char(idtFechaGen,'HH:mm:ss')||'</fechafacturacion>'||chr(10)||
                    oxmlAdqu||chr(10)||
                    oxmlDetalle||
                    '<listaMediosPagos>'||chr(10)||
                    '<medioPago>'||pkg_bcfactelectronica.csbTipoPago||'</medioPago>'||chr(10)||
                    '</listaMediosPagos>'||chr(10)||
                    oxmlPagos||chr(10)||
                    oxmlCodBarra||chr(10)||
                    csbTagPrinFin||chr(10)||
                    csbEncabezadoFin;
    IF isbProceso = 'I' THEN
       pkg_factura.prActuNumeFiscal ( inuFactura,
                                      nuConsecuFact,
                                      nuConsNumeAut,
                                      'S',
                                      onuError,
                                      osbError);
       IF onuError <> 0 THEN
          RETURN;
       END IF;
       v_styFacturaElectronica.contrato       := inuContrato;
       v_styFacturaElectronica.consfael       := nuConsecuFact;
       v_styFacturaElectronica.factura        := inuFactura;
       v_styFacturaElectronica.estado         := 1;
       v_styFacturaElectronica.fecha_registro := sysdate;
       v_styFacturaElectronica.XML_factelect  := xmlPeticion;
       v_styFacturaElectronica.numero_intento := 0;
       
       pkg_factura_electronica.prInsertarFactElec(v_styFacturaElectronica, onuError, osbError);
       
       IF onuError <> 0 THEN
          RETURN;
       END IF;
      
    ELSE    
      pkg_factura_electronica.prActualizaFactElec ( inuConsFael     => nuConsecuFact,
                                                    iclXmlFactelect => xmlPeticion,
                                                    inuIntento      => 0,
                                                    inuEstado       => 1,
                                                    onuError        => onuError,
                                                    osbError        => osbError);   
        IF onuError <> 0 THEN
          RETURN;
        END IF;
    END IF;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(onuError, osbError);
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuError, osbError);
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END prGeneraXMl;
  PROCEDURE prJobProcesarFacElec IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prJobProcesarFacElec
    Descripcion     : jobs que se encarga de generar la facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 29-11-2023

    Parametros de Entrada

    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       29-11-2023   OSF-1916    Creacion
    GDGuevara  24/05/2024   OSF-2408    Se cambia la tabla LDC_PECOFACT por LDC_PECOFACT
    GDGuevara  05-06-2024   OSF-2755    - Cursor cuGetPeriodProc: Se elimina la restriccion de validar 
                                          la existencia del periodo en la tabla periodo_factelect, 
                                          en su lugar se valida su existencia antes de adicionarlo.
                                          Se elimina la restriccion LDC_PECOFACT.pegpesta = 'T'
                                        - Cursor cuGetFacturas: Se adiciona una nueva restriccion 
                                          trunc(factura.factfege) = trunc(SYSDATE) para enviar a la 
                                          DIAN solo las facturas generadas en el dia del envio.
                                          Se valida que la factura tenga cupon asociado de tipo FA
                                        - Se reemplaza dbms_output.put_line por pkg_traza.trace
  ***************************************************************************/
    csbMT_NAME       VARCHAR2(100) := csbSP_NAME || '.prJobProcesarFacElec';
    nuCiclo          NUMBER        := pkg_parametros.fnugetvalornumerico('CICLO_FACTELECT');
    nuEstadoActuPro  NUMBER        := pkg_parametros.fnugetvalornumerico('ESTADO_ACTU_FACTELECT');    
    sbproceso        VARCHAR2(100) := 'PRJOBPROCESARFACELEC'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
    dtFechaHoy       DATE          := trunc(SYSDATE);
    nuError          NUMBER;
    sbError          VARCHAR2(4000);

    CURSOR cuGetPeriodProc IS
        SELECT unique a.pefacodi
        FROM  perifact a, 
              ldc_pecofact b
        WHERE a.pefacicl = nuCiclo
          AND a.pefaactu = 'S'
          AND b.pcfapefa = a.pefacodi;

    CURSOR cuGetFacturas(inuPeriodo IN NUMBER) IS
        SELECT *
        FROM factura
        WHERE factpefa = inuPeriodo
          AND factprog = 6
          AND trunc(factfege) = dtFechaHoy
          AND NOT EXISTS (SELECT 1
                          FROM factura_electronica
                          WHERE factura = factcodi)
          AND EXISTS (SELECT 1 FROM cupon
                      WHERE cupodocu = to_char(factcodi)
                        AND cupotipo = 'FA');

    TYPE tblFacturas IS  TABLE OF cuGetFacturas%ROWTYPE;
    v_tblFacturas tblFacturas;

    CURSOR cuGetFacturaReprocesar IS
        SELECT factura_electronica.rowid idreg,
               factura_electronica.factura factura,
               factura_electronica.contrato factsusc,
               factura.factfege
        FROM factura_electronica
            JOIN factura ON factura.factcodi = factura_electronica.factura
        WHERE factura_electronica.estado = nuEstadoActuPro;

    TYPE tblFacturasRepr IS  TABLE OF cuGetFacturaReprocesar%ROWTYPE;
    v_tblFacturasRepr tblFacturasRepr;
    
    CURSOR cuPeriFactElec (inuPeriodo IN NUMBER) IS
        SELECT 1
        FROM periodo_factelect
        WHERE periodo = inuPeriodo;

    nuConsecutivo   NUMBER := 0;
    nuIdReporte     NUMBER;
    nuTotal         NUMBER := 0;
    nuRegiProc      NUMBER := 0;
    nuPeriodo       NUMBER;
    nufactura       NUMBER;
    nuExiste        NUMBER; 
    
    PROCEDURE prActualizaPeriodo( isbEstado      IN periodo_factelect.estado%type,
                                  isbObservacion IN periodo_factelect.observacion%type DEFAULT NULL) IS

    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prActualizaPeriodo
        Descripcion     : actualizar periodo

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 17-11-2023

        Parametros de Entrada
          isbEstado       estado actualizar el periodo de facturacion
          isbObservacion  observacion
        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       17-11-2023   OSF-1916    Creacion
  ***************************************************************************/
       csbMT_NAME1     VARCHAR2(100) := csbMT_NAME || '.prActualizaPeriodo';
       PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace(' isbEstado => ' || isbEstado, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(' isbObservacion => ' || isbObservacion, pkg_traza.cnuNivelTrzDef);
        UPDATE periodo_factelect SET ESTADO = 'T'
        WHERE PERIODO = nuPeriodo;
        COMMIT;
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
   EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuErrorInt, sbErrorInt);
      pkg_traza.trace(' sbErrorInt => ' || sbErrorInt, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      rollback;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorInt, sbErrorInt);
      pkg_traza.trace(' sbErrorInt => ' || sbErrorInt, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      rollback;
    END prActualizaPeriodo;

  BEGIN
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
     pkg_estaproc.prinsertaestaproc( sbproceso , 0);
     nuIdReporte := pkg_reportes_inco.fnuCrearCabeReporte ( 'JOBFACTELE',
                                                            'Job de facturacion electronica - energia solar');
     pkg_traza.trace(' nuIdReporte => ' || nuIdReporte, pkg_traza.cnuNivelTrzDef);

     FOR reg IN cuGetPeriodProc LOOP
        nuPeriodo := reg.pefacodi;
        
        -- Valida la existencia del periodo en la tabla periodo_factelect
        IF cuPeriFactElec%ISOPEN THEN
           CLOSE cuPeriFactElec;
        END IF;  
        nuExiste := 0;
        OPEN cuPeriFactElec(reg.pefacodi);
        FETCH cuPeriFactElec INTO nuExiste;
        CLOSE cuPeriFactElec;

        -- Si no existe el periodo lo crea
        IF (nvl(nuExiste,0) = 0) THEN
            INSERT INTO periodo_factelect
                       (PERIODO,ESTADO,FECHA_REGISTRO)
                 VALUES(reg.pefacodi, 'P', SYSDATE);
            COMMIT;
        END IF;
        
        IF cuGetFacturas%ISOPEN THEN
           CLOSE cuGetFacturas;
        END IF;

        --se realiza proceso de facturacion electronica
        OPEN cuGetFacturas(reg.pefacodi);
        LOOP
            FETCH cuGetFacturas BULK COLLECT INTO v_tblFacturas LIMIT 100;
            nuTotal := nuTotal  + v_tblFacturas.COUNT;
            pkg_traza.trace('nuTotal en cuGetFacturas: '||nuTotal, pkg_traza.cnuNivelTrzDef);
            nufactura:=  null;
            FOR idx IN 1..v_tblFacturas.COUNT LOOP
                nufactura  := v_tblFacturas(idx).factcodi;
                nuRegiProc := nuRegiProc + 1;
                nuError := 0;
                -- Inserta el XML en la tabla FACTURA_ELECTRONICA
                prGeneraXMl
                ( 
                    v_tblFacturas(idx).factcodi,
                    v_tblFacturas(idx).factsusc,
                    v_tblFacturas(idx).factfege,
                    'I',
                    nuError,
                    sbError
                );

                IF nuError <> 0 THEN
                    ROLLBACK;
                    pkg_traza.trace('sbError en cuGetFacturas: '||sbError, pkg_traza.cnuNivelTrzDef);
                    nuConsecutivo := nuConsecutivo + 1;
                    pkg_reportes_inco.prCrearDetalleRepo( nuIdReporte,
                                                          v_tblFacturas(idx).factcodi,
                                                          sbError,
                                                          'S',
                                                          nuConsecutivo );
                ELSE
                    COMMIT;
                END IF;

                pkg_estaproc.prActualizaAvance( sbproceso,
                                             'Procesando factura '||v_tblFacturas(idx).factcodi,
                                             nuRegiProc,
                                             nuTotal);
            END LOOP;
            EXIT   WHEN cuGetFacturas%NOTFOUND;
        END LOOP;
        CLOSE cuGetFacturas;

        prActualizaPeriodo('T');
     END LOOP;

     --facturas a reprocesar
     OPEN cuGetFacturaReprocesar;
     LOOP
        FETCH cuGetFacturaReprocesar BULK COLLECT INTO v_tblFacturasRepr LIMIT 100;
          nuTotal := nuTotal  + v_tblFacturasRepr.COUNT;
          nufactura := null;
          pkg_traza.trace('nuTotal en cuGetFacturaReprocesar: '||nuTotal, pkg_traza.cnuNivelTrzDef);
          FOR idx IN 1..v_tblFacturasRepr.COUNT LOOP
              nuRegiProc := nuRegiProc + 1;
              nufactura  := v_tblFacturasRepr(idx).factura;
              nuError := 0;

              prGeneraXMl( v_tblFacturasRepr(idx).factura,
                           v_tblFacturasRepr(idx).factsusc,
                           v_tblFacturasRepr(idx).factfege,
                           'A',
                           nuError,
                           sbError);

              IF nuError <> 0 THEN
                 ROLLBACK;
                 pkg_traza.trace('sbError en cuGetFacturaReprocesar: '||sbError, pkg_traza.cnuNivelTrzDef);
                 nuConsecutivo := nuConsecutivo + 1;
                 pkg_reportes_inco.prCrearDetalleRepo( nuIdReporte,
                                                       v_tblFacturasRepr(idx).factura,
                                                       sbError,
                                                       'S',
                                                       nuConsecutivo );
             ELSE
                COMMIT;
             END IF;

             pkg_estaproc.prActualizaAvance( sbproceso,
                                             'Procesando factura '||v_tblFacturasRepr(idx).factura,
                                             nuRegiProc,
                                             nuTotal);
          END LOOP;
          EXIT   WHEN cuGetFacturaReprocesar%NOTFOUND;
      END LOOP;
      CLOSE cuGetFacturaReprocesar;

     pkg_estaproc.practualizaestaproc(isbproceso => sbproceso);
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      prActualizaPeriodo('E', sbError);
      nuConsecutivo := nuConsecutivo + 1;
      pkg_reportes_inco.prCrearDetalleRepo( nuIdReporte,
                                           nuFactura,
                                           sbError,
                                           'S',
                                           nuConsecutivo );
      pkg_estaproc.practualizaestaproc( sbproceso, 'Error controlado', sberror  );
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      prActualizaPeriodo('E', sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      nuConsecutivo := nuConsecutivo + 1;
      pkg_reportes_inco.prCrearDetalleRepo( nuIdReporte,
                                           nuFactura,
                                           sbError,
                                           'S',
                                           nuConsecutivo );
      pkg_estaproc.practualizaestaproc( sbproceso, 'Error others ', sberror  );
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END prJobProcesarFacElec;
END PKG_BOFACTELECTRONICA;
/
BEGIN
      pkg_utilidades.prAplicarPermisos('PKG_BOFACTELECTRONICA', 'PERSONALIZACIONES');
END;
/    