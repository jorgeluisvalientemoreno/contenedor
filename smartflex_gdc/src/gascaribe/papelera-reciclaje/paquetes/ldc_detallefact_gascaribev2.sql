CREATE OR REPLACE PACKAGE ldc_detallefact_gascaribev2 IS
  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : LDC_DetalleFact_GasCaribe
  Descripcion    : Paquete con la logica de negocio el Spool de Gas Caribe
  Autor          :
  Fecha          : 11/07/2012

  Historia de Modificaciones
  Fecha         Autor               Modificacion
  -------------------------------------------------
  11/07/2018    Sebastian Tapias  REQ.200-1920: Se modifica el servicio: <<RfConcepParcial>>
  13/03/2017    KCienfuegos       CA200-1081: Se modifican los m?todos: <<rfdatosconsumohist>>
                                                                        <<rfdatosconsumos>>
                                                                        <<RfDatosRevision>>
  11/01/2017    carlosr           Se crea el m?todo RfDatosConsumos
  26-12-2016    KCienfuegos       CA 200-326 Se modifica proceso InsLD_CUPON_CAUSAL
  11-11-2016    Sandra Mu?oz      CA 200-849.
                                  Creacion de los procedimientos/funciones fnuObservNoLectConsec y
                                  proDatosSpool
                                  Modificacion de fsbGetEncabezado, rfDatosGenerales
  06-09-2016    Sandra Mu?oz      ca 200-342.
                                  Creacion procedimientos fnuProductoPrincipal,
                                  ldc_fnuCuadrillaReparto, proCuadrillaReparto
                                  Se modifican los procedimientos fsbGetEncabConc4,
                                  RfDatosGenerales, RfDatosRevision, RfDatosConceptos,
                                  RfDatosConcEstadoCuenta,RfConcepParcial,fsbGetEncabezado
  17/12/2015    Agordillo         Se modifica el procedimiento <<RfConcepParcial>> SAO.369165
  07/10/2015    Mmejia            Modificacion <<fnuLecturaAnterior>> <<RfDatosConsumoHist>>
                                  Aranda.8800 Se agrega para validar la lectura anterior en el
                                  caso que la observacion sea diferente a NULL  y -1 retorne NULL.
                                  Se modifica el calculo de la conversion se M3 a  Kwh.
  05/08/2015    Mmejia            Modificacion <<RfConcepParcial>> <<RfDatosConsumoHist>> Aranda.8199
  25/06/2015    Mmejia            Modificacion <<RfConcepParcial>> Aranda.6477 Se agrega  la logica para agregar
                                  a los detalles de factura los diferidos que no estan asociados
                                  a una cuenta de cobro.
  18/05/2014    Agordillo          Modificacion Cambio.7864  se modifica el procedimiento <<RfDatosConceptos>>
  01/06/2015    Agordillo          Modificacion Cambio.7524
                                   Se modifica el procedimiento <<RfDatosGenerales>>
                                   Se crea el procedimiento <<InsLD_CUPON_CAUSAL>>
                                   Se modifica la funcion <<fnuLecturaAnterior>>
  27/05/2015    Slemus-Ara6452     Modificacion Aranda_Cambio.6452
                                   * Se modifica la consulta de agrupacion (group by ID, CONCEPTO,DOC_SOPORTE,CAU_CARGO)
                                   por campos orden y concepto.
  13-05-2015    Slemus-ARA7263    Se modifica el procedimiento <<rfdatosconsumohist>>
                                  para realizar el cambio el origen de datos de temperatura y presi?n.
                                  Se modifica la funcion <<fnuMesesDeuda>> para que incluya
                                  el valor en reclamo para calcular el saldo de la cuenta.

  19-03-2015    Agordillo         Se modifica los metodos <<RfConcepParcial>>, <<RfDatosRevision>>,
                                  <<RfConcepParcial>>

  02-03-2015    Llozada           Se modifican los m?todos <<RfDatosLecturas>>, <<RfDatosConsumoHist>>,
                                  <<fsbGetEncabezado>>, <<RfRangosConsumo>>
  ******************************************************************/

  --Tipo tabla PL de periodos
  TYPE tytbperiodos IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fsbVersion
  Descripcion :   Obtiene la versi?n del paquete
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
  **************************************************************************/

  FUNCTION fsbversion RETURN VARCHAR2;

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fsbGetEncabConc1
  Descripcion :   Obtiene los encabezados.
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
  Fecha               Autor              Modificacion
  =========           =========          ====================
  05-12-2014          ggamarra           Creacion
  **************************************************************************/

  FUNCTION fsbgetencabconc1 RETURN VARCHAR2;

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fsbGetEncabConc2
  Descripcion :   Obtiene los encabezados.
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
  Fecha               Autor              Modificacion
  =========           =========          ====================
  05-12-2014          ggamarra           Creacion
  **************************************************************************/

  FUNCTION fsbgetencabconc2 RETURN VARCHAR2;

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fsbGetEncabConc3
  Descripcion :   Obtiene los encabezados.
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
  Fecha               Autor              Modificacion
  =========           =========          ====================
  05-12-2014          ggamarra           Creacion
  **************************************************************************/

  FUNCTION fsbgetencabconc3 RETURN VARCHAR2;

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fsbGetEncabConc4
  Descripcion :   Obtiene los encabezados.
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
  Fecha               Autor              Modificacion
  =========           =========          ====================
  05-12-2014          ggamarra           Creacion
  **************************************************************************/

  FUNCTION fsbgetencabconc4 RETURN VARCHAR2;

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fsbGetEncabezado
  Descripcion :   Obtiene los encabezados.
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
  Fecha               Autor              Modificacion
  =========           =========          ====================
  05-12-2014          ggamarra           Creacion
  **************************************************************************/
  FUNCTION fsbgetencabezado RETURN VARCHAR2;

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fnuFechaSuspension
  Descripcion :   Obtiene la fecha de suspension
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
  **************************************************************************/

  FUNCTION fnufechasuspension(nuproducto  IN servsusc.sesunuse%TYPE,
                              nucategoria IN servsusc.sesucate%TYPE)
    RETURN NUMBER;

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   RfDatosGenerales
  Descripcion :   Obtiene los datos generales de una factura
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
  **************************************************************************/

  PROCEDURE rfdatosgenerales(orfcursor OUT constants.tyrefcursor);

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   RfDatosLecturas
  Descripcion :   Obtiene los datos de las lecturas y medidor
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
  **************************************************************************/

  PROCEDURE rfdatoslecturas(orfcursor OUT constants.tyrefcursor);

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   frfCambioCiclo
  Descripcion :   Obtiene los ciclos de facturaci?n anteriores
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
  **************************************************************************/

  FUNCTION frfcambiociclo(inufactsusc IN NUMBER) RETURN constants.tyrefcursor;

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   RfDatosConsumoHist
  Descripcion :   Obtiene datos de los consumos
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014          ggamarra            Creacion
  **************************************************************************/

  PROCEDURE rfdatosconsumohist(orfcursor OUT constants.tyrefcursor);

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   RfDatosRevision
  Descripcion :   Obtiene los datos de las fechas de revisi?n
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
  **************************************************************************/

  PROCEDURE rfdatosrevision(orfcursor OUT constants.tyrefcursor);

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   RfDatosConceptos
  Descripcion :   Obtiene los datos de los conceptos liquidados en la factura
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
  **************************************************************************/

  PROCEDURE rfdatosconceptos(orfcursor OUT constants.tyrefcursor);

  FUNCTION fnucanconceptos RETURN NUMBER;

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : RfDatosConcEstadoCuenta
    Descripcion    : Procedimiento para extraer los campos relacionados
                     con los datos de los conceptos en el estado de cuenta.
    Autor          : Gabriel Gamarra - Horbath Technologies

    Parametros           Descripcion
    ============         ===================
  orfcursor            Retorna los datos de los conceptos.

    Fecha           Autor               Modificacion
    =========       =========           ====================
    11/11/2014      ggamarra            Creacion.
    ******************************************************************/
  PROCEDURE rfdatosconcestadocuenta(orfcursor OUT constants.tyrefcursor);

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfConcepParcial
  Descripcion    : Procedimiento para mostrar el iva y el subtotal de los no regulados.
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================

  orfcursor            Retorna los datos

  Fecha           Autor               Modificacion
  =========       =========           ====================
  11/11/2014      ggamarra           Creacion.
  ******************************************************************/

  PROCEDURE rfconcepparcial(orfcursor OUT constants.tyrefcursor);

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   RfRangosConsumo
  Descripcion :   Obtiene los rangos tarifarios liquidados en consumos
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
  **************************************************************************/

  PROCEDURE rfrangosconsumo(orfcursor OUT constants.tyrefcursor);

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :  fnuConceptoComponent
  Descripcion : Obtiene el valor de los componentes del costo
  Autor       : Alexandra Gordillo

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  18-03-2015          agordillo            Creacion.

  **************************************************************************/
  FUNCTION fnuconceptocomponent(isbcomponente IN VARCHAR2) RETURN NUMBER;

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   rfGetValCostCompValid
  Descripcion :   Obtiene los componentes del costo
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
  **************************************************************************/

  PROCEDURE rfgetvalcostcompvalid(orfcursor OUT constants.tyrefcursor);

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   RfDatosCodBarras
  Descripcion :   Obtiene el codigo de barras
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
  **************************************************************************/

  PROCEDURE rfdatoscodbarras(orfcursor OUT constants.tyrefcursor);

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfDatosBarCode
  Descripcion    : procedimiento para extraer los datos relacionados
                   al codigo de barras para el estado de cuenta
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  11/11/2014      ggamarra             Creaci?n.
  ******************************************************************/
  PROCEDURE rfdatosbarcode(orfcursor OUT constants.tyrefcursor);

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   rfGetValRates
  Descripcion :   Obtiene los valores de las tasas de cambio
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
  **************************************************************************/

  PROCEDURE rfgetvalrates(orfcursor OUT constants.tyrefcursor);

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fnuLecturaAnterior
  Descripcion :   Obtiene el valor de la lectura anterior
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
  **************************************************************************/

  FUNCTION fnulecturaanterior(inusesunuse    IN servsusc.sesunuse%TYPE,
                              inuperiodofact IN perifact.pefacodi%TYPE)
    RETURN NUMBER;

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fnuMesesDeuda
  Descripcion :   Obtiene los meses de deuda
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
  **************************************************************************/

  FUNCTION fnumesesdeuda(inususccodi suscripc.susccodi%TYPE) RETURN NUMBER;

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fblNoRegulado
  Descripcion :   Valida si el contrato es de producto no regulado
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
  **************************************************************************/

  FUNCTION fblnoregulado(inususccodi suscripc.susccodi%TYPE) RETURN BOOLEAN;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fsbGetFechaPermmyyyy
  Descripcion    : Permite consultar la fecha del periodo
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================
  orfcursor            Retorna los datos de los periodos facturados

  Fecha             Autor             Modificacion
  =========       =========           ====================
  11/11/2014      ggamarra           Creacion.
  ******************************************************************/

  FUNCTION fsbgetfechapermmyyyy(inupefacodi IN perifact.pefacodi%TYPE)
    RETURN VARCHAR2;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuGetConsumoResidencial
  Descripcion    : Permite consultar el consumo residencial
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================
  orfcursor            Retorna los datos de los periodos facturados

  Fecha             Autor             Modificacion
  =========       =========           ====================
  11/11/2014      ggamarra           Creacion.
  ******************************************************************/

  FUNCTION fnugetconsumoresidencial(inusesunuse IN servsusc.sesunuse%TYPE,
                                    inupericose IN conssesu.cosspecs%TYPE)
    RETURN NUMBER;

  /**************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : InsLD_CUPON_CAUSAL
  Descripcion    : Procedure para utilizar en la regla POST de la solicitud
                    Solicitud de Estado de Cuenta donde se almacena el cupon del duplicado,
                    la causal de legalizacion de la solicitud.  ld_cupon_causal
                  Inserta solo si es una causal que genere cobro y si el tipo de solicitud
                  es Solicitud de Estado de Cuenta
  Autor          : pgarcia
  Fecha          : 28/10/2014

  Parametros              Descripcion
  ============         ===================
  inuPackageTypeId      Tipo de SOlicitud
  inuCuponId            Identificador del cupon
  inuCausalId           Identificador de la causal

  Fecha             Autor             Modificacion
  =========       =========           ====================
   01/06/2015      Agordillo          Creacion Cambio.7524
                                      Se copia el procedimiento InsLD_CUPON_CAUSAL del LDC_DETALLEFACT_EFIGAS
                                      se agrega a la proceso de impresion de Gases del Caribe.
  ******************************************************************/
  PROCEDURE InsLD_CUPON_CAUSAL(inuPackageTypeId IN NUMBER,
                               inuCuponId       IN NUMBER,
                               inuCausalId      IN NUMBER,
                               inuPackagesId    IN NUMBER);

  FUNCTION fsbCuadrillaReparto(inuOrden or_order.order_id%TYPE -- Orden
                               ) RETURN VARCHAR2;

  FUNCTION fsbCuadrillaReparto RETURN VARCHAR2;

  FUNCTION fnuProductoPrincipal(inuContrato suscripc.susccodi%TYPE -- Contrato
                                ) RETURN NUMBER;

  FUNCTION fsbRutaReparto(inuProducto pr_product.product_id%TYPE -- Producto
                          ) RETURN VARCHAR2;

  FUNCTION fnuObservNoLectConsec(inuPeriodoConsumo pericose.pecscons%TYPE, -- Periodo consumo
                                 inuProducto       pr_product.product_id%TYPE -- Producto
                                 ) RETURN NUMBER;

  FUNCTION fnuObservNoLectConsec RETURN NUMBER;

  PROCEDURE proDatosSpool(orfcursor OUT constants.tyRefCursor);

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   RfDatosConsumos
  Descripcion :   Obtiene datos de los consumos
  Autor       :   Carlos Alberto Ram?rez - Arquitecsoft

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-01-2017          carlosr            Creacion
  **************************************************************************/

  PROCEDURE rfdatosconsumos(orfcursor OUT constants.tyrefcursor);

  ----CASO 200-1626
  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fnuGetProducto
  Descripcion :   Servicio que permitira obtener el saldo anterior de un suscriptor
  Autor       :   Jorge valiente

  Historia de Modificaciones
  Fecha               Autor              Modificacion
  =========           =========          ====================
  **************************************************************************/
  FUNCTION FnuGetSaldoAnterior(InuContrato number,
                               InuFactura  number,
                               Inusesunuse number) RETURN NUMBER;
  ----CASO 200-1626

  --Inicio CASO 200-1515
  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfMarcaAguaDuplicado
  Descripcion    : procedimiento para extraer los datos y establecer si
                   se aplica la maraca de agua en la plantilla .NET
  Autor          : Daniel Valiente

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE RfMarcaAguaDuplicado(orfcursor OUT constants.tyRefCursor);
  --Fin CASO 200-1515

