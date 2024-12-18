create or replace PACKAGE PERSONALIZACIONES.PKG_BCFACTELECTRONICA IS
  /*
    Propiedad Intelectual de Gases del Caribe
    Programa        : pkg_bcfactelectronica
    Descripcion     : Contiene los procedimientos para la Facturacion Electronica

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    GDGuevara   24-04-2024  OSF-2620   Se modifica "TYPE tytAdquirente", cambiando de number a varchar a:
                                       ciudad       VARCHAR2(6)
                                       departamento VARCHAR2(3)
    dsaltarin   02-05-2024  OSF-2660   Se elimina la adición de 120 meses a la fecha de vencimiento de la cuenta de cobro.
    dsaltarin   10-05-2024  OSF-2705   Se modifica la forma de obtener el digito de verificación, el cual sera el ultimo dígito del nit.
*/
  --constates
  csbSI                    CONSTANT VARCHAR2(2)  := 'SI';
  csbIdEmpresa             CONSTANT NUMBER       := pkg_parametros.fnugetvalornumerico('COD_EMPRESA_FACTELECT');
  csbMuestraComercial      CONSTANT VARCHAR2(4)  := '0';
  csbMuestraComerCodigo    CONSTANT VARCHAR2(4)  := '0';
  csbPosicion              CONSTANT VARCHAR2(4)  := '0';
  csbTamanio               CONSTANT VARCHAR2(4)  := '0';
  cnuValorUnitPorCant      CONSTANT NUMBER       :=  0;
  csbTipoImpuesto          CONSTANT VARCHAR2(4)  := '3';
  csbTipoCodigoProducto    CONSTANT VARCHAR2(4)  := '999';
  csbUnidadmedidaOtro      CONSTANT VARCHAR2(4)  := '94';
  csbUnidadmedidaCons      CONSTANT VARCHAR2(4)  := 'KWH';
  csbCodigoMonedaCambio    CONSTANT VARCHAR2(4)  := 'COP';
  csbTipoCompra            CONSTANT VARCHAR2(4)  := '2';
  csbPrefijo               CONSTANT VARCHAR2(10) := pkg_parametros.fsbgetvalorcadena('PREFIJO_FACTELECT');
  csbTipoOperacion         CONSTANT VARCHAR2(4)  := '10';
  csbTipoDocumento         CONSTANT VARCHAR2(4)  := '1';
  csbCodPais               CONSTANT VARCHAR2(3)  := 'CO';
  csbNombrePais            CONSTANT VARCHAR2(15) := 'Colombia';
  csbTipoPago              CONSTANT VARCHAR2(15) := 'ZZZ';
  cnuTipoIdNit             CONSTANT NUMBER       := 110;
  cnuCodConcConsumo        CONSTANT NUMBER       := 983;

  csbtipoModelo            CONSTANT VARCHAR2(15) := 'recaudo';
  cnuOrden                 CONSTANT NUMBER       := 1;
  csbTipoCodificacion      CONSTANT VARCHAR2(15) := 'UCC-128';

  --registro de abquirentes
  TYPE tytAdquirente IS RECORD ( fechagene       DATE,
                                 ciudad          VARCHAR2(6),
                                 departamento    VARCHAR2(3),
                                 descCiudad      VARCHAR2(200),
                                 digitoVeri      VARCHAR2(2),
                                 direccion       VARCHAR2(200),
                                 email           VARCHAR2(100),
                                 nombreCompleto  VARCHAR2(300),
                                 nombreDepa      VARCHAR2(200),
                                 identificacion  VARCHAR2(30),
                                 pais            VARCHAR2(3),
                                 paisNombre      VARCHAR2(30),
                                 tipoIdentifi    VARCHAR2(4),
                                 tipoPersona     VARCHAR2(4),
                                 tipoObligacion  VARCHAR2(20)
                                );

  --registro de Campos Adicionales
  TYPE tytCamposAdicionales IS RECORD ( nombreCampo   VARCHAR2(20),
                                        orden         VARCHAR2(4),
                                        seccion       VARCHAR2(10),
                                        valorCampo    VARCHAR2(50));


  --registro de impuestos
  TYPE tytImpuesto IS RECORD ( baseimponible          VARCHAR2(100),
                               codImpuestoRetencion   VARCHAR2(10),
                               porcentaje             VARCHAR2(10),
                               valorImpuestoRetencion VARCHAR2(100)   );
  --registro de Campos Adicionales
  TYPE tytDetalle IS RECORD (   cantidad             VARCHAR2(20),
                                codigoproducto       VARCHAR2(20),
                                descripcion          VARCHAR2(200),
                                listaImpuestos       tytImpuesto,
                                muestraComercial     VARCHAR2(2),
                                muestracomercialcod  VARCHAR2(2),
                                nombreProducto       VARCHAR2(200),
                                posicion             VARCHAR2(2),
                                preciosinimpuestos   VARCHAR2(100),
                                preciototal          VARCHAR2(100),
                                tamanio              VARCHAR2(2),
                                tipoImpuesto         VARCHAR2(2),
                                tipocodigoproducto   VARCHAR2(10),
                                unidadmedida         VARCHAR2(4),
                                valorUnitPorCantidad VARCHAR2(100),
                                valorunitario        VARCHAR2(100));

  TYPE tbltytDetalle IS TABLE OF tytDetalle INDEX BY VARCHAR2(40);
  --registro de Campos Adicionales
  TYPE tytPagos IS RECORD ( periododepagoa       NUMBER,
                            fechavencimiento     VARCHAR2(30),
                            moneda               VARCHAR2(4),
                            tipocompra           VARCHAR2(8),
                            totBaseConImpuestos  VARCHAR2(100),
                            totalBaseImponible   VARCHAR2(100),
                            totalFactura         VARCHAR2(100),
                            totalImporteBruto    VARCHAR2(100));
   --registro de Campos Adicionales
  TYPE tytCodigoBarra IS RECORD ( cadenaACodificar   VARCHAR2(200),
                                  tipoModelo         VARCHAR2(30),
                                  orden              VARCHAR2(4),
                                  tipoCodificacion   VARCHAR2(10),
                                  descripcion        VARCHAR2(100),
                                  fecha              VARCHAR2(50) );


  PROCEDURE prGetInfoAdquirente ( inuFactura     IN  NUMBER,
                                  otytAdquirente OUT tytAdquirente,
                                  onuError       OUT NUMBER,
                                  osbError       OUT VARCHAR2);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoAdquirente
    Descripcion     : retorna informacion del adquirente

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 17-11-2023

    Parametros de Entrada
      inuFactura      codigo dela factura
    Parametros de Salida
      otytAdquirente  registro de informacion del adquirente
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       17-11-2023   OSF-1916    Creacion
  ***************************************************************************/
  PROCEDURE prGetInfoDetalle ( inuFactura     IN  NUMBER,
                               otbltytDetalle OUT tbltytDetalle,
                               onuError       OUT NUMBER,
                               osbError       OUT VARCHAR2);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoDetalle
    Descripcion     : retorna informacion de detalle la factura

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 17-11-2023

    Parametros de Entrada
      inuFactura       codigo de la factura
    Parametros de Salida
      otbltytDetalle  tabla con registro de detalle de cuenta de cobro
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    GDGuevara   04-03-2024  OSF-2284   Se adiciona una tabla para almacenar la unidad de medida del concepto y
                                       consultar primero si el concepto existe en la tabla conc_unid_medida_dian    
    LJLB        17-11-2023  OSF-1916   Creacion
  ***************************************************************************/

   PROCEDURE prGetInfoPagos ( inuFactura  IN  NUMBER,
                             idtFechaGen IN  DATE,
                             inuContrato IN  NUMBER,
                             otytPagos   OUT tytPagos,
                             onuError    OUT NUMBER,
                             osbError    OUT VARCHAR2);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoPagos
    Descripcion     : retorna informacion de  pago de factura

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 17-11-2023

    Parametros de Entrada
      inuFactura      codigo de la factura
      idtFechaGen     fecha de generacion de la factura
      inuContrato     codigo del contrato
    Parametros de Salida
      otytPagos      registro de informacion de pago
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        17-11-2023   OSF-1916    Creacion
  ***************************************************************************/


   PROCEDURE prGetInfoCodigoBarra ( inuFactura      IN  NUMBER,
                                    otytCodigoBarra OUT tytCodigoBarra,
                                    onuError        OUT NUMBER,
                                    osbError        OUT VARCHAR2);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCodigoBarra
    Descripcion     : retorna informacion de codigo de barra
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 20-12-2023

    Parametros de Entrada
      inuFactura       codigo de la factura
    Parametros de Salida
      otytCodigoBarra   registro de informacion de codigo de barra
      onuError          codigo del error
      osbError          mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        20-12-2023   OSF-1916    Creacion
  ***************************************************************************/

  FUNCTION frcGetFactReenviar( inuContrato    IN FACTURA_ELECTRONICA.CONTRATO%TYPE,
                               inuFactura     IN FACTURA_ELECTRONICA.CONSFAEL%TYPE,
                               idtFechaIni    IN FACTURA_ELECTRONICA.FECHA_REGISTRO%TYPE,
                               idtFechaFin    IN FACTURA_ELECTRONICA.FECHA_REGISTRO%TYPE,
                               inuEstado      IN FACTURA_ELECTRONICA.ESTADO%TYPE) RETURN constants_per.tyrefcursor;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcGetFactReenviar
    Descripcion     : proceso que retorna informacion para PB RFEL

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 15-11-2023

    Parametros de Entrada
      inuContrato    contrato
      inuFactura     consecutivo de factura electronica
      idtFechaIni    fecha inicial
      idtFechaFin    fecha final
      inuEstado      estado
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       16-11-2023   OSF-1916    Creacion
  ***************************************************************************/

  PROCEDURE prProcesarReenvio( inuConsFael IN FACTURA_ELECTRONICA.CONSFAEL%TYPE,
                               onuError    OUT NUMBER,
                               osbError    OUT VARCHAR2);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prProcesarReenvio
    Descripcion     : proceso que actualiza informacion del PB RFEL

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 15-11-2023

    Parametros de Entrada
      inuConsFael    consecutivo de factura electronica

    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       16-11-2023   OSF-1916    Creacion
  ***************************************************************************/