END ldc_detallefact_gascaribev2;
/
CREATE OR REPLACE PACKAGE BODY LDC_DetalleFact_GasCaribev2 IS
  csbBSS_FAC_SMS_200342 CONSTANT VARCHAR2(20) := 'BSS_FAC_SMS_200342_8';
  csbBSS_FAC_SMS_200849 CONSTANT VARCHAR2(20) := 'BSS_FAC_SMS_200849_5';
  csbEntrega2001081     CONSTANT VARCHAR2(200) := 'BSS_FAC_KCM_2001081_1';
  cnuCategoriaInd       CONSTANT servsusc.sesucate%TYPE := dald_parameter.fnuGetNumeric_Value('CODIGO_CATE_INDUSTRIAL',
                                                                                              0);
  gsbPaquete VARCHAR2(30) := 'LDC_DetalleFact_GasCaribe';
  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : LDC_DetalleFact_GasCaribe
  Descripcion    : Paquete con la logica de negocio el Spool de Gas Caribe
  Autor          :
  Fecha          : 11/07/2012

  Historia de Modificaciones
  Fecha         Autor               Modificacion
  -------------------------------------------------
  11/07/2018    Sebastian Tapias  REQ.200-1920: Se modifica el servicio: <<RfConcepParcial>>
  13/03/2017    KCienfuegos       CA200-1081: Se modifican los m?todos: <<rfdatosconsumohist>>
                                                                        <<rfdatosconsumos>>
                                                                        <<RfDatosRevision>>
  11/01/2017    carlosr           Se crea el m?todo RfDatosConsumos
  26-12-2016    KCienfuegos       CA 200-326 Se modifica proceso InsLD_CUPON_CAUSAL
  18-010-2016   Sandra Mu?oz      CA 200-849. Se modifica RfConcepParcial y rfDatosGenerales.
                                  Creacion de la funcion fnuObservNoLectConsec.
  06-09-2016    Sandra Mu?oz      Creacion procedimientos fnuProductoPrincipal,
                                  ldc_fnuCuadrillaReparto, proCuadrillaReparto
                                  Se modifican los procedimientos fsbGetEncabConc4,
                                  RfDatosGenerales, RfDatosRevision, RfDatosConceptos,
                                  RfDatosConcEstadoCuenta, RfConcepParcial, fsbGetEncabezado,
                                  fnuCanConceptos
  17/12/2015    Agordillo         Se modifica el procedimiento <<RfConcepParcial>> SAO.369165
  07/10/2015    Mmejia            Modificacion <<fnuLecturaAnterior>> <<RfDatosConsumoHist>>
                                  Aranda.8800 Se agrega para validar la lectura anterior en el
                                  caso que la observacion sea diferente a NULL  y -1 retorne NULL.
                                  Se modifica el calculo de la conversion se M3 a  Kwh.
  25/06/2015    Mmejia            Modificacion <<RfConcepParcial>> Aranda.6477 Se agrega  la logica para agregar
                                  a los detalles de factura los diferidos que no estan asociados
                                  a una cuenta de cobro.
  18/05/2014    Agordillo          Modificacion Cambio.7864  se modifica el procedimiento <<RfDatosConceptos>>
  01/06/2015    Agordillo          Modificacion Cambio.7524
  27/05/2015    Slemus-Ara6452     Modificacion Aranda_Cambio.6452
                                   * Se modifica la consulta de agrupacion (group by ID, CONCEPTO,DOC_SOPORTE,CAU_CARGO)
                                   por campos orden y concepto.
  13-05-2015    Slemus-ARA7263    Se modifica el procedimiento <<rfdatosconsumohist>>
                                  para realizar el cambio el origen de datos de temperatura y presi?n.
                                  Se modifica la funcion <<fnuMesesDeuda>> para que incluya
                                  el valor en reclamo para calcular el saldo de la cuenta
  19-03-2015    Agordillo         Incidente 140493.
                                  Se modifica los procedimiento <<RfConcepParcial>>, <<RfDatosRevision>>,
                                  <<rfGetValCostCompValid>> , <<RfDatosConceptos>>, <<RfDatosConcEstadoCuenta>>
                                  Se crea la funcion <<fnuConceptoComponent>> , <<fnuCanConceptos>>

  02-03-2015    Llozada           Se modifican los m?todos <<RfDatosLecturas>>, <<RfDatosConsumoHist>>,
                                  <<fsbGetEncabezado>>, <<RfRangosConsumo>>
  ******************************************************************/

  ----------------------------------------------------------------------
  -- Constantes
  ----------------------------------------------------------------------
  csbVersion CONSTANT VARCHAR2(50) := 'NC_4828';

  ----------------------------------------------------------------------
  -- Variables
  ----------------------------------------------------------------------
  gsbTotal         VARCHAR2(50);
  gsbIVANoRegulado VARCHAR2(50);
  gsbSubtotalNoReg VARCHAR2(50);
  gsbCargosMes     VARCHAR2(50);
  gnuConcNumber    NUMBER;

  glPackage_Cupon_id      ld_cupon_causal.package_id%TYPE := NULL; -- Agordillo Cambio.7524
  glCupon_Cupon_id        ld_cupon_causal.cuponume%TYPE := NULL; -- Agordillo Cambio.7524
  glCausal_Cupon_id       ld_cupon_causal.causal_id%TYPE := NULL; -- Agordillo Cambio.7524
  glPackage_type_Cupon_id NUMBER := 0; -- Agordillo Cambio.7524

  ----------------------------------------------------------------------
  -- Metodos
  ----------------------------------------------------------------------

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  BEGIN
    pkErrors.push('LDC_DetalleFact_GasCaribe.fsbVersion');
    pkErrors.pop;
    RETURN csbVersion;
  END fsbVersion;

  FUNCTION fnuProductoPrincipal(inuContrato suscripc.susccodi%TYPE -- Contrato
                                ) RETURN NUMBER IS
    /***********************************************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fnuProductoPrincipal
    Descripcion:        Obtiene el servicio principal de un contrato

    Autor    : Sandra Mu?oz
    Fecha    : 18-08-2016 cA200-342

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    18-08-2016   Sandra Mu?oz           Creacion
    ***********************************************************************************************/

    cnuError CONSTANT NUMBER := 2741;

    nuServGas           ld_parameter.numeric_value%TYPE := dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS');
    nuProductoPrincipal servsusc.sesunuse%TYPE; -- Servicio principal

  BEGIN

    IF fblaplicaentrega(csbBSS_FAC_SMS_200342) THEN

      SELECT sesunuse
        INTO nuProductoPrincipal
        FROM servsusc
       WHERE sesususc = inuContrato
         AND sesuserv = nuServGas;

    ELSE
      nuProductoPrincipal := NULL;
    END IF;

    RETURN nuProductoPrincipal;

  EXCEPTION

    WHEN OTHERS THEN
      RETURN NULL;
  END;

  FUNCTION fsbRutaReparto(inuProducto pr_product.product_id%TYPE -- Producto
                          ) RETURN VARCHAR2 IS
    /***********************************************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fnuRutaReparto
    Descripcion:        Para las categorias 1 y 2,  si tanto la direccion del producto como la
                        del contrato son iguales se debe seguir imprimiendo el campo RUTA como
                        se hace actualmente. Para categorias diferentes a 1 y 2 se debe conservar
                        el calculo de la columna RUTA.
                        Si la direccion de cobro del contrato y la direccion del producto son
                        diferentes significa que el contrato tiene direccion de cobro y deben
                        compararse los ciclos de facturacion de la direccion del producto y el
                        ciclo de Direccion del CONTRATO, si son DIFERENTES los ciclos, se debe
                        imprimir un -1 en el campo RUTA.




    Autor    : Sandra Mu?oz
    Fecha    : 19-08-2016 cA200-342

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    22-09-2016   Sandra Mu?oz           cA 200-342. Si la direccion del contrato es -1 se debe
                                        imprimir DIR COBRO
    21-09-2016   Sandra Mu?oz           CA 200-342. Se cambia el tipo de dato retornado por esta funcion
                                        y se publica en la especificacion para poder ser usada en
                                        cursores
    19-08-2016   Sandra Mu?oz           Creacion
    ***********************************************************************************************/

    cnuError CONSTANT NUMBER := 2741;

    nuCategoriaComercial   ld_parameter.numeric_value%TYPE := dald_parameter.fnuGetNumeric_Value('COMMERCIAL_CATEGORY'); -- Categoria comercial
    nuCategoriaResidencial ld_parameter.numeric_value%TYPE := dald_parameter.fnuGetNumeric_Value('RESIDEN_CATEGORY'); -- Categoria residencial
    nuDireccionProducto    pr_product.address_id%TYPE; -- Direccion del producto
    nuContrato             suscripc.susccodi%TYPE; -- Contrato
    nuDireccionContrato    suscripc.susciddi%TYPE; -- Direccion del contrato
    nuProductoPrincipal    pr_product.product_id%TYPE; -- Producto
    nuCicloContrato        ab_segments.ciclcodi%TYPE; -- Ciclo contrato
    nuCicloProducto        ab_segments.ciclcodi%TYPE; -- Ciclo contrato
    sbRuta                 VARCHAR2(500); -- Ruta de reparto
    nuCategoria            pr_product.category_id%TYPE; -- Categoria
    nuRutaContrato         ab_segments.route_id%TYPE; -- Ruta del contrato

  BEGIN
    IF NOT fblaplicaentrega(csbBSS_FAC_SMS_200342) THEN
      RETURN NULL;
    END IF;
    -- Buscar la ruta actual ya la informacion del producto y contrato
    SELECT ab_contrato.ciclcodi,
           ab_producto.ciclcodi,
           b.susciddi,
           pp.address_id,
           pp.category_id,
           ab_contrato.route_id
      INTO nuCicloContrato,
           nuCicloProducto,
           nuDireccionContrato,
           nuDireccionProducto,
           nuCategoria,
           nuRutaContrato
      FROM open.suscripc    b,
           open.pr_product  pp,
           open.ab_address  ca_contrato,
           open.ab_segments ab_contrato,
           open.ab_address  ca_producto,
           open.ab_segments ab_producto
     WHERE b.susccodi = pp.subscription_id
       AND b.susciddi = ca_contrato.address_id --(+)
       AND ca_contrato.segment_id = ab_contrato.segments_id
       AND pp.address_id = ca_producto.address_id --(+)
       AND ca_producto.segment_id = ab_producto.segments_id
       AND pp.product_id = inuProducto;

    -- Identificar el valor de la categoria residencial y comercial
    IF nuCategoria IN (nuCategoriaComercial, nuCategoriaResidencial) THEN

      IF nuRutaContrato = -1 THEN
        sbRuta := 'DIR COBRO';
      ELSE
        -- Identifica si tiene direccion de cobro
        IF nuDireccionProducto <> nuDireccionContrato THEN
          IF nuCicloContrato <> nuCicloProducto THEN
            sbRuta := 'DIR COBRO';
          END IF;
        END IF;
      END IF;

    END IF;

    RETURN sbRuta; -- Devuelve null si no cumple para enviar -1

  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END;
  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fsbGetEncabezado
  Descripcion :   Obtiene los encabezados.
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
  Fecha               Autor              Modificacion
  =========           =========          ====================
  11-11-2016          Sandra Mu?oz       CA200-849. Se agrega el titulo OBS_NO_LECT_CONSEC
  07-09-2016          Sandra Mu?oz       CA200-342. Se ubica la columna UNIDAD_OPERATIVA despues
                                         del tipo de producto
  01-03-2015          Llozada            Se cambia la columna TIPO DE PRODUCTO por TIPO_DE_PRODUCTO
  30-01-2014          ggamarra           Se modifican las variables de consumo para los rangos
  05-12-2014          ggamarra           Creacion
  **************************************************************************/
  FUNCTION fsbGetEncabezado RETURN VARCHAR2 IS
    sbEncabezado VARCHAR2(4000);

  BEGIN
    /*01-03-2015 Llozada: Se cambia la columna TIPO DE PRODUCTO por TIPO_DE_PRODUCTO*/
    sbEncabezado := 'NUMERO_FACT|FAC_NO|F_D_EMISON|MES_FAC|PERIODO_FACT|F_D_VENC|DIAS_CONSUMO|COD_DE_SERVICIO|CUPON|NOMBRE_SUSC|DIR_ENTREGA|' ||
                    'LOCALIDAD|USO|ESTRATO|CICLO|RUTA|MESES_DEUDA|NUM_CONTROL|PERIODO_CONSUMO|SALDO_A_FAVOR|SALDO_ANT|FECHA_SUSPENSION|VALOR_RECL|' ||
                    'TOTAL_A_PAGAR|PAGO_SIN_RECARGO|CONDICION_PAGO|IDENTIFICA|TIPO_DE_PRODUCTO|';

    -- CA 200-849. Se imprime la observacion de no lectura consecutiva
    IF fblAplicaEntrega(csbBSS_FAC_SMS_200849) THEN
      sbEncabezado := sbEncabezado || 'OBS_NO_LECT_CONSEC|';
    END IF;

    -- CA 200-342. Se agrega el campo unidad operativa despues del tipo de producto
    IF fblAplicaEntrega(csbBSS_FAC_SMS_200342) THEN
      sbEncabezado := sbEncabezado || 'UNIDAD_OPERATIVA|';
    END IF;

    sbEncabezado := sbEncabezado ||
                    'CUPO_DISPONIBLE|NO_MEDIDOR|LEC_ANT|LEC_ACTUAL|' ||
                    'CAUSA_N_LEC|CONSUMO|F_CORREC|CONSUMO1|MES1|CONSUMO2|MES2|CONSUMO3|MES3|CONSUMO4|MES4|CONSUMO5|MES5|CONSUMO6|MES6|' ||
                    'PROM_CONSUMO|TEMPERATURA|PRESION|CONS_KW|CALCULO_CONS|TIPO_NOTI|MENSGNRAL1|FECH_MAXIMA|FECH_SUSP|LIM_INFERIOR1|LIM_SUPERIOR1|' ||
                    'VALOR_UNIDAD1|RCONSUMO1|VAL_CONSUMO1|LIM_INFERIOR2|LIM_SUPERIOR2|VALOR_UNIDAD2|RCONSUMO2|VAL_CONSUMO2|LIM_INFERIOR3|' ||
                    'LIM_SUPERIOR3|VALOR_UNIDAD3|RCONSUMO3|VAL_CONSUMO3|LIM_INFERIOR4|LIM_SUPERIOR4|VALOR_UNIDAD4|RCONSUMO4|VAL_CONSUMO4|' ||
                    'LIM_INFERIOR5|LIM_SUPERIOR5|VALOR_UNIDAD5|RCONSUMO5|VAL_CONSUMO5|LIM_INFERIOR6|LIM_SUPERIOR6|VALOR_UNIDAD6|RCONSUMO6|' ||
                    'VAL_CONSUMO6|LIM_INFERIOR7|LIM_SUPERIOR7|VALOR_UNIDAD7|RCONSUMO7|VAL_CONSUMO7|COMPCOST|VALORESREF|VALCALC|CODIGO_1|CODIGO_2|' ||
                    'CODIGO_3|CODIGO_4|CODIGO_BARRAS|TASA_ULTIMA|TASA_PROMEDIO|TOTAL|IVA|SUBTOTAL|CARGOSMES|CANTIDAD_CONC|';

    /*01-03-2015 Llozada: Se comenta ya que el usuario solicita cambiar la columna TIPO DE PRODUCTO por TIPO_DE_PRODUCTO*/
    /*      sbEncabezado :=  'NUMERO_FACT|FAC_NO|F_D_EMISON|MES_FAC|PERIODO_FACT|F_D_VENC|DIAS_CONSUMO|COD_DE_SERVICIO|CUPON|NOMBRE_SUSC|DIR_ENTREGA|'||
    'LOCALIDAD|USO|ESTRATO|CICLO|RUTA|MESES_DEUDA|NUM_CONTROL|PERIODO_CONSUMO|SALDO_A_FAVOR|SALDO_ANT|FECHA_SUSPENSION|VALOR_RECL|'||
    'TOTAL_A_PAGAR|PAGO_SIN_RECARGO|CONDICION_PAGO|IDENTIFICA|TIPO DE PRODUCTO|CUPO_DISPONIBLE|NO_MEDIDOR|LEC_ANT|LEC_ACTUAL|'||
    'CAUSA_N_LEC|CONSUMO|F_CORREC|CONSUMO1|MES1|CONSUMO2|MES2|CONSUMO3|MES3|CONSUMO4|MES4|CONSUMO5|MES5|CONSUMO6|MES6|'||
    'PROM_CONSUMO|TEMPERATURA|PRESION|CONS_KW|CALCULO_CONS|TIPO_NOTI|MENSGNRAL1|FECH_MAXIMA|FECH_SUSP|LIM_INFERIOR1|LIM_SUPERIOR1|'||
    'VALOR_UNIDAD1|RCONSUMO1|VAL_CONSUMO1|LIM_INFERIOR2|LIM_SUPERIOR2|VALOR_UNIDAD2|RCONSUMO2|VAL_CONSUMO2|LIM_INFERIOR3|'||
    'LIM_SUPERIOR3|VALOR_UNIDAD3|RCONSUMO3|VAL_CONSUMO3|LIM_INFERIOR4|LIM_SUPERIOR4|VALOR_UNIDAD4|RCONSUMO4|VAL_CONSUMO4|'||
    'LIM_INFERIOR5|LIM_SUPERIOR5|VALOR_UNIDAD5|RCONSUMO5|VAL_CONSUMO5|LIM_INFERIOR6|LIM_SUPERIOR6|VALOR_UNIDAD6|RCONSUMO6|'||
    'VAL_CONSUMO6|LIM_INFERIOR7|LIM_SUPERIOR7|VALOR_UNIDAD7|RCONSUMO7|VAL_CONSUMO7|COMPCOST|VALORESREF|VALCALC|CODIGO_1|CODIGO_2|'||
    'CODIGO_3|CODIGO_4|CODIGO_BARRAS|TASA_ULTIMA|TASA_PROMEDIO|TOTAL|IVA|SUBTOTAL|CARGOSMES|CANTIDAD_CONC|';*/

    RETURN sbEncabezado;

  END fsbGetEncabezado;
  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fsbGetEncabConc1
  Descripcion :   Obtiene los encabezados.
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
  Fecha               Autor              Modificacion
  =========           =========          ====================
  05-12-2014          ggamarra           Creacion
  **************************************************************************/
  FUNCTION fsbGetEncabConc1 RETURN VARCHAR2 IS
    sbEncabezado VARCHAR2(4000);

  BEGIN

    sbEncabezado := 'DESC_CONCEP1|SALDO_ANT1|CAPITAL1|INTERES1|TOTAL1|SALDO_DIF1|CUOTAS1|DESC_CONCEP2|SALDO_ANT2|CAPITAL2|INTERES2|TOTAL2|SALDO_DIF2|CUOTAS2|DESC_CONCEP3|SALDO_ANT3|CAPITAL3|INTERES3|TOTAL3|SALDO_DIF3|CUOTAS3|DESC_CONCEP4|SALDO_ANT4|CAPITAL4|INTERES4|TOTAL4|SALDO_DIF4|CUOTAS4|' ||
                    'DESC_CONCEP5|SALDO_ANT5|CAPITAL5|INTERES5|TOTAL5|SALDO_DIF5|CUOTAS5|DESC_CONCEP6|SALDO_ANT6|CAPITAL6|INTERES6|TOTAL6|SALDO_DIF6|CUOTAS6|DESC_CONCEP7|SALDO_ANT7|CAPITAL7|INTERES7|TOTAL7|SALDO_DIF7|CUOTAS7|DESC_CONCEP8|SALDO_ANT8|CAPITAL8|INTERES8|TOTAL8|SALDO_DIF8|CUOTAS8|' ||
                    'DESC_CONCEP9|SALDO_ANT9|CAPITAL9|INTERES9|TOTAL9|SALDO_DIF9|CUOTAS9|DESC_CONCEP10|SALDO_ANT10|CAPITAL10|INTERES10|TOTAL10|SALDO_DIF10|CUOTAS10|DESC_CONCEP11|SALDO_ANT11|CAPITAL11|INTERES11|TOTAL11|SALDO_DIF11|CUOTAS11|DESC_CONCEP12|SALDO_ANT12|CAPITAL12|INTERES12|TOTAL12|SALDO_DIF12|CUOTAS12|' ||
                    'DESC_CONCEP13|SALDO_ANT13|CAPITAL13|INTERES13|TOTAL13|SALDO_DIF13|CUOTAS13|DESC_CONCEP14|SALDO_ANT14|CAPITAL14|INTERES14|TOTAL14|SALDO_DIF14|CUOTAS14|DESC_CONCEP15|SALDO_ANT15|CAPITAL15|INTERES15|TOTAL15|SALDO_DIF15|CUOTAS15|DESC_CONCEP16|SALDO_ANT16|CAPITAL16|INTERES16|TOTAL16|SALDO_DIF16|CUOTAS16|' ||
                    'DESC_CONCEP17|SALDO_ANT17|CAPITAL17|INTERES17|TOTAL17|SALDO_DIF17|CUOTAS17|DESC_CONCEP18|SALDO_ANT18|CAPITAL18|INTERES18|TOTAL18|SALDO_DIF18|CUOTAS18|DESC_CONCEP19|SALDO_ANT19|CAPITAL19|INTERES19|TOTAL19|SALDO_DIF19|CUOTAS19|DESC_CONCEP20|SALDO_ANT20|CAPITAL20|INTERES20|TOTAL20|SALDO_DIF20|CUOTAS20|';

    RETURN sbEncabezado;

  END fsbGetEncabConc1;
  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fsbGetEncabConc2
  Descripcion :   Obtiene los encabezados.
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
  Fecha               Autor              Modificacion
  =========           =========          ====================
  05-12-2014          ggamarra           Creacion
  **************************************************************************/
  FUNCTION fsbGetEncabConc2 RETURN VARCHAR2 IS
    sbEncabezado VARCHAR2(4000);

  BEGIN

    sbEncabezado := 'DESC_CONCEP21|SALDO_ANT21|CAPITAL21|INTERES21|TOTAL21|SALDO_DIF21|CUOTAS21|DESC_CONCEP22|SALDO_ANT22|CAPITAL22|INTERES22|TOTAL22|SALDO_DIF22|CUOTAS22|DESC_CONCEP23|SALDO_ANT23|CAPITAL23|INTERES23|TOTAL23|SALDO_DIF23|CUOTAS23|DESC_CONCEP24|SALDO_ANT24|CAPITAL24|INTERES24|TOTAL24|SALDO_DIF24|CUOTAS24|' ||
                    'DESC_CONCEP25|SALDO_ANT25|CAPITAL25|INTERES25|TOTAL25|SALDO_DIF25|CUOTAS25|DESC_CONCEP26|SALDO_ANT26|CAPITAL26|INTERES26|TOTAL26|SALDO_DIF26|CUOTAS26|DESC_CONCEP27|SALDO_ANT27|CAPITAL27|INTERES27|TOTAL27|SALDO_DIF27|CUOTAS27|DESC_CONCEP28|SALDO_ANT28|CAPITAL28|INTERES28|TOTAL28|SALDO_DIF28|CUOTAS28|' ||
                    'DESC_CONCEP29|SALDO_ANT29|CAPITAL29|INTERES29|TOTAL29|SALDO_DIF29|CUOTAS29|DESC_CONCEP30|SALDO_ANT30|CAPITAL30|INTERES30|TOTAL30|SALDO_DIF30|CUOTAS30|DESC_CONCEP31|SALDO_ANT31|CAPITAL31|INTERES31|TOTAL31|SALDO_DIF31|CUOTAS31|DESC_CONCEP32|SALDO_ANT32|CAPITAL32|INTERES32|TOTAL32|SALDO_DIF32|CUOTAS32|' ||
                    'DESC_CONCEP33|SALDO_ANT33|CAPITAL33|INTERES33|TOTAL33|SALDO_DIF33|CUOTAS33|DESC_CONCEP34|SALDO_ANT34|CAPITAL34|INTERES34|TOTAL34|SALDO_DIF34|CUOTAS34|DESC_CONCEP35|SALDO_ANT35|CAPITAL35|INTERES35|TOTAL35|SALDO_DIF35|CUOTAS35|DESC_CONCEP36|SALDO_ANT36|CAPITAL36|INTERES36|TOTAL36|SALDO_DIF36|CUOTAS36|' ||
                    'DESC_CONCEP37|SALDO_ANT37|CAPITAL37|INTERES37|TOTAL37|SALDO_DIF37|CUOTAS37|DESC_CONCEP38|SALDO_ANT38|CAPITAL38|INTERES38|TOTAL38|SALDO_DIF38|CUOTAS38|DESC_CONCEP39|SALDO_ANT39|CAPITAL39|INTERES39|TOTAL39|SALDO_DIF39|CUOTAS39|DESC_CONCEP40|SALDO_ANT40|CAPITAL40|INTERES40|TOTAL40|SALDO_DIF40|CUOTAS40|';

    RETURN sbEncabezado;

  END fsbGetEncabConc2;

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fsbGetEncabConc3
  Descripcion :   Obtiene los encabezados.
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
  Fecha               Autor              Modificacion
  =========           =========          ====================
  05-12-2014          ggamarra           Creacion
  **************************************************************************/

  FUNCTION fsbGetEncabConc3 RETURN VARCHAR2 IS
    sbEncabezado VARCHAR2(4000);

  BEGIN

    sbEncabezado := 'DESC_CONCEP41|SALDO_ANT41|CAPITAL41|INTERES41|TOTAL41|SALDO_DIF41|CUOTAS41|DESC_CONCEP42|SALDO_ANT42|CAPITAL42|INTERES42|TOTAL42|SALDO_DIF42|CUOTAS42|DESC_CONCEP43|SALDO_ANT43|CAPITAL43|INTERES43|TOTAL43|SALDO_DIF43|CUOTAS43|DESC_CONCEP44|SALDO_ANT44|CAPITAL44|INTERES44|TOTAL44|SALDO_DIF44|CUOTAS44|' ||
                    'DESC_CONCEP45|SALDO_ANT45|CAPITAL45|INTERES45|TOTAL45|SALDO_DIF45|CUOTAS45|DESC_CONCEP46|SALDO_ANT46|CAPITAL46|INTERES46|TOTAL46|SALDO_DIF46|CUOTAS46|DESC_CONCEP47|SALDO_ANT47|CAPITAL47|INTERES47|TOTAL47|SALDO_DIF47|CUOTAS47|DESC_CONCEP48|SALDO_ANT48|CAPITAL48|INTERES48|TOTAL48|SALDO_DIF48|CUOTAS48|' ||
                    'DESC_CONCEP49|SALDO_ANT49|CAPITAL49|INTERES49|TOTAL49|SALDO_DIF49|CUOTAS49|DESC_CONCEP50|SALDO_ANT50|CAPITAL50|INTERES50|TOTAL50|SALDO_DIF50|CUOTAS50|DESC_CONCEP51|SALDO_ANT51|CAPITAL51|INTERES51|TOTAL51|SALDO_DIF51|CUOTAS51|DESC_CONCEP52|SALDO_ANT52|CAPITAL52|INTERES52|TOTAL52|SALDO_DIF52|CUOTAS52|' ||
                    'DESC_CONCEP53|SALDO_ANT53|CAPITAL53|INTERES53|TOTAL53|SALDO_DIF53|CUOTAS53|DESC_CONCEP54|SALDO_ANT54|CAPITAL54|INTERES54|TOTAL54|SALDO_DIF54|CUOTAS54|DESC_CONCEP55|SALDO_ANT55|CAPITAL55|INTERES55|TOTAL55|SALDO_DIF55|CUOTAS55|DESC_CONCEP56|SALDO_ANT56|CAPITAL56|INTERES56|TOTAL56|SALDO_DIF56|CUOTAS56|' ||
                    'DESC_CONCEP57|SALDO_ANT57|CAPITAL57|INTERES57|TOTAL57|SALDO_DIF57|CUOTAS57|DESC_CONCEP58|SALDO_ANT58|CAPITAL58|INTERES58|TOTAL58|SALDO_DIF58|CUOTAS58|DESC_CONCEP59|SALDO_ANT59|CAPITAL59|INTERES59|TOTAL59|SALDO_DIF59|CUOTAS59|DESC_CONCEP60|SALDO_ANT60|CAPITAL60|INTERES60|TOTAL60|SALDO_DIF60|CUOTAS60|';

    RETURN sbEncabezado;

  END fsbGetEncabConc3;
  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fsbGetEncabConc4
  Descripcion :   Obtiene los encabezados.
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
  Fecha               Autor              Modificacion
  =========           =========          ====================
  26-02-2018          Daniel Valiente    Se a?adieron los encabezados de Marcas (Visible e Impreso)
  07-09-2016          Sandra Mu?oz       CA200-342. Ubica la unidad operativa antes del cupo brilla
  06-09-2016          Sandra Mu?oz       CA200-342. Se agrega la columna UNIDAD_OPERATIVA
  05-12-2014          ggamarra           Creacion
  **************************************************************************/

  FUNCTION fsbGetEncabConc4 RETURN VARCHAR2 IS
    sbEncabezado VARCHAR2(4000);

  BEGIN

    sbEncabezado := 'DESC_CONCEP61|SALDO_ANT61|CAPITAL61|INTERES61|TOTAL61|SALDO_DIF61|CUOTAS61|DESC_CONCEP62|SALDO_ANT62|CAPITAL62|INTERES62|TOTAL62|SALDO_DIF62|CUOTAS62|DESC_CONCEP63|SALDO_ANT63|CAPITAL63|INTERES63|TOTAL63|SALDO_DIF63|CUOTAS63|DESC_CONCEP64|SALDO_ANT64|CAPITAL64|INTERES64|TOTAL64|SALDO_DIF64|CUOTAS64|' ||
                    'DESC_CONCEP65|SALDO_ANT65|CAPITAL65|INTERES65|TOTAL65|SALDO_DIF65|CUOTAS65|DESC_CONCEP66|SALDO_ANT66|CAPITAL66|INTERES66|TOTAL66|SALDO_DIF66|CUOTAS66|DESC_CONCEP67|SALDO_ANT67|CAPITAL67|INTERES67|TOTAL67|SALDO_DIF67|CUOTAS67|DESC_CONCEP68|SALDO_ANT68|CAPITAL68|INTERES68|TOTAL68|SALDO_DIF68|CUOTAS68|' ||
                    'DESC_CONCEP69|SALDO_ANT69|CAPITAL69|INTERES69|TOTAL69|SALDO_DIF69|CUOTAS69|DESC_CONCEP70|SALDO_ANT70|CAPITAL70|INTERES70|TOTAL70|SALDO_DIF70|CUOTAS70|DESC_CONCEP71|SALDO_ANT71|CAPITAL71|INTERES71|TOTAL71|SALDO_DIF71|CUOTAS71|DESC_CONCEP72|SALDO_ANT72|CAPITAL72|INTERES72|TOTAL72|SALDO_DIF72|CUOTAS72|' ||
                    'DESC_CONCEP73|SALDO_ANT73|CAPITAL73|INTERES73|TOTAL73|SALDO_DIF73|CUOTAS73|DESC_CONCEP74|SALDO_ANT74|CAPITAL74|INTERES74|TOTAL74|SALDO_DIF74|CUOTAS74|DESC_CONCEP75|SALDO_ANT75|CAPITAL75|INTERES75|TOTAL75|SALDO_DIF75|CUOTAS75|DESC_CONCEP76|SALDO_ANT76|CAPITAL76|INTERES76|TOTAL76|SALDO_DIF76|CUOTAS76|' ||
                    'DESC_CONCEP77|SALDO_ANT77|CAPITAL77|INTERES77|TOTAL77|SALDO_DIF77|CUOTAS77|DESC_CONCEP78|SALDO_ANT78|CAPITAL78|INTERES78|TOTAL78|SALDO_DIF78|CUOTAS78|VISIBLE|IMPRESO|';
    RETURN sbEncabezado;

  END fsbGetEncabConc4;

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fnuGetProducto
  Descripcion :   Obtiene el producto asociado al contrato
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
  Fecha               Autor              Modificacion
  =========           =========          ====================
  11-11-2014          ggamarra           Creacion
  **************************************************************************/
  FUNCTION fnuGetProducto(inuFactura IN factura.factcodi%TYPE) RETURN NUMBER IS
    nuSesunuse servsusc.sesunuse%TYPE;
  BEGIN
    -- Inicialmente se consulta si tiene producto de GAS
    BEGIN
      SELECT sesunuse
        INTO nuSesunuse
        FROM servsusc, cuencobr
       WHERE sesunuse = cuconuse
         AND cucofact = inuFactura
         AND sesuserv = dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS')
         AND ROWNUM = 1;
    EXCEPTION
      WHEN no_data_found THEN
        nuSesunuse := -1;
    END;

    -- Si no tiene producto de GAS se selecciona cualquier producto del contrato
    IF (nuSesunuse = -1) THEN
      BEGIN

        SELECT cuconuse
          INTO nusesunuse
          FROM cuencobr
         WHERE cucofact = inuFactura
           AND ROWNUM = 1;

      EXCEPTION
        WHEN no_data_found THEN
          nuSesunuse := 0;
      END;
    END IF;

    RETURN nuSesunuse;
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END fnuGetProducto;

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fnuFechaSuspension
  Descripcion :   Obtiene la fecha de suspension
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
  Fecha               Autor              Modificacion
  =========           =========          ====================
  11-11-2014          ggamarra           Creacion
  **************************************************************************/
  FUNCTION fnuFechaSuspension(nuProducto  IN servsusc.sesunuse%TYPE,
                              nuCategoria IN servsusc.sesucate%TYPE)
    RETURN NUMBER IS
    nuCuentaSaldo NUMBER;
    nuDifeSaldo   NUMBER;
    nuSuspende    NUMBER;

  BEGIN

    SELECT /*+ index(cuencobr IX_CUENCOBR03)*/
     COUNT(1)
      INTO nuCuentaSaldo
      FROM CUENCOBR c
     WHERE c.cuconuse = nuProducto
       AND c.cucosacu > 0;

    SELECT COUNT(1)
      INTO nuDifeSaldo
      FROM diferido
     WHERE difenuse = nuProducto
       AND difesape > 0
       AND difeprog = 'GCNED';

    -- Si Es residencial
    IF (nuCategoria = 1 AND nuCuentaSaldo > 1) OR (nuDifeSaldo > 0) OR
       (nuCategoria != 1) THEN
      nuSuspende := 1;
    ELSE
      nuSuspende := 0;
    END IF;

    RETURN nuSuspende;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END fnuFechaSuspension;
  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuMesesDeuda
  Descripcion    : funci?n para obtener los meses con deuda del contrato.
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================
  inuSusccodi          contrato

  Fecha             Autor             Modificacion
  =========       =========           ====================
  14/05/2015      Slemus             Se modifica la consulta agregando los valores
                                     en reclamo, ya que el saldo real de la cuenta
                                     debe tenerlos en cuenta.
  11/11/2014      ggamarra           Creacion.
  ******************************************************************/
  FUNCTION fnumesesdeuda(inususccodi suscripc.susccodi%TYPE) RETURN NUMBER IS

    numesesdeuda NUMBER;

  BEGIN

    SELECT MAX(cuentas)
      INTO numesesdeuda
      FROM (SELECT sesunuse, COUNT(1) cuentas
              FROM cuencobr, servsusc
             WHERE cuconuse = sesunuse
               AND sesususc = inususccodi
               AND (nvl(cucosacu, 0) - nvl(cucovare, 0) - nvl(cucovrap, 0)) > 0
             GROUP BY sesunuse);

    RETURN numesesdeuda;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END fnumesesdeuda;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fblNoRegulado
  Descripcion    : funci?n para obtener si el contrato es regulado o no.
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================
  inuSusccodi          contrato

  Fecha             Autor             Modificacion
  =========       =========           ====================
  13/11/2014      ggamarra           Creacion.
  ******************************************************************/
  FUNCTION fblNoRegulado(inuSusccodi suscripc.susccodi%TYPE) RETURN BOOLEAN IS

    nuCategori  NUMBER;
    sbParameter ld_parameter.value_chain%TYPE := dald_parameter.fsbGetValue_Chain('CATEG_IDUSTRIA_NO_REG');

  BEGIN

    SELECT sesucate
      INTO nuCategori
      FROM servsusc
     WHERE sesususc = inuSusccodi
       AND rownum = 1;

    IF instr('|' || sbParameter || '|', '|' || nuCategori || '|') > 0 THEN

      RETURN TRUE;
    END IF;

    RETURN FALSE;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN FALSE;

  END fblNoRegulado;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfDatosGenerales
  Descripcion    : Procedimiento para extraer los campos relacionados
                   con los datos generales de la factura.
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  11-11-2016      Sandra Mu?oz        CA 200-849. Se elimina del cursor referenciado la observacion
                                      de no lectura consecutiva
  19-08-2016      Sandra Mu?oz        CA 200-342.
                                        * Se obtienen los datos a presentar basados en el servicio de
                                        gas
                                        * Se imprime en el spool la ruta de lectura
  01/06/2015      Agordilllo          Modificacion Cambio.7524
                                      Se agrega la logica de insercion en la tabla LD_CUPON_CAUSAL
                                      de acuerdo al requerimiento 173 de Cobro de Duplicado
                                      Se valida si se esta generando una solicitud de duplicado y si
                                      la causal es de cobro.
  11/11/2014      ggamarra           Creacion.
  ******************************************************************/
  PROCEDURE RfDatosGenerales(orfcursor OUT constants.tyRefCursor) IS
    sbFactcodi  ge_boInstanceControl.stysbValue;
    sbFactsusc  ge_boInstanceControl.stysbValue;
    blNRegulado BOOLEAN;

    nucausaldecobro NUMBER := 0; -- Agordillo Cambio.7524
    sbCuponume      NUMBER; -- Agordillo Cambio.7524

    -- Agordillo Cambio.7524
    CURSOR cucausaldecobro(nucausal_id NUMBER) IS
      SELECT COUNT(1)
        FROM dual
       WHERE nucausal_id IN
             ((SELECT to_number(column_value)
                FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CAUSALES_COBRO_DUPLICADO',
                                                                                         NULL),
                                                        ','))));

    rcLD_Cupon_Causal   daLD_Cupon_Causal.styLD_Cupon_Causal; -- Agordillo Cambio.7524
    nuProductoPrincipal servsusc.sesunuse%TYPE; -- CA 200-342.
    nuRutaReparto       NUMBER; -- Ruta CA 200-342

  BEGIN
    -- Obtiene el identificador de la factura instanciada
    sbFactcodi  := obtenervalorinstancia('FACTURA', 'FACTCODI');
    sbFactsusc  := obtenervalorinstancia('FACTURA', 'FACTSUSC');
    blNRegulado := fblNoRegulado(sbFactsusc);

    -- Inicio Agordillo Cambio.7524
    -- Inicio Paulaag RQ 173
    -- Obtiene el cupon instanciado
    sbCuponume       := PKBOBILLPRINTHEADERRULES.FSBGETCOUPON;
    glCupon_Cupon_id := sbCuponume;

    ut_trace.trace('-- PASO 3. [] RfDatosGenerales sbFactcodi: ' ||
                   sbFactcodi,
                   15);
    ut_trace.trace('-- PASO 4. [] RfDatosGenerales sbPackage_type_id: ' ||
                   glPackage_type_Cupon_id,
                   15);
    ut_trace.trace('-- PASO 5. [] RfDatosGenerales sbCausal_id: ' ||
                   glCausal_Cupon_id,
                   15);

    -- Si se genero en la solicitud de Estado de Cuenta, adicione el cobro por duplicado.
    IF glPackage_type_Cupon_id = 100006 THEN
      ut_trace.trace('-- PASO 6.[] glPackage_type_Cupon_id: ' ||
                     glPackage_type_Cupon_id,
                     15);

      -- Obtiene si la causal genera cobro.
      OPEN cucausaldecobro(glCausal_Cupon_id);
      FETCH cucausaldecobro
        INTO nucausaldecobro;
      CLOSE cucausaldecobro;

      ut_trace.trace('-- PASO 7.[] nucausaldecobro: ' || nucausaldecobro,
                     15);

      IF nucausaldecobro != 0 THEN
        -- Inserta en la entidad LD_CUPON_CAUSAL
        rcLD_Cupon_Causal.cuponume   := glCupon_Cupon_id;
        rcLD_Cupon_Causal.causal_id  := glCausal_Cupon_id;
        rcLD_Cupon_Causal.package_id := glPackage_Cupon_id;

        DALD_CUPON_CAUSAL.insRecord(rcLD_Cupon_Causal);
        ut_trace.trace('-- PASO 8.[] Inserto en LD_CUPON_CAUSAL cuponume: ' ||
                       glCupon_Cupon_id,
                       15);
      END IF;
    END IF;
    -- Fin Paulaag RQ 173
    -- Fin Agordillo Cambio.7524

    IF NOT blNRegulado THEN
      nuProductoPrincipal := fnuProductoPrincipal(sbFactsusc); -- CA200-342
      ---- Se abre el CURSOR a retornar.
      OPEN orfcursor FOR
        SELECT fc.factcodi FACTURA,
               to_char(fc.factfege,
                       'DD/MON/YYYY',
                       'nls_date_language=spanish') FECH_FACT,
               to_char(to_date(PF.PEFAMES || '-' || PF.PEFAANO, 'MM-YYYY'),
                       'MON-YYYY',
                       'nls_date_language=spanish') MES_FACT,
               to_char(to_date(pktblperifact.fnugetmonth(fc.factpefa) || '-' ||
                               pktblperifact.fnugetyear(fc.factpefa),
                               'MM-YYYY'),
                       'MONTH YYYY',
                       'nls_date_language=spanish') PERIODO_FACT,
               CASE
                 WHEN (LDC_BOFORMATOFACTURA.fnuObtNCuentaSaldo(s.sesunuse) > 2) AND
                      (s.sesucate = 1) THEN
                  'INMEDIATO'
                 WHEN (LDC_BOFORMATOFACTURA.fnuObtNCuentaSaldo(s.sesunuse) > 1) AND
                      (s.sesucate != 1) THEN
                  'INMEDIATO'
                 ELSE
                  TO_CHAR(cc.cucofeve, 'DD/MM/YYYY')
               END PAGO_HASTA,
               TO_CHAR(round(pc.pecsfecf - pc.pecsfeci)) DIAS_CONSUMO,
               b.susccodi CONTRATO,
               PKBOBILLPRINTHEADERRULES.FSBGETCOUPON() CUPON,
               a.subscriber_name || ' ' || a.subs_last_name NOMBRE,
               ca.address_parsed DIRECCION_COBRO,
               dage_geogra_location.fsbgetdescription(ca.geograp_location_id) ||
               ' - ' || substr(dage_geogra_location.fsbgetdescription(dage_geogra_location.fnugetgeo_loca_father_id(ca.geograp_location_id)),
                               0,
                               3) LOCALIDAD,
               open.pktblcategori.fsbgetdescription(s.sesucate) CATEGORIA,
               pktblsubcateg.fsbgetdescription(s.sesucate, s.sesusuca) ESTRATO,
               b.susccicl CICLO,
               nvl(fsbRutaReparto(inuProducto => s.sesunuse),
                   ab.route_id ||
                   daab_premise.fnugetconsecutive(ca.estate_number)) RUTA, -- ca200-342
               fnuMesesDeuda(fc.factsusc) MESES_DEUDA,
               cc.cucocodi NUM_CONTROL,
               TO_CHAR(pc.pecsfeci, 'DD/MON') || ' - ' ||
               to_char(pc.pecsfecf, 'DD/MON') PERIODO_CONSUMO,
               TO_CHAR(b.suscsafa, 'FM999,999,999,990') SALDO_FAVOR,
               NULL SALDO_ANT,
               CASE
                 WHEN (LDC_DetalleFact_GasCaribe.fnuFechaSuspension(s.sesunuse,
                                                                    s.sesucate) = 1) THEN
                  TO_CHAR(pefaffpa, 'DD/MM/YYYY')
                 ELSE
                  ''
               END FECHA_SUSPENSION,
               (SELECT SUM(cucovare + cucovrap)
                  FROM cuencobr, servsusc
                 WHERE cuconuse = sesunuse
                   AND sesususc = fc.factsusc) VALOR_RECL,
               TO_CHAR((SELECT ROUND(cupovalo)
                         FROM cupon
                        WHERE cuponume =
                              PKBOBILLPRINTHEADERRULES.FSBGETCOUPON()),
                       'FM999,999,999,990') TOTAL_FACTURA,
               TO_CHAR(cc.cucofeve, 'DD/MM/YYYY') PAGO_SIN_RECARGO,
               NULL CONDICION_PAGO,
               NULL IDENTIFICA,
               NULL SERVICIO
          FROM open.factura       fc,
               open.cuencobr      cc,
               open.suscripc      b,
               open.servsusc      s,
               open.ge_subscriber a,
               open.perifact      pf,
               open.pericose      pc,
               open.ab_address    ca,
               open.ab_segments   ab
         WHERE fc.factcodi = sbFactcodi
           AND fc.factcodi = cc.cucofact
           AND fc.factsusc = b.susccodi
           AND b.susccodi = s.sesususc
           AND a.subscriber_id = b.suscclie
           AND pf.pefacodi = fc.factpefa
           AND pc.pecscons =
               open.LDC_BOFORMATOFACTURA.fnuObtPerConsumo(pf.pefacicl,
                                                          pf.pefacodi)
           AND b.susciddi = ca.address_id --(+)
           AND pf.pefacodi = fc.factpefa
           AND ca.segment_id = ab.segments_id
           AND sesunuse = nvl(nuProductoPrincipal, sesunuse) -- CA200-342
           AND ROWNUM = 1;
    ELSE
      OPEN orfcursor FOR
        SELECT fc.factcodi FACTURA,
               to_char(fc.factfege,
                       'DD/MON/YYYY',
                       'nls_date_language=spanish') FECH_FACT,
               to_char(to_date(PF.PEFAMES || '-' || PF.PEFAANO, 'MM-YYYY'),
                       'MONTH YYYY',
                       'nls_date_language=spanish') MES_FACT,
               TO_CHAR(pc.pecsfeci, 'DD') || ' AL ' ||
               to_char(pc.pecsfecf, 'DD MONTH', 'nls_date_language=spanish') ||
               ' DEL ' || PEFAANO PERIODO_FACT,
               CASE
                 WHEN (LDC_BOFORMATOFACTURA.fnuObtNCuentaSaldo(s.sesunuse) > 2) AND
                      (s.sesucate = 1) THEN
                  'INMEDIATO'
                 WHEN (LDC_BOFORMATOFACTURA.fnuObtNCuentaSaldo(s.sesunuse) > 1) AND
                      (s.sesucate != 1) THEN
                  'INMEDIATO'
                 ELSE
                  TO_CHAR(cc.cucofeve,
                          'DD/MON/YYYY',
                          'nls_date_language=spanish')
               END PAGO_HASTA,
               NULL DIAS_CONSUMO,
               b.susccodi CONTRATO,
               PKBOBILLPRINTHEADERRULES.FSBGETCOUPON() CUPON,
               a.subscriber_name || ' ' || a.subs_last_name NOMBRE,
               ca.address_parsed || ' ' ||
               dage_geogra_location.fsbgetdescription(ca.geograp_location_id) DIRECCION_COBRO,
               NULL LOCALIDAD, -- Revisar si va el departamento donde se va a guardar
               NULL CATEGORIA,
               NULL ESTRATO,
               NULL CICLO,
               NULL RUTA,
               NULL MESES_DEUDA,
               NULL NUM_CONTROL,
               NULL PERIODO_CONSUMO,
               TO_CHAR(b.suscsafa, 'FM999,999,999,990') SALDO_FAVOR,
               to_char(PKBOBILLPRINTHEADERRULES.FNUGETTOTALPREVIOUSBALANCE,
                       'FM999,999,999,990') SALDO_ANT,
               NULL FECHA_SUSPENSION,
               NULL VALOR_RECL,
               TO_CHAR((SELECT ROUND(cupovalo)
                         FROM cupon
                        WHERE cuponume =
                              PKBOBILLPRINTHEADERRULES.FSBGETCOUPON()),
                       'FM999,999,999,990') TOTAL_FACTURA,
               TO_CHAR(cc.cucofeve, 'DD/MM/YYYY') PAGO_SIN_RECARGO,
               'CONTADO' CONDICION_PAGO,
               a.identification IDENTIFICA,
               'NO REGULADO' SERVICIO
          FROM open.factura       fc,
               open.cuencobr      cc,
               open.suscripc      b,
               open.servsusc      s,
               open.ge_subscriber a,
               open.perifact      pf,
               open.pericose      pc,
               open.ab_address    ca,
               open.ab_segments   ab
         WHERE fc.factcodi = sbFactcodi
           AND fc.factcodi = cc.cucofact
           AND fc.factsusc = b.susccodi
           AND b.susccodi = s.sesususc
           AND a.subscriber_id = b.suscclie
           AND pf.pefacodi = fc.factpefa
           AND pc.pecscons =
               open.LDC_BOFORMATOFACTURA.fnuObtPerConsumo(pf.pefacicl,
                                                          pf.pefacodi)
           AND b.susciddi = ca.address_id --(+)
           AND pf.pefacodi = fc.factpefa
           AND ca.segment_id = ab.segments_id
           AND ROWNUM = 1;
    END IF;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END RfDatosGenerales;

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :  fnuLecturaAnterior
  Descripcion :  Obtiene la lectura anterior dado el producto y periodo de facturacion
  Autor       : Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  07-10-2015          Mmejia                Modificacion ARA.8800
                                            Se modifica para que  valide si la lectura
                                            que existe como lectura anterior es diferente
                                            a la observacion NULL o -1 , dado este caso
                                            se retorna NULL.
  12-06-2015          Agordillo             Modificacion Caso.7524
                                            Se modifica la forma de obtener la lectura anterior.
                                            * Se consulta la fecha de la lectura del periodo de facturacion que se esta procesando
                                            * Se agrega la condicion leemfele < dtFechaPefa, para que se consulte las lecturas
                                            anteriores a la fecha de la lectura del periodo de facturacion que se esta procesando.
  13-11-2014          ggamarra              Creacion.
  **************************************************************************/
  FUNCTION fnuLecturaAnterior(inusesunuse    IN servsusc.sesunuse%TYPE,
                              inuPeriodoFact IN perifact.pefacodi%TYPE)
    RETURN NUMBER IS
    nuLectAnterior lectelme.leemleto%TYPE;
    dtFechaPefa    lectelme.leemfele%TYPE;

  BEGIN
    ut_trace.trace('INICIA LDC_DetalleFact_GasCaribe.fnuLecturaAnterior',
                   15);
    ut_trace.trace('LDC_DetalleFact_GasCaribe.fnuLecturaAnterior inuPeriodoFact ' ||
                   inuPeriodoFact,
                   15);

    -- Inicio Agordillo Modificacion Caso.7524
    -- Se consulta la fecha de lectura del periodo de facturacion actual que se esta procesando
    BEGIN
      SELECT Trunc(leemfele)
        INTO dtFechaPefa
        FROM open.lectelme
       WHERE leemsesu = inusesunuse
         AND leemclec = 'F'
         AND leempefa = inuPeriodoFact
         AND ROWNUM = 1;
    EXCEPTION
      WHEN No_Data_Found THEN
        dtFechaPefa := Trunc(SYSDATE);
    END;
    -- Fin Agordillo Modificacion Caso.7524

    BEGIN
      SELECT leemleto
        INTO nuLectAnterior
        FROM (SELECT
              --ARA.8800
              --07-10-2015
              --Mmejia
              --Se modifica el cursor para que valida si la lectura
              --tiene un observacion de lectura diferente de NULL
              --y -1 si es el caso se pone en NULL esta lectura
               CASE
                 WHEN Nvl(leemobsb, -2) NOT IN (-2, -1) THEN
                  NULL
                 ELSE
                  leemleto
               END leemleto,
               leempefa
                FROM OPEN.lectelme
               WHERE leemsesu = inusesunuse
                 AND leemclec = 'F'
                 AND leempefa != inuPeriodoFact
                 AND leemfele < dtFechaPefa -- Agordillo Modificacion Caso.7524
               ORDER BY leemfele DESC)
       WHERE ROWNUM = 1;

    EXCEPTION
      WHEN No_Data_Found THEN
        nuLectAnterior := NULL;
    END;

    ut_trace.trace('FIN LDC_DetalleFact_GasCaribe.fnuLecturaAnterior', 15);
    RETURN nuLectAnterior;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      nuLectAnterior := NULL;
    WHEN OTHERS THEN
      Errors.setError;
      nuLectAnterior := NULL;
  END fnuLecturaAnterior;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfDatosLecturas
  Descripcion    : Procedimiento para extraer los datos relacionados
                   con las lecturas
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos de las lecturas.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  01-03-2015      Llozada            Se modifica la l?gica ya que se estaban enviando trocadas la
                                     lectura anterior con la actual.
  11/11/2014      ggamarra           Creacion.
  ******************************************************************/
  PROCEDURE RfDatosLecturas(orfcursor OUT constants.tyRefCursor) AS
    sbFactcodi  ge_boInstanceControl.stysbValue;
    sbFactsusc  ge_boInstanceControl.stysbValue;
    blNRegulado BOOLEAN;
    nuSesunuse  servsusc.sesunuse%TYPE;

    LECTURA_ANTERIOR NUMBER;
    LECTURA_ACTUAL   NUMBER;
    NUM_MEDIDOR      VARCHAR2(50);
    OBS_LECTURA      VARCHAR2(100);

  BEGIN

    sbFactcodi  := obtenervalorinstancia('FACTURA', 'FACTCODI');
    sbFactsusc  := obtenervalorinstancia('FACTURA', 'FACTSUSC');
    blNRegulado := fblNoRegulado(sbFactsusc);
    nuSesunuse  := fnuGetProducto(sbFactcodi);

    BEGIN

      IF NOT blNRegulado THEN
        --01-03-2015 Llozada: Se modifica para que no envie mal las lecturas
        SELECT num_medidor,
               ROUND(SUM(leac), 2) lectura_actual,
               ROUND(SUM(NVL(lean, 0)), 2) lectura_anterior,
               causal_no_lec
          INTO NUM_MEDIDOR, LECTURA_ACTUAL, LECTURA_ANTERIOR, OBS_LECTURA
          FROM (SELECT NVL(leemleto, 0) leac,
                       nvl(fnuLecturaAnterior(sesunuse, factpefa), leemlean) lean, -- elemmedi
                       --(SELECT elmecodi FROM open.elemmedi WHERE elmeidem = leemelme AND ROWNUM = 1) num_medidor,
                       (SELECT emsscoem
                          FROM open.elmesesu
                         WHERE emsssesu = leemsesu
                           AND emssfere > SYSDATE
                           AND rownum = 1) num_medidor,
                       (SELECT obledesc
                          FROM open.OBSELECT
                         WHERE oblecodi = leemoble
                           AND oblecanl = 'S'
                           AND ROWNUM = 1) causal_no_lec
                  FROM open.FACTURA, open.SERVSUSC, open.LECTELME
                 WHERE factcodi = sbFactcodi
                   AND sesususc = factsusc
                   AND sesunuse = nuSesunuse
                   AND leemsesu = sesunuse
                   AND leempefa = factpefa
                   AND leemclec = 'F')
         WHERE ROWNUM = 1
         GROUP BY num_medidor, causal_no_lec;

      ELSE

        NUM_MEDIDOR      := NULL;
        LECTURA_ANTERIOR := NULL;
        LECTURA_ACTUAL   := NULL;
        OBS_LECTURA      := NULL;

      END IF;

    EXCEPTION
      WHEN no_data_found THEN
        NUM_MEDIDOR      := '';
        LECTURA_ANTERIOR := 0;
        LECTURA_ACTUAL   := 0;
        OBS_LECTURA      := ' ';
    END;

    OPEN orfcursor FOR
      SELECT NUM_MEDIDOR      NUM_MEDIDOR,
             LECTURA_ANTERIOR LECTURA_ANTERIOR,
             LECTURA_ACTUAL   LECTURA_ACTUAL,
             OBS_LECTURA      OBS_LECTURA
        FROM dual;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END RfDatosLecturas;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : frfCambioCiclo
  Descripcion    : Permite consultar los ultimos periodos facturados del contrato
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================
  orfcursor            Retorna los datos de los periodos facturados

  Fecha             Autor             Modificacion
  =========       =========           ====================
  11/11/2014      ggamarra           Creacion.
  ******************************************************************/
  FUNCTION frfCambioCiclo(inufactsusc IN NUMBER) RETURN constants.tyRefCursor IS
    ofrPeriodos constants.tyRefCursor;

  BEGIN

    OPEN ofrPeriodos FOR
      SELECT factpefa
        FROM (

              SELECT factpefa, trunc(factfege)
                FROM FACTURA
               WHERE factsusc = inufactsusc
                 AND factprog = 6
               GROUP BY factpefa, factfege
               ORDER BY factfege DESC)
       WHERE ROWNUM < 8;

    RETURN ofrPeriodos;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END frfCambioCiclo;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fsbGetFechaPermmyyyy
  Descripcion    : Permite consultar la fecha del periodo
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================
  orfcursor            Retorna los datos de los periodos facturados

  Fecha             Autor             Modificacion
  =========       =========           ====================
  11/11/2014      ggamarra           Creacion.
  ******************************************************************/

  FUNCTION fsbGetFechaPermmyyyy(inupefacodi IN perifact.pefacodi%TYPE)
    RETURN VARCHAR2 IS
    sbFechaPeriodo VARCHAR2(20);
  BEGIN
    IF (inupefacodi != -1) THEN
      SELECT to_char(to_date(pefames || '/' || pefaano, 'mm/yyyy'),
                     'MON-YY')
        INTO sbFechaPeriodo
        FROM perifact
       WHERE pefacodi = inupefacodi;
    ELSE
      sbFechaPeriodo := '';
    END IF;

    RETURN sbFechaPeriodo;
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      sbFechaPeriodo := '';
    WHEN OTHERS THEN
      Errors.setError;
      sbFechaPeriodo := '';
  END fsbGetFechaPermmyyyy;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuGetConsumoResidencial
  Descripcion    : Permite consultar el consumo residencial
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================
  orfcursor            Retorna los datos de los periodos facturados

  Fecha             Autor             Modificacion
  =========       =========           ====================
  11/11/2014      ggamarra           Creacion.
  ******************************************************************/

  FUNCTION fnuGetConsumoResidencial(inusesunuse IN servsusc.sesunuse%TYPE,
                                    inuPericose IN conssesu.cosspecs%TYPE)
    RETURN NUMBER IS
    nuConsumo conssesu.cosscoca%TYPE;
  BEGIN

    BEGIN
      SELECT cosssuma
        INTO nuConsumo
        FROM open.vw_cmprodconsumptions
       WHERE cosssesu = inusesunuse
         AND cosspecs = inuPericose
         AND rownum = 1;

    EXCEPTION
      WHEN no_data_found THEN
        nuConsumo := 0;
    END;

    RETURN nuConsumo;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      nuConsumo := 0;
    WHEN OTHERS THEN
      nuConsumo := 0;
  END fnuGetConsumoResidencial;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfDatosConsumoHist
  Descripcion    : Procedimiento para extraer los datos relacionados
                   a los consumos historicos
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================
  orfcursor            Retorna los datos consumos historicos.

  Fecha             Autor            Modificacion
  =========       =========          ====================
  13/03/2017      KCienfuegos.CA1081 Se modifican los cursores cucm_vavafacoP y cucm_vavafacoPL
                                     para obtener el valor de la columna vvfcvalo en lugar de la
                                     columna vvfcvapr, de acuerdo a lo cotizado por NLCZ.
  07/10/2015      Mmejia.ARA.8800    Se modifica la funcion modificar el calculo de la conversion
                                     de M3 a Kwh.
  07/09/2015      Spacheco ara8640   Se trabaja con open fetch para identificar la configuracion mas
                                     cercana al dia actual para la temperatura y la presion.
  05/08/2015      Mmejia.ARA.8199    Se modifica la funcion para que el variable sbFactor_correccion sea de tipo
                                     varchar2 no number la varible es sbFactor_correccion
  17/07/2015      Spacheco-ara8209   se modifica para que al identificar un ciclo telemedio el mensaje de calculo de
                                     consumo colocara rtu.
  13-05-2015      Slemus-ARA7263     Se modifica el origen de datos de temperatura y presi?n.
  01-03-2015      Llozada            Se envia el consumo sin multiplicarlo por el factor de correcci?n ya que en
                                     la tabla de consumos est? f?rmula ya est? aplicada.
  11/11/2014      ggamarra           Creacion.
  ******************************************************************/
  PROCEDURE rfdatosconsumohist(orfcursor OUT constants.tyrefcursor) AS

    sbfactsusc ge_boinstancecontrol.stysbvalue;
    sbfactpefa ge_boinstancecontrol.stysbvalue;
    sbfactcodi ge_boinstancecontrol.stysbvalue;

    nuperidocons pericose.pecscons%TYPE;

    consumo_actual      NUMBER;
    cons_correg         NUMBER;
    sbFactor_correccion VARCHAR2(200);
    consumo_mes_1       NUMBER;
    fecha_cons_mes_1    VARCHAR2(10);
    consumo_mes_2       NUMBER;
    fecha_cons_mes_2    VARCHAR2(10);
    consumo_mes_3       NUMBER;
    fecha_cons_mes_3    VARCHAR2(10);
    consumo_mes_4       NUMBER;
    fecha_cons_mes_4    VARCHAR2(10);
    consumo_mes_5       NUMBER;
    fecha_cons_mes_5    VARCHAR2(10);
    consumo_mes_6       NUMBER;
    fecha_cons_mes_6    VARCHAR2(10);
    consumo_promedio    NUMBER;
    supercompres        NUMBER;
    temperatura         NUMBER;
    presion             NUMBER;
    calculo_cons        VARCHAR2(50);
    equival_kwh         VARCHAR2(50);
    nuCategoria         servsusc.sesucate%TYPE;

    par_pod_calor NUMBER := dald_parameter.fnugetnumeric_value('FIDF_POD_CALORIFICO');

    nucicloc    NUMBER;
    nuproduct   NUMBER;
    blnregulado BOOLEAN;
    nugeoloc    ge_geogra_location.geograp_location_id%TYPE;
    vnucite     NUMBER;

    --declaracion de cursores
    CURSOR cucm_vavafacoP(nuproduct1 IN servsusc.sesunuse%TYPE) IS
      SELECT decode(nuCategoria, cnuCategoriaInd, vvfcvalo, vvfcvapr) presion
        FROM open.cm_vavafaco
       WHERE vvfcsesu = nuproduct1
         AND vvfcfefv >= trunc(SYSDATE)
         AND vvfcvafc = 'PRESION_OPERACION'
       ORDER BY vvfcfefv ASC;

    CURSOR cucm_vavafacoPL(nugeoloc1 IN NUMBER) IS
      SELECT decode(nuCategoria, cnuCategoriaInd, vvfcvalo, vvfcvapr) presion
        FROM open.cm_vavafaco
       WHERE vvfcfefv >= trunc(SYSDATE)
         AND vvfcvafc = 'PRESION_OPERACION'
         AND vvfcubge = nugeoloc1
       ORDER BY vvfcfefv ASC;

    CURSOR cucm_vavafacoPt(nuproduct1 IN servsusc.sesunuse%TYPE) IS
      SELECT vvfcvapr
        FROM open.cm_vavafaco
       WHERE vvfcsesu = nuproduct1
         AND vvfcfefv >= trunc(SYSDATE)
         AND vvfcvafc = 'TEMPERATURA'
       ORDER BY vvfcfefv ASC;

    CURSOR cucm_vavafacotL(nugeoloc1 IN NUMBER) IS
      SELECT vvfcvapr
        FROM open.cm_vavafaco
       WHERE vvfcfefv >= trunc(SYSDATE)
         AND vvfcvafc = 'TEMPERATURA'
         AND vvfcubge = nugeoloc1
       ORDER BY vvfcfefv ASC;

    -- Obtiene los historicos de consumo
    PROCEDURE gethistoricos(nucontrato IN NUMBER,
                            nuproducto IN NUMBER,
                            nuciclo    IN NUMBER,
                            nuperiodo  IN NUMBER) AS
      TYPE tytbperiodos IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;

      tbperconsumo tytbperiodos;
      tbperfactura tytbperiodos;

      tbperiodos tytbperiodos;
      frperiodos constants.tyrefcursor;

      nuperfactactual perifact.pefacodi%TYPE;
      nuperfactprev   perifact.pefacodi%TYPE;
      nuperconsprev   pericose.pecscons%TYPE;
      sbperiodos      VARCHAR2(100) := '';
      contador        NUMBER := 1;
      periodo         NUMBER;
      consumo         NUMBER;
      nuciclof        NUMBER;

      CURSOR cuconsumo(nuproducto NUMBER, tbperi tytbperiodos) IS
        SELECT SUM(c_1) consumo_1,
               SUM(c_2) consumo_2,
               SUM(c_3) consumo_3,
               SUM(c_4) consumo_4,
               SUM(c_5) consumo_5,
               SUM(c_6) consumo_6
          FROM (SELECT CASE
                         WHEN pecscons = tbperi(1) THEN
                          SUM(cosssuma)
                       END c_1,
                       CASE
                         WHEN pecscons = tbperi(2) THEN
                          SUM(cosssuma)
                       END c_2,
                       CASE
                         WHEN pecscons = tbperi(3) THEN
                          SUM(cosssuma)
                       END c_3,
                       CASE
                         WHEN pecscons = tbperi(4) THEN
                          SUM(cosssuma)
                       END c_4,
                       CASE
                         WHEN pecscons = tbperi(5) THEN
                          SUM(cosssuma)
                       END c_5,
                       CASE
                         WHEN pecscons = tbperi(6) THEN
                          SUM(cosssuma)
                       END c_6
                  FROM open.vw_cmprodconsumptions -- pericose
                 WHERE cosssesu = nuproducto
                   AND pecscons IN (tbperi(1),
                                    tbperi(2),
                                    tbperi(3),
                                    tbperi(4),
                                    tbperi(5),
                                    tbperi(6))
                 GROUP BY pecscons);

      nupro NUMBER;
      nucat NUMBER;

    BEGIN
      ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist.getHistoricos',
                     15);

      nuciclof := nuciclo;

      -- Periodo de facturacion Actual
      nuperfactactual := nuperiodo; -- obtenervalorinstancia('FACTURA','FACTPEFA');

      -- Obtiene los periodos facturados
      frperiodos := frfcambiociclo(nucontrato);
      FETCH frperiodos BULK COLLECT
        INTO tbperiodos;
      ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos Inicio Obtiene los ultimos 6 periodos facturados',
                     15);
      -- Obtiene los ultimos 6 periodos facturados
      FOR i IN 1 .. 6 LOOP
        -- Periodo de Facturacion Anterior
        BEGIN
          nuperfactprev := pkbillingperiodmgr.fnugetperiodprevious(nuperfactactual);

        EXCEPTION
          WHEN ex.controlled_error THEN
            nuperfactprev := -1;
          WHEN OTHERS THEN
            nuperfactprev := -1;
        END;

        -- Se valida si el periodo obtenido es igual al facturado si no es igual, es por
        -- que el cliente cambio de ciclo
        IF (tbperiodos.exists(i + 1)) AND
           (tbperiodos(i + 1) != nuperfactprev) THEN
          nuperfactprev := tbperiodos(i + 1);
          nuciclof      := pktblperifact.fnugetcycle(nuperfactprev);
        END IF;

        -- Periodo de consumo Anterior
        BEGIN
          nuperconsprev := ldc_boformatofactura.fnuobtperconsumo(nuciclof,
                                                                 nuperfactprev);
        EXCEPTION
          WHEN "OPEN".ex.CONTROLLED_ERROR THEN
            nuperconsprev := -1;
          WHEN OTHERS THEN
            nuperconsprev := -1;
        END;

        tbperconsumo(i) := nuperconsprev;
        tbperfactura(i) := nuperfactprev;

        IF (sbperiodos IS NOT NULL) THEN
          sbperiodos := nuperconsprev || ',' || sbperiodos;
        ELSE
          sbperiodos := nuperconsprev;
        END IF;

        --   dbms_output.put_line('i '||i||' periodo Consumo '||nuPerConsPrev||' periodo facturacion '||nuPerFactPrev);
        -- El Anterior queda actual para hayar los anteriores
        nuperfactactual := nuperfactprev;

      END LOOP;
      ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos Fin  Obtiene los ultimos 6 periodos facturados',
                     15);

      ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos Inicio recorre el cursor cuconsumo',
                     15);
      FOR i IN cuconsumo(nuproducto, tbperconsumo) LOOP
        ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_1',
                       15);
        consumo_mes_1 := nvl(i.consumo_1, 0);
        ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_2',
                       15);
        consumo_mes_2 := nvl(i.consumo_2, 0);
        ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_3',
                       15);
        consumo_mes_3 := nvl(i.consumo_3, 0);
        ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_4',
                       15);
        consumo_mes_4 := nvl(i.consumo_4, 0);
        ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_5',
                       15);
        consumo_mes_5 := nvl(i.consumo_5, 0);
        ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_6',
                       15);
        consumo_mes_6 := nvl(i.consumo_6, 0);
      END LOOP;
      ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos Fin recorre el cursor cuconsumo',
                     15);

      -- Hayando meses
      fecha_cons_mes_1 := fsbgetfechapermmyyyy(tbperfactura(1));
      fecha_cons_mes_2 := fsbgetfechapermmyyyy(tbperfactura(2));
      fecha_cons_mes_3 := fsbgetfechapermmyyyy(tbperfactura(3));
      fecha_cons_mes_4 := fsbgetfechapermmyyyy(tbperfactura(4));
      fecha_cons_mes_5 := fsbgetfechapermmyyyy(tbperfactura(5));
      fecha_cons_mes_6 := fsbgetfechapermmyyyy(tbperfactura(6));
      ut_trace.trace('Fin LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist.getHistoricos',
                     15);
    END gethistoricos;

  BEGIN
    ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist',
                   15);
    sbfactcodi  := obtenervalorinstancia('FACTURA', 'FACTCODI');
    sbfactsusc  := obtenervalorinstancia('FACTURA', 'FACTSUSC');
    sbfactpefa  := obtenervalorinstancia('FACTURA', 'FACTPEFA');
    nuproduct   := fnugetproducto(sbfactcodi);
    blnregulado := fblnoregulado(sbfactsusc);
    nuCategoria := pktblservsusc.fnugetcategory(nuproduct);

    IF NOT blnregulado THEN

      BEGIN

        nucicloc := nvl(pktblservsusc.fnugetbillingcycle(nuproduct), -1);

        -- Se obtiene el periodo de consumo actual, dado el periodo de facturacion
        nuperidocons := ldc_boformatofactura.fnuobtperconsumo(nucicloc,
                                                              sbfactpefa);

      EXCEPTION
        WHEN OTHERS THEN
          nucicloc     := -1;
          nuperidocons := -1;
      END;

      gethistoricos(sbfactsusc, nuproduct, nucicloc, sbfactpefa);

      ut_trace.trace('LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist Obtener el origen del consumo',
                     15);

      -- Obtener el origen del consumo
      BEGIN

        SELECT decode(cossmecc, 1, 'LEC.MEDIDOR', 'ESTIMADO')
          INTO calculo_cons
          FROM vw_cmprodconsumptions
         WHERE cosssesu = nuproduct
           AND cosspefa = sbfactpefa
           AND cosspecs = nuperidocons;

      EXCEPTION
        WHEN OTHERS THEN
          calculo_cons := NULL;
      END;
      ut_trace.trace('LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist VAlidacion ciclo asociado',
                     15);
      --Spacheco ara:8209 --se valida si el ciclo asociado al usuario esta configurado en el parametro
      --de ciclo de telemedido
      IF calculo_cons IS NOT NULL THEN
        SELECT COUNT(*)
          INTO vnucite
          FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbGetValue_Chain('CICLO_TELEMEDIDOS_GDC'),
                                                  ','))
         WHERE column_value = pktblservsusc.fnugetsesucicl(nuproduct);

        IF vnucite = 1 THEN
          calculo_cons := 'RTU';
        END IF;
      END IF;
      ut_trace.trace('LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist 1 ', 15);
      BEGIN
        /*01-03-2015 Llozada: Se envia el consumo sin multiplicarlo por el factor de correcci?n ya que en
        la tabla de consumos est? f?rmula ya est? aplicada.*/
        SELECT consumo_act,
               to_char(fac_correccion, '0.9999'),
               round(consumo_act),
               supercompres, /*,temperatura,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              presion,*/
               round(consumo_act) || ' M3 Equivalen a ' ||
               --ARA.8800
               --Mmejia
               --07-10-2015
               --Se modifica el calculo de la conversion de M3 a Kwh
               --segun se envio en el FANA debe ser diferencia de lecturas
               --por el facto en el parametro FIDF_POD_CALORIFICO
               --round(par_pod_calor * consumo_act / 3.6, 2) || 'kwh',
                round(par_pod_calor * consumo_act, 2) || 'kwh',
               round((consumo_mes_1 + consumo_mes_2 + consumo_mes_3 +
                     consumo_mes_4 + consumo_mes_5 + consumo_mes_6) / 6) cons_promedio
          INTO consumo_actual,
               sbFactor_correccion,
               cons_correg,
               supercompres,
               equival_kwh,
               consumo_promedio
          FROM (SELECT fnugetconsumoresidencial(MAX(sesunuse), MAX(cosspecs)) consumo_act,
                       MAX(fccofaco) fac_correccion,
                       MAX(fccofasc) supercompres,
                       /* max(fccofate) temperatura,
                       max(fccofapr) presion,*/
                       MAX(fccofapc) * MAX(fccofaco) poder_calor
                  FROM factura f
                 INNER JOIN servsusc s
                    ON (sesususc = factsusc AND
                       sesuserv =
                       dald_parameter.fnugetnumeric_value('COD_SERV_GAS'))
                  LEFT OUTER JOIN conssesu c
                    ON (c.cosssesu = s.sesunuse AND c.cosspefa = f.factpefa AND
                       cossmecc = 4)
                  LEFT OUTER JOIN cm_facocoss
                    ON (cossfcco = fccocons)
                 WHERE factcodi = sbfactcodi),
               perifact
         WHERE pefacodi = sbfactpefa;

        ut_trace.trace('LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist 2 ',
                       15);
        BEGIN
          nugeoloc := daab_address.fnugetgeograp_location_id(dapr_product.fnugetaddress_id(nuproduct,
                                                                                           0),
                                                             0);
        END;
        ut_trace.trace('LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist 3',
                       15);

        /*SPacheco Ara 8640 se trabaja con open fetch para identificar la configuracion mas
        cerca al dia del proceso*/
        --se consulta presion

        OPEN cucm_vavafacoP(nuproduct);
        FETCH cucm_vavafacoP
          INTO presion;
        IF cucm_vavafacoP%NOTFOUND THEN

          ------si no existe configuracion de presion para el producto se consulta por localidad
          OPEN cucm_vavafacoPl(nugeoloc);
          FETCH cucm_vavafacoPl
            INTO presion;
          IF cucm_vavafacoPl%NOTFOUND THEN
            presion := 0;

          END IF;
          CLOSE cucm_vavafacoPl;
          ------
        END IF;
        CLOSE cucm_vavafacoP;

        ut_trace.trace('LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist 4',
                       15);
        /*SPacheco Ara 8640 se trabaja con open fetch para identificar la configuracion mas
        cerca al dia del proceso*/
        --se consulta la temperatura configurada por el producto
        OPEN cucm_vavafacoPt(nuproduct);
        FETCH cucm_vavafacoPt
          INTO temperatura;
        IF cucm_vavafacoPt%NOTFOUND THEN

          ------si no posee configuracion de temperatura por producto consulta por localidad

          OPEN cucm_vavafacotl(nugeoloc);
          FETCH cucm_vavafacotl
            INTO temperatura;
          IF cucm_vavafacotl%NOTFOUND THEN
            temperatura := 0;

          END IF;
          CLOSE cucm_vavafacotl;
          ------
        END IF;
        CLOSE cucm_vavafacoPt;

        /*01-03-2015 Llozada: Se comenta ya que est? calculando mal el consumo, lo esta multiplicando
        2 veces por el factor de correcci?n*/
        /*select consumo_act,
                to_char(fac_correccion,'0.9999'), round(consumo_act*fac_correccion),
                supercompres,temperatura,
                presion, round(consumo_act)||' M3 Equivalen a '||round(PAR_POD_CALOR*consumo_act/3.6,2)||'kwh',
                round((CONSUMO_MES_1+CONSUMO_MES_2+CONSUMO_MES_3+CONSUMO_MES_4+CONSUMO_MES_5+CONSUMO_MES_6)/6) CONS_PROMEDIO
         into  CONSUMO_ACTUAL,FACTOR_CORRECCION,CONS_CORREG,SUPERCOMPRES,TEMPERATURA,PRESION,EQUIVAL_KWH ,CONSUMO_PROMEDIO
        from
         (select fnuGetConsumoResidencial(max(sesunuse),max(cosspecs)) consumo_act,
                 max(fccofaco) fac_correccion,
                 max(fccofasc) supercompres,
                 max(fccofate) temperatura,
                 max(fccofapr) presion,
                 max(fccofapc)*max(fccofaco) poder_calor
             FROM factura f inner join servsusc s
                 on (sesususc = factsusc and sesuserv=dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS'))
                 LEFT OUTER JOIN conssesu c
                 ON (c.cosssesu = s.sesunuse
                 and c.cosspefa = f.factpefa
                 AND cossmecc=4)
                 left outer join cm_facocoss on (cossfcco=fccocons)
             WHERE  factcodi = sbFactcodi ), perifact
             where pefacodi=sbFactpefa;*/

      EXCEPTION
        WHEN no_data_found THEN

          consumo_actual      := 0;
          sbFactor_correccion := '0';
          consumo_mes_1       := 0;
          fecha_cons_mes_1    := ' ';
          consumo_mes_2       := 0;
          fecha_cons_mes_2    := ' ';
          consumo_mes_3       := 0;
          fecha_cons_mes_3    := ' ';
          consumo_mes_4       := 0;
          fecha_cons_mes_4    := ' ';
          consumo_mes_5       := 0;
          fecha_cons_mes_5    := ' ';
          consumo_mes_6       := 0;
          fecha_cons_mes_6    := ' ';
          consumo_promedio    := 0;
          supercompres        := 0;
          temperatura         := 0;
          presion             := 0;
          cons_correg         := 0;
          calculo_cons        := ' ';
          equival_kwh         := ' ';

      END;
      -- Si es no regulado no muestra datos
    ELSE
      consumo_actual      := NULL;
      sbFactor_correccion := NULL;
      consumo_mes_1       := NULL;
      fecha_cons_mes_1    := NULL;
      consumo_mes_2       := NULL;
      fecha_cons_mes_2    := NULL;
      consumo_mes_3       := NULL;
      fecha_cons_mes_3    := NULL;
      consumo_mes_4       := NULL;
      fecha_cons_mes_4    := NULL;
      consumo_mes_5       := NULL;
      fecha_cons_mes_5    := NULL;
      consumo_mes_6       := NULL;
      fecha_cons_mes_6    := NULL;
      consumo_promedio    := NULL;
      supercompres        := NULL;
      temperatura         := NULL;
      presion             := NULL;
      cons_correg         := NULL;
      equival_kwh         := NULL;
      calculo_cons        := NULL;

    END IF;

    OPEN orfcursor FOR
      SELECT cons_correg         cons_correg,
             sbFactor_correccion factor_correccion,
             consumo_mes_1       consumo_mes_1,
             fecha_cons_mes_1    fecha_cons_mes_1,
             consumo_mes_2       consumo_mes_2,
             fecha_cons_mes_2    fecha_cons_mes_2,
             consumo_mes_3       consumo_mes_3,
             fecha_cons_mes_3    fecha_cons_mes_3,
             consumo_mes_4       consumo_mes_4,
             fecha_cons_mes_4    fecha_cons_mes_4,
             consumo_mes_5       consumo_mes_5,
             fecha_cons_mes_5    fecha_cons_mes_5,
             consumo_mes_6       consumo_mes_6,
             fecha_cons_mes_6    fecha_cons_mes_6,
             consumo_promedio    consumo_promedio,
             temperatura         temperatura,
             presion             presion,
             equival_kwh         equival_kwh,
             calculo_cons        calculo_cons
        FROM dual;
    ut_trace.trace('Fin LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist', 15);
  EXCEPTION
    WHEN ex.controlled_error THEN
      RAISE ex.controlled_error;
    WHEN OTHERS THEN
      errors.seterror;
      RAISE ex.controlled_error;
  END rfdatosconsumohist;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfDatosRevision
  Descripcion    : Procedimiento para extraer los campos relacionados
                   con los datos del medidor.
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================
  orfcursor            Retorna los datos de las fechas de revision

  Fecha           Autor               Modificacion
  =========       =========           ====================
  13/03/2017      KCienfuegos        CA200-1081: Se crea el cursor cuObtProductoGas para obtener el producto de gas
                                     del contrato asociado a la factura.
  20/08/2016      Sandra Mu?oz       CA 200-342. Imprime fecha de suspension INMEDIATO si la fecha
                                       de revision es menor que la fecha del sistema
  20/03/2015      agordillo          Modificacion Incidente.140493
                                     * Se modifica las fechas para los usuarios de tipo de notificacion 3, lo cuales
                                     se encuentran en el mes 59
                                     se actualiza la fecha FECH_SUSP por la fecha que devuelve la funcion LDC_GETFECHAMAXIMARP,
                                     la cual contempla la logica de restar de la fecha maxima, los 5 dias configurados
                                     en parametro NUM_DIAS_NOTIFICAR_RP
                                     Se actualiza la fecha FECH_MAXIMA por la consulta al campo plazo_maximo de la tabla
                                     LDC_PLAZOS_CERT
  11/11/2014      ggamarra           Creacion.
  ******************************************************************/

  PROCEDURE RfDatosRevision(orfcursor OUT constants.tyRefCursor) IS
    sbFactcodi      ge_boInstanceControl.stysbValue;
    FECH_MAXIMA     VARCHAR2(50);
    FECH_SUSP       VARCHAR2(50);
    TIPO_NOTI       NUMBER;
    MENS_NOTI       VARCHAR2(2000);
    nuMesesRevision NUMBER := dald_parameter.fnuGetNumeric_Value('LDC_MESES_VALIDEZ_CERT');
    nuEdadProd      NUMBER(4);
    nuProducto      NUMBER;
    csbMensajeA     VARCHAR2(2000) := 'La Revision Periodica debe Realizarse con Organismos de Inspeccion Acreditados.';
    csbMensajeD     VARCHAR2(2000) := 'Solicite la Revision Periodica con un Organismo de Inspeccion Acreditado y/o distribuidor y siga disfrutando del servicio de Gas.';

    CURSOR cuEdad(producto_id LDC_PLAZOS_CERT.id_producto%TYPE,
                  nuMesesCert NUMBER) IS
      SELECT nuMesesCert -
             months_between(trunc(to_date(nvl(plazo_maximo,
                                              sesufein +
                                              nuMesesCert * 365 / 12)),
                                  'MONTH'),
                            trunc(SYSDATE, 'MONTH'))
        FROM LDC_PLAZOS_CERT, servsusc
       WHERE id_producto = producto_id
         AND sesunuse = id_producto;

    CURSOR cuObtProductoGas(nuFactura NUMBER) IS
      SELECT sesunuse
        FROM open.factura f, open.servsusc p
       WHERE f.factsusc = p.sesususc
         AND f.factcodi = nuFactura
         AND p.sesuserv =
             dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS');

  BEGIN
    -- Obtiene el identificador de la factura instanciada
    sbFactcodi := obtenervalorinstancia('FACTURA', 'FACTCODI');

    -- Se obtiene el producto gas asociado al contrato de la factura CA200-1081
    IF (fblaplicaentrega(csbEntrega2001081)) THEN
      OPEN cuObtProductoGas(sbFactcodi);
      FETCH cuObtProductoGas
        INTO nuProducto;
      CLOSE cuObtProductoGas;
    ELSE
      nuProducto := fnuGetProducto(sbFactcodi);
    END IF;
    --Fin CA200-1081

    OPEN cuEdad(nuProducto, nuMesesRevision);
    FETCH cuEdad
      INTO nuEdadProd;
    CLOSE cuEdad;

    CASE
      WHEN nuEdadProd <= 54 THEN
        FECH_MAXIMA := NULL;
        FECH_SUSP   := NULL;
        TIPO_NOTI   := 0;
        MENS_NOTI   := csbMensajeA;

      WHEN nuEdadProd = 55 THEN
        FECH_MAXIMA := to_char(LDC_GETFECHAMAXIMARP,
                               'DD Month YYYY',
                               'nls_date_language=spanish');
        FECH_SUSP   := NULL;
        TIPO_NOTI   := 1;
        MENS_NOTI   := NULL;

      WHEN nuEdadProd >= 56 AND nuEdadProd < 59 THEN
        FECH_MAXIMA := to_char(LDC_GETFECHAMAXIMARP,
                               'DD Month YYYY',
                               'nls_date_language=spanish');
        FECH_SUSP   := NULL;
        TIPO_NOTI   := 2;
        MENS_NOTI   := NULL;

      WHEN nuEdadProd = 59 THEN
        -- Inicia Agordillo Incidente.140493
        -- Se consulta la fecha maxima del certificado
        BEGIN
          SELECT to_char(trunc(plazo_maximo),
                         'DD Month YYYY',
                         'nls_date_language=spanish')
            INTO FECH_MAXIMA
            FROM LDC_PLAZOS_CERT
           WHERE id_producto = nuProducto;

        EXCEPTION
          WHEN OTHERS THEN
            FECH_MAXIMA := NULL;
        END;

        --FECH_MAXIMA := to_char(LDC_GETFECHAMAXIMARP,'DD Month YYYY','nls_date_language=spanish') ;
        FECH_SUSP := to_char(LDC_GETFECHAMAXIMARP,
                             'DD Month YYYY',
                             'nls_date_language=spanish');
        TIPO_NOTI := 3;
        MENS_NOTI := NULL;

    -- Inicia Agordillo Incidente.140493

    /*
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    BEGIN

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    select to_char(trunc(plazo_min_suspension),'DD Month YYYY','nls_date_language=spanish') INTO FECH_SUSP
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    from LDC_PLAZOS_CERT
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    where id_producto = nuProducto ;

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    EXCEPTION
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        when others then
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        FECH_SUSP := null ;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    END ; */

      WHEN nuEdadProd >= 60 THEN

        FECH_MAXIMA := to_char(LDC_GETFECHAMAXIMARP,
                               'DD Month YYYY',
                               'nls_date_language=spanish');
        FECH_SUSP   := NULL;
        TIPO_NOTI   := 4;
        MENS_NOTI   := csbMensajeD;

      ELSE

        TIPO_NOTI   := 0;
        MENS_NOTI   := csbMensajeA;
        FECH_MAXIMA := NULL;
        FECH_SUSP   := NULL;

    END CASE;

    -- CA 200-342. Imprime fecha de suspension INMEDIATO si la fecha de revision es menor que la
    -- fecha del sistema
    IF fblAplicaEntrega(csbBSS_FAC_SMS_200342) THEN
      IF trunc(to_DATE(FECH_MAXIMA,
                       'DD Month YYYY',
                       'nls_date_language=spanish')) < trunc(SYSDATE) THEN
        FECH_SUSP := 'INMEDIATO';
      END IF;
    END IF;

    ---- Se abre el CURSOR a retornar.

    OPEN orfcursor FOR
      SELECT TIPO_NOTI   TIPO_NOTI,
             MENS_NOTI   MENS_NOTI,
             FECH_MAXIMA FECH_MAXIMA,
             FECH_SUSP   FECH_SUSP
        FROM dual;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END RfDatosRevision;

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : RfDatosConceptos
    Descripcion    : Procedimiento para extraer los campos relacionados
                     con los datos de los conceptos.
    Autor          : Gabriel Gamarra - Horbath Technologies

    Parametros           Descripcion
    ============         ===================
  orfcursor            Retorna los datos de los conceptos.

    Fecha           Autor               Modificacion
    =========       =========           ====================
    20-08-2016      Sandra Mu?oz        Se agrupan los cargos del servicio 7055
    18/05/2014      Agordillo           Modificacion Cambio.7864
                                        * Se modifica para que cuando se consulta los no Regulados, el campo CUOTAS se obtenga
                                        del campo correspondiente en la tabla temporal
    27/05/2015      Slemus              Modificacion Aranda_Cambio.6452
                                        * Se modifica la consulta de agrupacion (group by ID, CONCEPTO,DOC_SOPORTE,CAU_CARGO)
                                        por campos orden y concepto.
    07/04/2015      Agordillo           Modificacion Incidente.140493
                                        * Se agrega a la consulta la agrupacion (group by ID, CONCEPTO,DOC_SOPORTE,CAU_CARGO)
                                        por concepto, documento de soporte y causa de cargo, y se realiza ordenamiendo
                                        por el campo ORDEN
    12/03/2015      Agordillo           Modificacion Incidente.143745
                                        * Se agrega la condicion en la consulta de usuarios cuando no son regulados
                                        para que no incluya los signos que son PA , SA
                                        * Se cambia el llamado a la tabla LDC_CONC_FACTURA_TMP por LDC_CONC_FACTURA_TEMP
    04/02/2014      ggamarra            Se agrega formateo de numero en campo cuotas NC 4173
    11/11/2014      ggamarra            Creacion.

    ******************************************************************/
  PROCEDURE RfDatosConceptos(orfcursor OUT constants.tyRefCursor) IS

    sbFactsusc            ge_boInstanceControl.stysbValue;
    blNRegulado           BOOLEAN;
    nuServicioBrilla      ld_parameter.numeric_value%TYPE := dald_parameter.fnuGetNumeric_Value('COD_PRODUCT_TYPE_BRILLA'); -- CA200-342. Producto brilla
    nuAplicaEntrega200342 NUMBER; -- CA200-342. Indica si la entrega esta aplicada

  BEGIN

    -- Obtiene el identificador de la factura instanciada
    sbFactsusc  := obtenervalorinstancia('FACTURA', 'FACTSUSC');
    blNRegulado := fblNoRegulado(sbFactsusc);

    IF NOT blNRegulado THEN
      -- CA 200-342.
      IF fblaplicaentrega(csbBSS_FAC_SMS_200342) THEN
        nuAplicaEntrega200342 := 1;
      ELSE
        nuAplicaEntrega200342 := 0;
      END IF;

      OPEN orfcursor FOR

      -- Agordillo Incidente 140493
        SELECT ETIQUETA,
               DESC_CONCEP,
               SALDO_ANT,
               CAPITAL,
               INTERES,
               TOTAL,
               SALDO_DIF,
               CUOTAS
          FROM (SELECT ID ETIQUETA,
                       CONCEPTO DESC_CONCEP,
                       TO_CHAR(SUM(VENCIDO), 'FM999,999,999,990') SALDO_ANT,
                       TO_CHAR(SUM(VALOR_MES), 'FM999,999,999,990') CAPITAL,
                       TO_CHAR(SUM(AMORTIZACION), 'FM999,999,999,990') INTERES,
                       TO_CHAR(SUM(PRESENTE_MES), 'FM999,999,999,990') TOTAL,
                       TO_CHAR(SUM(SALDO_DIFERIDO), 'FM999,999,999,990') SALDO_DIF,
                       ltrim(rtrim(TO_CHAR(MAX(CUOTAS_PENDIENTES),
                                           'FM999,999,999,990'))) CUOTAS,
                       MAX(ORDEN_CONCEPTO) ORDEN
                  FROM LDC_CONC_FACTURA_TEMP lcft
                -- INICIO CA 200-342.
                 WHERE lcft.servicio <> nuServicioBrilla
                    OR nuAplicaEntrega200342 = 0
                 GROUP BY ID, CONCEPTO, DOC_SOPORTE, CAU_CARGO
                UNION ALL
                SELECT ID ETIQUETA,
                       CONCEPTO DESC_CONCEP,
                       TO_CHAR(SUM(VENCIDO), 'FM999,999,999,990') SALDO_ANT,
                       TO_CHAR(SUM(VALOR_MES), 'FM999,999,999,990') CAPITAL,
                       TO_CHAR(SUM(AMORTIZACION), 'FM999,999,999,990') INTERES,
                       TO_CHAR(SUM(PRESENTE_MES), 'FM999,999,999,990') TOTAL,
                       TO_CHAR(SUM(SALDO_DIFERIDO), 'FM999,999,999,990') SALDO_DIF,
                       ltrim(rtrim(TO_CHAR(CUOTAS_PENDIENTES,
                                           'FM999,999,999,990'))) CUOTAS,
                       MAX(ORDEN_CONCEPTO) ORDEN
                  FROM LDC_CONC_FACTURA_TEMP lcft
                 WHERE lcft.servicio = nuServicioBrilla
                   AND nuAplicaEntrega200342 = 1
                 GROUP BY ID, CONCEPTO, cuotas_pendientes
                -- FIN CA 200-342
                 ORDER BY ORDEN);

    ELSE

      OPEN orfcursor FOR

      -- Agordillo Incidente 140493
        SELECT ETIQUETA,
               DESC_CONCEP,
               SALDO_ANT,
               CAPITAL,
               INTERES,
               TOTAL,
               SALDO_DIF,
               CUOTAS
          FROM (SELECT ID ETIQUETA,
                       CONCEPTO DESC_CONCEP,
                       NULL SALDO_ANT,
                       TO_CHAR(SUM(VALOR_MES), 'FM999,999,999,990') CAPITAL,
                       TO_CHAR(SUM(AMORTIZACION), 'FM999,999,999,990') INTERES,
                       TO_CHAR(SUM(PRESENTE_MES), 'FM999,999,999,990') TOTAL,
                       TO_CHAR(SUM(SALDO_DIFERIDO), 'FM999,999,999,990') SALDO_DIF,
                       ltrim(rtrim(TO_CHAR(MAX(PRODUCTO),
                                           'FM999,999,999,990'))) CUOTAS, -- Agordillo Caso.7864
                       MAX(ORDEN_CONCEPTO) ORDEN
                  FROM LDC_CONC_FACTURA_TEMP
                 WHERE CONC_SIGNO NOT IN ('SA', 'PA') -- Agordillo Incidente.143745
                 GROUP BY ID, CONCEPTO --,DOC_SOPORTE,CAU_CARGO --Slemus Ara 6452
                 ORDER BY ORDEN);

    END IF;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END RfDatosConceptos;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuCanConceptos
  Descripcion    : Obtiene la cantidad de conceptos a mostrar en el detalle de la factura.
  Autor          : Alexandra Gordillo

  Fecha           Autor               Modificacion
  =========       =========           ====================
  12-09-2016      Sandra Mu?oz        Se agrupan los registros del concepto brilla para obtener
                                      el total de conceptos
  07/04/2015      Agordillo           Creacion.

  ******************************************************************/
  FUNCTION fnuCanConceptos RETURN NUMBER AS

    sbFactsusc            ge_boInstanceControl.stysbValue;
    blNRegulado           BOOLEAN;
    nuCanConceptos        NUMBER;
    nuServicioBrilla      ld_parameter.numeric_value%TYPE := dald_parameter.fnuGetNumeric_Value('COD_PRODUCT_TYPE_BRILLA'); -- CA200-342. Producto brilla
    nuAplicaEntrega200342 NUMBER; -- CA200-342. Indica si la entrega esta aplicada

  BEGIN

    -- Obtiene el identificador de la factura instanciada
    sbFactsusc  := obtenervalorinstancia('FACTURA', 'FACTSUSC');
    blNRegulado := fblNoRegulado(sbFactsusc);

    IF NOT blNRegulado THEN

      -- CA 200-342.
      IF fblaplicaentrega(csbBSS_FAC_SMS_200342) THEN
        nuAplicaEntrega200342 := 1;
      ELSE
        nuAplicaEntrega200342 := 0;
      END IF;

      -- Agordillo Incidente 140493
      SELECT COUNT(1)
        INTO nuCanConceptos
        FROM (SELECT ID ETIQUETA,
                     CONCEPTO DESC_CONCEP,
                     TO_CHAR(SUM(VENCIDO), 'FM999,999,999,990') SALDO_ANT,
                     TO_CHAR(SUM(VALOR_MES), 'FM999,999,999,990') CAPITAL,
                     TO_CHAR(SUM(AMORTIZACION), 'FM999,999,999,990') INTERES,
                     TO_CHAR(SUM(PRESENTE_MES), 'FM999,999,999,990') TOTAL,
                     TO_CHAR(SUM(SALDO_DIFERIDO), 'FM999,999,999,990') SALDO_DIF,
                     ltrim(rtrim(TO_CHAR(MAX(CUOTAS_PENDIENTES),
                                         'FM999,999,999,990'))) CUOTAS,
                     MAX(ORDEN_CONCEPTO) ORDEN
                FROM LDC_CONC_FACTURA_TEMP
              -- INICIO CA 200-342.
               WHERE servicio <> nuServicioBrilla
                  OR nuAplicaEntrega200342 = 0
               GROUP BY ID, CONCEPTO, DOC_SOPORTE, CAU_CARGO
              UNION ALL
              SELECT ID ETIQUETA,
                     CONCEPTO DESC_CONCEP,
                     TO_CHAR(SUM(VENCIDO), 'FM999,999,999,990') SALDO_ANT,
                     TO_CHAR(SUM(VALOR_MES), 'FM999,999,999,990') CAPITAL,
                     TO_CHAR(SUM(AMORTIZACION), 'FM999,999,999,990') INTERES,
                     TO_CHAR(SUM(PRESENTE_MES), 'FM999,999,999,990') TOTAL,
                     TO_CHAR(SUM(SALDO_DIFERIDO), 'FM999,999,999,990') SALDO_DIF,
                     ltrim(rtrim(TO_CHAR(CUOTAS_PENDIENTES,
                                         'FM999,999,999,990'))) CUOTAS,
                     MAX(ORDEN_CONCEPTO) ORDEN
                FROM LDC_CONC_FACTURA_TEMP lcft
               WHERE lcft.servicio = nuServicioBrilla
                 AND nuAplicaEntrega200342 = 1
               GROUP BY ID, CONCEPTO, cuotas_pendientes
              -- FIN CA 200-342

               ORDER BY ORDEN);

    ELSE

      SELECT COUNT(1)
        INTO nuCanConceptos
        FROM (SELECT ID ETIQUETA,
                     CONCEPTO DESC_CONCEP,
                     NULL SALDO_ANT,
                     TO_CHAR(SUM(VALOR_MES), 'FM999,999,999,990') CAPITAL,
                     TO_CHAR(SUM(AMORTIZACION), 'FM999,999,999,990') INTERES,
                     TO_CHAR(SUM(PRESENTE_MES), 'FM999,999,999,990') TOTAL,
                     TO_CHAR(SUM(SALDO_DIFERIDO), 'FM999,999,999,990') SALDO_DIF,
                     ltrim(rtrim(TO_CHAR(MAX(PRODUCTO), 'FM999,999,999,990'))) CUOTAS,
                     MAX(ORDEN_CONCEPTO) ORDEN
                FROM LDC_CONC_FACTURA_TEMP
               WHERE CONC_SIGNO NOT IN ('SA', 'PA') -- Agordillo Incidente.143745
               GROUP BY ID, CONCEPTO, DOC_SOPORTE, CAU_CARGO
               ORDER BY ORDEN);

    END IF;

    RETURN nuCanConceptos;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      --RAISE ex.CONTROLLED_ERROR;
      nuCanConceptos := 0;
      RETURN nuCanConceptos;
    WHEN OTHERS THEN
      Errors.setError;
      --RAISE ex.CONTROLLED_ERROR;
      nuCanConceptos := 0;
      RETURN nuCanConceptos;
  END fnuCanConceptos;

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : RfDatosConcEstadoCuenta
    Descripcion    : Procedimiento para extraer los campos relacionados
                     con los datos de los conceptos en el estado de cuenta.
    Autor          : Gabriel Gamarra - Horbath Technologies

    Parametros           Descripcion
    ============         ===================
  orfcursor            Retorna los datos de los conceptos.

    Fecha           Autor               Modificacion
    =========       =========           ====================
    06-09-2016      Sandra Mu?oz        CA200-342. Agrupacion conceptos brilla
    07/04/2015      Agordillo           Modificacion Incidente.140493
                                        * Se agrega a la consulta la agrupacion (group by ID, CONCEPTO,DOC_SOPORTE,CAU_CARGO)
                                        por concepto, documento de soporte y causa de cargo, y se realiza ordenamiendo
                                        por el campo ORDEN
    12/03/2015      Agordillo           Modificacion Incidente.143745
                                        * Se cambia el llamado a la tabla LDC_CONC_FACTURA_TMP por LDC_CONC_FACTURA_TEMP
    11/11/2014      ggamarra            Creacion.
    ******************************************************************/
  PROCEDURE RfDatosConcEstadoCuenta(orfcursor OUT constants.tyRefCursor) IS
    sbFactcodi  ge_boInstanceControl.stysbValue;
    sbFactsusc  ge_boInstanceControl.stysbValue;
    blNRegulado BOOLEAN;

    -- Numero de detalles del bloque de cargos
    nuRegistrosHoja       NUMBER := 30;
    nuRegBlanks           NUMBER;
    nuServicioBrilla      ld_parameter.numeric_value%TYPE := dald_parameter.fnuGetNumeric_Value('COD_PRODUCT_TYPE_BRILLA'); -- CA200-342. Producto brilla
    nuAplicaEntrega200342 NUMBER; -- CA200-342. Indica si la entrega esta aplicada

  BEGIN

    -- Obtiene el identificador de la factura instanciada
    sbFactcodi  := obtenervalorinstancia('FACTURA', 'FACTCODI');
    sbFactsusc  := obtenervalorinstancia('FACTURA', 'FACTSUSC');
    blNRegulado := fblNoRegulado(sbFactsusc);

    IF NOT blNRegulado THEN

      IF MOD(gnuConcNumber, nuRegistrosHoja) = 0 THEN
        nuRegBlanks := 0;
      ELSE
        nuRegBlanks := nuRegistrosHoja -
                       MOD(gnuConcNumber, nuRegistrosHoja);
      END IF;

      -- CA 200-342
      IF fblaplicaentrega(csbBSS_FAC_SMS_200342) THEN
        nuAplicaEntrega200342 := 1;
      ELSE
        nuAplicaEntrega200342 := 0;
      END IF;
      -- Agordillo Incidente.140493
      OPEN orfcursor FOR
        SELECT ETIQUETA,
               DESC_CONCEP,
               SALDO_ANT,
               CAPITAL,
               INTERES,
               TOTAL,
               SALDO_DIF,
               CUOTAS
          FROM (SELECT ID ETIQUETA,
                       CONCEPTO DESC_CONCEP,
                       TO_CHAR(SUM(VENCIDO), 'FM999,999,999,990') SALDO_ANT,
                       TO_CHAR(SUM(VALOR_MES), 'FM999,999,999,990') CAPITAL,
                       TO_CHAR(SUM(AMORTIZACION), 'FM999,999,999,990') INTERES,
                       TO_CHAR(SUM(PRESENTE_MES), 'FM999,999,999,990') TOTAL,
                       TO_CHAR(SUM(SALDO_DIFERIDO), 'FM999,999,999,990') SALDO_DIF,
                       MAX(CUOTAS_PENDIENTES) CUOTAS,
                       MAX(orden_concepto) ORDEN
                  FROM LDC_CONC_FACTURA_TEMP lcft
                -- INICIO CA 200-342
                 WHERE lcft.servicio <> nuServicioBrilla
                    OR nuAplicaEntrega200342 = 1
                 GROUP BY ID, CONCEPTO, DOC_SOPORTE, CAU_CARGO
                UNION ALL
                SELECT ID ETIQUETA,
                       CONCEPTO DESC_CONCEP,
                       TO_CHAR(SUM(VENCIDO), 'FM999,999,999,990') SALDO_ANT,
                       TO_CHAR(SUM(VALOR_MES), 'FM999,999,999,990') CAPITAL,
                       TO_CHAR(SUM(AMORTIZACION), 'FM999,999,999,990') INTERES,
                       TO_CHAR(SUM(PRESENTE_MES), 'FM999,999,999,990') TOTAL,
                       TO_CHAR(SUM(SALDO_DIFERIDO), 'FM999,999,999,990') SALDO_DIF,
                       CUOTAS_PENDIENTES CUOTAS,
                       MAX(ORDEN_CONCEPTO) ORDEN
                  FROM LDC_CONC_FACTURA_TEMP lcft
                 WHERE lcft.servicio = nuServicioBrilla
                   AND nuAplicaEntrega200342 = 0
                 GROUP BY ID, CONCEPTO, cuotas_pendientes
                -- FIN CA 200-342
                )
        UNION ALL
        SELECT 34   ETIQUETA,
               NULL DESC_CONCEP,
               NULL SALDO_ANT,
               NULL CAPITAL,
               NULL INTERES,
               NULL TOTAL,
               NULL SALDO_DIF,
               NULL CUOTAS
          FROM servsusc
         WHERE ROWNUM <= nuRegBlanks;

    ELSE

      /*SELECT ID ETIQUETA, CONCEPTO DESC_CONCEP,
             NULL SALDO_ANT,
             TO_CHAR(VALOR_MES,'FM999,999,999,990') CAPITAL,
             TO_CHAR(AMORTIZACION,'FM999,999,999,990') INTERES,
             TO_CHAR(PRESENTE_MES,'FM999,999,999,990') TOTAL,
             TO_CHAR(SALDO_DIFERIDO,'FM999,999,999,990') SALDO_DIF,
             PRODUCTO CUOTAS
      FROM LDC_CONC_FACTURA_TEMP
      where conc_signo not in ('PA','SA') ; */
      -- Agordillo Incidente.140493
      OPEN orfcursor FOR
        SELECT ETIQUETA,
               DESC_CONCEP,
               SALDO_ANT,
               CAPITAL,
               INTERES,
               TOTAL,
               SALDO_DIF,
               CUOTAS
          FROM (SELECT ID ETIQUETA,
                       CONCEPTO DESC_CONCEP,
                       NULL SALDO_ANT,
                       TO_CHAR(SUM(VALOR_MES), 'FM999,999,999,990') CAPITAL,
                       TO_CHAR(SUM(AMORTIZACION), 'FM999,999,999,990') INTERES,
                       TO_CHAR(SUM(PRESENTE_MES), 'FM999,999,999,990') TOTAL,
                       TO_CHAR(SUM(SALDO_DIFERIDO), 'FM999,999,999,990') SALDO_DIF,
                       MAX(PRODUCTO) CUOTAS,
                       MAX(ORDEN_CONCEPTO) ORDEN
                  FROM LDC_CONC_FACTURA_TEMP
                 WHERE CONC_SIGNO NOT IN ('PA', 'SA') -- Agordillo Incidente.143745
                 GROUP BY ID, CONCEPTO, DOC_SOPORTE, CAU_CARGO
                 ORDER BY ORDEN);

    END IF;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END RfDatosConcEstadoCuenta;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfConcepParcial
  Descripcion    : Procedimiento para mostrar el iva y el subtotal de los no regulados.
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================

  orfcursor            Retorna los datos

  Fecha           Autor               Modificacion
  =========       =========           ====================
  11/07/2018      Sebastian Tapias    REQ.200-1920: Se incluyen conceptos con cargdoso "ID-" a la factura.
                                                    que esten configurados en el parametro ID_CONCEPT_VIEW_BILL
  10/01/2018      Jorge Valiente      CASO 200-1626: Se realizo el llamado del nuevo servicio
                                                     FnuGetSaldoAntetior para reemplazar el servicio de OPEN
  18-10-2016      Sandra Mu?oz.       CA200-849: Se acumula en el total del diferido para que sume
                                      el valor de los diferidos que aun no se estan facturando
  12-09-2016      Sandra Mu?oz        CA200-342: Se llena el campo servicio para poder usarlo
                                      para agrupar los conceptos de brilla
  17/12/2015      Agordillo           Modificacion SAO.369165
                                      Se agrega un IF que permite validar si el servicio es 7053,
                                      se asigne null al saldo pendiente y numero de cuotas al diferido dado
                                      que esta informacion no se muestra en la factura
  05/08/2015      Mmejia              Modificacion Aranda.8199 Se traslada la logica que valida los diferidos
                                      que no estan asociados a una cuenta cobro para que se procese antes de
                                      calcular los campos del total mes esto ya que el total mes se
                                      estaba mostrando antes de estos registros en la impresion de la  factura.
  25/06/2015      Mmejia              Modificacion Aranda.6477 Se agrega  la logica para agregar
                                      a los detalles de factura los diferidos que no estan asociados
                                      a una cuenta de cobro.
  19/03/2015      Agordillo           Modificacion Incidente.140493
                                      * Se agrega una condicion cuando se esta agrupando los diferidos para que diferencie
                                      por causa de cargo, dado que a este concepto es al unico que se le muestra el saldo
                                      del diferido, intereses y cuotas pendiente.
                                      * Se agrega una condicion para que se inserte los cargos que son Diferidos pero no
                                      tienen causa de cargo 51-Cuota
                                      * Se agrega una condicion cuando el cargo es interes de un diferido para que solo se
                                      muestre en el cargo si es cuota.
  12/03/2015      Agordillo           Modificacion Incidente.143745
                                      * Se modifica el type tyrcCargosOrd para agrecar el campo signo
                                      * Se modifica para que en la tabla tbCargosOrdered que contiene los cargos
                                      ordenados se agrege el signo del cargo(DB,CR,SA,PA) etc.
                                      * Se cambia la insercion a la tabla LDC_CONC_FACTURA_TMP por LDC_CONC_FACTURA_TEMP
                                      dado que la primera tabla no tiene campo de signo
                                      * Se cambia la forma de insercion en la tabla LDC_CONC_FACTURA_TEMP definiendole
                                      los campos a insertar,para que en posteriores modificaciones de esta no exista
                                      problema para adicionar un nuevo campo y afecte los objetos que tambien la utilicen.
                                      * Se modifica el IF para acumular los totales (tbCargosOrdered(-1).TOTAL)
                                      en usuarios no regulados para que no tenga en cuenta los pagos signo (PA)
  11/11/2014      ggamarra           Creacion.
  ******************************************************************/

  PROCEDURE RfConcepParcial(orfcursor OUT constants.tyRefCursor) IS

    sbFactcodi  number := 2043084140;
    sbFactsusc  number := 66252894;
    blNRegulado BOOLEAN;
    nuServicio  servsusc.sesuserv%TYPE; -- Agordillo SAO.369165

    TYPE tyrcCargos IS RECORD(
      CARGCUCO cargos.CARGCUCO%TYPE,
      CARGNUSE cargos.CARGNUSE%TYPE,
      SERVCODI servicio.SERVCODI%TYPE,
      SERVDESC servicio.SERVDESC%TYPE,
      CARGCONC cargos.CARGCONC%TYPE,
      CONCDEFA concepto.CONCDEFA%TYPE,
      CARGCACA cargos.CARGCACA%TYPE,
      CARGSIGN cargos.CARGSIGN%TYPE,
      CARGPEFA cargos.CARGPEFA%TYPE,
      CARGVALO cargos.CARGVALO%TYPE,
      CARGDOSO cargos.CARGDOSO%TYPE,
      CARGCODO cargos.CARGCODO%TYPE,
      CARGUNID cargos.CARGUNID%TYPE,
      CARGFECR cargos.CARGFECR%TYPE,
      CARGPROG cargos.CARGPROG%TYPE,
      CARGPECO cargos.CARGPECO%TYPE,
      CARGTICO cargos.CARGTICO%TYPE,
      CARGVABL cargos.CARGVABL%TYPE,
      CARGTACO cargos.CARGTACO%TYPE,
      ORDEN    NUMBER);

    TYPE tytbCargos IS TABLE OF tyrcCargos INDEX BY BINARY_INTEGER;

    tbCargos     tytbCargos;
    tbCargosNull tytbCargos;

    TYPE tyrcCargosOrd IS RECORD(
      ETIQUETA    VARCHAR2(3),
      CONCEPTO_ID NUMBER,
      CONCEPTOS   VARCHAR2(60),
      SIGNO       VARCHAR2(10), -- Agordilllo Incidente.143745
      ORDEN       NUMBER,
      SALDO_ANT   NUMBER,
      CAPITAL     NUMBER,
      INTERES     NUMBER,
      TOTAL       NUMBER,
      SALDO_DIF   NUMBER,
      CUOTAS      NUMBER,
      CAR_DOSO    VARCHAR2(100), -- Agordilllo Incidente.140493
      CAR_CACA    NUMBER,
      servicio    NUMBER -- CA 200-342
      ); -- Agordilllo Incidente.140493

    TYPE tytbFinal IS TABLE OF tyrcCargosOrd INDEX BY BINARY_INTEGER;

    tbCargosOrdered tytbFinal;
    tbFinalNull     tytbFinal;

    sbConcIVA      VARCHAR2(2000) := '137|287|586|616';
    sbConcRecamora VARCHAR2(2000) := '153|154|155|156|157|220|284|285|286';
    --REQ.200-1920: Se crea variable para los conceptos a mostrar.
    sbConcIncluFact VARCHAR2(2000) := open.dald_parameter.fsbgetvalue_chain('ID_CONCEPT_VIEW_BILL',
                                                                            NULL);
    --Fin.

    nuDifesape       NUMBER;
    nuDifecuotas     NUMBER;
    nuInteres        NUMBER;
    nuLastSesu       NUMBER;
    sbDescServ       servicio.servdesc%TYPE;
    nuConcIVA        NUMBER := 137;
    nuConcSuministro NUMBER := 200;
    nuConcComercial  NUMBER := 716;
    inx              NUMBER;
    inxConc          VARCHAR2(10);
    i                NUMBER;
    j                NUMBER;
    k                NUMBER;
    nuSaldoAnterior  NUMBER;
    nuSaldoProd      NUMBER;
    rcProduct        servsusc%ROWTYPE;
    rcProductNull    servsusc%ROWTYPE;
    nuPorcSubs       NUMBER;
    sbIdentifica     ld_policy.identification_id%TYPE;
    nuDoso           cargos.cargdoso%TYPE;
    nutem            NUMBER;

    CURSOR cuCargos IS
      SELECT CARGCUCO,
             CARGNUSE,
             SERVCODI,
             SERVDESC,
             CARGCONC,
             CONCDEFA,
             CARGCACA,
             CARGSIGN,
             CARGPEFA,
             CARGVALO,
             CARGDOSO,
             CARGCODO,
             CARGUNID,
             CARGFECR,
             CARGPROG,
             CARGPECO,
             CARGTICO,
             CARGVABL,
             CARGTACO,
             ORDEN

      -- Se ordenan los productos seg?n el orden que se requiere
        FROM cargos,
             cuencobr,
             servsusc,
             concepto,
             (SELECT decode(servcodi,
                            7014,
                            1,
                            6121,
                            2,
                            7055,
                            3,
                            7056,
                            4,
                            7053,
                            5,
                            7052,
                            6,
                            7054,
                            7,
                            99) orden,
                     servcodi,
                     servdesc
                FROM servicio) Serv_ord
       WHERE cucofact = sbFactcodi
         AND cargcuco = cucocodi
         AND cargnuse = sesunuse
         AND sesuserv = servcodi
         AND cargconc = conccodi
      UNION -- Se agregan los productos que no facturan en la cuenta Y tengan saldo pendiente
      SELECT -1 CARGCUCO,
             sesunuse CARGNUSE,
             SERVCODI,
             SERVDESC,
             -1 CARGCONC,
             NULL CONCDEFA,
             -1 CARGCACA,
             'XX' CARGSIGN,
             -9999 CARGPEFA,
             0 CARGVALO,
             '-' CARGDOSO,
             0 CARGCODO,
             0 CARGUNID,
             SYSDATE CARGFECR,
             NULL CARGPROG,
             NULL CARGPECO,
             NULL CARGTICO,
             NULL CARGVABL,
             NULL CARGTACO,
             ORDEN
      -- Se ordenan los productos seg?n el orden que se requiere
        FROM servsusc,
             (SELECT decode(servcodi,
                            7014,
                            1,
                            6121,
                            2,
                            7055,
                            3,
                            7056,
                            4,
                            7053,
                            5,
                            7052,
                            6,
                            7054,
                            7,
                            99) orden,
                     servcodi,
                     servdesc
                FROM servicio) Serv_ord
       WHERE sesususc = sbFactsusc
         AND sesuserv = servcodi
         AND pkbccuencobr.fnugetoutstandbal(sesunuse) > 0
       ORDER BY orden, cargnuse, cargpefa DESC, cargdoso;

    CURSOR cuDiferidos IS
      SELECT *
        FROM diferido, concepto
       WHERE DIFESUSC = sbfactsusc
         AND DIFESAPE > 0
         AND difeconc = conccodi;

    SUBTYPE stytbcuDiferidos IS cuDiferidos%ROWTYPE;
    TYPE tytbcuDiferidos IS TABLE OF stytbcuDiferidos INDEX BY BINARY_INTEGER;
    tdiferidos tytbcuDiferidos;

    TYPE tytbNumber IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
    TYPE tytbVarchar IS TABLE OF NUMBER INDEX BY VARCHAR2(10);
    gtbFinancion tytbNumber;
    gtbConceptos tytbVarchar;
    nuIndex      NUMBER := 0;

    nuAplicaEntrega200342 NUMBER;

    --------------------------
    --200-2156 Samuel Pacheco
    --------------------------
    TYPE rcConcep IS RECORD(
      cargconc NUMBER,
      cargdoso VARCHAR2(50),
      cargvalo NUMBER(13, 2));

    TYPE tbConcep IS TABLE OF rcConcep INDEX BY varchar2(50);
    tConcep tbConcep;

    sbindice varchar2(50);

    nucargconc open.cargos.cargconc%type := null;
    sbcargdoso open.cargos.cargdoso%type := null;
    nucargvalo open.cargos.cargvalo%type := null;
    -------------------------
    --Fin Cambio.
    -------------------------

  BEGIN

    -- Obtiene el identificador de la factura instanciada
    sbFactcodi  := 2043084140;
    sbFactsusc  := 66252894;
    blNRegulado := fblNoRegulado(sbFactsusc);
    nuLastSesu  := -1;
    inx         := 1;

    gsbTotal         := NULL;
    gsbIVANoRegulado := NULL;
    gsbSubtotalNoReg := NULL;
    gsbCargosMes     := NULL;
    gnuConcNumber    := 0;

    -- Inicio CA200-342
    IF fblAplicaEntrega(csbBSS_FAC_SMS_200342) THEN
      nuAplicaEntrega200342 := 1;
    ELSE
      nuAplicaEntrega200342 := 0;
    END IF;
    -- Fin CA200-342

    tbCargos        := tbCargosNull;
    tbCargosOrdered := tbFinalNull;

    OPEN cuCargos;
    FETCH cuCargos BULK COLLECT
      INTO tbCargos;
    CLOSE cuCargos;

    IF NOT blNRegulado THEN
      ut_trace.trace('Crear detalles para los regulados ', 10);

      i := tbCargos.first;
      tConcep.Delete;
      LOOP

        EXIT WHEN i IS NULL;

        -- Inicio CA 200-342
        IF fblaplicaentrega(csbBSS_FAC_SMS_200342) THEN
          tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
          tbCargosOrdered(-1).servicio := tbCargos(i).servcodi; -- Total servicio
          tbCargosOrdered(-2).servicio := tbCargos(i).servcodi; -- IVA
          tbCargosOrdered(-3).servicio := tbCargos(i).servcodi; -- Recargo por mora
        END IF;
        -- Fin CA 200-342

        -- Imprime encabezado si cambia de servicio suscrito
        IF nuLastSesu <> tbCargos(i).cargnuse THEN

          rcProduct := pktblservsusc.frcgetrecord(tbCargos(i).cargnuse);
          pkboinstanceprintingdata.instancecurrentproduct(rcProduct);
          --CASO 200-1626
          --Se coloca en comentario el servicio de OPEN para obtener el saldo anterio y se realiza
          --el llamado del nuevo servicio para obtener el saldo anterior
          --nuSaldoAnterior := pkbobillprintprodrules.fsbgetpreviousbalance;
          nuSaldoAnterior := FnuGetSaldoAnterior(to_number(sbFactsusc),
                                                 to_number(sbFactcodi),
                                                 tbCargos(i).cargnuse);
          --
          pkboinstanceprintingdata.instancecurrentproduct(rcProductNull);
          nuSaldoProd := pkbccuencobr.fnugetoutstandbal(tbCargos(i).cargnuse);

          IF (tbCargos(i).cargpefa = -9999 AND nuSaldoProd > 0) OR tbCargos(i)
            .cargpefa <> -9999 THEN

            tbCargosOrdered(inx).ETIQUETA := '31';

            IF tbCargos(i).servcodi IN (7055, 7056) THEN
              tbCargosOrdered(inx).CONCEPTOS := upper(tbCargos(i).servdesc) ||
                                                ' (Serv.Susc.' || tbCargos(i)
                                               .cargnuse || ')';
            ELSE

              tbCargosOrdered(inx).CONCEPTOS := 'SERV.' ||
                                                upper(tbCargos(i).servdesc) ||
                                                ' (Serv.Susc.' || tbCargos(i)
                                               .cargnuse || ')';
            END IF;

            inx := inx + 1;

            -- Inicio CA 200-342
            IF fblAplicaEntrega(csbBSS_FAC_SMS_200342) THEN
              tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
            END IF;
            -- Fin CA 200-342

            -- Se crea la linea de saldo anterior si tiene

            IF nvl(nuSaldoAnterior, 0) > 0 THEN

              tbCargosOrdered(inx).ETIQUETA := '32';
              tbCargosOrdered(inx).CONCEPTOS := 'Saldo Anterior';
              tbCargosOrdered(inx).SALDO_ANT := nuSaldoAnterior;
              inx := inx + 1;
            ELSE
              -- El producto no tiene cargos, muestra el saldo para que salga en el detalle
              IF tbCargos(i).cargpefa = -9999 THEN
                tbCargosOrdered(inx).ETIQUETA := '32';
                tbCargosOrdered(inx).CONCEPTOS := 'Saldo Anterior';
                tbCargosOrdered(inx).SALDO_ANT := nuSaldoProd;
                inx := inx + 1;
              END IF;

            END IF;

            -- Inicio CA 200-342
            IF fblAplicaEntrega(csbBSS_FAC_SMS_200342) THEN
              tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
            END IF;
            -- Fin CA 200-342

            -- Crea el detalle de totales
            tbCargosOrdered(-1).ETIQUETA := '33';
            tbCargosOrdered(-1).CAR_DOSO := tbCargos(i).SERVCODI; -- Agordillo Incidente 140493
            tbCargosOrdered(-1).CONCEPTOS := 'Total Servicio:';
            tbCargosOrdered(-1).CAPITAL := 0;
            tbCargosOrdered(-1).INTERES := 0;
            tbCargosOrdered(-1).TOTAL := 0;
            tbCargosOrdered(-1).SALDO_DIF := 0;

            -- Crea el acumulado de IVA
            tbCargosOrdered(-2).ETIQUETA := '32';
            tbCargosOrdered(-2).CONCEPTOS := 'IVA';
            tbCargosOrdered(-2).CAPITAL := 0;

            -- Crea el acumulado de Recargo por mora
            tbCargosOrdered(-3).ETIQUETA := '32';
            tbCargosOrdered(-3).CONCEPTOS := 'x';
            tbCargosOrdered(-3).INTERES := 0;
            tbCargosOrdered(-3).CAR_DOSO := tbCargos(i).SERVCODI; -- Agordillo Incidente 140493

          END IF;

        END IF;

        -- Crea los detalles
        -- se cambian los valores seg?n los signos, no se estan teniendo en cuenta SA
        IF tbCargos(i).cargsign IN ('CR', 'AS', 'PA') THEN
          tbCargos(i).cargvalo := -1 * tbCargos(i).cargvalo;
        ELSIF tbCargos(i).cargsign IN ('DB') THEN
          tbCargos(i).cargvalo := tbCargos(i).cargvalo;
        ELSE
          tbCargos(i).cargvalo := 0;
        END IF;

        -- Modificaci?n de las descripciones de los conceptos

        CASE
        -- Si el concepto es prima seguros se agrega la cedula
          WHEN tbCargos(i).SERVCODI IN (7053) AND
                instr('|' || sbConcIVA || '|',
                      '|' || tbCargos(i).cargconc || '|') = 0 AND
                instr('|' || sbConcRecamora || '|',
                      '|' || tbCargos(i).cargconc || '|') = 0 THEN

            BEGIN

              SELECT identification_id
                INTO sbIdentifica
                FROM ld_policy
               WHERE product_id = tbCargos(i).cargnuse;

              tbCargos(i).CONCDEFA := tbCargos(i)
                                      .CONCDEFA || ' CC: ' || sbIdentifica;

            EXCEPTION
              WHEN OTHERS THEN
                NULL;
            END;

        -- Si el concepto es subsidio se agrega el %
          WHEN tbCargos(i).SERVCODI IN (7014) AND tbCargos(i).cargconc = 196 THEN

            BEGIN

              SELECT SUM(ralivasu) * 100 / SUM(ralivaul)
                INTO nuPorcSubs
                FROM rangliqu
               WHERE ralicodo = tbCargos(i).cargcodo
                 AND ralivasu > 0;

              IF tbCargos(i).cargdoso LIKE 'SU-PR%' THEN

                tbCargos(i).CONCDEFA := tbCargos(i)
                                        .CONCDEFA ||
                                         ' LEY 142/94(Hasta 20M3 ' ||
                                         round(nuPorcSubs, 2) ||
                                         '% Cons.) SU-' || tbCargos(i)
                                        .cargunid || 'AJ-' ||
                                         substr(tbCargos(i).cargdoso, 7, 6);
              ELSE
                tbCargos(i).CONCDEFA := tbCargos(i)
                                        .CONCDEFA ||
                                         ' LEY 142/94(Hasta 20M3 ' ||
                                         round(nuPorcSubs, 2) || '% Cons.)';
              END IF;

            EXCEPTION
              WHEN OTHERS THEN
                NULL;
            END;
            -- Si el concepto es contribuci?n se agrega el %
          WHEN tbCargos(i).SERVCODI IN (7014) AND tbCargos(i).cargconc = 37 THEN

            BEGIN

              SELECT vitcporc
                INTO nuPorcSubs
                FROM ta_vigetaco, pericose
               WHERE vitctaco = tbCargos(i).CARGTACO
                 AND pecscons = tbCargos(i).CARGPECO
                 AND pecsfecf BETWEEN vitcfein AND vitcfefi
                 AND vitcvige = 'S'
                 AND ROWNUM = 1;

              IF tbCargos(i).cargdoso LIKE 'CN-PR%' THEN

                tbCargos(i).CONCDEFA := tbCargos(i)
                                        .CONCDEFA || '(' ||
                                         round(nuPorcSubs, 2) ||
                                         '% Cons. + ' ||
                                         round(nuPorcSubs, 2) ||
                                         '% C. Fijo CN-AJ-' ||
                                         substr(tbCargos(i).cargdoso, 7, 6);
              ELSE
                tbCargos(i).CONCDEFA := tbCargos(i)
                                        .CONCDEFA || '(' ||
                                         round(nuPorcSubs, 2) ||
                                         '% Cons. + ' ||
                                         round(nuPorcSubs, 2) || '% C. Fijo';
              END IF;

            EXCEPTION
              WHEN OTHERS THEN
                NULL;
            END;

          WHEN tbCargos(i)
           .SERVCODI IN (7014) AND tbCargos(i).cargdoso LIKE 'CO-PR%TC%' THEN

            tbCargos(i).CONCDEFA := tbCargos(i)
                                    .CONCDEFA || 'CO-' || tbCargos(i)
                                    .cargunid || 'AJ-' ||
                                     substr(tbCargos(i).cargdoso, 7, 6);

          ELSE
            NULL;

        END CASE;

        -- Evalua primero si es concepto de Iva o Recargo por mora para acumular

        CASE -- Acumulado de IVA
          WHEN instr('|' || sbConcIVA || '|',
                     '|' || tbCargos(i).cargconc || '|') > 0 THEN

            tbCargosOrdered(-2).CAPITAL := tbCargosOrdered(-2)
                                           .CAPITAL + tbCargos(i).cargvalo;

        -- Acumulado Recargo por mora
          WHEN instr('|' || sbConcRecamora || '|',
                     '|' || tbCargos(i).cargconc || '|') > 0 THEN

            tbCargosOrdered(-3).INTERES := tbCargosOrdered(-3)
                                           .INTERES + tbCargos(i).cargvalo;

            IF tbCargosOrdered(-3).CONCEPTOS = 'x' THEN
              tbCargosOrdered(-3).CONCEPTOS := 'INTERES DE MORA(Tasa ' || tbCargos(i)
                                              .cargunid || '%)';
            END IF;

        -- Arma el detalle para los dem?s cargos diferentes de diferidos
          WHEN substr(tbCargos(i).cargdoso, 0, 3) NOT IN ('ID-', 'DF-') AND tbCargos(i)
              .cargsign IN ('DB', 'CR', 'PA', 'AS') THEN

            tbCargosOrdered(inx).ETIQUETA := '32';
            tbCargosOrdered(inx).CONCEPTO_ID := tbCargos(i).cargconc; -- Agordilllo Incidente.140493
            tbCargosOrdered(inx).CONCEPTOS := tbCargos(i).concdefa;
            tbCargosOrdered(inx).SIGNO := tbCargos(i).cargsign; -- Agordilllo Incidente.143745
            tbCargosOrdered(inx).CAR_DOSO := tbCargos(i).cargdoso; -- Agordilllo Incidente.140493
            tbCargosOrdered(inx).CAR_CACA := tbCargos(i).cargcaca; -- Agordilllo Incidente.140493
            tbCargosOrdered(inx).SALDO_ANT := NULL;
            tbCargosOrdered(inx).CAPITAL := tbCargos(i).cargvalo;
            tbCargosOrdered(inx).INTERES := NULL;
            tbCargosOrdered(inx).TOTAL := NULL;
            tbCargosOrdered(inx).SALDO_DIF := NULL;
            tbCargosOrdered(inx).CUOTAS := NULL;
            -- tbCargosOrdered(inx).SERVICIO := tbCargos(i).servicio; -- CA 200-342

            inx := inx + 1;

            -- Inicio CA 200-342
            IF fblAplicaEntrega(csbBSS_FAC_SMS_200342) THEN
              tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
            END IF;
            -- Fin CA 200-342

        -- Agrupa diferido con su respectivo interes de financiaci?n
        -- Agordillo Incidente.140493
        -- Se agrega la condicion de causa de cargo 51 que corresponde la cuota del diferido
        -- El cual si debe de mostrar el saldo del diferido y el interes
          WHEN substr(tbCargos(i).cargdoso, 0, 3) = 'DF-' AND
               (tbCargos(i).cargcaca = 51) THEN

            IF tbCargos(i).SERVCODI = 7053 THEN

              nuDifesape   := NULL;
              nuDifecuotas := NULL;
              nuInteres    := NULL;

            ELSE
              --Mmejia.Aranda 6477
              --Se almacena los codigo de los diferidos en la tabla
              nuIndex := SUBSTR(tbcargos(i).cargdoso,
                                4,
                                LENGTH(tbcargos(i).cargdoso) - 3);
              gtbFinancion(nuIndex) := SUBSTR(tbcargos(i).cargdoso,
                                              4,
                                              LENGTH(tbcargos(i).cargdoso) - 3);

              BEGIN

                SELECT decode(difesign, 'DB', difesape, -1 * difesape),
                       (difenucu - difecupa)
                  INTO nuDifesape, nuDifecuotas
                  FROM diferido
                 WHERE difecodi =
                       substr(tbCargos(i).cargdoso,
                              4,
                              length(tbCargos(i).cargdoso) - 3);
              EXCEPTION
                WHEN OTHERS THEN
                  nuDifesape   := 0;
                  nuDifecuotas := 0;
              END;

              BEGIN

                SELECT decode(cargsign, 'DB', cargvalo, -1 * cargvalo)
                  INTO nuInteres
                  FROM cargos
                 WHERE cargdoso =
                       'ID-' ||
                       substr(tbCargos(i).cargdoso,
                              4,
                              length(tbCargos(i).cargdoso) - 3)
                   AND cargcuco = tbCargos(i).cargcuco;

              EXCEPTION
                WHEN OTHERS THEN
                  nuInteres := 0;
              END;

              ------------------------
              --200-2156 Inicio
              --OBS. Se captura informacion del concepto ID-
              -- Se guarda en memoria para indicar que ya fue agregado.
              ------------------------
              BEGIN

                SELECT c.cargconc, c.cargdoso, c.cargvalo
                  INTO nucargconc, sbcargdoso, nucargvalo
                  FROM OPEN.cargos c
                 WHERE cargdoso =
                       'ID-' ||
                       substr(tbCargos(i).cargdoso,
                              4,
                              length(tbCargos(i).cargdoso) - 3)
                   AND cargcuco = tbCargos(i).cargcuco;

              EXCEPTION
                WHEN OTHERS THEN
                  nuInteres := 0;
              END;

              sbindice := lpad(nucargconc, 4, '0') || sbcargdoso;
              --dbms_output.put_line('lo agrega -->' || sbindice);
              tConcep(sbindice).cargconc := nucargconc;
              tConcep(sbindice).cargdoso := sbcargdoso;
              tConcep(sbindice).cargvalo := nucargvalo;

              ----------------------
              --200-2156 Fin
              ----------------------

            END IF;

            tbCargosOrdered(inx).ETIQUETA := '32';
            tbCargosOrdered(inx).CONCEPTO_ID := tbCargos(i).cargconc; -- Agordilllo Incidente.140493
            tbCargosOrdered(inx).CONCEPTOS := tbCargos(i).concdefa;
            tbCargosOrdered(inx).SIGNO := tbCargos(i).cargsign; -- Agordilllo Incidente.143745
            tbCargosOrdered(inx).CAR_DOSO := tbCargos(i).cargdoso; -- Agordilllo Incidente.140493
            tbCargosOrdered(inx).CAR_CACA := tbCargos(i).cargcaca; -- Agordilllo Incidente.140493
            tbCargosOrdered(inx).SALDO_ANT := NULL;
            tbCargosOrdered(inx).CAPITAL := tbCargos(i).cargvalo;
            tbCargosOrdered(inx).INTERES := nuInteres;
            tbCargosOrdered(inx).TOTAL := NULL;
            tbCargosOrdered(inx).SALDO_DIF := nuDifesape;
            tbCargosOrdered(inx).CUOTAS := nuDifecuotas;
            -- tbCargosOrdered(inx).SERVICIO := tbCargos(i).servicio; -- CA 200-342

            inx := inx + 1;

            -- Inicio CA 200-342
            IF fblAplicaEntrega(csbBSS_FAC_SMS_200342) THEN
              tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
            END IF;
            -- Fin CA 200-342

        --------------------------------------------------------------------------------------------------
        -- Inicia Agordillo Incidente 140493
        -- Se agrega la condicion and (tbCargos(i).cargcaca !=51)
        -- para que se incluya los diferidos cuando no corresponden a cuota
          WHEN substr(tbCargos(i).cargdoso, 0, 3) = 'DF-' AND
               (tbCargos(i).cargcaca != 51) THEN

            --Mmejia.Aranda 6477
            --Se almacena los codigo de los diferidos en la tabla
            nuIndex := SUBSTR(tbcargos(i).cargdoso,
                              4,
                              LENGTH(tbcargos(i).cargdoso) - 3);
            gtbFinancion(nuIndex) := SUBSTR(tbcargos(i).cargdoso,
                                            4,
                                            LENGTH(tbcargos(i).cargdoso) - 3);

            tbCargosOrdered(inx).ETIQUETA := '32';
            tbCargosOrdered(inx).CONCEPTO_ID := tbCargos(i).cargconc; -- Agordilllo Incidente.140493
            tbCargosOrdered(inx).CONCEPTOS := tbCargos(i).concdefa;
            tbCargosOrdered(inx).SIGNO := tbCargos(i).cargsign; -- Agordilllo Incidente.143745
            tbCargosOrdered(inx).CAR_DOSO := tbCargos(i).cargdoso; -- Agordilllo Incidente.140493
            tbCargosOrdered(inx).CAR_CACA := tbCargos(i).cargcaca; -- Agordilllo Incidente.140493
            tbCargosOrdered(inx).SALDO_ANT := NULL;
            tbCargosOrdered(inx).CAPITAL := tbCargos(i).cargvalo;
            tbCargosOrdered(inx).INTERES := NULL;
            tbCargosOrdered(inx).TOTAL := NULL;
            tbCargosOrdered(inx).SALDO_DIF := NULL;
            tbCargosOrdered(inx).CUOTAS := NULL;
            -- tbCargosOrdered(inx).SERVICIO := tbCargos(i).servicio; -- CA 200-342

            inx := inx + 1;

            -- Inicio CA 200-342
            IF fblAplicaEntrega(csbBSS_FAC_SMS_200342) THEN
              tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
            END IF;
            -- Fin CA 200-342

        -- Fin Agordillo Incidente 140493
        ---------------------------------------------------------------------------------------------------

          WHEN substr(tbCargos(i).cargdoso, 0, 3) = 'ID-' THEN
            -- Busca si el Interes tiene diferido padre
            BEGIN
              -- Agordillo Incidente 140493 aca generaba error cuando existe el mismo diferido
              -- liquidado para el mismo concepto en la misma cuenta de cobro mas de una vez Ej (cuota, abonos sin intereses)
              -- Se agrega la condicion (and cargcaca =51) dado que en una cuenta de cobro, solo puede
              -- Haber un cargo con causa de cargo 51 - Cuota de Diferido en FGCA
              SELECT cargdoso
                INTO nuDoso
                FROM cargos
               WHERE cargdoso =
                     'DF-' ||
                     substr(tbCargos(i).cargdoso,
                            4,
                            length(tbCargos(i).cargdoso) - 3)
                 AND cargcuco = tbCargos(i).cargcuco
                 AND cargcaca = 51; -- Agordillo Incidente 140493

            EXCEPTION
              WHEN OTHERS THEN
                nuDoso := NULL;
            END;
            -- Si no existe el diferido padre muestra el concepto
            ------------------
            --REQ.2001920 -->
            -- Si no existe el diferido padre muestra el concepto
            -- O si el concepto esta configurado para mostrarse --> ID_CONCEPT_VIEW_BILL
            ------------------
            ------------------
            --200-2156
            --OBS. Se maneja indice, para verificar si el conpceto ya fue agregado.
            -- Si el concepto ya fue agregado no lo tomo, si no lo tomo.
            --Ademas se cambia la logica del parametro del caso 200-1920
            ------------------
            sbindice := lpad(tbCargos(i).cargconc, 4, '0') || tbCargos(i)
                       .cargdoso;
            --dbms_output.put_line('lo valida -->' || sbindice);

            IF nuDoso IS NULL OR NOT tConcep.EXISTS(sbindice)
            /*instr('|' || sbConcIncluFact || '|',
                                             '|' || tbCargos(i).cargconc || '|') > 0*/
             THEN
              --REQ.2001920: Fin.
              --200-2156 Fin.
              IF tbCargos(i).SERVCODI = 7053 THEN

                nuDifesape   := NULL;
                nuDifecuotas := NULL;
              ELSE

                --Mmejia.Aranda 6477
                --Se almacena los codigo de los diferidos en la tabla
                nuIndex := SUBSTR(tbcargos(i).cargdoso,
                                  4,
                                  LENGTH(tbcargos(i).cargdoso) - 3);
                gtbFinancion(nuIndex) := SUBSTR(tbcargos(i).cargdoso,
                                                4,
                                                LENGTH(tbcargos(i).cargdoso) - 3);

                BEGIN

                  SELECT decode(difesign, 'DB', difesape, -1 * difesape),
                         (difenucu - difecupa)
                    INTO nuDifesape, nuDifecuotas
                    FROM diferido
                   WHERE difecodi =
                         substr(tbCargos(i).cargdoso,
                                4,
                                length(tbCargos(i).cargdoso) - 3);
                EXCEPTION
                  WHEN OTHERS THEN
                    nuDifesape   := 0;
                    nuDifecuotas := 0;
                END;
              END IF;

              tbCargosOrdered(inx).ETIQUETA := '32';
              tbCargosOrdered(inx).CONCEPTO_ID := tbCargos(i).cargconc; -- Agordilllo Incidente.140493
              tbCargosOrdered(inx).CONCEPTOS := tbCargos(i).concdefa;
              tbCargosOrdered(inx).SIGNO := tbCargos(i).cargsign; -- Agordilllo Incidente.143745
              tbCargosOrdered(inx).CAR_DOSO := tbCargos(i).cargdoso; -- Agordilllo Incidente.140493
              tbCargosOrdered(inx).CAR_CACA := tbCargos(i).cargcaca; -- Agordilllo Incidente.140493
              tbCargosOrdered(inx).SALDO_ANT := NULL;
              tbCargosOrdered(inx).CAPITAL := 0;
              tbCargosOrdered(inx).INTERES := tbCargos(i).cargvalo;
              tbCargosOrdered(inx).TOTAL := NULL;
              tbCargosOrdered(inx).SALDO_DIF := nuDifesape;
              tbCargosOrdered(inx).CUOTAS := nuDifecuotas;
              -- tbCargosOrdered(inx).SERVICIO := tbCargos(i).servicio; -- CA 200-342

              inx := inx + 1;

              -- Inicio CA 200-342
              IF fblAplicaEntrega(csbBSS_FAC_SMS_200342) THEN
                tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
              END IF;
              -- Fin CA 200-342

            END IF;

          ELSE

            NULL;
        END CASE;

        -- Acumulaci?n de totales

        IF tbCargos(i).cargsign IN ('CR', 'AS', 'PA', 'DB') THEN
          -- Acumula intereres de financiaci?n e IVA
          IF (substr(tbCargos(i).cargdoso, 0, 3) = 'ID-') OR
             instr('|' || sbConcRecamora || '|',
                   '|' || tbCargos(i).cargconc || '|') > 0 THEN

            tbCargosOrdered(-1).INTERES := tbCargosOrdered(-1)
                                           .INTERES + tbCargos(i).cargvalo;
          ELSE
            tbCargosOrdered(-1).CAPITAL := tbCargosOrdered(-1)
                                           .CAPITAL + tbCargos(i).cargvalo;
          END IF;

          tbCargosOrdered(-1).TOTAL := tbCargosOrdered(-1)
                                       .TOTAL + tbCargos(i).cargvalo;

          IF substr(tbCargos(i).cargdoso, 0, 3) = 'DF-' AND tbCargos(i)
            .SERVCODI <> 7053 AND tbCargos(i).cargcaca = 51 -- Incidente 140493, Agordillo acumula total cuando es cuota
           THEN

            --Mmejia.Aranda 6477
            --Se almacena los codigo de los diferidos en la tabla
            nuIndex := SUBSTR(tbcargos(i).cargdoso,
                              4,
                              LENGTH(tbcargos(i).cargdoso) - 3);
            gtbFinancion(nuIndex) := SUBSTR(tbcargos(i).cargdoso,
                                            4,
                                            LENGTH(tbcargos(i).cargdoso) - 3);

            BEGIN

              SELECT decode(difesign, 'DB', difesape, -1 * difesape)
                INTO nuDifesape
                FROM diferido
               WHERE difecodi =
                     substr(tbCargos(i).cargdoso,
                            4,
                            length(tbCargos(i).cargdoso) - 3);

            EXCEPTION
              WHEN OTHERS THEN
                nuDifesape := 0;
            END;

            tbCargosOrdered(-1).SALDO_DIF := tbCargosOrdered(-1)
                                             .SALDO_DIF + nuDifesape;

          END IF;

        END IF;

        -- Muestra el IVA, Recamora y Total si el servicio cambia
        IF tbCargos.NEXT(i) IS NULL THEN

          --Aranada.8199
          --Mejia
          --05-08-2015
          --Se traslada la logica de diferidos no asociados a cuentas de cobro
          --para que se procese antes de de calcular el total de la factura

          --Aranda.6477
          --Mmejia
          --Se agrega  la logica para agregar a los detalles de factura
          --los diferidos que no estan asociados a una cuenta de cobro.
          ut_trace.Trace(' LDC_DetalleFact_GasCaribe.RfConcepParcial Inicio Almacenar diferidos restantes',
                         10);
          IF (tbCargosOrdered.Count() > 0) THEN
            ut_trace.Trace(' LDC_DetalleFact_GasCaribe.RfConcepParcial Inicio Almacenar diferidos restantes 1',
                           10);

            k := tbCargosOrdered.FIRST;

            LOOP
              EXIT WHEN k IS NULL;
              IF (tbCargosOrdered(k)
                 .CONCEPTO_ID IS NOT NULL AND k NOT IN (-1, -2, -3)) THEN
                inxConc := To_Char(tbCargosOrdered(k).CONCEPTO_ID, '0000');
                inxConc := RTrim(LTrim(inxConc));
                ut_trace.Trace(' LDC_DetalleFact_GasCaribe.RfConcepParcial Inicio Almacenar diferidos restantes inxConc[' ||
                               inxConc || ']idx[' || k || ']',
                               10);
                gtbConceptos(inxConc) := k;
              END IF;
              k := tbCargosOrdered.NEXT(k);
            END LOOP;
          END IF;
          ut_trace.Trace(' LDC_DetalleFact_GasCaribe.RfConcepParcial Fin  Almacenar diferidos restantes gtbConceptos.COUNT[' ||
                         gtbConceptos.COUNT || ']',
                         10);

          --Validacion diferidos con saldo no asociados a una cuenta de cobro
          OPEN cuDiferidos;
          FETCH cuDiferidos BULK COLLECT
            INTO tdiferidos;
          CLOSE cuDiferidos;

          k := tdiferidos.FIRST;

          LOOP
            EXIT WHEN k IS NULL;

            IF (NOT gtbFinancion.EXISTS(tdiferidos(k).difecodi)) THEN
              -- Creacion de detalles
              inxConc := To_Char(tdiferidos(k).difeconc, '0000');
              inxConc := RTrim(LTrim(inx));
              --inx := inx + 1;

              ut_trace.TRACE('   tdiferidos (k).difecodi[' || tdiferidos(k)
                             .difecodi || '] inx [' || inx || ']',
                             15);

              -- Agordillo SAO.369165
              -- 17/12/2015 Se agrega el IF para validar si el servicio es 7053, se asigne null al saldo pendiente y numero de cuotas
              -- al diferido dado que esta informacion no se muestra en la factura.
              nuServicio := pktblservsusc.fnugetsesuserv(tdiferidos(k)
                                                         .difenuse);
              IF nuServicio = 7053 THEN

                nuDifesape := NULL;
                tdiferidos(k).difesape := NULL;

                nuDifecuotas := NULL;
                tdiferidos(k).difenucu := NULL;

              ELSE

                nuDifesape := nuDifesape + tdiferidos(k).difesape;

                -- Inicio CA 200-849.
                -- Se acumula el saldo diferido para incluir el valor de los
                -- diferidos que aun no se estan facturando
                IF fblaplicaentrega(csbBSS_FAC_SMS_200849) THEN
                  tbCargosOrdered(-1).saldo_dif := tbCargosOrdered(-1)
                                                   .saldo_dif + tDiferidos(k)
                                                   .difesape;
                END IF;
                -- Fin CA 200-849.

              END IF;

              -- Agordillo SAO.369165
              -- 17/12/2015 Se agrega la condicion and nuServicio != 7053 para que solo se sume el saldo de diferido
              -- Cuando el servicio es diferente 7053

              --Valida si existe
              IF (gtbConceptos.EXISTS(inxConc) AND nuServicio != 7053) THEN
                ut_trace.TRACE('   tdiferidos (k).difecodi[' || tdiferidos(k)
                               .difecodi || '] EXISTE ',
                               15);
                inx := gtbConceptos(inxConc);
                tbcargosordered(inx).SALDO_DIF := tbcargosordered(inx)
                                                  .SALDO_DIF + tdiferidos(k)
                                                  .difesape;

              ELSE
                ut_trace.TRACE('   tdiferidos (k).difecodi[' || tdiferidos(k)
                               .difecodi || '] NO EXISTE ',
                               15);
                tbCargosOrdered(inx).ETIQUETA := '32';
                ut_trace.TRACE('   tdiferidos (k).difecodi[' || tdiferidos(k)
                               .difecodi || '] NO EXISTE ',
                               15);
                tbCargosOrdered(inx).CONCEPTO_ID := tdiferidos(k).difeconc;
                tbCargosOrdered(inx).CONCEPTOS := tdiferidos(k).concdefa;
                ut_trace.TRACE('   tdiferidos (k).difecodi[' || tdiferidos(k)
                               .difecodi || '] NO EXISTE ',
                               15);
                tbCargosOrdered(inx).SIGNO := NULL;
                tbCargosOrdered(inx).CAR_DOSO := NULL;
                tbCargosOrdered(inx).CAR_CACA := NULL;
                tbCargosOrdered(inx).SALDO_ANT := NULL;
                tbCargosOrdered(inx).CAPITAL := 0;
                tbCargosOrdered(inx).INTERES := NULL;
                tbCargosOrdered(inx).TOTAL := NULL;
                ut_trace.TRACE('   tdiferidos (k).difecodi[' || tdiferidos(k)
                               .difecodi || '] NO EXISTE ',
                               15);
                tbCargosOrdered(inx).SALDO_DIF := tdiferidos(k).difesape;
                tbCargosOrdered(inx).CUOTAS := tdiferidos(k).difenucu;
                ut_trace.TRACE('   tdiferidos (k).difecodi[' || tdiferidos(k)
                               .difecodi || '] NO EXISTE ',
                               15);
                inx := inx + 1;

                -- Inicio CA 200-342
                IF fblAplicaEntrega(csbBSS_FAC_SMS_200342) THEN
                  tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
                END IF;
                -- Fin CA 200-342

              END IF;

            END IF;
            k := tdiferidos.NEXT(k);
          END LOOP;

          ut_trace.TRACE('   RfConcepParcial Termina  loop de difereidos',
                         15);

          --inx := inx + 1;

          IF tbCargosOrdered(-2).CAPITAL <> 0 THEN
            tbCargosOrdered(inx) := tbCargosOrdered(-2);
            inx := inx + 1;

            -- Inicio CA 200-342
            IF fblAplicaEntrega(csbBSS_FAC_SMS_200342) THEN
              tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
            END IF;
            -- Fin CA 200-342

          END IF;

          IF tbCargosOrdered(-3).INTERES <> 0 THEN
            tbCargosOrdered(inx) := tbCargosOrdered(-3);
            inx := inx + 1;

            -- Inicio CA 200-342
            IF fblAplicaEntrega(csbBSS_FAC_SMS_200342) THEN
              tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
            END IF;
            -- Fin CA 200-342

          END IF;

          tbCargosOrdered(inx) := tbCargosOrdered(-1);
          inx := inx + 1;

          -- Inicio CA 200-342
          IF fblAplicaEntrega(csbBSS_FAC_SMS_200342) THEN
            tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
          END IF;
          -- Fin CA 200-342

          tbCargosOrdered.delete(-2);
          tbCargosOrdered.delete(-3);
          tbCargosOrdered.delete(-1);

        ELSE

          j := tbCargos.next(i);

          IF tbCargos(j).cargnuse <> tbCargos(i).cargnuse THEN

            IF tbCargosOrdered(-2).CAPITAL <> 0 THEN
              tbCargosOrdered(inx) := tbCargosOrdered(-2);
              inx := inx + 1;
              -- Inicio CA 200-342
              IF fblAplicaEntrega(csbBSS_FAC_SMS_200342) THEN
                tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
              END IF;
              -- Fin CA 200-342

            END IF;

            IF tbCargosOrdered(-3).INTERES <> 0 THEN
              tbCargosOrdered(inx) := tbCargosOrdered(-3);
              inx := inx + 1;

              -- Inicio CA 200-342
              IF fblAplicaEntrega(csbBSS_FAC_SMS_200342) THEN
                tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
              END IF;
              -- Fin CA 200-342

            END IF;

            tbCargosOrdered(inx) := tbCargosOrdered(-1);
            inx := inx + 1;

            -- Inicio CA 200-342
            IF fblAplicaEntrega(csbBSS_FAC_SMS_200342) THEN
              tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
            END IF;
            -- Fin CA 200-342

            tbCargosOrdered.delete(-2);
            tbCargosOrdered.delete(-3);
            tbCargosOrdered.delete(-1);

          END IF;

        END IF;

        -- reasigna el servicio para los cambios
        nuLastSesu := tbCargos(i).cargnuse;

        i := tbCargos.next(i);

      END LOOP;
      tConcep.Delete; -- Se formatea tabla temporal

      DELETE FROM LDC_CONC_FACTURA_TEMP;

      ut_trace.TRACE('   tbCargosOrdered.count[' || tbCargosOrdered.Count || '] ',
                     15);

      -- Agordilllo Incidente.140493
      -- Se agrega la columna orden a la tabla PL, para mantener el orden cuando se agrupen los datos.
      FOR i IN tbCargosOrdered.first .. tbCargosOrdered.last LOOP
        tbCargosOrdered(i).ORDEN := i;
      END LOOP;

      -- Agordilllo Incidente.143745
      FORALL i IN tbCargosOrdered.first .. tbCargosOrdered.last
        INSERT INTO LDC_CONC_FACTURA_TEMP
          (ID,
           CONCEPTO_ID,
           CONCEPTO,
           CONC_SIGNO,
           TIPO_CONCEPTO,
           ORDEN_CONCEPTO,
           VALOR_MES,
           PRESENTE_MES,
           AMORTIZACION,
           SALDO_DIFERIDO,
           VENCIDO,
           TASA_INTERES,
           CUOTAS_PENDIENTES,
           SERVICIO,
           PRODUCTO,
           DOC_SOPORTE,
           CAU_CARGO)
        VALUES
          (tbCargosOrdered(i).ETIQUETA,
           tbCargosOrdered(i).CONCEPTO_ID,
           tbCargosOrdered(i).CONCEPTOS,
           tbCargosOrdered(i).SIGNO,
           NULL,
           tbCargosOrdered(i).ORDEN, -- Agordilllo Incidente.140493
           tbCargosOrdered(i).CAPITAL,
           tbCargosOrdered(i).TOTAL,
           tbCargosOrdered(i).INTERES,
           tbCargosOrdered(i).SALDO_DIF,
           tbCargosOrdered(i).SALDO_ANT,
           NULL,
           tbCargosOrdered(i).CUOTAS,
           decode(nuAplicaEntrega200342,
                  0,
                  NULL,
                  tbCargosOrdered(i).servicio),
           NULL,
           tbCargosOrdered(i).CAR_DOSO,
           tbCargosOrdered(i).CAR_CACA);

      -- Agordilllo Incidente.140493
      -- Se agrega el llamado  a la funcion fnuCanConceptos, dado que para mostrarse los datos se agrupan,
      -- y el numero de concepto no corresponden a los datos inciales sin agrupacion
      gnuConcNumber := LDC_DetalleFact_GasCaribe.fnuCanConceptos; --tbCargosOrdered.COUNT ;

    ELSE

      -- Crear detalles para los no regulados

      i := tbCargos.first;

      LOOP

        EXIT WHEN i IS NULL;

        -- Imprime encabezado si cambia de servicio suscrito
        IF nuLastSesu = -1 THEN

          -- Crea el detalle de total
          tbCargosOrdered(-1).ETIQUETA := '36';
          tbCargosOrdered(-1).CONCEPTOS := 'TOTALES';
          tbCargosOrdered(-1).CAPITAL := 0;
          tbCargosOrdered(-1).INTERES := 0;
          tbCargosOrdered(-1).TOTAL := 0;
          tbCargosOrdered(-1).SALDO_DIF := pkbobillprintheaderrules.fnugettotalpreviousbalance -
                                           pkbobillprintheaderrules.fsbgetpositivebalance;

        END IF;

        -- Crea los detalles

        IF tbCargos(i).cargsign IN ('CR', 'AS', 'PA') THEN
          tbCargos(i).cargvalo := -1 * tbCargos(i).cargvalo;
        ELSIF tbCargos(i).cargsign IN ('DB') THEN
          tbCargos(i).cargvalo := tbCargos(i).cargvalo;
        ELSE
          tbCargos(i).cargvalo := 0;
        END IF;

        IF instr('|' || sbConcIVA || '|',
                 '|' || tbCargos(i).cargconc || '|') = 0 THEN

          tbCargosOrdered(inx).ETIQUETA := '35';
          tbCargosOrdered(inx).CONCEPTO_ID := tbCargos(i).cargconc; -- Agordilllo Incidente.140493
          tbCargosOrdered(inx).CONCEPTOS := tbCargos(i).concdefa;
          tbCargosOrdered(inx).SIGNO := tbCargos(i).cargsign; -- Agordilllo Incidente.143745
          tbCargosOrdered(inx).CAR_DOSO := tbCargos(i).cargdoso; -- Agordilllo Incidente.140493
          tbCargosOrdered(inx).CAR_CACA := tbCargos(i).cargcaca; -- Agordilllo Incidente.140493
          tbCargosOrdered(inx).SALDO_ANT := NULL;
          tbCargosOrdered(inx).CAPITAL := tbCargos(i).cargvalo;
          tbCargosOrdered(inx).INTERES := NULL;
          tbCargosOrdered(inx).TOTAL := NULL;
          tbCargosOrdered(inx).SALDO_DIF := NULL;

          IF tbCargos(i).cargconc IN (nuConcSuministro, nuConcComercial) THEN

            tbCargosOrdered(inx).CUOTAS := tbCargos(i).cargunid;

          END IF;

          inx := inx + 1;

        END IF;

        -- Acumulaci?n de totales

        IF tbCargos(i).cargsign IN ('CR', 'AS', 'DB') THEN
          -- Agordillo Incidente.143745 se excluyen los totales de PA

          IF instr('|' || sbConcIVA || '|',
                   '|' || tbCargos(i).cargconc || '|') > 0 THEN
            tbCargosOrdered(-1).INTERES := tbCargosOrdered(-1)
                                           .INTERES + tbCargos(i).cargvalo;
          ELSE
            tbCargosOrdered(-1).CAPITAL := tbCargosOrdered(-1)
                                           .CAPITAL + tbCargos(i).cargvalo;
            tbCargosOrdered(-1).SALDO_DIF := tbCargosOrdered(-1).SALDO_DIF + tbCargos(i)
                                             .cargvalo;
          END IF;

          tbCargosOrdered(-1).TOTAL := tbCargosOrdered(-1)
                                       .TOTAL + tbCargos(i).cargvalo;

        END IF;

        -- Muestra los totales si el servicio cambia

        IF tbCargos.next(i) IS NULL THEN

          -- tbCargosOrdered(inx) := tbCargosOrdered(-1);
          -- inx := inx +1;
          gsbTotal         := tbCargosOrdered(-1).TOTAL;
          gsbIVANoRegulado := tbCargosOrdered(-1).INTERES;
          gsbSubtotalNoReg := tbCargosOrdered(-1).SALDO_DIF;
          gsbCargosMes     := tbCargosOrdered(-1).CAPITAL;

          tbCargosOrdered.delete(-1);

        END IF;

        -- reasigna el servicio para los cambios
        nuLastSesu := tbCargos(i).cargnuse;

        i := tbCargos.next(i);

      END LOOP;

      DELETE FROM LDC_CONC_FACTURA_TEMP;

      --gnuConcNumber := LDC_DetalleFact_GasCaribe.fnuCanConceptos; --tbCargosOrdered.COUNT;

      FOR i IN tbCargosOrdered.first .. tbCargosOrdered.last LOOP
        tbCargosOrdered(i).ORDEN := i;
      END LOOP;

      -- Agordilllo Incidente.143745
      FORALL i IN tbCargosOrdered.first .. tbCargosOrdered.last
        INSERT INTO LDC_CONC_FACTURA_TEMP
          (ID,
           CONCEPTO_ID,
           CONCEPTO,
           CONC_SIGNO,
           TIPO_CONCEPTO,
           ORDEN_CONCEPTO,
           VALOR_MES,
           PRESENTE_MES,
           AMORTIZACION,
           SALDO_DIFERIDO,
           VENCIDO,
           TASA_INTERES,
           CUOTAS_PENDIENTES,
           SERVICIO,
           PRODUCTO,
           DOC_SOPORTE,
           CAU_CARGO)
        VALUES
          (tbCargosOrdered(i).ETIQUETA,
           tbCargosOrdered(i).CONCEPTO_ID,
           tbCargosOrdered(i).CONCEPTOS,
           tbCargosOrdered(i).SIGNO,
           NULL,
           tbCargosOrdered(i).ORDEN, -- Agordilllo Incidente.140493
           tbCargosOrdered(i).CAPITAL,
           tbCargosOrdered(i).TOTAL,
           tbCargosOrdered(i).INTERES,
           tbCargosOrdered(i).SALDO_DIF,
           NULL,
           NULL,
           NULL,
           NULL,
           tbCargosOrdered(i).CUOTAS,
           tbCargosOrdered(i).CAR_DOSO,
           tbCargosOrdered(i).CAR_CACA);

      -- Agordilllo Incidente.140493
      -- Se agrega el llamado  a la funcion fnuCanConceptos, dado que para mostrarse los datos se agrupan,
      -- y el numero de concepto no corresponden a los datos inciales sin agrupacion
      gnuConcNumber := LDC_DetalleFact_GasCaribe.fnuCanConceptos; --tbCargosOrdered.COUNT ;

    END IF;

    ut_trace.trace('TOTAL:' || gsbTotal || ' IVA:' || gsbIVANoRegulado ||
                   ' SUBTOTAL:' || gsbSubtotalNoReg || ' CARGOSMES:' ||
                   gsbCargosMes || ' CANTIDAD_CONC:' || gnuConcNumber,
                   15);

    OPEN orfcursor FOR
      SELECT TO_CHAR(gsbTotal, 'FM999,999,999,990') TOTAL,
             TO_CHAR(gsbIVANoRegulado, 'FM999,999,999,990') IVA,
             TO_CHAR(gsbSubtotalNoReg, 'FM999,999,999,990') SUBTOTAL,
             TO_CHAR(gsbCargosMes, 'FM999,999,999,990') CARGOSMES,
             gnuConcNumber CANTIDAD_CONC

        FROM DUAL;

  END RfConcepParcial;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfRangosConsumo
  Descripcion    : Procedimiento para extraer los campos relacionados
                   con los datos del medidor.
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================

  orfcursor            Retorna los datos de las fechas de revision

  Fecha           Autor               Modificacion
  =========       =========           ====================
  15/05/2018      Jorge Valiente      CASO 200-1427: Tomar de instancia APLICA para establecer
                                                     datos de rango de consumo a KISOKO .NET
   02-03-2015     agordillo          Incidente 143186 Modificacion
                                     Se comenta la consulta donde se obtiene los rango liquidados, dado que estos datos se
                                     obtienen el en cursor orfcursor, adicional cuando
                                     se le liquida al usuario mas de un rango de consumo genera error.
  02-03-2015      Llozada            Se modifica la l?gica para que ubique el consumo en el rango de la tarifa
                                     correspondiente
  12/02/2015      agordillo          Incidente.140643 Modificacion
                                      * Se modifica el select para obtener el maximo rango liquidado al cliente,
                                      y se le agrega relacion de concepto y servicio. Dado que pueden existir
                                      varlos registros con el mismo cargdoso y que no corresponden al mismo producto
                                      y al concepto de consumo
                                      * Se modifica el cursor orfcursor para que se filtre por el concepto de consumo
                                      dado que pueden existir varios rango liquidados y no corresponden al consumo.
  11/11/2014      ggamarra           Creacion.

  ******************************************************************/

  PROCEDURE RfRangosConsumo(orfcursor OUT constants.tyRefCursor) IS
    sbFactcodi     ge_boInstanceControl.stysbValue;
    sbFactsusc     ge_boInstanceControl.stysbValue;
    blNRegulado    BOOLEAN;
    nuTari         NUMBER;
    nuLimite       NUMBER;
    nuConsec       NUMBER;
    nuLimiSuperior NUMBER;
    nuSesu         NUMBER;
    nuBlankRanks   NUMBER;
    nuConcConsumo  NUMBER := 31; -- Agordillo Incidente.140643
    nuLimInferior  rangliqu.raliliir%TYPE;
    nuLimSuperior  rangliqu.ralilisr%TYPE;
    nuValorUnidad  rangliqu.ralivalo%TYPE;
    nuConsumo      rangliqu.raliunli%TYPE;
    nuValConsumo   rangliqu.ralivaul%TYPE;

    --Varciable CASO 200-1427
    sbAplicaNET ge_boInstanceControl.stysbValue;

  BEGIN

    -- Obtiene el identificador de la factura instanciada
    sbFactcodi := obtenervalorinstancia('FACTURA', 'FACTCODI');
    sbFactsusc := obtenervalorinstancia('FACTURA', 'FACTSUSC');

    --Inicio caso 200-1427
    sbAplicaNET := obtenervalorinstancia('FACTURA', 'APLICA');
    IF sbAplicaNET IS NULL THEN
      sbAplicaNET := '0';
    END IF;
    dbms_output.put_line(sbAplicaNET);
    --FIn CASO 200-1427

    blNRegulado := fblNoRegulado(sbFactsusc);

    -- Obtener la tarifa

    --CCASO 200-1427
    --Cambio de logica para .NET KISOKO
    --IF NOT blNRegulado THEN
    IF NOT blNRegulado OR sbAplicaNET = '1' THEN
      --
      BEGIN
        IF sbAplicaNET = '1' THEN
          -- CASO 200-1427
          SELECT MAX(ralilisr), MAX(raliidre), MAX(ralicodo), MAX(cargnuse)
            INTO nuLimite, nuTari, nuConsec, nuSesu
            FROM cargos, cuencobr, rangliqu, servsusc
           WHERE cargcuco = cucocodi
                --AND    cucofact = sbFactcodi
             AND cargdoso LIKE 'CO-%TC-%'
             AND cargdoso NOT LIKE 'CO-PR%TC-%'
             AND cargconc = nuConcConsumo
             AND raliconc = cargconc -- Agordillo Incidente.140643
             AND cuconuse = ralisesu -- Agordillo Incidente.140643
             AND cargcodo = ralicodo
             AND ralisesu = sesunuse
             and sesususc = sbFactsusc;
        ELSE
          --CONSULTA ORIGINAL
          SELECT MAX(ralilisr), MAX(raliidre), MAX(ralicodo), MAX(cargnuse)
            INTO nuLimite, nuTari, nuConsec, nuSesu
            FROM cargos, cuencobr, rangliqu
           WHERE cargcuco = cucocodi
             AND cucofact = sbFactcodi
             AND cargdoso LIKE 'CO-%TC-%'
             AND cargdoso NOT LIKE 'CO-PR%TC-%'
             AND cargconc = nuConcConsumo
             AND raliconc = cargconc -- Agordillo Incidente.140643
             AND cuconuse = ralisesu -- Agordillo Incidente.140643
             AND cargcodo = ralicodo;
        END IF; --IF sbAplicaNET = '1' THEN
      EXCEPTION
        WHEN OTHERS THEN
          nuLimite := -1;
          nuTari   := -1;
          nuConsec := -1;
          nuSesu   := -1;
      END;

      -- Hallar cantidad de rangos

      IF nuTari > 0 THEN

        SELECT 7 - COUNT(1)
          INTO nuBlankRanks
          FROM ta_rangvitc
         WHERE ravtvitc = nuTari;

      ELSE

        nuBlankRanks := 7;

      END IF;

      -- Hallar el limite superior de la tarifa
      BEGIN

        SELECT MAX(ravtlisu)
          INTO nuLimiSuperior
          FROM ta_rangvitc
         WHERE ravtvitc = nuTari;

      EXCEPTION
        WHEN OTHERS THEN
          nuLimiSuperior := -1;
      END;

      -- Agordillo Incidente 143186
      -- Se comenta la siguiente consulta dado que estos datos se obtienen el en cursor orfcursor, adicional cuando
      -- se liquida al usuario mas de un rango genera error.
      /*  SELECT raliliir LIM_INFERIOR ,ralilisr LIM_SUPERIOR, ralivalo VALOR_UNIDAD, raliunli CONSUMO, ralivaul  VAL_CONSUMO
      into  nuLimInferior, nuLimSuperior, nuValorUnidad, nuConsumo, nuValConsumo
      FROM  rangliqu
      WHERE ralicodo = nuConsec
      AND ralisesu  = nuSesu
      and raliconc = nuConcConsumo;   -- Agordillo Incidente.140643  */

      OPEN orfcursor FOR
        SELECT LIM_INFERIOR LIM_INFERIOR,
               decode(LIM_SUPERIOR, nuLimiSuperior, 'MAS', LIM_SUPERIOR) LIM_SUPERIOR,
               VALOR_UNIDAD VALOR_UNIDAD,
               CONSUMO CONSUMO,
               TO_CHAR(VAL_CONSUMO, 'FM999,999,999,990.00') VAL_CONSUMO
          FROM (
                --02-03-2015 Llozada: Se comenta porque el consumo debe ubicarse de acuerdo al rango
                /*SELECT raliliir LIM_INFERIOR ,ralilisr LIM_SUPERIOR, ralivalo VALOR_UNIDAD, raliunli CONSUMO, ralivaul  VAL_CONSUMO
                FROM    rangliqu
                WHERE ralicodo = nuConsec
                AND ralisesu  = nuSesu
                and raliconc = nuConcConsumo   -- Agordillo Incidente.140643
                union
                SELECT  ravtliin LIM_INFERIOR, ravtlisu LIM_SUPERIOR, ravtvalo VALOR_UNIDAD,  0 CONSUMO, 0 VAL_CONSUMO
                FROM  ta_rangvitc
                WHERE ravtvitc = nuTari
                AND ravtliin > nuLimite*/

                --02-03-2015 Llozada: Se ubican las tarifas liquidadas en los rangos de la tarifa
                SELECT rango_tarifas.LIM_INFERIOR,
                        rango_tarifas.LIM_SUPERIOR,
                        nvl(rango_liquidado.VALOR_UNIDAD, 0) VALOR_UNIDAD,
                        nvl(rango_liquidado.CONSUMO, 0) CONSUMO,
                        nvl(rango_liquidado.VAL_CONSUMO, 0) VAL_CONSUMO
                  FROM (SELECT ravtliin LIM_INFERIOR,
                                ravtlisu LIM_SUPERIOR,
                                0        VALOR_UNIDAD,
                                0        CONSUMO,
                                0        VAL_CONSUMO
                           FROM open.ta_rangvitc
                          WHERE ravtvitc = nuTari) rango_tarifas,
                        (SELECT raliliir LIM_INFERIOR,
                                ralilisr LIM_SUPERIOR,
                                ralivalo VALOR_UNIDAD,
                                raliunli CONSUMO,
                                ralivaul VAL_CONSUMO
                           FROM open.rangliqu
                          WHERE ralicodo = nuConsec
                            AND ralisesu = nuSesu
                            AND raliconc = nuConcConsumo) rango_liquidado
                 WHERE rango_tarifas.LIM_INFERIOR =
                       rango_liquidado.LIM_INFERIOR(+)
                   AND rango_tarifas.LIM_SUPERIOR =
                       rango_liquidado.LIM_SUPERIOR(+))
        UNION ALL
        SELECT NULL LIM_INFERIOR,
               NULL LIM_SUPERIOR,
               NULL VALOR_UNIDAD,
               NULL CONSUMO,
               NULL VAL_CONSUMO
          FROM servsusc
         WHERE rownum <= nuBlankRanks;

    ELSE

      nuBlankRanks := 7;

      OPEN orfcursor FOR
        SELECT NULL LIM_INFERIOR,
               NULL LIM_SUPERIOR,
               NULL VALOR_UNIDAD,
               NULL CONSUMO,
               NULL VAL_CONSUMO
          FROM servsusc
         WHERE rownum <= nuBlankRanks;

    END IF;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END RfRangosConsumo;

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :  fnuConceptoComponent
  Descripcion : Obtiene el concepto del componente de costo dado su nombre Ej: GM,TM etc
  Parametros  : Recibe como parametro de entrada la abreviacion del componente.
  Autor       : Alexandra Gordillo

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  18-03-2015          agordillo            Creacion. Incidente.140493

  **************************************************************************/
  FUNCTION fnuConceptoComponent(isbComponente IN VARCHAR2) RETURN NUMBER IS
    nuConcepto      NUMBER;
    nuEqComponentes NUMBER := 15000;
  BEGIN

    -- Consulta los componentes de costo
    SELECT to_number(target_value)
      INTO nuConcepto
      FROM ge_equivalenc_values
     WHERE equivalence_set_id = nuEqComponentes
       AND upper(origin_value) LIKE '%' || upper(isbComponente) || '%';

    RETURN nuConcepto;

  EXCEPTION
    WHEN no_data_found THEN
      nuConcepto := 0;
      RETURN nuConcepto;
    WHEN OTHERS THEN
      nuConcepto := 0;
      RETURN nuConcepto;
  END fnuConceptoComponent;

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :  rfGetValCostCompValid
  Descripcion : Obtiene el valor de los componentes del costo
  Autor       : Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  19-03-2015          agordillo           Modificacion Incidente.140493
                                          * Se realiza el llamado a la funcion LDC_DetalleFact_GasCaribe.fnuConceptoComponent
                                          para obtener el concepto que corresponde el componente de costo.
                                          * Se agrega el  tbCompCost(6).concept para que se consulte la tarifa del concepto 741 de
                                          confibiabilidad, dado que en un futuro puede tener valor este componente.
  11-11-2014          ggamarra            Creacion.

  **************************************************************************/
  PROCEDURE rfGetValCostCompValid(orfcursor OUT constants.tyRefCursor) AS
    nuVitcons    ta_vigetaco.vitccons%TYPE;
    nuVitcvalo   ta_vigetaco.vitcvalo%TYPE;
    sbFactcodi   ge_boInstanceControl.stysbValue;
    sbFactsusc   ge_boInstanceControl.stysbValue;
    nuProducto   servsusc.sesunuse%TYPE;
    rcProduct    open.servsusc%ROWTYPE;
    blNoRegulada BOOLEAN;
    inuConcept   NUMBER;
    inuCompType  NUMBER := 1;
    inuFOT       NUMBER := 6;

    TYPE tyrcCompCost IS RECORD(
      concept NUMBER,
      valor   NUMBER);
    TYPE tytbCompCost IS TABLE OF tyrcCompCost INDEX BY BINARY_INTEGER;

    tbCompCost tytbCompCost;

  BEGIN

    --Obtiene el identificador de la factura de la instancia
    sbFactcodi := obtenervalorinstancia('FACTURA', 'FACTCODI');
    sbFactsusc := obtenervalorinstancia('FACTURA', 'FACTSUSC');
    nuProducto := fnuGetProducto(sbFactcodi);

    blNoRegulada := fblNoRegulado(sbFactsusc);

    -- Verifica si el cliente es industria no regulada

    IF NOT blNoRegulada AND nuProducto > 0 THEN

      rcProduct := pktblservsusc.frcgetrecord(nuProducto);
      pkBOInstancePrintingData.instancecurrentproduct(rcProduct);

      -- Inicia Agordillo Incidente.140493
      tbCompCost(1).concept := LDC_DetalleFact_GasCaribe.fnuConceptoComponent('GM'); -- Gm Suministro
      tbCompCost(2).concept := LDC_DetalleFact_GasCaribe.fnuConceptoComponent('TM'); -- Tm Transporte
      tbCompCost(3).concept := LDC_DetalleFact_GasCaribe.fnuConceptoComponent('DM'); -- Dm Distribuccion
      tbCompCost(4).concept := LDC_DetalleFact_GasCaribe.fnuConceptoComponent('CV'); -- Cv Comercializacion
      tbCompCost(5).concept := LDC_DetalleFact_GasCaribe.fnuConceptoComponent('CM'); -- Cm Componente Fijo
      tbCompCost(6).concept := LDC_DetalleFact_GasCaribe.fnuConceptoComponent('CC'); -- Cc Confiabilidad
      -- Fin Agordillo Incidente.140493

      FOR i IN tbCompCost.first .. tbCompCost.last LOOP

        BEGIN
          nuVitcons := open.FA_BOPrintCostCompRules.fnuGetCostCompValid(tbCompCost(i)
                                                                        .concept,
                                                                        inuCompType,
                                                                        inuFOT);

          SELECT vitcvalo
            INTO nuVitcvalo
            FROM ta_vigetaco
           WHERE vitccons = nuVitcons;

          tbCompCost(i).valor := nuVitcvalo;

        EXCEPTION
          WHEN no_data_found THEN
            --Agordillo Incidente.140493
            tbCompCost(i).valor := 0;
          WHEN OTHERS THEN
            tbCompCost(i).valor := 0;
        END;

      END LOOP;

      OPEN orfcursor FOR
        SELECT 'Gm = $' || tbCompCost(1).valor || ' Tm = $' || tbCompCost(2)
               .valor || ' Dm = $' || tbCompCost(3).valor || ' Cv = $' || tbCompCost(4)
               .valor || ' Cc = $' || tbCompCost(6).valor || -- Agordillo Incidente.140493
                ' Cm = $' || tbCompCost(5).valor COMPCOST
          FROM dual;

    ELSE
      OPEN orfcursor FOR
        SELECT '-' COMPCOST FROM dual;

    END IF;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END rfGetValCostCompValid;

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :  rfGetValRates
  Descripcion : Obtiene el valor de las tasas
  Autor       : Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014          ggamarra            Creacion.

  **************************************************************************/
  PROCEDURE rfGetValRates(orfcursor OUT constants.tyRefCursor) AS

    sbFactcodi   ge_boInstanceControl.stysbValue;
    sbFactsusc   ge_boInstanceControl.stysbValue;
    blNoRegulada BOOLEAN;
    sbTP         VARCHAR2(50);
    sbTU         VARCHAR2(50);

    CURSOR cuMoneValo(sbMone valomone.vamotmde%TYPE) IS
      SELECT vamovalo
        FROM (SELECT vamovalo
                FROM valomone
               WHERE vamotmor = 'PC'
                 AND vamotmde = sbMone
               ORDER BY vamoffvi DESC)
       WHERE rownum = 1;

  BEGIN

    --Obtiene el identificador de la factura de la instancia
    sbFactcodi := obtenervalorinstancia('FACTURA', 'FACTCODI');
    sbFactsusc := obtenervalorinstancia('FACTURA', 'FACTSUSC');

    blNoRegulada := fblNoRegulado(sbFactsusc);
    -- Verifica si el cliente es industria no regulada

    IF blNoRegulada THEN

      OPEN cuMoneValo('TU');

      IF cuMoneValo%NOTFOUND THEN
        sbTU := 0;
      ELSE
        FETCH cuMoneValo
          INTO sbTU;
      END IF;

      CLOSE cuMoneValo;

      OPEN cuMoneValo('TP');

      IF cuMoneValo%NOTFOUND THEN
        sbTP := 0;
      ELSE
        FETCH cuMoneValo
          INTO sbTP;
      END IF;

      CLOSE cuMoneValo;

      OPEN orfcursor FOR
        SELECT 'Tasa Ultimo dia Mes   $' || sbTU tasa_ultima,
               'Tasa Prom. Mes        $' || sbTP tasa_promedio
          FROM dual;

    ELSE

      OPEN orfcursor FOR
        SELECT NULL tasa_ultima, NULL tasa_promedio FROM dual;

    END IF;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END rfGetValRates;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfDatosCodBarras
  Descripcion    : procedimiento para extraer los datos relacionados
                   al codigo de barras
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  11/11/2014      ggamarra             Creaci?n.
  ******************************************************************/
  PROCEDURE RfDatosCodBarras(orfcursor OUT constants.tyRefCursor)

   AS

    sbFactcodi  ge_boInstanceControl.stysbValue;
    sbCodigoEAN ld_parameter.value_chain%TYPE;
  BEGIN

    sbFactcodi  := obtenervalorinstancia('FACTURA', 'FACTCODI');
    sbCodigoEAN := dald_parameter.fsbGetValue_Chain('COD_EAN_CODIGO_BARRAS');

    OPEN orfcursor FOR
      SELECT codigo_1,
             codigo_2,
             codigo_3,
             codigo_4,
             CASE
               WHEN codigo_3 IS NOT NULL THEN
                '(415)' || codigo_1 || '(8020)' || codigo_2 || '(3900)' ||
                codigo_3 || '(96)' || codigo_4
               ELSE
                NULL
             END codigo_barras
        FROM (SELECT sbCodigoEAN codigo_1,
                     lpad(cuponume, 10, '0') codigo_2,
                     lpad(round(cupovalo), 10, '0') codigo_3,
                     to_char(ADD_MONTHS(cucofeve, 120), 'yyyymmdd') codigo_4
                FROM factura, cuencobr, cupon
               WHERE factcodi = sbFactcodi
                 AND cupodocu = factcodi
                 AND cuponume = PKBOBILLPRINTHEADERRULES.FSBGETCOUPON()
                 AND factcodi = cucofact
              UNION
              SELECT NULL, ' ', NULL, ' ' FROM dual)
       WHERE rownum = 1;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END RfDatosCodBarras;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfDatosBarCode
  Descripcion    : procedimiento para extraer los datos relacionados
                   al codigo de barras para el estado de cuenta
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  11/11/2014      ggamarra             Creaci?n.
  ******************************************************************/
  PROCEDURE RfDatosBarCode(orfcursor OUT constants.tyRefCursor)

   AS

    sbFactcodi  ge_boInstanceControl.stysbValue;
    sbCodigoEAN ld_parameter.value_chain%TYPE;
  BEGIN

    sbFactcodi  := obtenervalorinstancia('FACTURA', 'FACTCODI');
    sbCodigoEAN := dald_parameter.fsbGetValue_Chain('COD_EAN_CODIGO_BARRAS');

    OPEN orfcursor FOR
      SELECT CODE, NULL IMAGE
        FROM (SELECT '415' ||
                     dald_parameter.fsbGetValue_Chain('COD_EAN_CODIGO_BARRAS') ||
                     '8020' || lpad(cuponume, 10, '0') || chr(200) || '3900' ||
                     lpad(cupovalo, 10, '0') || chr(200) || '96' ||
                     to_char(cucofeve, 'yyyymmdd') CODE
                FROM factura, cuencobr, cupon
               WHERE factcodi = sbFactcodi
                 AND cupodocu = factcodi
                 AND cuponume = PKBOBILLPRINTHEADERRULES.FSBGETCOUPON()
                 AND factcodi = cucofact)
       WHERE rownum = 1;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END RfDatosBarCode;

  /**************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : InsLD_CUPON_CAUSAL
  Descripcion    : Procedure para utilizar en la regla POST de la solicitud
                    Solicitud de Estado de Cuenta donde se almacena el cupon del duplicado,
                    la causal de legalizacion de la solicitud.  ld_cupon_causal
                  Inserta solo si es una causal que genere cobro y si el tipo de solicitud
                  es Solicitud de Estado de Cuenta
  Autor          : pgarcia
  Fecha          : 28/10/2014

  Parametros              Descripcion
  ============         ===================
  inuPackageTypeId      Tipo de SOlicitud
  inuCuponId            Identificador del cupon
  inuCausalId           Identificador de la causal

  Fecha             Autor             Modificacion
  =========       =========           ====================
   26/12/2016     KCienfuegos         CA200-326 Se setea la variable global gTipoSolicitud
   01/06/2015      Agordillo          Creacion Cambio.7524
                                      Se copia el procedimiento InsLD_CUPON_CAUSAL del LDC_DETALLEFACT_EFIGAS
                                      se agrega a la proceso de impresion de Gases del Caribe.
  ******************************************************************/
  PROCEDURE InsLD_CUPON_CAUSAL(inuPackageTypeId IN NUMBER,
                               inuCuponId       IN NUMBER,
                               inuCausalId      IN NUMBER,
                               inuPackagesId    IN NUMBER) IS
    CURSOR cucausaldecobro(nucausal_id NUMBER) IS
      SELECT COUNT(1)
        FROM dual
       WHERE nucausal_id IN
             ((SELECT to_number(column_value)
                FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CAUSALES_COBRO_DUPLICADO',
                                                                                         NULL),
                                                        ','))));

    rcld_cupon_causal dald_cupon_causal.styld_cupon_causal;
    nucausaldecobro   NUMBER := 0;
  BEGIN

    ut_trace.trace('INICIO', 2);
    ut_trace.trace('inuPackageTypeId:' || inuPackageTypeId, 2);
    ut_trace.trace(' - inuCausalId:' || inuCausalId, 2);

    LDC_DUPLICADO_MESES_ANT.gTipoSolicitud := inuPackageTypeId;

    glPackage_type_Cupon_id := inuPackageTypeId;
    glCausal_Cupon_id       := inuCausalId;
    glPackage_Cupon_id      := inuPackagesId;
    ut_trace.trace(' - END', 2);
  EXCEPTION
    WHEN OTHERS THEN
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END InsLD_CUPON_CAUSAL;

  FUNCTION fsbCuadrillaReparto(inuOrden or_order.order_id%TYPE -- Orden
                               ) RETURN VARCHAR2 IS
    /***********************************************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fsbCuadrillaReparto
    Descripcion:        Imita la rutina de ldc_boasigauto.prasignacion con el fin de determinar el
                        codigo de la unidad operativa a la que se asignara la orden de reparto

    Autor    : Sandra Mu?oz
    Fecha    : 04-08-2016 cA200-342

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    13-09-2016   Sandra Mu?oz           Se corrige el cursor que obtiene la categoria del producto
                                        ya que no estaba retornando uno de los productos
                                        que estaban permitidos para asignacion automatica y
                                        esto hacia que no se mostrara cuadrilla en el spool
    13-09-2016   Sandra Mu?oz           Se retorna el codigo alterno o el nombre de la cuadrilla
    07-06-2016   Sandra Mu?oz           Se corrigen los cierres de cursor para evitar excepciones
                                        y se eliminan los return null para evitar que no siga
                                        evaluando los registros arrojados por el cursor principal
    04-08-2016   Sandra Mu?oz           Creacion
    ***********************************************************************************************/

    nuTipoTrabajo        or_order.task_type_id%TYPE;
    nuTipoTrabajoReparto ld_parameter.numeric_value%TYPE;
    nuPackType           ps_package_type.package_type_id%TYPE;
    exError EXCEPTION; -- Error controlado

    -- Cursor para validar las unidades opertaivas configuradas para la actividad de la orden
    -- generada por la solicitud configurada en la forma de uobysol
    CURSOR cuUoBySol(nuOrder_id   or_order_activity.order_id%TYPE,
                     nuPackage_id or_order_activity.package_id%TYPE) IS
      SELECT lptou.operating_unit_id,
             lptou.procesopre,
             lptou.procesopost,
             lptou.catecodi,
             lptou.items_id,
             ooa.product_id,
             ooa.address_id,
             ooa.activity_id,
             ooa.subscription_id
        FROM ldc_package_type_oper_unit lptou,
             ldc_package_type_assign    lpta,
             or_order_activity          ooa
       WHERE ooa.order_id = nuOrder_Id
            --AND    nvl(ooa.package_id, 0) = nvl(nupackage_id, 0)
         AND lptou.items_id = ooa.activity_id
         AND lpta.package_type_assign_id = lptou.package_type_assign_id
         AND lpta.package_type_id =
             decode(damo_packages.fnugetpackage_type_id(ooa.package_id,
                                                        NULL),
                    NULL,
                    -1,
                    damo_packages.fnugetpackage_type_id(ooa.package_id, NULL))
         AND lptou.operating_unit_id NOT IN
             (SELECT lc.operating_unit_id
                FROM ldc_caruniope lc
               WHERE lc.activo = 'N');

    tempCuUoBySol cuUoBySol%ROWTYPE;

    -- Cursor para validar la categoria a la que pertenece el suscriptor
    CURSOR cuCategoria(nuproduct_id or_order_activity.product_id%TYPE,
                       nuaddress_id or_order_activity.address_id%TYPE) IS
      SELECT pp.category_id
        FROM pr_product pp
       WHERE pp.product_id = decode(nuproduct_id,
                                    NULL,
                                    (SELECT pp1.product_id
                                       FROM pr_product pp1
                                      WHERE pp1.address_id = nuaddress_id
                                        AND pp1.product_type_id IN
                                            (SELECT to_number(column_value)
                                               FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_TIPO_SOL_ASIG',
                                                                                                                        NULL),
                                                                                       ',')))
                                        AND rownum = 1),
                                    nuproduct_id)
         AND pp.product_type_id IN
             (SELECT to_number(column_value)
                FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_TIPO_SOL_ASIG',
                                                                                         NULL),
                                                        ',')))
         AND rownum = 1;

    tempCuCategoria cuCategoria%ROWTYPE;

    -- Cursor para validar la zona de la unidad opertaiva que sera asignada desde uobysol y que esta
    -- zona maneje el secotr operativo qeu sera asignado a la orden.
    CURSOR cuGe_sectorOpe_Zona(inuOperating_sector_id or_order.operating_sector_id%TYPE,
                               inuOperating_zone_id   or_operating_unit.operating_zone_id%TYPE) IS
      SELECT gsz.*
        FROM ge_sectorope_zona gsz
       WHERE gsz.id_sector_operativo = inuOperating_sector_id
            --daor_order.fnugetoperating_sector_id(:new.order_id)
         AND gsz.id_zona_operativa = inuOperating_zone_id;

    tempCuGe_sectorope_zona cuGe_sectorope_zona%ROWTYPE;

    -- Cursor para identificar el tipo de producto y si es generico
    CURSOR cuTipoProducto(nuProduct_id or_order_activity.product_id%TYPE) IS
      SELECT NVL(p.product_type_id, 0) tipo_producto
        FROM open.pr_product p
       WHERE p.product_id = nuProduct_id
         AND p.product_type_id =
             open.dald_parameter.fnuGetNumeric_Value('COD_PRO_GEN', NULL);

    rtCuTipoProducto cuTipoProducto%ROWTYPE;

    -- Cursor para obtener la categroia de la direccion de la orden si el producto es generico
    CURSOR cuSegmentoCategoria(nuaddress_id or_order_activity.address_id%TYPE) IS
      SELECT nvl(s.category_, 0) categoria, s.subcategory_ subcategoria
        FROM open.ab_address aa, open.ab_segments s
       WHERE aa.address_id = nuaddress_id
         AND aa.segment_id = s.segments_id;

    rtCuSegmentoCategoria cuSegmentoCategoria%ROWTYPE;

    -- Cursor identificar las unidades operativas desactivadas en ldc_caruniope
    CURSOR cuLdc_CarUniOpe(INUOPERATING_SECTOR_ID OR_ORDER.OPERATING_SECTOR_ID%TYPE) IS
      SELECT *
        FROM OPEN.LDC_CARUNIOPE
       WHERE OPERATING_UNIT_ID = INUOPERATING_SECTOR_ID
         AND ACTIVO = 'N';

    -- Con este cursor se valida que exista una configuraci?n para el tipo de solicitud en la forma
    -- CAMU
    CURSOR cuConfMulti(inuPackageType ps_package_type.package_type_id%TYPE) IS
      SELECT tipo_trabajo
        FROM ldc_conf_asign_multi_01
       WHERE solicitud = inuPackageType
         AND asign_multi = 'S';

    rtCuLdc_CarUniOpe cuLdc_CarUniOpe%ROWTYPE;

    --MANEJO DE VARIABLES
    sbDatain              VARCHAR2(4000);
    nuError               NUMBER := 2741;
    sbError               VARCHAR2(4000);
    sbUnidadOperativa     VARCHAR2(4000);
    sbExecServicio        VARCHAR2(4000);
    nuOperating_sector_id or_order.operating_sector_id%TYPE;
    nuOperating_zone_id   or_operating_unit.operating_zone_id%TYPE;
    nuControlCicloUobysol NUMBER;
    sbCuadrilla           or_operating_unit.name%TYPE; -- Codigo alterno o nombre de la cuadrilla

  BEGIN

    --CICLO PARA RECORRER LAS UNIDADES OPERATIVAS DE UOBYSOL

    NUCONTROLCICLOUOBYSOL := 0;
    FOR TEMPCUUOBYSOL IN CUUOBYSOL(inuOrden, NULL) LOOP

      NUCONTROLCICLOUOBYSOL := 1;

      OPEN CULDC_CARUNIOPE(TEMPCUUOBYSOL.OPERATING_UNIT_ID);
      FETCH CULDC_CARUNIOPE
        INTO RTCULDC_CARUNIOPE;
      IF CULDC_CARUNIOPE%NOTFOUND THEN

        OPEN CUCATEGORIA(TEMPCUUOBYSOL.PRODUCT_ID,
                         TEMPCUUOBYSOL.ADDRESS_ID);
        FETCH CUCATEGORIA
          INTO TEMPCUCATEGORIA;
        CLOSE CUCATEGORIA;

        SBUNIDADOPERATIVA := NULL;

        --LLOZADA: Se obtiene el tipo de solicitud
        nuPackType := damo_packages.fnugetpackage_type_id(NULL, NULL);

        IF nuPackType IS NOT NULL THEN

          --LLOZADA: Se abre el cursor para obtener el tipo de trabajo configurado
          OPEN cuConfMulti(nuPackType);
          FETCH cuConfMulti
            INTO nuTipoTrabajo;
          CLOSE cuConfMulti;

          --LLOZADA: Si trae datos es porque existe una configuraci?n
          --para multifamiliares
          IF nuTipoTrabajo IS NOT NULL THEN
            SBDATAIN := SBDATAIN || '|' || nuTipoTrabajo;

          END IF;
        END IF;

        /*02/07/2014 LLOZADA: Se debe dejar NUll la variable SBUNIDADOPERATIVA para que
        para que realice la configuraci?n b?sica de UOBYSOL*/

        IF SBUNIDADOPERATIVA = '-1' THEN
          SBUNIDADOPERATIVA := NULL;
        END IF;

        IF SBUNIDADOPERATIVA IS NULL THEN

          --CONSULTA PARA OBTENER EL SECTOR OPERATIVO DE LA ORDEN
          BEGIN
            SELECT OPERATING_SECTOR_ID
              INTO NUOPERATING_SECTOR_ID
              FROM OR_ORDER OO
             WHERE OO.ORDER_ID = inuOrden;
          END;

          --CONSULTA PARA OBTENER LA ZONA DE LA ORDEN
          BEGIN
            SELECT OPERATING_ZONE_ID
              INTO NUOPERATING_ZONE_ID
              FROM OR_OPERATING_UNIT OOU
             WHERE OOU.OPERATING_UNIT_ID = TEMPCUUOBYSOL.OPERATING_UNIT_ID;
          END;
          --CURSOR PARA VALIDAR SI EL SECTOR OPERATIVO ESTA
          --CONFIGURADO DENTRO DE LA ZONA;
          OPEN CUGE_SECTOROPE_ZONA(NUOPERATING_SECTOR_ID,
                                   NUOPERATING_ZONE_ID);
          FETCH CUGE_SECTOROPE_ZONA
            INTO TEMPCUGE_SECTOROPE_ZONA;
          IF CUGE_SECTOROPE_ZONA%FOUND THEN

            OPEN CUTIPOPRODUCTO(TEMPCUUOBYSOL.PRODUCT_ID);
            FETCH CUTIPOPRODUCTO
              INTO RTCUTIPOPRODUCTO;
            IF CUTIPOPRODUCTO%FOUND THEN

              OPEN CUSEGMENTOCATEGORIA(TEMPCUUOBYSOL.ADDRESS_ID);
              FETCH CUSEGMENTOCATEGORIA
                INTO RTCUSEGMENTOCATEGORIA;
              UT_TRACE.TRACE('LA CATEGIRIA DEL PRODUCTO GENERICO ES [' ||
                             RTCUSEGMENTOCATEGORIA.CATEGORIA || ']',
                             10);

              CLOSE CUSEGMENTOCATEGORIA;
            END IF;
            CLOSE CUTIPOPRODUCTO;
            --FIN NC 2493

            OPEN CUCATEGORIA(TEMPCUUOBYSOL.PRODUCT_ID,
                             TEMPCUUOBYSOL.ADDRESS_ID);
            FETCH CUCATEGORIA
              INTO TEMPCUCATEGORIA;

            IF CUCATEGORIA%FOUND OR TEMPCUUOBYSOL.CATECODI = -1 OR
              --NC 2493
               RTCUSEGMENTOCATEGORIA.CATEGORIA = TEMPCUUOBYSOL.CATECODI THEN
              --FIN NC 2493

              --VALIDA LA CATEGORIA DEL PRODUTO CONFIGURADA
              --CON LA CONFIGURADA EN UOBYSOL

              IF TEMPCUCATEGORIA.CATEGORY_ID = TEMPCUUOBYSOL.CATECODI OR
                 TEMPCUUOBYSOL.CATECODI = -1 OR
                 RTCUSEGMENTOCATEGORIA.CATEGORIA = TEMPCUUOBYSOL.CATECODI THEN
                --FIN NC 2493

                -- Se obtiene el codigo alterno o la descripcion de la unidad operativa
                BEGIN
                  SELECT nvl(nvl(oou.oper_unit_code, oou.name),
                             to_char(oou.operating_unit_id))
                    INTO sbCuadrilla
                    FROM or_operating_unit oou
                   WHERE oou.operating_unit_id =
                         TEMPCUUOBYSOL.OPERATING_UNIT_ID;
                EXCEPTION
                  WHEN OTHERS THEN
                    sbCuadrilla := to_char(TEMPCUUOBYSOL.OPERATING_UNIT_ID);
                END;

                RETURN sbCuadrilla;
              END IF;
            END IF; --FIN VALIDACION DE CATEGORIA

            CLOSE CUCATEGORIA;

          END IF;

          CLOSE CUGE_SECTOROPE_ZONA;

        END IF; --FIN VALIDACION SECTOR OPERATIVO

      END IF; --VALIDACION SBUNIDADOPERATIVA IS NULL
      --FIN PROCESO CONFIGURACION UOBYSOL

      --       END IF; --VALIDACION DE UNIDADES OPERATIVAS ACTIVAS
      CLOSE CULDC_CARUNIOPE;

    END LOOP;

    RETURN NULL;

  EXCEPTION

    WHEN OTHERS THEN
      RETURN NULL;
  END fsbCuadrillaReparto;

  FUNCTION fsbCuadrillaReparto RETURN VARCHAR2 IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: proCuadrillaReparto
    Descripcion:        Cuadrilla a la que se le asignara el reparto de la factura

    Autor    : Sandra Mu?oz
    Fecha    : 14-10-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    11-11-2016   Sandra Mu?oz           CA200-849. Se trasnforma este procedimiento en funcion
                                        para que retorne la cuadrilla, sin devolver cursor
                                        referenciado
    14-10-2016   Sandra Mu?oz           Creacion
    ******************************************************************/
    sbFactsusc           ge_boInstanceControl.stysbValue; -- Contrato
    sbCuadrilla          or_operating_unit.name%TYPE; -- Cuadrilla que reparte la factura
    nuOrdenReparto       or_order.order_id%TYPE; -- Orden de reparto
    nuCantidadIntentos   ldc_order.asignacion%TYPE := dald_parameter.fnuGetNumeric_Value('CANTIDAD_INTENTOS_ASIGNACION');
    nuExiste             NUMBER; -- Indica si un elemento existe en la bd
    nuTipoTrabajoReparto ld_parameter.numeric_value%TYPE; -- Tipo de trabajo
    exError EXCEPTION;

  BEGIN
    sbFactsusc := obtenervalorinstancia('FACTURA', 'FACTSUSC');
    IF fblAplicaEntrega(csbBSS_FAC_SMS_200342) THEN
      BEGIN
        nuCantidadIntentos := 0;

        -- Identificar el tipo de trabajo usado para reparto de facturas
        BEGIN
          nuTipoTrabajoReparto := dald_parameter.fnuGetNumeric_Value('TIPO_TRABAJO_REPARTO');
        EXCEPTION
          WHEN OTHERS THEN
            RAISE exError;
        END;

        IF nuTipoTrabajoReparto IS NULL THEN
          RAISE exError;
        END IF;

        BEGIN
          SELECT COUNT(1)
            INTO nuExiste
            FROM or_task_type ott
           WHERE ott.task_type_id = nuTipoTrabajoReparto;
        EXCEPTION
          WHEN OTHERS THEN
            RAISE exError;
        END;

        IF nuExiste = 0 THEN
          RAISE exError;
        END IF;

        -- Buscar la ultima orden registrada del tipo de trabajo usado para reparto de facturas
        BEGIN
          SELECT MAX(ooa.order_id)
            INTO nuOrdenReparto
            FROM or_order_activity ooa, or_order oo
           WHERE ooa.subscription_id = to_number(sbFactsusc)
             AND oo.order_id = ooa.order_id
             AND oo.task_type_id = nuTipoTrabajoReparto;
        EXCEPTION
          WHEN OTHERS THEN
            RAISE exError;
        END;

        sbCuadrilla := fsbCuadrillaReparto(inuOrden => nuOrdenReparto); -- CA. 200-342

      EXCEPTION
        WHEN exError THEN
          sbCuadrilla := NULL;
      END;

    END IF;

    RETURN sbCuadrilla;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;

  END;

  FUNCTION fnuObservNoLectConsec(inuPeriodoConsumo pericose.pecscons%TYPE, -- Periodo consumo
                                 inuProducto       pr_product.product_id%TYPE -- Producto
                                 ) RETURN NUMBER IS
    /***********************************************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: fnuObservNoLectConsec
    Descripcion:        Funcion que recibe un periodo de consumo y un numero de servicio y lee entre
                        las lecturas la maxima por periodo de consumo partiendo desde el periodo de
                        consumo actual hacia atras el numero de periodos definidos en
                        SPOOL_NRO_OBSERVACIONES_CONSECUTIVAS para ver si el producto tiene el mismo
                        numero de observacion de lectura (definidos en el parametro
                        SPOOL_OBSERVACIONES_CONSECUTIVAS).  Si el sistema tiene la misma observacion
                        de no lectura en los periodos consecutivos, la funcion debe retornar el
                        codigo de la observacion de no lectura, si no se cuenta con las misma
                        observacion de no lectura en los periodos consecutivos se debe regresar un
                        valor null.

    Autor    : Sandra Mu?oz
    Fecha    : 18-09-2016 cA200-849

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    18-10-2016   Sandra Mu?oz           Creacion
    ***********************************************************************************************/

    cnuError CONSTANT NUMBER := 2741;
    sbError                 ge_error_log.description%TYPE; -- Error
    sbObservAEvaluar        ld_parameter.value_chain%TYPE; -- Observaciones a evaluar
    nuCantPeriodos          ld_parameter.numeric_value%TYPE; -- Cantidad de periodos evaluar
    sbTieneLectConsecutivas CHAR(1); -- Indica si existen observaciones consecutivas
    nuPeriodo               NUMBER; -- Periodo evaluado
    nuObservacionAnterior   lectelme.leemoble%TYPE; -- Observacion de no lectura evaluada anteriormente

    CURSOR cuLecturas IS
      SELECT l.leemoble
        FROM lectelme l
       WHERE l.LEEMSESU = inuProducto -- Producto
         AND l.LEEMCLEC = 'F' -- Solo lecturas de facturacion
         AND l.leemfele IN (SELECT MAX(l1.leemfele)
                              FROM lectelme l1
                             WHERE l1.leemsesu = l.leemsesu -- Producto
                               AND l1.leemclec = 'F' -- Solo lecturas de facturacion
                               AND l1.leempecs = l.leempecs) -- Maxima fecha de lectura encontrada para el periodo de consumo
         AND l.leempecs <= inuPeriodoConsumo -- Anterior al periodo evaluado
       ORDER BY l.leempecs DESC, l.leempefa DESC, l.leemfele DESC;

  BEGIN
    ut_trace.trace('Inicio ldc_detallefact_gascaribe.fnuObservNoLectConsec',
                   1);

    -- Si la entrega no esta aplicada se retorna un null
    IF NOT fblaplicaentrega(csbBSS_FAC_SMS_200849) THEN
      ut_trace.trace('Entrega ' || csbBSS_FAC_SMS_200849 || ' no aplicada',
                     10);
      RETURN NULL;
    END IF;

    ut_trace.trace('Entrega ' || csbBSS_FAC_SMS_200849 || ' aplicada', 10);

    -- Obtener el valor del parametro SPOOL_OBSERV_CONSECUTIVAS el cual almacena las observaciones
    -- de no lectura a evaluar
    BEGIN
      sbObservAEvaluar := dald_parameter.fsbGetValue_Chain(inuparameter_id => 'SPOOL_OBSERV_CONSECUTIVAS');
    EXCEPTION
      WHEN OTHERS THEN
        sbError := 'No fue posible consultar el parametro SPOOL_OBSERV_CONSECUTIVAS. ' ||
                   SQLERRM;
        RAISE ex.Controlled_error;
    END;

    IF sbObservAEvaluar IS NULL THEN
      sbError := 'No se ha definido un valor para el parametro ' ||
                 sbObservAEvaluar;
      RAISE ex.Controlled_error;
    END IF;

    ut_trace.trace('sbObservAEvaluar ' || sbObservAEvaluar, 10);

    -- Obtener el valor del parametro SPOOL_NRO_OBSERV_CONSECUTIVAS el cual almacena el numero
    -- de periodos a evaluar
    BEGIN
      nuCantPeriodos := dald_parameter.fnuGetNumeric_Value(inuparameter_id => 'SPOOL_NRO_OBSERV_CONSECUTIVAS');
    EXCEPTION
      WHEN OTHERS THEN
        sbError := 'No fue posible consultar el parametro SPOOL_NRO_OBSERV_CONSECUTIVAS. ' ||
                   SQLERRM;
        RAISE ex.Controlled_error;
    END;

    IF nuCantPeriodos IS NULL THEN
      sbError := 'No se ha definido un valor para el parametro ' ||
                 nuCantPeriodos;
      RAISE ex.Controlled_error;
    END IF;

    ut_trace.trace('nuCantPeriodos ' || nuCantPeriodos, 10);

    -- Evaluar si existen las observaciones de no lectura en periodos consecutivos
    sbTieneLectConsecutivas := 'S';
    nuPeriodo               := 1;
    FOR rgLecturas IN cuLecturas LOOP

      -- Si la observacion viene vacia se considera que no tiene observaciones de no lectura
      -- consecutivas
      IF rgLecturas.Leemoble IS NULL THEN
        sbTieneLectConsecutivas := 'N';
        EXIT;
      END IF;

      -- Si la observacion de no lectura no esta contenida dentro de las que se deben evaluar
      -- se considera que no tiene observaciones de no lectura consecutivas
      IF instr(sbObservAEvaluar, rgLecturas.Leemoble || '|') = 0 THEN
        sbTieneLectConsecutivas := 'N';
        EXIT;
      END IF;

      -- Se inicializa la variable donde se almacena la lectura a evaluar
      IF nuPeriodo = 1 THEN
        nuObservacionAnterior := rgLecturas.Leemoble;
      END IF;

      -- Si la observacion de no lectura cambia, se considera que no tieen observaciones de
      -- no lectura consecutivas
      IF rgLecturas.Leemoble <> nuObservacionAnterior THEN
        sbTieneLectConsecutivas := 'N';
        EXIT;
      END IF;

      -- Si ya recorrio todos los periodos a tener en cuenta
      IF nuPeriodo + 1 > nuCantPeriodos THEN
        EXIT;
      END IF;

      nuPeriodo := nuPeriodo + 1;

    END LOOP;

    IF sbTieneLectConsecutivas = 'S' AND nuPeriodo = nuCantPeriodos THEN
      RETURN nuObservacionAnterior;
    END IF;

    RETURN NULL;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      ut_trace.trace(sbError, 10);
      RETURN NULL;

    WHEN OTHERS THEN
      ut_trace.trace('Error no controlado en ldc_detallefact_gascaribee.fsbTieneOservLecturaConsec' || '. ' ||
                     SQLERRM,
                     10);
      RETURN NULL;
  END;

  FUNCTION fnuObservNoLectConsec RETURN NUMBER IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: proObservNoLectConsec
    Descripcion:        Observacion de no lectura consecutiva

    Autor    : Sandra Mu?oz
    Fecha    : 10-11-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    10-11-2016   Sandra Mu?oz           CA200-849. Creacion
    ******************************************************************/
    sbFactcodi               ge_boInstanceControl.stysbValue;
    sbFactsusc               ge_boInstanceControl.stysbValue;
    nuObservacionConsecutiva lectelme.leemoble%TYPE; -- Observacion no lectura
    nuProductoPrincipal      servsusc.sesunuse%TYPE; -- Producto personal
    exError EXCEPTION;

  BEGIN

    IF fblAplicaEntrega(csbBSS_FAC_SMS_200849) THEN

      sbFactcodi          := obtenervalorinstancia('FACTURA', 'FACTCODI');
      sbFactsusc          := obtenervalorinstancia('FACTURA', 'FACTSUSC');
      nuProductoPrincipal := fnuProductoPrincipal(inuContrato => sbFactsusc);

      BEGIN
        SELECT ldc_detallefact_gascaribe.fnuObservNoLectConsec(inuperiodoconsumo => pc.pecscons,
                                                               inuproducto       => s.sesunuse)
          INTO nuObservacionConsecutiva
          FROM open.factura  fc,
               open.suscripc b,
               open.servsusc s,
               open.perifact pf,
               open.pericose pc
         WHERE fc.factcodi = sbFactcodi
           AND fc.factsusc = b.susccodi
           AND b.susccodi = s.sesususc
           AND pf.pefacodi = fc.factpefa
           AND pc.pecscons =
               open.LDC_BOFORMATOFACTURA.fnuObtPerConsumo(pf.pefacicl,
                                                          pf.pefacodi)
           AND pf.pefacodi = fc.factpefa
           AND sesunuse = nvl(nuProductoPrincipal, sesunuse)
           AND ROWNUM = 1;
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
      END;

    END IF;

    RETURN nuObservacionConsecutiva;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END;

  PROCEDURE proDatosSpool(orfcursor OUT constants.tyRefCursor) IS
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: proDatosSpool
    Descripcion:        Se obtienen todos los datos que solo seran mostrados en el spool

    Autor    : Sandra Mu?oz
    Fecha    : 10-11-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    10-11-2016   Sandra Mu?oz           CA200-849. Creacion
    ******************************************************************/

    sbProceso VARCHAR2(4000) := 'proDatosSpool';
    nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
    sbError   VARCHAR2(4000);
    nuExiste  NUMBER; -- Evalua si un elemento existe
    exError EXCEPTION; -- Error controlado

  BEGIN
    ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);

    OPEN orfcursor FOR
      SELECT nvl(ldc_detallefact_gascaribe.fsbCuadrillaReparto, ' ') cuadrilla_reparto,
             nvl(to_char(ldc_detallefact_gascaribe.fnuObservNoLectConsec),
                 ' ') observ_no_lect_consec
        FROM dual;

    ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
  EXCEPTION
    WHEN exError THEN
      ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                     sbProceso || '(' || nuPaso || '):' || sbError);
      dbms_output.put_line('TERMINO CON ERROR ' || gsbPaquete || '.' ||
                           sbProceso || '(' || nuPaso || '):' || sbError);
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       sbError);

    WHEN OTHERS THEN
      sbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||
                 sbProceso || '(' || nuPaso || '): ' || SQLERRM;
      ut_trace.trace(sbError);
      dbms_output.put_line(sbError);
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       sbError);
  END;

  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   RfDatosConsumos
  Descripcion :   Obtiene datos de los consumos
  Autor       :   Carlos Alberto Ram?rez - Arquitecsoft

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  13-03-2017    KCienfuegos.CA1081   Se modifican los cursores cucm_vavafacoP y cucm_vavafacoPL
                                     para obtener el valor de la columna vvfcvalo en lugar de la
                                     columna vvfcvapr, de acuerdo a lo cotizado por NLCZ.
  11-01-2017          carlosr        Creacion
  **************************************************************************/
  PROCEDURE rfdatosconsumos(orfcursor OUT constants.tyrefcursor) AS

    sbfactsusc ge_boinstancecontrol.stysbvalue;
    sbfactpefa ge_boinstancecontrol.stysbvalue;
    sbfactcodi ge_boinstancecontrol.stysbvalue;

    nuperidocons pericose.pecscons%TYPE;

    consumo_actual      NUMBER;
    cons_correg         NUMBER;
    sbFactor_correccion VARCHAR2(200);
    consumo_mes_1       NUMBER;
    fecha_cons_mes_1    VARCHAR2(10);
    consumo_mes_2       NUMBER;
    fecha_cons_mes_2    VARCHAR2(10);
    consumo_mes_3       NUMBER;
    fecha_cons_mes_3    VARCHAR2(10);
    consumo_mes_4       NUMBER;
    fecha_cons_mes_4    VARCHAR2(10);
    consumo_mes_5       NUMBER;
    fecha_cons_mes_5    VARCHAR2(10);
    consumo_mes_6       NUMBER;
    fecha_cons_mes_6    VARCHAR2(10);
    consumo_promedio    NUMBER;
    supercompres        NUMBER;
    temperatura         NUMBER;
    presion             NUMBER;
    calculo_cons        VARCHAR2(50);
    equival_kwh         VARCHAR2(50);
    nuCategoria         servsusc.sesucate%TYPE;

    par_pod_calor NUMBER := dald_parameter.fnugetnumeric_value('FIDF_POD_CALORIFICO');

    nucicloc    NUMBER;
    nuproduct   NUMBER;
    blnregulado BOOLEAN;
    nugeoloc    ge_geogra_location.geograp_location_id%TYPE;
    vnucite     NUMBER;

    --declaracion de cursores
    CURSOR cucm_vavafacoP(nuproduct1 IN servsusc.sesunuse%TYPE) IS
      SELECT decode(nuCategoria, cnuCategoriaInd, vvfcvalo, vvfcvapr) presion
        FROM open.cm_vavafaco
       WHERE vvfcsesu = nuproduct1
         AND vvfcfefv >= trunc(SYSDATE)
         AND vvfcvafc = 'PRESION_OPERACION'
       ORDER BY vvfcfefv ASC;

    CURSOR cucm_vavafacoPL(nugeoloc1 IN NUMBER) IS
      SELECT decode(nuCategoria, cnuCategoriaInd, vvfcvalo, vvfcvapr) presion
        FROM open.cm_vavafaco
       WHERE vvfcfefv >= trunc(SYSDATE)
         AND vvfcvafc = 'PRESION_OPERACION'
         AND vvfcubge = nugeoloc1
       ORDER BY vvfcfefv ASC;

    CURSOR cucm_vavafacoPt(nuproduct1 IN servsusc.sesunuse%TYPE) IS
      SELECT vvfcvapr
        FROM open.cm_vavafaco
       WHERE vvfcsesu = nuproduct1
         AND vvfcfefv >= trunc(SYSDATE)
         AND vvfcvafc = 'TEMPERATURA'
       ORDER BY vvfcfefv ASC;

    CURSOR cucm_vavafacotL(nugeoloc1 IN NUMBER) IS
      SELECT vvfcvapr
        FROM open.cm_vavafaco
       WHERE vvfcfefv >= trunc(SYSDATE)
         AND vvfcvafc = 'TEMPERATURA'
         AND vvfcubge = nugeoloc1
       ORDER BY vvfcfefv ASC;

    -- Obtiene los historicos de consumo
    PROCEDURE gethistoricos(nucontrato IN NUMBER,
                            nuproducto IN NUMBER,
                            nuciclo    IN NUMBER,
                            nuperiodo  IN NUMBER) AS
      TYPE tytbperiodos IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;

      tbperconsumo tytbperiodos;
      tbperfactura tytbperiodos;

      tbperiodos tytbperiodos;
      frperiodos constants.tyrefcursor;

      nuperfactactual perifact.pefacodi%TYPE;
      nuperfactprev   perifact.pefacodi%TYPE;
      nuperconsprev   pericose.pecscons%TYPE;
      sbperiodos      VARCHAR2(100) := '';
      contador        NUMBER := 1;
      periodo         NUMBER;
      consumo         NUMBER;
      nuciclof        NUMBER;

      CURSOR cuconsumo(nuproducto NUMBER, tbperi tytbperiodos) IS
        SELECT SUM(c_1) consumo_1,
               SUM(c_2) consumo_2,
               SUM(c_3) consumo_3,
               SUM(c_4) consumo_4,
               SUM(c_5) consumo_5,
               SUM(c_6) consumo_6
          FROM (SELECT CASE
                         WHEN pecscons = tbperi(1) THEN
                          SUM(cosssuma)
                       END c_1,
                       CASE
                         WHEN pecscons = tbperi(2) THEN
                          SUM(cosssuma)
                       END c_2,
                       CASE
                         WHEN pecscons = tbperi(3) THEN
                          SUM(cosssuma)
                       END c_3,
                       CASE
                         WHEN pecscons = tbperi(4) THEN
                          SUM(cosssuma)
                       END c_4,
                       CASE
                         WHEN pecscons = tbperi(5) THEN
                          SUM(cosssuma)
                       END c_5,
                       CASE
                         WHEN pecscons = tbperi(6) THEN
                          SUM(cosssuma)
                       END c_6
                  FROM open.vw_cmprodconsumptions -- pericose
                 WHERE cosssesu = nuproducto
                   AND pecscons IN (tbperi(1),
                                    tbperi(2),
                                    tbperi(3),
                                    tbperi(4),
                                    tbperi(5),
                                    tbperi(6))
                 GROUP BY pecscons);

      nupro NUMBER;
      nucat NUMBER;

    BEGIN
      ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist.getHistoricos',
                     15);

      nuciclof := nuciclo;

      -- Periodo de facturacion Actual
      nuperfactactual := nuperiodo; -- obtenervalorinstancia('FACTURA','FACTPEFA');

      -- Obtiene los periodos facturados
      frperiodos := frfcambiociclo(nucontrato);
      FETCH frperiodos BULK COLLECT
        INTO tbperiodos;
      ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos Inicio Obtiene los ultimos 6 periodos facturados',
                     15);
      -- Obtiene los ultimos 6 periodos facturados
      FOR i IN 1 .. 6 LOOP
        -- Periodo de Facturacion Anterior
        BEGIN
          nuperfactprev := pkbillingperiodmgr.fnugetperiodprevious(nuperfactactual);

        EXCEPTION
          WHEN ex.controlled_error THEN
            nuperfactprev := -1;
          WHEN OTHERS THEN
            nuperfactprev := -1;
        END;

        -- Se valida si el periodo obtenido es igual al facturado si no es igual, es por
        -- que el cliente cambio de ciclo
        IF (tbperiodos.exists(i + 1)) AND
           (tbperiodos(i + 1) != nuperfactprev) THEN
          nuperfactprev := tbperiodos(i + 1);
          nuciclof      := pktblperifact.fnugetcycle(nuperfactprev);
        END IF;

        -- Periodo de consumo Anterior
        BEGIN
          nuperconsprev := ldc_boformatofactura.fnuobtperconsumo(nuciclof,
                                                                 nuperfactprev);
        EXCEPTION
          WHEN "OPEN".ex.CONTROLLED_ERROR THEN
            nuperconsprev := -1;
          WHEN OTHERS THEN
            nuperconsprev := -1;
        END;

        tbperconsumo(i) := nuperconsprev;
        tbperfactura(i) := nuperfactprev;

        IF (sbperiodos IS NOT NULL) THEN
          sbperiodos := nuperconsprev || ',' || sbperiodos;
        ELSE
          sbperiodos := nuperconsprev;
        END IF;

        --   dbms_output.put_line('i '||i||' periodo Consumo '||nuPerConsPrev||' periodo facturacion '||nuPerFactPrev);
        -- El Anterior queda actual para hayar los anteriores
        nuperfactactual := nuperfactprev;

      END LOOP;
      ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos Fin  Obtiene los ultimos 6 periodos facturados',
                     15);

      ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos Inicio recorre el cursor cuconsumo',
                     15);
      FOR i IN cuconsumo(nuproducto, tbperconsumo) LOOP
        ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_1',
                       15);
        consumo_mes_1 := nvl(i.consumo_1, 0);
        ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_2',
                       15);
        consumo_mes_2 := nvl(i.consumo_2, 0);
        ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_3',
                       15);
        consumo_mes_3 := nvl(i.consumo_3, 0);
        ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_4',
                       15);
        consumo_mes_4 := nvl(i.consumo_4, 0);
        ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_5',
                       15);
        consumo_mes_5 := nvl(i.consumo_5, 0);
        ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_6',
                       15);
        consumo_mes_6 := nvl(i.consumo_6, 0);
      END LOOP;
      ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos Fin recorre el cursor cuconsumo',
                     15);

      -- Hayando meses
      fecha_cons_mes_1 := fsbgetfechapermmyyyy(tbperfactura(1));
      fecha_cons_mes_2 := fsbgetfechapermmyyyy(tbperfactura(2));
      fecha_cons_mes_3 := fsbgetfechapermmyyyy(tbperfactura(3));
      fecha_cons_mes_4 := fsbgetfechapermmyyyy(tbperfactura(4));
      fecha_cons_mes_5 := fsbgetfechapermmyyyy(tbperfactura(5));
      fecha_cons_mes_6 := fsbgetfechapermmyyyy(tbperfactura(6));
      ut_trace.trace('Fin LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist.getHistoricos',
                     15);
    END gethistoricos;

  BEGIN
    ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist',
                   15);
    sbfactcodi  := obtenervalorinstancia('FACTURA', 'FACTCODI');
    sbfactsusc  := obtenervalorinstancia('FACTURA', 'FACTSUSC');
    sbfactpefa  := obtenervalorinstancia('FACTURA', 'FACTPEFA');
    nuproduct   := fnugetproducto(sbfactcodi);
    nuCategoria := pktblservsusc.fnugetcategory(nuproduct);
    blnregulado := fblnoregulado(sbfactsusc);

    IF NOT blnregulado THEN

      BEGIN

        nucicloc := nvl(pktblservsusc.fnugetbillingcycle(nuproduct), -1);

        -- Se obtiene el periodo de consumo actual, dado el periodo de facturacion
        nuperidocons := ldc_boformatofactura.fnuobtperconsumo(nucicloc,
                                                              sbfactpefa);

      EXCEPTION
        WHEN OTHERS THEN
          nucicloc     := -1;
          nuperidocons := -1;
      END;

      gethistoricos(sbfactsusc, nuproduct, nucicloc, sbfactpefa);

      ut_trace.trace('LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist Obtener el origen del consumo',
                     15);

      -- Obtener el origen del consumo
      BEGIN

        SELECT decode(cossmecc, 1, 'LEC.MEDIDOR', 'ESTIMADO')
          INTO calculo_cons
          FROM vw_cmprodconsumptions
         WHERE cosssesu = nuproduct
           AND cosspefa = sbfactpefa
           AND cosspecs = nuperidocons;

      EXCEPTION
        WHEN OTHERS THEN
          calculo_cons := NULL;
      END;
      ut_trace.trace('LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist VAlidacion ciclo asociado',
                     15);
      --Spacheco ara:8209 --se valida si el ciclo asociado al usuario esta configurado en el parametro
      --de ciclo de telemedido
      IF calculo_cons IS NOT NULL THEN
        SELECT COUNT(*)
          INTO vnucite
          FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbGetValue_Chain('CICLO_TELEMEDIDOS_GDC'),
                                                  ','))
         WHERE column_value = pktblservsusc.fnugetsesucicl(nuproduct);

        IF vnucite = 1 THEN
          calculo_cons := 'RTU';
        END IF;
      END IF;
      ut_trace.trace('LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist 1 ', 15);
      BEGIN
        /*01-03-2015 Llozada: Se envia el consumo sin multiplicarlo por el factor de correcci?n ya que en
        la tabla de consumos est? f?rmula ya est? aplicada.*/
        SELECT consumo_act,
               to_char(fac_correccion, '0.9999'),
               round(consumo_act),
               supercompres, /*,temperatura,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              presion,*/
               round(consumo_act) || ' M3 Equivalen a ' ||
               --ARA.8800
               --Mmejia
               --07-10-2015
               --Se modifica el calculo de la conversion de M3 a Kwh
               --segun se envio en el FANA debe ser diferencia de lecturas
               --por el facto en el parametro FIDF_POD_CALORIFICO
               --round(par_pod_calor * consumo_act / 3.6, 2) || 'kwh',
                round(par_pod_calor * consumo_act, 2) || 'kwh',
               round((consumo_mes_1 + consumo_mes_2 + consumo_mes_3 +
                     consumo_mes_4 + consumo_mes_5 + consumo_mes_6) / 6) cons_promedio
          INTO consumo_actual,
               sbFactor_correccion,
               cons_correg,
               supercompres,
               equival_kwh,
               consumo_promedio
          FROM (SELECT fnugetconsumoresidencial(MAX(sesunuse), MAX(cosspecs)) consumo_act,
                       MAX(fccofaco) fac_correccion,
                       MAX(fccofasc) supercompres,
                       /* max(fccofate) temperatura,
                       max(fccofapr) presion,*/
                       MAX(fccofapc) * MAX(fccofaco) poder_calor
                  FROM factura f
                 INNER JOIN servsusc s
                    ON (sesususc = factsusc AND
                       sesuserv =
                       dald_parameter.fnugetnumeric_value('COD_SERV_GAS'))
                  LEFT OUTER JOIN conssesu c
                    ON (c.cosssesu = s.sesunuse AND c.cosspefa = f.factpefa AND
                       cossmecc = 4)
                  LEFT OUTER JOIN cm_facocoss
                    ON (cossfcco = fccocons)
                 WHERE factcodi = sbfactcodi),
               perifact
         WHERE pefacodi = sbfactpefa;

        ut_trace.trace('LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist 2 ',
                       15);
        BEGIN
          nugeoloc := daab_address.fnugetgeograp_location_id(dapr_product.fnugetaddress_id(nuproduct,
                                                                                           0),
                                                             0);
        END;
        ut_trace.trace('LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist 3',
                       15);

        /*SPacheco Ara 8640 se trabaja con open fetch para identificar la configuracion mas
        cerca al dia del proceso*/
        --se consulta presion
        OPEN cucm_vavafacoP(nuproduct);
        FETCH cucm_vavafacoP
          INTO presion;
        IF cucm_vavafacoP%NOTFOUND THEN

          ------si no existe configuracion de presion para el producto se consulta por localidad
          OPEN cucm_vavafacoPl(nugeoloc);
          FETCH cucm_vavafacoPl
            INTO presion;
          IF cucm_vavafacoPl%NOTFOUND THEN
            presion := 0;

          END IF;
          CLOSE cucm_vavafacoPl;
          ------
        END IF;
        CLOSE cucm_vavafacoP;

        ut_trace.trace('LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist 4',
                       15);
        /*SPacheco Ara 8640 se trabaja con open fetch para identificar la configuracion mas
        cerca al dia del proceso*/
        --se consulta la temperatura configurada por el producto
        OPEN cucm_vavafacoPt(nuproduct);
        FETCH cucm_vavafacoPt
          INTO temperatura;
        IF cucm_vavafacoPt%NOTFOUND THEN

          ------si no posee configuracion de temperatura por producto consulta por localidad

          OPEN cucm_vavafacotl(nugeoloc);
          FETCH cucm_vavafacotl
            INTO temperatura;
          IF cucm_vavafacotl%NOTFOUND THEN
            temperatura := 0;

          END IF;
          CLOSE cucm_vavafacotl;
          ------
        END IF;
        CLOSE cucm_vavafacoPt;

        /*01-03-2015 Llozada: Se comenta ya que est? calculando mal el consumo, lo esta multiplicando
        2 veces por el factor de correcci?n*/
        /*select consumo_act,
                to_char(fac_correccion,'0.9999'), round(consumo_act*fac_correccion),
                supercompres,temperatura,
                presion, round(consumo_act)||' M3 Equivalen a '||round(PAR_POD_CALOR*consumo_act/3.6,2)||'kwh',
                round((CONSUMO_MES_1+CONSUMO_MES_2+CONSUMO_MES_3+CONSUMO_MES_4+CONSUMO_MES_5+CONSUMO_MES_6)/6) CONS_PROMEDIO
         into  CONSUMO_ACTUAL,FACTOR_CORRECCION,CONS_CORREG,SUPERCOMPRES,TEMPERATURA,PRESION,EQUIVAL_KWH ,CONSUMO_PROMEDIO
        from
         (select fnuGetConsumoResidencial(max(sesunuse),max(cosspecs)) consumo_act,
                 max(fccofaco) fac_correccion,
                 max(fccofasc) supercompres,
                 max(fccofate) temperatura,
                 max(fccofapr) presion,
                 max(fccofapc)*max(fccofaco) poder_calor
             FROM factura f inner join servsusc s
                 on (sesususc = factsusc and sesuserv=dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS'))
                 LEFT OUTER JOIN conssesu c
                 ON (c.cosssesu = s.sesunuse
                 and c.cosspefa = f.factpefa
                 AND cossmecc=4)
                 left outer join cm_facocoss on (cossfcco=fccocons)
             WHERE  factcodi = sbFactcodi ), perifact
             where pefacodi=sbFactpefa;*/

      EXCEPTION
        WHEN no_data_found THEN

          consumo_actual      := 0;
          sbFactor_correccion := '0';
          consumo_mes_1       := 0;
          fecha_cons_mes_1    := ' ';
          consumo_mes_2       := 0;
          fecha_cons_mes_2    := ' ';
          consumo_mes_3       := 0;
          fecha_cons_mes_3    := ' ';
          consumo_mes_4       := 0;
          fecha_cons_mes_4    := ' ';
          consumo_mes_5       := 0;
          fecha_cons_mes_5    := ' ';
          consumo_mes_6       := 0;
          fecha_cons_mes_6    := ' ';
          consumo_promedio    := 0;
          supercompres        := 0;
          temperatura         := 0;
          presion             := 0;
          cons_correg         := 0;
          calculo_cons        := ' ';
          equival_kwh         := ' ';

      END;
      -- Si es no regulado no muestra datos
    ELSE
      consumo_actual      := NULL;
      sbFactor_correccion := NULL;
      consumo_mes_1       := NULL;
      fecha_cons_mes_1    := NULL;
      consumo_mes_2       := NULL;
      fecha_cons_mes_2    := NULL;
      consumo_mes_3       := NULL;
      fecha_cons_mes_3    := NULL;
      consumo_mes_4       := NULL;
      fecha_cons_mes_4    := NULL;
      consumo_mes_5       := NULL;
      fecha_cons_mes_5    := NULL;
      consumo_mes_6       := NULL;
      fecha_cons_mes_6    := NULL;
      consumo_promedio    := NULL;
      supercompres        := NULL;
      temperatura         := NULL;
      presion             := NULL;
      cons_correg         := NULL;
      equival_kwh         := NULL;
      calculo_cons        := NULL;

    END IF;

    OPEN orfcursor FOR
      SELECT consumo_mes, fecha_cons_mes
        FROM (SELECT consumo_mes_1    consumo_mes,
                     fecha_cons_mes_1 fecha_cons_mes,
                     1                orden_consumo
                FROM dual
              UNION
              SELECT consumo_mes_2    consumo_mes,
                     fecha_cons_mes_2 fecha_cons_mes,
                     2                orden_consumo
                FROM dual
              UNION
              SELECT consumo_mes_3    consumo_mes,
                     fecha_cons_mes_3 fecha_cons_mes,
                     3                orden_consumo
                FROM dual
              UNION
              SELECT consumo_mes_4    consumo_mes,
                     fecha_cons_mes_4 fecha_cons_mes,
                     4                orden_consumo
                FROM dual
              UNION
              SELECT consumo_mes_5    consumo_mes,
                     fecha_cons_mes_5 fecha_cons_mes,
                     5                orden_consumo
                FROM dual
              UNION
              SELECT consumo_mes_6    consumo_mes,
                     fecha_cons_mes_6 fecha_cons_mes,
                     6                orden_consumo
                FROM dual)
       ORDER BY orden_consumo DESC;
    ut_trace.trace('Fin LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist', 15);
  EXCEPTION
    WHEN ex.controlled_error THEN
      RAISE ex.controlled_error;
    WHEN OTHERS THEN
      errors.seterror;
      RAISE ex.controlled_error;
  END rfdatosconsumos;

  ----CASO 200-1626
  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fnuGetProducto
  Descripcion :   Servicio que permitira obtener el saldo anterior de un suscriptor
  Autor       :   Jorge valiente

  Historia de Modificaciones
  Fecha               Autor              Modificacion
  =========           =========          ====================
  **************************************************************************/
  FUNCTION FnuGetSaldoAnterior(InuContrato number,
                               InuFactura  number,
                               Inusesunuse number) RETURN NUMBER IS

    cursor cusaldoanterior is
      select (sum(CUCOSACU) - sum(CUCOVARE) - sum(CUCOVRAP)) saldo_ant
        from servsusc, cuencobr
       where sesususc = InuContrato
         and sesunuse = decode(Inusesunuse, -1, sesunuse, Inusesunuse)
         and cuconuse = sesunuse
         and cucosacu > 0
         and cucofact != InuFactura
       group by sesunuse, sesuserv;

    rfcusaldoanterior cusaldoanterior%rowtype;
  BEGIN
    ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.FnuGetSaldoAnterior',
                   15);

    ut_trace.trace('Contrato[' || InuContrato || ']', 15);
    ut_trace.trace('Factura[' || InuFactura || ']', 15);
    ut_trace.trace('Servicio[' || Inusesunuse || ']', 15);

    open cusaldoanterior;
    fetch cusaldoanterior
      into rfcusaldoanterior;
    close cusaldoanterior;

    return nvl(rfcusaldoanterior.saldo_ant, 0);

    ut_trace.trace('Fin LDC_DETALLEFACT_GASCARIBE.FnuGetSaldoAnterior', 15);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      --RAISE ex.CONTROLLED_ERROR;
      return 0;
    WHEN OTHERS THEN
      return 0;
      --Errors.setError;
    --RAISE ex.CONTROLLED_ERROR;
  END FnuGetSaldoAnterior;
  -----

  --Inicio CASO 200-1515
  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfMarcaAguaDuplicado
  Descripcion    : procedimiento para extraer los datos y establecer si
                   se aplica la maraca de agua en la plantilla .NET
  Autor          : Daniel Valiente

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE RfMarcaAguaDuplicado(orfcursor OUT constants.tyRefCursor)

   AS

  BEGIN

    ut_trace.trace('Fin LDC_DETALLEFACT_GASCARIBE.RfMarcaAguaDuplicado',
                   15);

    OPEN orfcursor FOR
      SELECT nvl(visible, 0) visible, impreso
        FROM (SELECT dald_parameter.fnuGetNumeric_Value('DUPLICADO_WATERMARK',
                                                        null) AS visible,
                     G.NAME_ AS impreso
                FROM GE_PERSON G
               WHERE G.PERSON_ID = GE_BOPERSONAL.FNUGETPERSONID)
       WHERE rownum = 1;

    ut_trace.trace('Fin LDC_DETALLEFACT_GASCARIBE.RfMarcaAguaDuplicado',
                   15);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      OPEN orfcursor FOR
        SELECT 0, NULL FROM dual;
      --RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      OPEN orfcursor FOR
        SELECT 0, NULL FROM dual;
      --Errors.setError;
    --RAISE ex.CONTROLLED_ERROR;
  END RfMarcaAguaDuplicado;
  --Fin CASO 200-1515

END LDC_DetalleFact_GasCaribev2;
/
GRANT EXECUTE on LDC_DETALLEFACT_GASCARIBEV2 to SYSTEM_OBJ_PRIVS_ROLE;
/