END pkg_bcfactelectronica;
/
create or replace PACKAGE BODY  personalizaciones.pkg_bcfactelectronica IS
     -- Constantes para el control de la traza
  csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion     CONSTANT VARCHAR2(15) := 'OSF-2620';

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

  FUNCTION fsbGetDigitoVerifi( isbIdentificacion IN VARCHAR2,
                               osbIdentSinDigito OUT VARCHAR2 ) RETURN VARCHAR2 IS
  /**************************************************************************
   Propiedad Intelectual de GDC

    Funcion     :  fsbGetDigitoVerifi
    Descripcion :  devuelve digito de verificacion
    Autor       :  Luis Javier Lopez Barrios
    Fecha       :  21-11-2023

    Entrada
      isbIdentificacion identificacion
    Salida
      osbIdentSinDigito identificacion sin digito
    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    21-11-2023           LJLB               Creacion
    10-05-2027           DSALTARIN          OSF-2705: Modificar la forma de obtener el dígito de verificacion,
                                            antes se separaba por guión medio(-).
  **************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fsbGetDigitoVerifi';
    sbDigitoVeri    VARCHAR2(2);

    nuError  NUMBER;
    sbError  VARCHAR2(4000);
    sbIdPar  VARCHAR2(30);

    CURSOR cuGetDigitoVeri IS
    SELECT SUBSTR(isbIdentificacion, INSTR(isbIdentificacion, '-') + 1, 1) digito_verif,
           SUBSTR(isbIdentificacion, 1, INSTR(isbIdentificacion, '-') - 1) NitSinDigi
    FROM DUAL
    WHERE INSTR(isbIdentificacion, '-') > 0;

  BEGIN

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('isbIdentificacion => ' || isbIdentificacion, pkg_traza.cnuNivelTrzDef);
    
    sbIdPar := replace(isbIdentificacion,'-','');
    pkg_traza.trace('sbIdPar => ' || sbIdPar, pkg_traza.cnuNivelTrzDef);
    sbDigitoVeri := substr(sbIdPar,10,10);
    pkg_traza.trace('sbDigitoVeri => ' || sbDigitoVeri, pkg_traza.cnuNivelTrzDef);
    osbIdentSinDigito := substr(sbIdPar,1,9);
    pkg_traza.trace('osbIdentSinDigito => ' || osbIdentSinDigito, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    return nvl(sbDigitoVeri,'0');

  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.geterror(nuError,sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RETURN '';
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RETURN '';
  END fsbGetDigitoVerifi;

   PROCEDURE prGetInfoAdquirente ( inuFactura     IN  NUMBER,
                                   otytAdquirente OUT tytAdquirente,
                                   onuError       OUT NUMBER,
                                   osbError       OUT VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoAdquirente
    Descripcion     : retorna informacion del adquirente

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 17-11-2023

    Parametros de Entrada
      inuFactura      codigo dela factura
    Parametros de Salida
      otytAdquirente  registro de informacion del adquirente
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       17-11-2023   OSF-1916    Creacion
  ***************************************************************************/
   csbMT_NAME           VARCHAR2(100) := csbSP_NAME || '.prGetInfoAdquirente';
   v_tytAdquirenteNull  tytAdquirente;
   sbDigitoVeri         VARCHAR2(2) := '0';
   nuTipoPersona        NUMBER;

   CURSOR cuGetInfoCliente IS
   SELECT factura.factfege,
          ab_address.address_parsed,
          ab_address.geograp_location_id,
          ge_subscriber.subscriber_id,
          ge_subscriber.ident_type_id,
          ge_subscriber.identification,
          ge_subscriber.subscriber_name||' '||ge_subscriber.subs_last_name nombre,
          ge_subscriber.e_mail
    FROM factura
     JOIN suscripc ON suscripc.susccodi = factura.factsusc
     JOIN ge_subscriber ON ge_subscriber.subscriber_id = suscripc.suscclie
     JOIN ab_address ON ab_address.address_id = suscripc.susciddi
    WHERE factura.factcodi = inuFactura;

    CURSOR cugetInfoCiudad(inuLocalidad NUMBER) IS
    SELECT ldc_equiva_localidad.departamento||ldc_equiva_localidad.municipio ciudad,
      ldc_equiva_localidad.departamento,
      l.description descciudad,
      d.description descdepartamento
    FROM ldc_equiva_localidad
      JOIN ge_geogra_location l ON l.geograp_location_id = ldc_equiva_localidad.geograp_location_id
      JOIN ge_geogra_location d ON d.geograp_location_id = l.geo_loca_father_id
    WHERE l.geograp_location_id = inuLocalidad;

    CURSOR cugetEquiTipoIden(inuTipoIden NUMBER) IS
    SELECT equi_tipo_identfael.tipo_idendian
    FROM equi_tipo_identfael
    WHERE equi_tipo_identfael.tipo_idenosf = inuTipoIden;


    regInfoCliente       cuGetInfoCliente%ROWTYPE;
    regInfoClienteNull   cuGetInfoCliente%ROWTYPE;
    regInfoCiudad        cugetInfoCiudad%ROWTYPE;
    regInfoCiudadNull    cugetInfoCiudad%ROWTYPE;
    nuTipoIdent          equi_tipo_identfael.tipo_idendian%TYPE;
    sbIdentSinDigito     varchar2(40);

    PROCEDURE prCloseCursor IS
     csbMT_NAME1      VARCHAR2(150) := csbSP_NAME || '.prCloseCursor';
    BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        IF cuGetInfoCliente%ISOPEN THEN
           CLOSE cuGetInfoCliente;
        END IF;

        IF cugetInfoCiudad%ISOPEN THEN
           CLOSE cugetInfoCiudad;
        END IF;

        IF cugetEquiTipoIden%ISOPEN THEN
           CLOSE cugetEquiTipoIden;
        END IF;

        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prCloseCursor;

    PROCEDURE prInicializarValores IS
     csbMT_NAME1      VARCHAR2(150) := csbSP_NAME || '.prInicializarValores';
    BEGIN
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      regInfoCliente := regInfoClienteNull;
      otytAdquirente := v_tytAdquirenteNull;
      regInfoCiudad  := regInfoCiudadNull;
      nuTipoPersona  := 1;
      nuTipoIdent    := NULL;
      sbIdentSinDigito := NULL;

      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prInicializarValores;

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);

    pkg_error.prinicializaerror(onuError, osbError);
    prCloseCursor;
    prInicializarValores;

    OPEN cuGetInfoCliente;
    FETCH cuGetInfoCliente INTO regInfoCliente;
    CLOSE cuGetInfoCliente;

    OPEN cugetInfoCiudad(regInfoCliente.geograp_location_id);
    FETCH cugetInfoCiudad INTO regInfoCiudad;
    CLOSE cugetInfoCiudad;

    OPEN cugetEquiTipoIden(regInfoCliente.ident_type_id);
    FETCH cugetEquiTipoIden INTO nuTipoIdent;
    CLOSE cugetEquiTipoIden;

    IF nuTipoIdent IS NULL THEN
       onuError := 1;
       osbError := 'Tipo de identificacion ['||regInfoCliente.ident_type_id||'] no esta homologado.';
    END IF;
    sbIdentSinDigito := regInfoCliente.identification;
    IF regInfoCliente.ident_type_id = cnuTipoIdNit THEN
       sbDigitoVeri  := fsbGetDigitoVerifi(regInfoCliente.identification, sbIdentSinDigito);
       nuTipoPersona := 2;
    END IF;

    otytAdquirente.fechagene       := regInfoCliente.factfege;
    otytAdquirente.ciudad          := regInfoCiudad.ciudad;
    otytAdquirente.departamento    := regInfoCiudad.departamento;
    otytAdquirente.descCiudad      := regInfoCiudad.descciudad;
    otytAdquirente.digitoVeri      := sbDigitoVeri;
    otytAdquirente.direccion       := regInfoCliente.address_parsed;
    otytAdquirente.email           := regInfoCliente.e_mail;
    otytAdquirente.nombreCompleto  := regInfoCliente.nombre;
    otytAdquirente.nombreDepa      := regInfoCiudad.descdepartamento;
    otytAdquirente.identificacion  := sbIdentSinDigito;
    otytAdquirente.pais            := csbCodPais;
    otytAdquirente.paisNombre      := csbNombrePais;
    otytAdquirente.tipoIdentifi    := nuTipoIdent;
    otytAdquirente.tipoPersona     := nuTipoPersona;
    otytAdquirente.tipoObligacion  := null;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
   EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(onuError, osbError);
      prCloseCursor;
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuError, osbError);
      prCloseCursor;
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END prGetInfoAdquirente;

  PROCEDURE prGetInfoDetalle ( inuFactura     IN  NUMBER,
                               otbltytDetalle OUT tbltytDetalle,
                               onuError       OUT NUMBER,
                               osbError       OUT VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoDetalle
    Descripcion     : retorna informacion de detalle la factura

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 17-11-2023

    Parametros de Entrada
      inuFactura       codigo de la factura
    Parametros de Salida
      otbltytDetalle  tabla con registro de detalle de cuenta de cobro
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    GDGuevara   07-03-2024  OSF-2284   Por estandarizacion del codigo luego de la validacion tecnica:
                                       Se cambia el alias codigoproducto por codigoconcepto en cugetCargos
                                       Se crea cursor CURSOR cuUnidadMedida
    GDGuevara   04-03-2024  OSF-2284   Se adiciona una tabla para almacenar la unidad de medida del concepto y
                                       consultar primero si el concepto existe en la tabla conc_unid_medida_dian
    LJLB        17-11-2023  OSF-1916   Creacion
  ***************************************************************************/

    -- Tipo de dato de tabla PL donde el indice es el concepto y el valor es la unidad de medida
    TYPE tytbUnMed IS TABLE OF VARCHAR2(10) INDEX BY BINARY_INTEGER;
    tbUnMed            tytbUnMed;
    
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prGetInfoDetalle';
    v_tytDetalle      tytDetalle;
    v_tytDetallenull  tytDetalle;
    v_tytImpuesto     tytImpuesto;
    v_tytImpuestonull tytImpuesto;
    sbIndex           VARCHAR2(40);
    sbUnidMed         VARCHAR2(10);
    nuContador        NUMBER;

    CURSOR cugetCargos IS
        SELECT nvl(cargos.cargunid,1) cantidad,
              cargos.cargconc         codigoconcepto,
              concepto.concdesc       descripcion,
              cargos.cargvalo         preciototal,
              round(decode( nvl(cargos.cargunid,1),  0, 0, cargos.cargvalo / cargos.cargunid),2) valorunitario
        FROM cargos
          JOIN cuencobr ON cuencobr.cucocodi = cargos.cargcuco
          JOIN concepto ON concepto.conccodi = cargos.cargconc
        WHERE cuencobr.cucofact = inuFactura;

    -- Cursor para leer la unidad de medida DIAN por concepto
    CURSOR cuUnidadMedida IS
        SELECT concepto_id, 
               unidad_medida 
        FROM conc_unid_medida_dian;
     
    PROCEDURE prInicializarValores IS
        csbMT_NAME1      VARCHAR2(150) := csbSP_NAME || '.prInicializarValores';
    BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        otbltytDetalle.DELETE;
        v_tytDetalle  := v_tytDetallenull;
        v_tytImpuesto := v_tytImpuestonull;
        nuContador    := 0;
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prInicializarValores;

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);
    pkg_error.prinicializaerror(onuError, osbError);
    prInicializarValores;

    -- Inicia la coleccion de las unidades de medida por concepto
    tbUnMed.DELETE;
    FOR rc IN cuUnidadMedida LOOP
        tbUnMed(rc.concepto_id) := rc.unidad_medida;
    END LOOP;

    -- Recorre los cargos facturados
    FOR reg IN cugetCargos LOOP
        nuContador := nuContador + 1;

        -- Inicia la unidad de medida por defecto en 94
        sbUnidMed := csbUnidadmedidaOtro;
        -- Valida si existe la unidad de medida del concepto en la tabla conc_unid_medida_dian
        IF tbUnMed.EXISTS(reg.codigoconcepto) then
           sbUnidMed := tbUnMed(reg.codigoconcepto);
        END IF;
        
        sbIndex    := inuFactura||nuContador;
        otbltytDetalle(sbIndex).cantidad              := reg.cantidad;
        otbltytDetalle(sbIndex).codigoproducto        := reg.codigoconcepto;
        otbltytDetalle(sbIndex).descripcion           := reg.descripcion;

        v_tytImpuesto.baseimponible           := 0;
        v_tytImpuesto.codImpuestoRetencion    := 0;
        v_tytImpuesto.porcentaje              := 0;
        v_tytImpuesto.valorImpuestoRetencion  := 0;

        otbltytDetalle(sbIndex).listaImpuestos        := v_tytImpuesto;
        otbltytDetalle(sbIndex).muestraComercial      := csbMuestraComercial;
        otbltytDetalle(sbIndex).muestracomercialcod   := csbMuestraComerCodigo;
        otbltytDetalle(sbIndex).nombreProducto        := reg.descripcion;
        otbltytDetalle(sbIndex).posicion              := csbPosicion;
        otbltytDetalle(sbIndex).preciosinimpuestos    := reg.preciototal;
        otbltytDetalle(sbIndex).preciototal           := reg.preciototal;
        otbltytDetalle(sbIndex).tamanio               := csbTamanio;
        otbltytDetalle(sbIndex).tipoImpuesto          := csbTipoImpuesto;
        otbltytDetalle(sbIndex).tipocodigoproducto    := csbTipoCodigoProducto;
        otbltytDetalle(sbIndex).unidadmedida          := sbUnidMed;
        otbltytDetalle(sbIndex).valorUnitPorCantidad  := reg.preciototal;
        otbltytDetalle(sbIndex).valorunitario         := reg.valorunitario;
    END LOOP;
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
  END prGetInfoDetalle;

  PROCEDURE prGetInfoCodigoBarra (  inuFactura      IN  NUMBER,
                                    otytCodigoBarra OUT tytCodigoBarra,
                                    onuError        OUT NUMBER,
                                    osbError        OUT VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoCodigoBarra
    Descripcion     : retorna informacion de codigo de barra
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 20-12-2023

    Parametros de Entrada
      inuFactura       codigo de la factura
    Parametros de Salida
      otytCodigoBarra   registro de informacion de codigo de barra
      onuError          codigo del error
      osbError          mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        20-12-2023   OSF-1916    Creacion
  ***************************************************************************/
    csbMT_NAME   VARCHAR2(70) := csbSP_NAME || '.prGetInfoCodigoBarra';
    sbcodigoean  VARCHAR2(100):= dald_parameter.fsbGetValue_Chain('COD_EAN_CODIGO_BARRAS');

    CURSOR cuGetInfoCodiBarra IS
    SELECT CASE WHEN codigo_3 IS NOT NULL THEN
            '(415)' || codigo_1 || '(8020)' || codigo_2 || '(3900)' ||  codigo_3 || '(96)' || codigo_4
            ELSE
               NULL
            END cadenaACodificar,
            csbtipoModelo tipoModelo,
            cnuOrden orden,
            csbTipoCodificacion tipoCodificacion,
            'Pague hasta el: '||to_char(cucofeve, 'yyyy-mm-dd') descripcion,
            to_char(cucofeve, 'yyyy-MM-dd')||'T'||'00:00:00 -05:00'  fecha
    FROM (
      SELECT sbcodigoean codigo_1
            ,lpad(cuponume, 10, '0') codigo_2
            ,lpad(round(cupovalo), 10, '0') codigo_3
            ,to_char(add_months(cucofeve, 120), 'yyyymmdd') codigo_4,
            add_months(cucofeve, 120) cucofeve
        FROM factura, cuencobr, cupon
       WHERE factcodi = inuFactura
         AND cupodocu = TO_CHAR(factcodi)
         AND factcodi = cucofact
         AND factsusc = cuposusc
        );

    PROCEDURE prCloseCursor IS
     csbMT_NAME1      VARCHAR2(70) := csbSP_NAME || '.prCloseCursor';
   BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        IF cuGetInfoCodiBarra%ISOPEN THEN
           CLOSE cuGetInfoCodiBarra;
        END IF;

        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prCloseCursor;

  BEGIN
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      pkg_traza.trace(' inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);
      pkg_error.prinicializaerror(onuError, osbError);
      prCloseCursor;

      OPEN cuGetInfoCodiBarra;
      FETCH cuGetInfoCodiBarra INTO otytCodigoBarra;
      CLOSE cuGetInfoCodiBarra;

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
  END prGetInfoCodigoBarra;
  PROCEDURE prGetInfoPagos ( inuFactura  IN  NUMBER,
                             idtFechaGen IN  DATE,
                             inuContrato IN  NUMBER,
                             otytPagos   OUT tytPagos,
                             onuError    OUT NUMBER,
                             osbError    OUT VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGetInfoPagos
    Descripcion     : retorna informacion de  pago de factura

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 17-11-2023

    Parametros de Entrada
      inuFactura      codigo de la factura
      idtFechaGen     fecha de generacion de la factura
      inuContrato     codigo del contrato
    Parametros de Salida
      otytPagos      registro de informacion de pago
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        17-11-2023   OSF-1916    Creacion
  ***************************************************************************/
   csbMT_NAME       VARCHAR2(70) := csbSP_NAME || '.prGetInfoPagos';
   nuValor          NUMBER;
   dtFechavenc      DATE;
   v_tytPagosNull   tytPagos;

   CURSOR cugetFechaVenc IS
   SELECT sum(cucovato) valor, trunc(cuencobr.cucofeve) cucofeve
   FROM cuencobr
   WHERE cuencobr.cucofact = inuFactura
   GROUP BY trunc(cuencobr.cucofeve);

   PROCEDURE prCloseCursor IS
     csbMT_NAME1      VARCHAR2(70) := csbSP_NAME || '.prCloseCursor';
   BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF cugetFechaVenc%ISOPEN THEN
           CLOSE cugetFechaVenc;
        END IF;

        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prCloseCursor;

    PROCEDURE prInicializarValores IS
     csbMT_NAME1      VARCHAR2(70) := csbSP_NAME || '.prInicializarValores';
    BEGIN
      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

      nuValor     := NULL;
      dtFechavenc := NULL;
      v_tytPagosNull := otytPagos;

      pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prInicializarValores;

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' inuContrato => ' || inuContrato, pkg_traza.cnuNivelTrzDef);

    pkg_error.prinicializaerror(onuError, osbError);
    prCloseCursor;
    prInicializarValores;

    OPEN cugetFechaVenc;
    FETCH cugetFechaVenc INTO nuValor, dtFechavenc;
    CLOSE cugetFechaVenc;

    pkg_traza.trace(' nuValor => ' || nuValor, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' dtFechavenc => ' || dtFechavenc, pkg_traza.cnuNivelTrzDef);

    otytPagos.periododepagoa       := round(dtFechavenc - idtFechaGen ,0);
    otytPagos.fechavencimiento     := to_char(dtFechavenc, 'yyyy-MM-dd')||'T'||to_char(dtFechavenc,'HH:mm:ss') ;
    otytPagos.moneda               := csbCodigoMonedaCambio;
    otytPagos.tipocompra           := csbTipoCompra;
    otytPagos.totBaseConImpuestos  := nuValor;
    otytPagos.totalBaseImponible   := 0;
    otytPagos.totalFactura         := nuValor;
    otytPagos.totalImporteBruto    := nuValor;

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
  END prGetInfoPagos;
  FUNCTION frcGetFactReenviar( inuContrato    IN FACTURA_ELECTRONICA.CONTRATO%TYPE,
                               inuFactura     IN FACTURA_ELECTRONICA.CONSFAEL%TYPE,
                               idtFechaIni    IN FACTURA_ELECTRONICA.FECHA_REGISTRO%TYPE,
                               idtFechaFin    IN FACTURA_ELECTRONICA.FECHA_REGISTRO%TYPE,
                               inuEstado      IN FACTURA_ELECTRONICA.ESTADO%TYPE) RETURN constants_per.tyrefcursor IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcGetFactReenviar
    Descripcion     : proceso que retorna informacion para PB RFEL

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 15-11-2023

    Parametros de Entrada
      inuContrato    contrato
      inuFactura     factura
      idtFechaIni    fecha inicial
      idtFechaFin    fecha final
      inuEstado      estado
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       16-11-2023   OSF-1916    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(70) := csbSP_NAME || '.frcGetFactReenviar';
    rcFactElec      constants_per.tyrefcursor;
    nuError         NUMBER;
    sberror         VARCHAR2(4000);

    sbEstadoValido  parametros.valor_cadena%type := pkg_parametros.fsbgetvalorcadena('ESTADO_REENVIO_FACELE');

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' nuContrato => ' || inuContrato, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' nuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' idtFechaIni => ' || idtFechaIni, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' idtFechaFin => ' || idtFechaFin, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' nuEstado => ' || inuContrato, pkg_traza.cnuNivelTrzDef);

    IF idtFechaIni IS NULL THEN
       OPEN rcfactelec FOR
       SELECT consfael consecutivo_factura,
              contrato contrato,
              FACTURA factura,
              decode(estado, 3, 'RECHAZADO PT', 4, 'RECHAZADO DIAN') estado,
              numero_intento,
              fecha_registro fecha_registro,
              fecha_envio fecha_envio,
              fecha_respuesta fecha_respuesta,
              xml_factelect xml_solicitud,
              xml_respuesta xml_respuesta,
              mensaje_respuesta mensaje_respuesta
        FROM factura_electronica
        WHERE (contrato = inucontrato OR inucontrato IS NULL)
         AND (consfael = inufactura OR inufactura IS NULL)
         AND  (estado = inuestado OR
                (inuestado IS NULL AND estado IN ( SELECT to_number(regexp_substr(sbEstadoValido,'[^,]+', 1,LEVEL)) AS estados
                                                  FROM dual
                                                  CONNECT BY regexp_substr(sbEstadoValido, '[^,]+', 1, LEVEL) IS NOT NULL)));

    ELSE
        OPEN rcfactelec FOR
        SELECT consfael consecutivo_factura,
               contrato contrato,
              FACTURA factura,
              decode(estado, 3, 'RECHAZADO PT', 4, 'RECHAZADO DIAN') estado,
               numero_intento,
              fecha_registro fecha_registro,
              fecha_envio fecha_envio,
              fecha_respuesta fecha_respuesta,
              xml_factelect xml_solicitud,
              xml_respuesta xml_respuesta,
              mensaje_respuesta mensaje_respuesta
        FROM factura_electronica
        WHERE (contrato = inucontrato OR inucontrato IS NULL)
         AND (consfael = inufactura OR inufactura IS NULL)
         AND  (estado = inuestado OR (inuestado IS NULL
                 AND estado IN ( SELECT to_number(regexp_substr(sbEstadoValido,'[^,]+', 1,LEVEL)) AS estados
                                  FROM dual
                                  CONNECT BY regexp_substr(sbEstadoValido, '[^,]+', 1, LEVEL) IS NOT NULL)))
         AND fecha_registro BETWEEN idtFechaIni AND idtFechaFin;
    END IF;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN rcFactElec;
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace(' sberror => ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace(' sberror => ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
  END frcGetFactReenviar;

  PROCEDURE prProcesarReenvio( inuConsFael IN FACTURA_ELECTRONICA.CONSFAEL%TYPE,
                               onuError    OUT NUMBER,
                               osbError    OUT VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prProcesarReenvio
    Descripcion     : proceso que actualiza informacion del PB RFEL

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 15-11-2023

    Parametros de Entrada
      inuConsFael    consecutivo de factura electronica

    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       16-11-2023   OSF-1916    Creacion
  ***************************************************************************/
   csbMT_NAME      VARCHAR2(70) := csbSP_NAME || '.prProcesarReenvio';
   nuEstadoActuPro  NUMBER := pkg_parametros.fnugetvalornumerico('ESTADO_ACTU_FACTELECT');
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuConsFael => ' || inuConsFael, pkg_traza.cnuNivelTrzDef);
    pkg_error.prInicializaError( onuError, osbError );

    UPDATE FACTURA_ELECTRONICA SET ESTADO = nuEstadoActuPro
    WHERE CONSFAEL = inuConsFael;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(onuError, osbError);
      pkg_traza.trace(' sberror => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuError, osbError);
      pkg_traza.trace(' sberror => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END prProcesarReenvio;
END pkg_bcfactelectronica;
/