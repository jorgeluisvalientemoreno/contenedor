create or replace PACKAGE ldc_detallefact_gascaribe IS
 /********************************************************************************************************************************
  Propiedad intelectual de PETI.

  Unidad         : LDC_DetalleFact_GasCaribe
  Descripcion    : Paquete con la logica de negocio el Spool de Gas Caribe
  Autor          :
  Fecha          : 11/07/2012

  Historia de Modificaciones
  Fecha         Autor               Modificacion
  -------------------------------------------------
  29/08/2023    diana.montes    OSF-1462: Se modifica cursor cusaldoanterior para que no tenga en cuenta
                                cuenta de cobro cuyo saldo sea menor al valor en reclamo y Ajustes de
                                validación.
  21/07/2022    cgonzalez      OSF-442 Se adicionar el servicio <fnuObtPuntos>
  17/06/2022    cgonzalez      OSF-387 Se ajusta servicios <RfConcepParcial>
  22/04/2022  ibecerra      OSF-144 se modifica la logica del metodo <RfDatosRevision> para llamar
                  al servicio <ldc_pkgprocrevperfact.RfDatosRevision>
  18/04/2022    cgonzalez      OSF-159 Se ajusta servicios <RfConcepParcial>
  04-01-2021    Horbath           CA559. Se ajusta la funcion <<RfDatosCuenxCobrTt>>
  11/07/2018    Sebastian Tapias  REQ.200-1920: Se modifica el servicio: <<RfConcepParcial>>
  13/03/2017    KCienfuegos       CA200-1081: Se modifican los métodos: <<rfdatosconsumohist>>
                                                                        <<rfdatosconsumos>>
                                                                        <<RfDatosRevision>>
  11/01/2017    carlosr           Se crea el método RfDatosConsumos
  26-12-2016    KCienfuegos       CA 200-326 Se modifica proceso InsLD_CUPON_CAUSAL
  11-11-2016    Sandra Muñoz      CA 200-849.
                                  Creacion de los procedimientos/funciones fnuObservNoLectConsec y
                                  proDatosSpool
                                  Modificacion de fsbGetEncabezado, rfDatosGenerales
  06-09-2016    Sandra Muñoz      ca 200-342.
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
                                  para realizar el cambio el origen de datos de temperatura y presión.
                                  Se modifica la funcion <<fnuMesesDeuda>> para que incluya
                                  el valor en reclamo para calcular el saldo de la cuenta.

  19-03-2015    Agordillo         Se modifica los metodos <<RfConcepParcial>>, <<RfDatosRevision>>,
                                  <<RfConcepParcial>>

  02-03-2015    Llozada           Se modifican los métodos <<RfDatosLecturas>>, <<RfDatosConsumoHist>>,
                                  <<fsbGetEncabezado>>, <<RfRangosConsumo>>
  10/05/2022   John Jairo Jimenez OSF-72 Se crea el procedimiento : RfDatosMedMalubi retorna si se debe generara
                                         notificación o no de medidor mal ubicado.
  02/06/2022   John Jairo Jimenez OSF-65 Se modifica el procedimiento : RfConcepParcial, para cuando la entrega este activa, a la decripcion
                                         de los conceptosde subsidio configurados en el parametro : CONCSUBSIDIOSPOOL
                                         el respectivo % con el que se calculó el subsidio.
                                         Para los intereses de financiacion, tambien en la descripcion
                                         del cargo se debe colocar el %de interes, siempre y cuando el
                                         tipo de producto este configurado en el parametro : INTFINANPRODSPOOL.
  02/06/2022   John Jairo Jimenez    OSF-65 Se modifica el procedimiento : rfdatosconsumohist para
                                            añadirle a la variabe : equival_kwh
                                            el valor en pesos por Kilovatio/hora,la formula aplicada
                                            es : round(consumo_act/(par_pod_calor * consumo_act),2).--
  24/06/2022   John Jairo Jimenez    OSF-393 Se crea el procedimiento : rfLastPayment el cual nos mostrar?
                                             el ultimo pago del usuario y su respectiva fecha de pago.--
                                             Se modifica el procedimiento : RfDatosLecturas para cuando el
                                             consumo sea estimado y la observacion de lecatura sea NULL,
                                             Se le asigne a la observacion de lectura el valor configurado
                                             en el parametro : PARAM_OBS_DESV_SIGNIFI.
                                             Se modifica el procedimiento : fsbGetEncabezado para agregarle
                                             al encabezado los campos : VALOR_ULTIMO_PAGO y FECHA_ULTIMO_PAGO.

********************************************************************************************************************************/

 --Tipo tabla PL de periodos
 TYPE tytbperiodos IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
 ------------------------------------------------------------------------------------------------------------------------

 FUNCTION fsbversion RETURN VARCHAR2;
  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fsbVersion
  Descripcion :   Obtiene la versión del paquete
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
  **************************************************************************/
 ------------------------------------------------------------------------------------------------------------------------

 FUNCTION fsbgetencabconc1 RETURN VARCHAR2;
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
 ------------------------------------------------------------------------------------------------------------------------

 FUNCTION fsbgetencabconc2 RETURN VARCHAR2;
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
------------------------------------------------------------------------------------------------------------------------

 FUNCTION fsbgetencabconc3 RETURN VARCHAR2;
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
 ------------------------------------------------------------------------------------------------------------------------

 FUNCTION fsbgetencabconc4 RETURN VARCHAR2;
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
 ------------------------------------------------------------------------------------------------------------------------
 FUNCTION fsbgetencabconc5 RETURN VARCHAR2;
  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fsbGetEncabConc5
  Descripcion :   Obtiene los encabezados.
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
  Fecha               Autor              Modificacion
  =========           =========          ====================
  05-12-2014          ggamarra           Creacion
  **************************************************************************/
 ------------------------------------------------------------------------------------------------------------------------
 FUNCTION fsbgetencabezado RETURN VARCHAR2;
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
 -----------------------------------------------------------------------------------------------------------------------

 FUNCTION fnuGetProducto(inuFactura IN factura.factcodi%TYPE) RETURN NUMBER;
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
 ------------------------------------------------------------------------------------------------------------------------

 FUNCTION fnufechasuspension(nuproducto  IN servsusc.sesunuse%TYPE,
                              nucategoria IN servsusc.sesucate%TYPE) RETURN NUMBER;
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
 ------------------------------------------------------------------------------------------------------------------------

 PROCEDURE rfdatosgenerales(orfcursor OUT constants.tyrefcursor);
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
 ------------------------------------------------------------------------------------------------------------------------

 PROCEDURE rfdatoslecturas(orfcursor OUT constants.tyrefcursor);
  /****************************************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   RfDatosLecturas
  Descripcion :   Obtiene los datos de las lecturas y medidor
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                    Modificacion
  =========           =========                ====================
  11-11-2014           ggamarra                Creacion
  24/06/2022      John Jairo Jimenez OSF-393 : Se modifica para cuando el consumo sea estimado y la
                                               observacion de lecatura sea NULL, se le asigne a la
                                               observacion de lectura el valor configurado
                                               en el parametro : PARAM_OBS_DESV_SIGNIFI.
  *****************************************************************************************************/
 ------------------------------------------------------------------------------------------------------------------------

 FUNCTION frfcambiociclo(inufactsusc IN NUMBER) RETURN constants.tyrefcursor;
  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   frfCambioCiclo
  Descripcion :   Obtiene los ciclos de facturación anteriores
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
  **************************************************************************/
 ------------------------------------------------------------------------------------------------------------------------

 PROCEDURE rfdatosconsumohist(orfcursor OUT constants.tyrefcursor);
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
 ------------------------------------------------------------------------------------------------------------------------

 PROCEDURE rfdatosrevision(orfcursor OUT constants.tyrefcursor);
  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   RfDatosRevision
  Descripcion :   Obtiene los datos de las fechas de revisión
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
  **************************************************************************/
 ------------------------------------------------------------------------------------------------------------------------

 PROCEDURE rfdatosconceptos(orfcursor OUT constants.tyrefcursor);
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
 ------------------------------------------------------------------------------------------------------------------------

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
 ------------------------------------------------------------------------------------------------------------------------

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
  ------------------------------------------------------------------------------------------------------------------------

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
 ------------------------------------------------------------------------------------------------------------------------

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
 ------------------------------------------------------------------------------------------------------------------------

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
 ------------------------------------------------------------------------------------------------------------------------

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
 ------------------------------------------------------------------------------------------------------------------------

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
  11/11/2014      ggamarra             Creación.
  ******************************************************************/
 ------------------------------------------------------------------------------------------------------------------------

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
 ------------------------------------------------------------------------------------------------------------------------

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
 ------------------------------------------------------------------------------------------------------------------------

 FUNCTION fnulecturaanterior(inusesunuse    IN servsusc.sesunuse%TYPE,
                              inuperiodofact IN perifact.pefacodi%TYPE) RETURN NUMBER;
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
 ------------------------------------------------------------------------------------------------------------------------

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
 ------------------------------------------------------------------------------------------------------------------------

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
 ------------------------------------------------------------------------------------------------------------------------

 FUNCTION fsbgetfechapermmyyyy(inupefacodi IN perifact.pefacodi%TYPE) RETURN VARCHAR2;
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
 ------------------------------------------------------------------------------------------------------------------------

 FUNCTION fnugetconsumoresidencial(inusesunuse IN servsusc.sesunuse%TYPE,
                                    inupericose IN conssesu.cosspecs%TYPE) RETURN NUMBER;
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
 ------------------------------------------------------------------------------------------------------------------------

 PROCEDURE InsLD_CUPON_CAUSAL(inuPackageTypeId IN NUMBER,
                               inuCuponId       IN NUMBER,
                               inuCausalId      IN NUMBER,
                               inuPackagesId    IN NUMBER);
 ------------------------------------------------------------------------------------------------------------------------

 FUNCTION fsbCuadrillaReparto(inuOrden or_order.order_id%TYPE -- Orden
                               ) RETURN VARCHAR2;
 ------------------------------------------------------------------------------------------------------------------------

 FUNCTION fsbCuadrillaReparto RETURN VARCHAR2;
 ------------------------------------------------------------------------------------------------------------------------

 FUNCTION fnuProductoPrincipal(inuContrato suscripc.susccodi%TYPE -- Contrato
                                ) RETURN NUMBER;
 ------------------------------------------------------------------------------------------------------------------------

 FUNCTION fsbRutaReparto(inuProducto pr_product.product_id%TYPE -- Producto
                          ) RETURN VARCHAR2;
 ------------------------------------------------------------------------------------------------------------------------

 FUNCTION fnuObservNoLectConsec(inuPeriodoConsumo pericose.pecscons%TYPE, -- Periodo consumo
                                 inuProducto       pr_product.product_id%TYPE -- Producto
                                 ) RETURN NUMBER;
 ------------------------------------------------------------------------------------------------------------------------

 FUNCTION fnuObservNoLectConsec RETURN NUMBER;
 ------------------------------------------------------------------------------------------------------------------------

 PROCEDURE proDatosSpool(orfcursor OUT constants.tyRefCursor);
 ------------------------------------------------------------------------------------------------------------------------

 PROCEDURE rfdatosconsumos(orfcursor OUT constants.tyrefcursor);
  /**************************************************************************
    Propiedad Intelectual de PETI

    Funcion     :   RfDatosConsumos
    Descripcion :   Obtiene datos de los consumos
    Autor       :   Carlos Alberto Ramirez - Arquitecsoft

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    11-01-2017          carlosr            Creacion
   **************************************************************************/
 ------------------------------------------------------------------------------------------------------------------------

 FUNCTION FnuGetSaldoAnterior(InuContrato number,
                               InuFactura  number,
                               Inusesunuse number) RETURN NUMBER;
  /**************************************************************************
   Propiedad Intelectual de PETI

   Funcion     :   FnuGetSaldoAnterior
   Descripcion :   Servicio que permitira obtener el saldo anterior de un suscriptor
   Autor       :   Jorge valiente

   Historia de Modificaciones
   Fecha               Autor              Modificacion
   =========           =========          ====================
  **************************************************************************/
 ------------------------------------------------------------------------------------------------------------------------

 PROCEDURE RfMarcaAguaDuplicado(orfcursor OUT constants.tyRefCursor);
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
 ------------------------------------------------------------------------------------------------------------------------

 PROCEDURE RfProteccion_Datos(orfcursor OUT constants.tyRefCursor);
  /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : RfProteccion_Datos
   Descripcion    : Servicio para retonar si el funcionario tiene o no la solciitud de proteccion de
                   datos activo en OSF
   Autor          : Jorge Valiente

   Parametros              Descripcion
  ============         ===================
   orfcursor            Retorna caracter
                               S SI tiene proteccion de datos activo.
                               N NO tiene proteccion de datos activo.

   Fecha             Autor             Modificacion
   =========       =========           ====================
 ******************************************************************/
 ------------------------------------------------------------------------------------------------------------------------

 PROCEDURE RfDatosAdicionales(orfcursor OUT constants.tyRefCursor);
  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfDatosAdicionales
  Descripcion    : Procedimiento para extraer datos adicionales para mostrar en el SPOOL.
  Autor          : Jorge Valiente

  Parametros           Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
 ------------------------------------------------------------------------------------------------------------------------

 FUNCTION FSBCategoriaUNICO(InuCATEGORIA number, InuSubCATEGORIA number) RETURN VARCHAR2;
  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FSBCategoriaUNICO
  Descripcion    : funcion para obtener la descripcion UNICO para las categorias
                   configuradas en el parametro COD_CAT_SPO_GDC
  Autor          : Jorge Valiente

  Parametros           Descripcion
  ============         ===================
  inuSusccodi          contrato

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
 ------------------------------------------------------------------------------------------------------------------------

  FUNCTION fsbgetCalifVariConsumos(inusesunuse IN servsusc.sesunuse%TYPE,
                                   inupericose IN conssesu.cosspecs%TYPE)
    RETURN VARCHAR2;
   /*****************************************************************
   Propiedad intelectual de PETI (c).

   Unidad         : fsbgetCalifVariConsumos
   Descripcion    : Permite retronar la causa de desviacion de consumo
   Autor          : Llozada

   Parametros           Descripcion
   ============         ===================
   inusesunuse      Producto
   inupericose      Periodo de consumo

   Fecha             Autor             Modificacion
   =========       =========           ====================
   18/09/2017      llozada           Creacion.
   ******************************************************************/
 ------------------------------------------------------------------------------------------------------------------------

 FUNCTION fsbFormatoCupoBrilla (inuCupo IN NUMBER) RETURN VARCHAR2;
  /*****************************************************************
    Propiedad intelectual de GDC.

    Unidad         : fsbFormatoCupoBrilla
    Descripcion    : dar formato al cupo brilla
    Autor          : elal

    Parametros           Descripcion
    ============         ===================
    inuCupo          cupo

    Fecha             Autor             Modificacion
    =========       =========           ====================
    22/04/2019      elal           Creacion.
  ******************************************************************/
 ------------------------------------------------------------------------------------------------------------------------

 FUNCTION fsbGetPeriodo(inunuse IN NUMBER, inuDiferido IN NUMBER) RETURN VARCHAR2;
  /*****************************************************************
      Propiedad intelectual de GDC (c).

      Unidad         : fsbGetPeriodo
      Descripcion    : proceso que devuelve el periodo del diferido
      Autor          : Luis Javier Lopez - Horbath Technologies

      Parametros           Descripcion
      ============         ===================
        inunuse            producto
        inuDiferido        diferido
          Fecha           Autor               Modificacion
      =========       =========           ====================
      28/05/2020      Luis Lopez          CA 379 :  se adiciona logica para mostrar descripcion del periodo a los diferidos de res 059
 *****************************************************************/
 ------------------------------------------------------------------------------------------------------------------------

 PROCEDURE RfDatosCuenxCobrTt(orfcursor OUT constants.tyRefCursor);
  /*****************************************************************
    Propiedad intelectual de GDC (c).

    Unidad         : RfDatosCuenxCobrTt
    Descripcion    : funcion que devuelve el valor por cobrar de la tarifa transitoria

    Autor          : Luis Javier Lopez Barrios / Horbath

    Parametros           Descripcion
    ============         ===================
    inuSusccodi          contrato

    Fecha             Autor             Modificacion
    =========       =========           ====================
 ******************************************************************/
 ------------------------------------------------------------------------------------------------------------------------

 PROCEDURE RfDatosFinanEspecial(orfcursor OUT constants.tyRefCursor);
 /*****************************************************************
    Propiedad intelectual de GDC (c).

    Unidad         : RfDatosFinanEspecial
    Descripcion    : proceso que devuelve si un producto tiene financiacion de cartera especiales
    Ticket         : 874

    Autor          : Luis Javier Lopez Barrios / Horbath

    Parametros           Descripcion
    ============         ===================


    Fecha             Autor             Modificacion
    =========       =========           ====================
 ******************************************************************/
 ------------------------------------------------------------------------------------------------------------------------

 PROCEDURE RfDatosMedMalubi(orfcursor OUT constants.tyRefCursor);
  /*********************************************************************************
    Propiedad intelectual de GDC (c).

    Unidad         : RfDatosMedMalubi
    Descripcion    : Procedimiento para extraer si el usuario tiene solicitud VSI
                     dentro del periodo de facturación
    Ticket         : OSF-72
    Fecha          : 10/05/2022

    Autor          : John Jairo Jimenez Marimon

    Parametros           Descripcion
    ============         ===================


    Fecha             Autor             Modificacion
    =========       =========           ====================
 **********************************************************************************/
 ------------------------------------------------------------------------------------------------------------------------

 PROCEDURE rfdatosimpresiondig(orfcursorimpdig OUT constants.tyRefCursor);
 /******************************************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : rfdatosimpresiondig
  Descripcion    : Procedimiento que valida si se imprime factuta fisica a usuario o no.
  Ticket         : OSF-65
  Fecha          : 31/05/2022

  Autor          : John Jairo Jimenez Marimon

  Parametros           Descripcion
  ============         ===================


  Fecha             Autor             Modificacion
  =========       =========           ====================
 ******************************************************************************************/
 ------------------------------------------------------------------------------------------------------------------------

 PROCEDURE rfLastPayment(orfcursor OUT constants.tyRefCursor);
 /*********************************************************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : rfLastPayment
  Descripcion    : Procedimiento que retorna el ultimo pago del usuario y la fecha de este ultimo pago.
  Ticket         : OSF-393
  Fecha          : 24/06/2022

  Autor          : John Jairo Jimenez Marimon

  Parametros           Descripcion
  ============         ===================


  Fecha             Autor             Modificacion
  =========       =========           ====================
*********************************************************************************************************/
------------------------------------------------------------------------------------------------------------------------

FUNCTION fnuObtPuntos(inuContrato IN NUMBER) RETURN NUMBER;
/*****************************************************************
 Propiedad intelectual de GDC (c).

 Unidad         : fnuObtPuntos
 Descripcion    : Obtiene los puntos puntualizate de un contrato
 Autor          : Carlos Gonzalez (Horbath)
 ******************************************************************/

 PROCEDURE rfGetSaldoAnterior(orfcursorsaldoante OUT constants.tyRefCursor);
 /******************************************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : rfGetSaldoAnterior
  Descripcion    : Procedimiento que retorna saldo anterior
  Ticket         : OSF-1056
  Fecha          : 26/04/2023
  Autor          : Luis Javier Lopez Barrios

  Parametros           Descripcion
  ============         ===================


  Fecha             Autor             Modificacion
  =========       =========           ====================
 ******************************************************************************************/
 ------------------------------------------------------------------------------------------------------------------------

 PROCEDURE prcGetInfoAdicional(orfcursorinfoadic OUT constants.tyRefCursor);
 /******************************************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : frcGetInfoAdicional
  Descripcion    : Procedimiento que retorna informacion adicional en el spool
  Ticket         : OSF-2494
  Fecha          : 12/04/2024
  Autor          : Luis Javier Lopez Barrios

  Parametros           Descripcion
  ============         ===================


  Fecha             Autor             Modificacion
  =========       =========           ====================
 ******************************************************************************************/
END ldc_detallefact_gascaribe;
/
create or replace PACKAGE BODY LDC_DetalleFact_GasCaribe IS

  csbBSS_FAC_SMS_200849 CONSTANT VARCHAR2(20) := 'BSS_FAC_SMS_200849_5';
  cnuCategoriaInd       CONSTANT servsusc.sesucate%TYPE := dald_parameter.fnuGetNumeric_Value('CODIGO_CATE_INDUSTRIAL',
                                                                                              0);
  gsbPaquete VARCHAR2(30) := 'LDC_DetalleFact_GasCaribe';
 /********************************************************************************************************************************
  Propiedad intelectual de PETI.

  UNID         : LDC_DetalleFact_GasCaribe
  Descripcion    : Paquete con la logica de negocio el Spool de Gas Caribe
  Autor          :
  Fecha          : 11/07/2012

  Historia de Modificaciones
  Fecha         Autor               Modificacion
  -------------------------------------------------
  17/06/2022    cgonzalez      OSF-387 Se ajusta servicios <RfConcepParcial>
  18/04/2022    cgonzalez      OSF-159 Se ajusta servicios <RfConcepParcial>
  04-01-2021    Horbath           CA559. Se ajusta la funcion <<RfDatosCuenxCobrTt>>
  11/07/2018    Sebastian Tapias  REQ.200-1920: Se modifica el servicio: <<RfConcepParcial>>
  13/03/2017    KCienfuegos       CA200-1081: Se modifican los métodos: <<rfdatosconsumohist>>
                                                                        <<rfdatosconsumos>>
                                                                        <<RfDatosRevision>>
  11/01/2017    carlosr           Se crea el método RfDatosConsumos
  26-12-2016    KCienfuegos       CA 200-326 Se modifica proceso InsLD_CUPON_CAUSAL
  18-010-2016   Sandra Muñoz      CA 200-849. Se modifica RfConcepParcial y rfDatosGenerales.
                                  Creacion de la funcion fnuObservNoLectConsec.
  06-09-2016    Sandra Muñoz      Creacion procedimientos fnuProductoPrincipal,
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
                                  para realizar el cambio el origen de datos de temperatura y presión.
                                  Se modifica la funcion <<fnuMesesDeuda>> para que incluya
                                  el valor en reclamo para calcular el saldo de la cuenta
  19-03-2015    Agordillo         Incidente 140493.
                                  Se modifica los procedimiento <<RfConcepParcial>>, <<RfDatosRevision>>,
                                  <<rfGetValCostCompValid>> , <<RfDatosConceptos>>, <<RfDatosConcEstadoCuenta>>
                                  Se crea la funcion <<fnuConceptoComponent>> , <<fnuCanConceptos>>

  02-03-2015    Llozada           Se modifican los métodos <<RfDatosLecturas>>, <<RfDatosConsumoHist>>,
                                  <<fsbGetEncabezado>>, <<RfRangosConsumo>>
  10/05/2022   John Jairo Jimenez OSF-72 Se crea el procedimiento : RfDatosMedMalubi retorna si se debe generara
                                         notificación o nó de medidor mal ubicado.
  02/06/2022   John Jairo Jimenez OSF-65 Se modifica el procedimiento : RfConcepParcial, para cuando la entrega este activa, a la decripcion
                                         de los conceptosde subsidio configurados en el parametro : CONCSUBSIDIOSPOOL
                                         el respectivo % con el que se calculó el subsidio.
                                         Para los intereses de financiacion, tambien en la descripcion
                                         del cargo se debe colocar el %de interes, siempre y cuando el
                                         tipo de producto este configurado en el parametro : INTFINANPRODSPOOL.
 02/06/2022   John Jairo Jimenez    OSF-65 Se modifica el procedimiento : rfdatosconsumohist para
                                            añadirle a la variabe : equival_kwh
                                            el valor en pesos por Kilovatio/hora,la formula aplicada
                                            es : round(consumo_act/(par_pod_calor * consumo_act),2).
24/06/2022   John Jairo Jimenez    OSF-393 Se crea el procedimiento : rfLastPayment el cual nos mostrar?
                                             el ultimo pago del usuario y su respectiva fecha de pago.--
                                             Se modifica el procedimiento : RfDatosLecturas para cuando el
                                             consumo sea estimado y la observacion de lecatura sea NULL,
                                             Se le asigne a la observacion de lectura el valor configurado
                                             en el parametro : PARAM_OBS_DESV_SIGNIFI.
                                             Se modifica el procedimiento : fsbGetEncabezado para agregarle
                                             al encabezado los campos : VALOR_ULTIMO_PAGO y FECHA_ULTIMO_PAGO.

********************************************************************************************************************************/

  ----------------------------------------------------------------------
  -- Constantes
  ----------------------------------------------------------------------
  csbVersion CONSTANT VARCHAR2(50) := 'OSF-1462';

  ----------------------------------------------------------------------
  -- Variables
  ----------------------------------------------------------------------
  gnuConcNumber    NUMBER;

  glPackage_Cupon_id      ld_cupon_causal.package_id%TYPE := NULL; -- Agordillo Cambio.7524
  glCausal_Cupon_id       ld_cupon_causal.causal_id%TYPE := NULL; -- Agordillo Cambio.7524
  glPackage_type_Cupon_id NUMBER := 0; -- Agordillo Cambio.7524

-- Metodos
---------------------------------------------------------------------------------------------
FUNCTION fsbVersion RETURN VARCHAR2 IS
BEGIN
    ut_trace.trace('Inicia LDC_DetalleFact_GasCaribe.fsbVersion'  );
    RETURN csbVersion;
    ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fsbVersion'  );
END fsbVersion;

---------------------------------------------------------------------------------------------
FUNCTION fnuProductoPrincipal(
                              inuContrato suscripc.susccodi%TYPE -- Contrato
                             ) RETURN NUMBER IS
/***********************************************************************************************
 Propiedad intelectual de Gases del Caribe.

 Nombre del Paquete: fnuProductoPrincipal
 Descripcion:        Obtiene el servicio principal de un contrato

 Autor    : Sandra Muñoz
 Fecha    : 18-08-2016 cA200-342

 Historia de Modificaciones

 DD-MM-YYYY    <Autor>.              Modificacion
 -----------  -------------------    -------------------------------------
 18-08-2016   Sandra Muñoz           Creacion
***********************************************************************************************/
nuServGas           ld_parameter.numeric_value%TYPE := dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS');
nuProductoPrincipal servsusc.sesunuse%TYPE; -- Servicio principal
BEGIN
    ut_trace.trace('Inicia LDC_DetalleFact_GasCaribe.fnuProductoPrincipal'  );
    nuProductoPrincipal := NULL;
    SELECT sesunuse INTO nuProductoPrincipal
        FROM servsusc
        WHERE sesususc = inuContrato
        AND sesuserv = nuServGas;
    RETURN nuProductoPrincipal;
    ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fnuProductoPrincipal'  );
    EXCEPTION
        WHEN OTHERS THEN
        RETURN NULL;
END fnuProductoPrincipal;
---------------------------------------------------------------------------------------------

FUNCTION fsbRutaReparto(
                         inuProducto pr_product.product_id%TYPE -- Producto
                       ) RETURN VARCHAR2 IS
/********************************************************************************************************************
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




    Autor    : Sandra Muñoz
    Fecha    : 19-08-2016 cA200-342

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    22-09-2016   Sandra Muñoz           cA 200-342. Si la direccion del contrato es -1 se debe
                                        imprimir DIR COBRO
    21-09-2016   Sandra Muñoz           CA 200-342. Se cambia el tipo de dato retornado por esta funcion
                                        y se publica en la especificacion para poder ser usada en
                                        cursores
    19-08-2016   Sandra Muñoz           Creacion
********************************************************************************************************************/
nuCategoriaComercial   ld_parameter.numeric_value%TYPE := dald_parameter.fnuGetNumeric_Value('COMMERCIAL_CATEGORY'); -- Categoria comercial
nuCategoriaResidencial ld_parameter.numeric_value%TYPE := dald_parameter.fnuGetNumeric_Value('RESIDEN_CATEGORY'); -- Categoria residencial
nuDireccionProducto    pr_product.address_id%TYPE; -- Direccion del producto
nuDireccionContrato    suscripc.susciddi%TYPE; -- Direccion del contrato
nuCicloContrato        ab_segments.ciclcodi%TYPE; -- Ciclo contrato
nuCicloProducto        ab_segments.ciclcodi%TYPE; -- Ciclo contrato
sbRuta                 VARCHAR2(500); -- Ruta de reparto
nuCategoria            pr_product.category_id%TYPE; -- Categoria
nuRutaContrato         ab_segments.route_id%TYPE; -- Ruta del contrato
BEGIN
 ut_trace.trace('Inicia LDC_DetalleFact_GasCaribe.fsbRutaReparto'  );
 -- Buscar la ruta actual ya la informacion del producto y contrato
 SELECT ab_contrato.ciclcodi
       ,ab_producto.ciclcodi
       ,b.susciddi
       ,pp.address_id
       ,pp.category_id
       ,ab_contrato.route_id
   INTO nuCicloContrato
       ,nuCicloProducto
       ,nuDireccionContrato
       ,nuDireccionProducto
       ,nuCategoria
       ,nuRutaContrato
   FROM suscripc b
        ,pr_product pp
        ,ab_address  ca_contrato
        ,ab_segments ab_contrato
        ,ab_address  ca_producto
        ,ab_segments ab_producto
   WHERE b.susccodi             = pp.subscription_id
     AND b.susciddi             = ca_contrato.address_id --(+)
     AND ca_contrato.segment_id = ab_contrato.segments_id
     AND pp.address_id          = ca_producto.address_id --(+)
     AND ca_producto.segment_id = ab_producto.segments_id
     AND pp.product_id          = inuProducto;

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
ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fsbRutaReparto'  );
EXCEPTION
 WHEN OTHERS THEN
  RETURN NULL;
END fsbRutaReparto;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fsbGetEncabezado RETURN VARCHAR2 IS
/******************************************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fsbGetEncabezado
  Descripcion :   Obtiene los encabezados.
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
  Fecha               Autor              Modificacion
  =========           =========          ====================
  26/04/2023          Luis Javier Lopez      OSF-1056: se agrega nuevo campo SALDO_ANTE
  13/09/2022          Jorge Valiente     OSF-555: Agregar al encabezado las nuevas columnas IMPRIMEFACT|VALOR_ULT_PAGO|FECHA_ULT_PAGO
  02/11/2021          LJLB                 CA 874 se coloca campo FINAESPE
  11/06/2020          LJLB               CA 415  se agrega nuevo campo ACUMU_TARITT
  11-11-2016          Sandra Muñoz       CA200-849. Se agrega el titulo OBS_NO_LECT_CONSEC
  07-09-2016          Sandra Muñoz       CA200-342. Se ubica la columna UNID_OPERATIVA despues
                                         del tipo de producto
  01-03-2015          Llozada            Se cambia la columna TIPO DE PRODUCTO por TIPO_DE_PRODUCTO
  30-01-2014          ggamarra           Se modifican las variables de consumo para los rangos
  05-12-2014          ggamarra           Creacion
************************************************************************************************************/
sbEncabezado VARCHAR2(4000);
BEGIN
 ut_trace.trace('Inicia LDC_DetalleFact_GasCaribe.fsbGetEncabezado'  );
 sbEncabezado := 'NUMERO_FACT|FAC_NO|F_D_EMISON|MES_FAC|PERIODO_FACT|F_D_VENC|DIAS_CONSUMO|COD_DE_SERVICIO|CUPON|NOMBRE_SUSC|DIR_ENTREGA|' ||
                 'LOCALIDAD|USO|ESTRATO|CICLO|RUTA|MESES_DEUDA|NUM_CONTROL|PERIODO_CONSUMO|SALDO_A_FAVOR|SALDO_ANT|FECHA_SUSPENSION|VALOR_RECL|' ||
                 'TOTAL_A_PAGAR|PAGO_SIN_RECARGO|CONDICION_PAGO|IDENTIFICA|TIPO_DE_PRODUCTO|';

 sbEncabezado := sbEncabezado || 'OBS_NO_LECT_CONSEC|';
 sbEncabezado := sbEncabezado || 'UNID_OPERATIVA|';
 sbEncabezado := sbEncabezado ||
                'CUPO_DISPONIBLE|NO_MEDIDOR|LEC_ANT|LEC_ACTUAL|' ||
                'CAUSA_N_LEC|CONSUMO|F_CORREC|CONSUMO1|MES1|CONSUMO2|MES2|CONSUMO3|MES3|CONSUMO4|MES4|CONSUMO5|MES5|CONSUMO6|MES6|' ||
                'PROM_CONSUMO|TEMPERATURA|PRESION|CONS_KW|CALCULO_CONS|TIPO_NOTI|MENSGNRAL1|FECH_MAXIMA|FECH_SUSP|LIM_INFERIOR1|LIM_SUPERIOR1|' ||
                'VALOR_UNID1|RCONSUMO1|VAL_CONSUMO1|LIM_INFERIOR2|LIM_SUPERIOR2|VALOR_UNID2|RCONSUMO2|VAL_CONSUMO2|LIM_INFERIOR3|' ||
                'LIM_SUPERIOR3|VALOR_UNID3|RCONSUMO3|VAL_CONSUMO3|LIM_INFERIOR4|LIM_SUPERIOR4|VALOR_UNID4|RCONSUMO4|VAL_CONSUMO4|' ||
                'LIM_INFERIOR5|LIM_SUPERIOR5|VALOR_UNID5|RCONSUMO5|VAL_CONSUMO5|LIM_INFERIOR6|LIM_SUPERIOR6|VALOR_UNID6|RCONSUMO6|' ||
                'VAL_CONSUMO6|LIM_INFERIOR7|LIM_SUPERIOR7|VALOR_UNID7|RCONSUMO7|VAL_CONSUMO7|COMPCOST|VALORESREF|VALCALC|CODIGO_1|CODIGO_2|' ||
                'CODIGO_3|CODIGO_4|CODIGO_BARRAS|TASA_ULTIMA|TASA_PROMEDIO|VISIBLE|IMPRESO|PROTECCION_ESTADO|DIRECCION_PRODUCTO|CAUSA_DESVIACION|PAGARE_UNICO|' ||
                'CAMBIOUSO|ACUMU_TARITT|FINAESPE|MED_MAL_UBICADO|IMPRIMEFACT|VALOR_ULT_PAGO|FECHA_ULT_PAGO|TOTAL|IVA|SUBTOTAL|CARGOSMES|CANTIDAD_CONC|SALDO_ANTE|';
 ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fsbGetEncabezado'  );
 RETURN sbEncabezado;

END fsbGetEncabezado;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fsbGetEncabConc1 RETURN VARCHAR2 IS
/**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fsbGetEncabConc1
  Descripcion :   Obtiene los encabezados.
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
  Fecha               Autor              Modificacion
  =========           =========          ====================
  05-12-2014          ggamarra           Creacion
*************************************************************************/
sbEncabezado VARCHAR2(4000);
BEGIN
  ut_trace.trace('Inicia LDC_DetalleFact_GasCaribe.fsbGetEncabConc1'  );
  sbEncabezado := 'CONC1|DESC_CONCEP1|SALDO_ANT1|CAPITAL1|INTERES1|TOTAL1|SALDO_DIF1|UNID1|CANT1|UNIT1|IVA1|CUOTAS1|CONC2|DESC_CONCEP2|SALDO_ANT2|CAPITAL2|INTERES2|TOTAL2|SALDO_DIF2|UNID2|CANT2|UNIT2|IVA2|CUOTAS2|CONC3|DESC_CONCEP3|SALDO_ANT3|CAPITAL3|INTERES3|TOTAL3|SALDO_DIF3|UNID3|CANT3|UNIT3|IVA3|CUOTAS3|CONC4|DESC_CONCEP4|SALDO_ANT4|CAPITAL4|INTERES4|TOTAL4|SALDO_DIF4|UNID4|CANT4|UNIT4|IVA4|CUOTAS4|' ||
                    'CONC5|DESC_CONCEP5|SALDO_ANT5|CAPITAL5|INTERES5|TOTAL5|SALDO_DIF5|UNID5|CANT5|UNIT5|IVA5|CUOTAS5|CONC6|DESC_CONCEP6|SALDO_ANT6|CAPITAL6|INTERES6|TOTAL6|SALDO_DIF6|UNID6|CANT6|UNIT6|IVA6|CUOTAS6|CONC7|DESC_CONCEP7|SALDO_ANT7|CAPITAL7|INTERES7|TOTAL7|SALDO_DIF7|UNID7|CANT7|UNIT7|IVA7|CUOTAS7|CONC8|DESC_CONCEP8|SALDO_ANT8|CAPITAL8|INTERES8|TOTAL8|SALDO_DIF8|UNID8|CANT8|UNIT8|IVA8|CUOTAS8|' ||
                    'CONC9|DESC_CONCEP9|SALDO_ANT9|CAPITAL9|INTERES9|TOTAL9|SALDO_DIF9|UNID9|CANT9|UNIT9|IVA9|CUOTAS9|CONC10|DESC_CONCEP10|SALDO_ANT10|CAPITAL10|INTERES10|TOTAL10|SALDO_DIF10|UNID10|CANT10|UNIT10|IVA10|CUOTAS10|CONC11|DESC_CONCEP11|SALDO_ANT11|CAPITAL11|INTERES11|TOTAL11|SALDO_DIF11|UNID11|CANT11|UNIT11|IVA11|CUOTAS11|CONC12|DESC_CONCEP12|SALDO_ANT12|CAPITAL12|INTERES12|TOTAL12|SALDO_DIF12|UNID12|CANT12|UNIT12|IVA12|CUOTAS12|' ||
                    'CONC13|DESC_CONCEP13|SALDO_ANT13|CAPITAL13|INTERES13|TOTAL13|SALDO_DIF13|UNID13|CANT13|UNIT13|IVA13|CUOTAS13|CONC14|DESC_CONCEP14|SALDO_ANT14|CAPITAL14|INTERES14|TOTAL14|SALDO_DIF14|UNID14|CANT14|UNIT14|IVA14|CUOTAS14|CONC15|DESC_CONCEP15|SALDO_ANT15|CAPITAL15|INTERES15|TOTAL15|SALDO_DIF15|UNID15|CANT15|UNIT15|IVA15|CUOTAS15|CONC16|DESC_CONCEP16|SALDO_ANT16|CAPITAL16|INTERES16|TOTAL16|SALDO_DIF16|UNID16|CANT16|UNIT16|IVA16|CUOTAS16|' ||
                    'CONC17|DESC_CONCEP17|SALDO_ANT17|CAPITAL17|INTERES17|TOTAL17|SALDO_DIF17|UNID17|CANT17|UNIT17|IVA17|CUOTAS17|CONC18|DESC_CONCEP18|SALDO_ANT18|CAPITAL18|INTERES18|TOTAL18|SALDO_DIF18|UNID18|CANT18|UNIT18|IVA18|CUOTAS18|CONC19|DESC_CONCEP19|SALDO_ANT19|CAPITAL19|INTERES19|TOTAL19|SALDO_DIF19|UNID19|CANT19|UNIT19|IVA19|CUOTAS19|';--CONC20|DESC_CONCEP20|SALDO_ANT20|CAPITAL20|INTERES20|TOTAL20|SALDO_DIF20|UNID20|CANT20|UNIT20|IVA20|CUOTAS20|';*/
 ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fsbGetEncabConc1'  );
 RETURN sbEncabezado;
END fsbGetEncabConc1;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fsbGetEncabConc2 RETURN VARCHAR2 IS
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
sbEncabezado VARCHAR2(4000);
BEGIN
 ut_trace.trace('Inicia LDC_DetalleFact_GasCaribe.fsbGetEncabConc2'  );
 sbEncabezado := 'CONC20|DESC_CONCEP20|SALDO_ANT20|CAPITAL20|INTERES20|TOTAL20|SALDO_DIF20|UNID20|CANT20|UNIT20|IVA20|CUOTAS20|CONC21|DESC_CONCEP21|SALDO_ANT21|CAPITAL21|INTERES21|TOTAL21|SALDO_DIF21|UNID21|CANT21|UNIT21|IVA21|CUOTAS21|CONC22|DESC_CONCEP22|SALDO_ANT22|CAPITAL22|INTERES22|TOTAL22|SALDO_DIF22|UNID22|CANT22|UNIT22|IVA22|CUOTAS22|CONC23|DESC_CONCEP23|SALDO_ANT23|CAPITAL23|INTERES23|TOTAL23|SALDO_DIF23|UNID23|CANT23|UNIT23|IVA23|CUOTAS23|CONC24|DESC_CONCEP24|SALDO_ANT24|CAPITAL24|INTERES24|TOTAL24|SALDO_DIF24|UNID24|CANT24|UNIT24|IVA24|CUOTAS24|' ||
'CONC25|DESC_CONCEP25|SALDO_ANT25|CAPITAL25|INTERES25|TOTAL25|SALDO_DIF25|UNID25|CANT25|UNIT25|IVA25|CUOTAS25|CONC26|DESC_CONCEP26|SALDO_ANT26|CAPITAL26|INTERES26|TOTAL26|SALDO_DIF26|UNID26|CANT26|UNIT26|IVA26|CUOTAS26|CONC27|DESC_CONCEP27|SALDO_ANT27|CAPITAL27|INTERES27|TOTAL27|SALDO_DIF27|UNID27|CANT27|UNIT27|IVA27|CUOTAS27|CONC28|DESC_CONCEP28|SALDO_ANT28|CAPITAL28|INTERES28|TOTAL28|SALDO_DIF28|UNID28|CANT28|UNIT28|IVA28|CUOTAS28|' ||
'CONC29|DESC_CONCEP29|SALDO_ANT29|CAPITAL29|INTERES29|TOTAL29|SALDO_DIF29|UNID29|CANT29|UNIT29|IVA29|CUOTAS29|CONC30|DESC_CONCEP30|SALDO_ANT30|CAPITAL30|INTERES30|TOTAL30|SALDO_DIF30|UNID30|CANT30|UNIT30|IVA30|CUOTAS30|CONC31|DESC_CONCEP31|SALDO_ANT31|CAPITAL31|INTERES31|TOTAL31|SALDO_DIF31|UNID31|CANT31|UNIT31|IVA31|CUOTAS31|CONC32|DESC_CONCEP32|SALDO_ANT32|CAPITAL32|INTERES32|TOTAL32|SALDO_DIF32|UNID32|CANT32|UNIT32|IVA32|CUOTAS32|' ||
'CONC33|DESC_CONCEP33|SALDO_ANT33|CAPITAL33|INTERES33|TOTAL33|SALDO_DIF33|UNID33|CANT33|UNIT33|IVA33|CUOTAS33|CONC34|DESC_CONCEP34|SALDO_ANT34|CAPITAL34|INTERES34|TOTAL34|SALDO_DIF34|UNID34|CANT34|UNIT34|IVA34|CUOTAS34|CONC35|DESC_CONCEP35|SALDO_ANT35|CAPITAL35|INTERES35|TOTAL35|SALDO_DIF35|UNID35|CANT35|UNIT35|IVA35|CUOTAS35|CONC36|DESC_CONCEP36|SALDO_ANT36|CAPITAL36|INTERES36|TOTAL36|SALDO_DIF36|UNID36|CANT36|UNIT36|IVA36|CUOTAS36|' ||
'CONC37|DESC_CONCEP37|SALDO_ANT37|CAPITAL37|INTERES37|TOTAL37|SALDO_DIF37|UNID37|CANT37|UNIT37|IVA37|CUOTAS37|';

 ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fsbGetEncabConc2'  );
 RETURN sbEncabezado;
END fsbGetEncabConc2;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fsbGetEncabConc3 RETURN VARCHAR2 IS
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
sbEncabezado VARCHAR2(4000);
BEGIN
 ut_trace.trace('Inicia LDC_DetalleFact_GasCaribe.fsbGetEncabConc3'  );
 sbEncabezado := 'CONC38|DESC_CONCEP38|SALDO_ANT38|CAPITAL38|INTERES38|TOTAL38|SALDO_DIF38|UNID38|CANT38|UNIT38|IVA38|CUOTAS38|CONC39|DESC_CONCEP39|SALDO_ANT39|CAPITAL39|INTERES39|TOTAL39|SALDO_DIF39|UNID39|CANT39|UNIT39|IVA39|CUOTAS39|CONC40|DESC_CONCEP40|SALDO_ANT40|CAPITAL40|INTERES40|TOTAL40|SALDO_DIF40|UNID40|CANT40|UNIT40|IVA40|CUOTAS40|CONC41|DESC_CONCEP41|SALDO_ANT41|CAPITAL41|INTERES41|TOTAL41|SALDO_DIF41|UNID41|CANT41|UNIT41|IVA41|CUOTAS41|CONC42|DESC_CONCEP42|SALDO_ANT42|CAPITAL42|INTERES42|TOTAL42|SALDO_DIF42|UNID42|CANT42|UNIT42|IVA42|CUOTAS42|CONC43|DESC_CONCEP43|SALDO_ANT43|CAPITAL43|INTERES43|TOTAL43|SALDO_DIF43|UNID43|CANT43|UNIT43|IVA43|CUOTAS43|CONC44|DESC_CONCEP44|SALDO_ANT44|CAPITAL44|INTERES44|TOTAL44|SALDO_DIF44|UNID44|CANT44|UNIT44|IVA44|CUOTAS44|' ||
                'CONC45|DESC_CONCEP45|SALDO_ANT45|CAPITAL45|INTERES45|TOTAL45|SALDO_DIF45|UNID45|CANT45|UNIT45|IVA45|CUOTAS45|CONC46|DESC_CONCEP46|SALDO_ANT46|CAPITAL46|INTERES46|TOTAL46|SALDO_DIF46|UNID46|CANT46|UNIT46|IVA46|CUOTAS46|CONC47|DESC_CONCEP47|SALDO_ANT47|CAPITAL47|INTERES47|TOTAL47|SALDO_DIF47|UNID47|CANT47|UNIT47|IVA47|CUOTAS47|CONC48|DESC_CONCEP48|SALDO_ANT48|CAPITAL48|INTERES48|TOTAL48|SALDO_DIF48|UNID48|CANT48|UNIT48|IVA48|CUOTAS48|' ||
                'CONC49|DESC_CONCEP49|SALDO_ANT49|CAPITAL49|INTERES49|TOTAL49|SALDO_DIF49|UNID49|CANT49|UNIT49|IVA49|CUOTAS49|CONC50|DESC_CONCEP50|SALDO_ANT50|CAPITAL50|INTERES50|TOTAL50|SALDO_DIF50|UNID50|CANT50|UNIT50|IVA50|CUOTAS50|CONC51|DESC_CONCEP51|SALDO_ANT51|CAPITAL51|INTERES51|TOTAL51|SALDO_DIF51|UNID51|CANT51|UNIT51|IVA51|CUOTAS51|CONC52|DESC_CONCEP52|SALDO_ANT52|CAPITAL52|INTERES52|TOTAL52|SALDO_DIF52|UNID52|CANT52|UNIT52|IVA52|CUOTAS52|' ||
                'CONC53|DESC_CONCEP53|SALDO_ANT53|CAPITAL53|INTERES53|TOTAL53|SALDO_DIF53|UNID53|CANT53|UNIT53|IVA53|CUOTAS53|CONC54|DESC_CONCEP54|SALDO_ANT54|CAPITAL54|INTERES54|TOTAL54|SALDO_DIF54|UNID54|CANT54|UNIT54|IVA54|CUOTAS54|CONC55|DESC_CONCEP55|SALDO_ANT55|CAPITAL55|INTERES55|TOTAL55|SALDO_DIF55|UNID55|CANT55|UNIT55|IVA55|CUOTAS55|';


 ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fsbGetEncabConc3'  );
 RETURN sbEncabezado;
END fsbGetEncabConc3;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fsbGetEncabConc4 RETURN VARCHAR2 IS
/*********************************************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fsbGetEncabConc4
  Descripcion :   Obtiene los encabezados.
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
  Fecha               Autor              Modificacion
  =========           =========          ====================
  26-02-2018          Daniel Valiente    Se añadieron los encabezados de Marcas (Visible e Impreso)
  07-09-2016          Sandra Muñoz       CA200-342. Ubica la UNID operativa antes del cupo brilla
  06-09-2016          Sandra Muñoz       CA200-342. Se agrega la columna UNID_OPERATIVA
  05-12-2014          ggamarra           Creacion
*********************************************************************************************************/
sbEncabezado VARCHAR2(4000);
BEGIN
ut_trace.trace('Inicia LDC_DetalleFact_GasCaribe.fsbGetEncabConc4'  );
 sbEncabezado := 'CONC56|DESC_CONCEP56|SALDO_ANT56|CAPITAL56|INTERES56|TOTAL56|SALDO_DIF56|UNID56|CANT56|UNIT56|IVA56|CUOTAS56|CONC57|DESC_CONCEP57|SALDO_ANT57|CAPITAL57|INTERES57|TOTAL57|SALDO_DIF57|UNID57|CANT57|UNIT57|IVA57|CUOTAS57|CONC58|DESC_CONCEP58|SALDO_ANT58|CAPITAL58|INTERES58|TOTAL58|SALDO_DIF58|UNID58|CANT58|UNIT58|IVA58|CUOTAS58|CONC59|DESC_CONCEP59|SALDO_ANT59|CAPITAL59|INTERES59|TOTAL59|SALDO_DIF59|UNID59|CANT59|UNIT59|IVA59|CUOTAS59|'||
                'CONC60|DESC_CONCEP60|SALDO_ANT60|CAPITAL60|INTERES60|TOTAL60|SALDO_DIF60|UNID60|CANT60|UNIT60|IVA60|CUOTAS60|CONC61|DESC_CONCEP61|SALDO_ANT61|CAPITAL61|INTERES61|TOTAL61|SALDO_DIF61|UNID61|CANT61|UNIT61|IVA61|CUOTAS61|CONC62|DESC_CONCEP62|SALDO_ANT62|CAPITAL62|INTERES62|TOTAL62|SALDO_DIF62|UNID62|CANT62|UNIT62|IVA62|CUOTAS62|' ||
                'CONC63|DESC_CONCEP63|SALDO_ANT63|CAPITAL63|INTERES63|TOTAL63|SALDO_DIF63|UNID63|CANT63|UNIT63|IVA63|CUOTAS63|CONC64|DESC_CONCEP64|SALDO_ANT64|CAPITAL64|INTERES64|TOTAL64|SALDO_DIF64|UNID64|CANT64|UNIT64|IVA64|CUOTAS64|CONC65|DESC_CONCEP65|SALDO_ANT65|CAPITAL65|INTERES65|TOTAL65|SALDO_DIF65|UNID65|CANT65|UNIT65|IVA65|CUOTAS65|CONC66|DESC_CONCEP66|SALDO_ANT66|CAPITAL66|INTERES66|TOTAL66|SALDO_DIF66|UNID66|CANT66|UNIT66|IVA66|CUOTAS66|' ||
                'CONC67|DESC_CONCEP67|SALDO_ANT67|CAPITAL67|INTERES67|TOTAL67|SALDO_DIF67|UNID67|CANT67|UNIT67|IVA67|CUOTAS67|CONC68|DESC_CONCEP68|SALDO_ANT68|CAPITAL68|INTERES68|TOTAL68|SALDO_DIF68|UNID68|CANT68|UNIT68|IVA68|CUOTAS68|CONC69|DESC_CONCEP69|SALDO_ANT69|CAPITAL69|INTERES69|TOTAL69|SALDO_DIF69|UNID69|CANT69|UNIT69|IVA69|CUOTAS69|CONC70|DESC_CONCEP70|SALDO_ANT70|CAPITAL70|INTERES70|TOTAL70|SALDO_DIF70|UNID70|CANT70|UNIT70|IVA70|CUOTAS70|' ||
                'CONC71|DESC_CONCEP71|SALDO_ANT71|CAPITAL71|INTERES71|TOTAL71|SALDO_DIF71|UNID71|CANT71|UNIT71|IVA71|CUOTAS71|CONC72|DESC_CONCEP72|SALDO_ANT72|CAPITAL72|INTERES72|TOTAL72|SALDO_DIF72|UNID72|CANT72|UNIT72|IVA72|CUOTAS72|CONC73|DESC_CONCEP73|SALDO_ANT73|CAPITAL73|INTERES73|TOTAL73|SALDO_DIF73|UNID73|CANT73|UNIT73|IVA73|CUOTAS73|';
 ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fsbGetEncabConc4'  );
 RETURN sbEncabezado;
END fsbGetEncabConc4;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fsbGetEncabConc5 RETURN VARCHAR2 IS
/*********************************************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fsbGetEncabConc5
  Descripcion :   Obtiene los encabezados.
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
  Fecha               Autor              Modificacion
  =========           =========          ====================
  05-12-2014          ggamarra           Creacion
*********************************************************************************************************/
sbEncabezado VARCHAR2(4000);
BEGIN
ut_trace.trace('Inicia LDC_DetalleFact_GasCaribe.fsbGetEncabConc5'  );
 sbEncabezado := 'CONC74|DESC_CONCEP74|SALDO_ANT74|CAPITAL74|INTERES74|TOTAL74|SALDO_DIF74|UNID74|CANT74|UNIT74|IVA74|CUOTAS74|' ||
                'CONC75|DESC_CONCEP75|SALDO_ANT75|CAPITAL75|INTERES75|TOTAL75|SALDO_DIF75|UNID75|CANT75|UNIT75|IVA75|CUOTAS75|CONC76|DESC_CONCEP76|SALDO_ANT76|CAPITAL76|INTERES76|TOTAL76|SALDO_DIF76|UNID76|CANT76|UNIT76|IVA76|CUOTAS76|CONC77|DESC_CONCEP77|SALDO_ANT77|CAPITAL77|INTERES77|TOTAL77|SALDO_DIF77|UNID77|CANT77|UNIT77|IVA77|CUOTAS77|CONC78|DESC_CONCEP78|SALDO_ANT78|CAPITAL78|INTERES78|TOTAL78|SALDO_DIF78|UNID78|CANT78|UNIT78|IVA78|CUOTAS78|CALIFICACION|';
 ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fsbGetEncabConc5'  );
 RETURN sbEncabezado;
END fsbGetEncabConc5;

FUNCTION fnuGetProducto(inuFactura IN factura.factcodi%TYPE) RETURN NUMBER IS
/**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   fnuGetProducto
  Descripcion :   Obtiene el producto asociado al contrato
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
  Fecha               Autor              Modificacion
  =========           =========          ====================
  11-11-2014          ggamarra           Creacion
*****************************************************************************/
nuSesunuse servsusc.sesunuse%TYPE;
BEGIN
 ut_trace.trace('Inicia LDC_DetalleFact_GasCaribe.fnuGetProducto'  );
 -- Inicialmente se consulta si tiene producto de GAS
 BEGIN
  SELECT sesunuse INTO nuSesunuse
    FROM servsusc, cuencobr
   WHERE sesunuse = cuconuse
     AND cucofact = inuFactura
     AND sesuserv = dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS')
     AND rownum = 1;
 EXCEPTION
  WHEN no_data_found THEN
      nuSesunuse := -1;
 END;
 -- Si no tiene producto de GAS se selecciona cualquier producto del contrato
 IF (nuSesunuse = -1) THEN
  BEGIN
   SELECT cuconuse INTO nusesunuse
     FROM cuencobr
    WHERE cucofact = inuFactura
      AND rownum = 1;
  EXCEPTION
   WHEN no_data_found THEN
       nuSesunuse := 0;
  END;
 END IF;
 ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fnuGetProducto'  );
 RETURN nuSesunuse;
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  RAISE pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
   Pkg_Error.setError;
   RAISE pkg_error.CONTROLLED_ERROR;
END fnuGetProducto;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fnuFechaSuspension(
                            nuProducto  IN servsusc.sesunuse%TYPE
                           ,nuCategoria IN servsusc.sesucate%TYPE
                           )
RETURN NUMBER IS
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
nuCuentaSaldo NUMBER;
nuDifeSaldo   NUMBER;
nuSuspende    NUMBER;
BEGIN
 ut_trace.trace('Inicia LDC_DetalleFact_GasCaribe.fnuFechaSuspension'  );
 SELECT /*+ index(cuencobr IX_CUENCOBR03)*/
       COUNT(1) INTO nuCuentaSaldo
   FROM cuencobr c
  WHERE c.cuconuse = nuProducto
    AND c.cucosacu > 0;

 SELECT COUNT(1) INTO nuDifeSaldo
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
 ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fnuFechaSuspension'  );
 RETURN nuSuspende;
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  RAISE pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
   Pkg_Error.setError;
   RAISE pkg_error.CONTROLLED_ERROR;
END fnuFechaSuspension;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fnumesesdeuda(inususccodi suscripc.susccodi%TYPE) RETURN NUMBER IS
/*************************************************************************************
  Propiedad intelectual de PETI (c).

  UNID         : fnuMesesDeuda
  Descripcion    : función para obtener los meses con deuda del contrato.
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
*****************************************************************************************/
numesesdeuda NUMBER;
BEGIN
ut_trace.trace('Inicia LDC_DetalleFact_GasCaribe.fnumesesdeuda'  );
 SELECT MAX(cuentas) INTO numesesdeuda
   FROM (
         SELECT sesunuse, COUNT(1) cuentas
           FROM cuencobr, servsusc
          WHERE cuconuse = sesunuse
            AND sesususc = inususccodi
            AND (nvl(cucosacu, 0) - nvl(cucovare, 0) - nvl(cucovrap, 0)) > 0
          GROUP BY sesunuse);
 ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fnumesesdeuda'  );
 RETURN numesesdeuda;
EXCEPTION
 WHEN OTHERS THEN
  RETURN 0;
END fnumesesdeuda;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fblNoRegulado(inuSusccodi suscripc.susccodi%TYPE) RETURN BOOLEAN IS
/*********************************************************************************************
  Propiedad intelectual de PETI (c).

  UNID         : fblNoRegulado
  Descripcion    : función para obtener si el contrato es regulado o no.
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================
  inuSusccodi          contrato

  Fecha             Autor             Modificacion
  =========       =========           ====================
  13/11/2014      ggamarra           Creacion.
  15/03/2019      Jorge Valiente     CAS 200-2479: Modificaion del servicio  con la definicion del
                                                   Ing. Francisco Castro. buscando el servicio
                                                   de tipo de producto 7014
******************************************************************************************************/
nuCategori  NUMBER;
sbParameter ld_parameter.value_chain%TYPE := dald_parameter.fsbGetValue_Chain('CATEG_IDUSTRIA_NO_REG');
BEGIN
 ut_trace.trace('Inicia LDC_DetalleFact_GasCaribe.fblNoRegulado'  );
 SELECT sesucate INTO nuCategori
   FROM servsusc
  WHERE sesususc = inuSusccodi
    AND sesuserv = 7014
    AND rownum = 1;

 IF instr('|' || sbParameter || '|', '|' || nuCategori || '|') > 0 THEN
  RETURN TRUE;
 END IF;
 RETURN FALSE;
 ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fblNoRegulado'  );
EXCEPTION
 WHEN OTHERS THEN
  RETURN FALSE;
END fblNoRegulado;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE rfdatosgenerales(
                           orfcursor OUT constants.tyRefCursor
                          ) IS
/****************************************************************************************************************
  Propiedad intelectual de PETI (c).

  UNID         : RfDatosGenerales
  Descripcion    : Procedimiento para extraer los campos relacionados
                   con los datos generales de la factura.
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
 19/07/2022         JJJM              OSF-407 Se desacopla el procedimiento, pasando la
                                      logica al procedimiento : ldc_pkgprocefactspoolatencli.rfdatosgenerales
                                      y haciendo el llamado desde este.
****************************************************************************************************************/
 sbFactcodi      ge_boInstanceControl.stysbValue;
 sbFactsusc      ge_boInstanceControl.stysbValue;
 blnregulado     BOOLEAN;
BEGIN
 ut_trace.trace('Inicio ldc_detallefact_gascaribe.rfdatosgenerales', 15);
 -- Obtiene el identificador de la factura instanciada
 sbFactcodi  := obtenervalorinstancia('FACTURA', 'FACTCODI');
 ut_trace.trace('Parametro sbFactcodi : '||sbFactcodi, 15);
 sbFactsusc  := obtenervalorinstancia('FACTURA', 'FACTSUSC');
 ut_trace.trace('Parametro sbFactsusc : '||sbFactsusc, 15);
 blnregulado := fblnoregulado(sbfactsusc);
 -- Se obtiene resultado
 ut_trace.trace('Se ejecuta el procedimiento : ldc_pkgprocefactspoolatencli.rfdatosgenerales', 15);
 ldc_pkgprocefactspoolatencli.rfdatosgenerales(
                                               sbFactcodi
                                              ,sbFactsusc
                                              ,blnregulado
                                              ,orfcursor
                                              );
 ut_trace.trace('Fin ldc_detallefact_gascaribe.rfdatosgenerales', 15);
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  RAISE pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
  Pkg_Error.setError;
  RAISE pkg_error.CONTROLLED_ERROR;
END rfdatosgenerales;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fnuLecturaAnterior(
                            inusesunuse    IN servsusc.sesunuse%TYPE
                           ,inuPeriodoFact IN perifact.pefacodi%TYPE
                           ) RETURN NUMBER IS
/*******************************************************************************************************************************************
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
*******************************************************************************************************************************************/
nuLectAnterior lectelme.leemleto%TYPE;
dtFechaPefa    lectelme.leemfele%TYPE;
BEGIN
 ut_trace.trace('INICIA LDC_DetalleFact_GasCaribe.fnuLecturaAnterior',15);
 ut_trace.trace('LDC_DetalleFact_GasCaribe.fnuLecturaAnterior inuPeriodoFact ' ||inuPeriodoFact,15);
 -- Se consulta la fecha de lectura del periodo de facturacion actual que se esta procesando
 BEGIN
  SELECT Trunc(leemfele) INTO dtFechaPefa
    FROM lectelme
   WHERE leemsesu = inusesunuse
     AND leemclec = 'F'
     AND leempefa = inuPeriodoFact
     AND rownum = 1;
  EXCEPTION
   WHEN no_data_found THEN
    dtFechaPefa := Trunc(SYSDATE);
  END;

 BEGIN
  SELECT leemleto INTO nuLectAnterior
    FROM (
          SELECT
                 CASE
                  WHEN Nvl(leemobsb, -2) NOT IN (-2, -1) THEN
                   NULL
                 ELSE
                   leemleto
                 END leemleto
                ,leempefa
            FROM lectelme
           WHERE leemsesu = inusesunuse
             AND leemclec = 'F'
             AND leempefa != inuPeriodoFact
             AND leemfele < dtfechapefa
           ORDER BY leemfele DESC
         )
   WHERE rownum = 1;
EXCEPTION
 WHEN No_Data_Found THEN
   nuLectAnterior := NULL;
END;
ut_trace.trace('FIN LDC_DetalleFact_GasCaribe.fnuLecturaAnterior', 15);
RETURN nuLectAnterior;
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
    nuLectAnterior := NULL;
    RETURN nuLectAnterior;
 WHEN OTHERS THEN
   Pkg_Error.setError;
   nuLectAnterior := NULL;
   RETURN nuLectAnterior;
END fnuLecturaAnterior;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE RfDatosLecturas(orfcursor OUT constants.tyRefCursor) AS
/**********************************************************************************************************************************
  Propiedad intelectual de PETI (c).

  UNID         : RfDatosLecturas
  Descripcion    : Procedimiento para extraer los datos relacionados
                   con las lecturas
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos de las lecturas.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  21/07/2022       JJJM              OSF-407 Se desacopla el procedimiento, pasando la
                                     logica al procedimiento : ldc_pkgprocefactspoolfac.RfDatosLecturas
                                     y haciendo el llamado desde este.

**********************************************************************************************************************************/
sbFactcodi  ge_boInstanceControl.stysbValue;
sbFactsusc  ge_boInstanceControl.stysbValue;
sbfactpefa  ge_boinstancecontrol.stysbvalue;
blnregulado BOOLEAN;
nuSesunuse  servsusc.sesunuse%TYPE;
nucicloc    NUMBER;
BEGIN
 ut_trace.trace('Inicio ldc_detallefact_gascaribe.rfdatoslecturas', 15);
 sbFactcodi    := obtenervalorinstancia('FACTURA', 'FACTCODI');
 ut_trace.trace('Parametro : sbFactcodi : '||sbFactcodi, 15);
 sbFactsusc    := obtenervalorinstancia('FACTURA', 'FACTSUSC');
 ut_trace.trace('Parametro : sbFactsusc : '||sbFactsusc, 15);
 blNRegulado   := fblNoRegulado(sbFactsusc);
 ut_trace.trace('Parametro : blNRegulado : ', 15);
 nuSesunuse    := fnuGetProducto(sbFactcodi);
 ut_trace.trace('Parametro : nuSesunuse : '||nuSesunuse, 15);
 nucicloc      := nvl(pktblservsusc.fnugetbillingcycle(nuSesunuse), -1);
 ut_trace.trace('Parametro : nucicloc : '||nucicloc, 15);
 sbfactpefa    := obtenervalorinstancia('FACTURA', 'FACTPEFA');
 ut_trace.trace('Parametro : sbfactpefa : '||sbfactpefa, 15);
 ut_trace.trace('Ejecucion ldc_pkgprocefactspoolfac.rfdatoslecturas', 15);
 ldc_pkgprocefactspoolfac.rfdatoslecturas(
                                          sbFactcodi
                                         ,sbfactpefa
                                         ,blNRegulado
                                         ,nuSesunuse
                                         ,nucicloc
                                         ,orfcursor
                                         );
 ut_trace.trace('Fin ldc_detallefact_gascaribe.rfdatoslecturas', 15);
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
   RAISE pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
   Pkg_Error.setError;
   RAISE pkg_error.CONTROLLED_ERROR;
END RfDatosLecturas;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION frfCambioCiclo(inufactsusc IN NUMBER) RETURN constants.tyRefCursor IS
/**********************************************************************************
  Propiedad intelectual de PETI (c).

  UNID         : frfCambioCiclo
  Descripcion    : Permite consultar los ultimos periodos facturados del contrato
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================
  orfcursor            Retorna los datos de los periodos facturados

  Fecha             Autor             Modificacion
  =========       =========           ====================
  11/11/2014      ggamarra           Creacion.
*************************************************************************************/
ofrPeriodos constants.tyRefCursor;
BEGIN
 ut_trace.trace('Inicia LDC_DetalleFact_GasCaribe.frfCambioCiclo'  );
 OPEN ofrPeriodos FOR
  SELECT factpefa
            FROM(
                 SELECT factpefa, trunc(factfege)
                   FROM factura
                  WHERE factsusc = inufactsusc
                    AND factprog = 6
                  GROUP BY factpefa, factfege
                  ORDER BY factfege DESC
                 )
   WHERE rownum < 8;
   ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.frfCambioCiclo'  );
RETURN ofrPeriodos;
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  RAISE pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
  Pkg_Error.setError;
  RAISE pkg_error.CONTROLLED_ERROR;
END frfCambioCiclo;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fsbGetFechaPermmyyyy(inupefacodi IN perifact.pefacodi%TYPE) RETURN VARCHAR2 IS
/*************************************************************************
  Propiedad intelectual de PETI (c).

  UNID         : fsbGetFechaPermmyyyy
  Descripcion    : Permite consultar la fecha del periodo
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================
  orfcursor            Retorna los datos de los periodos facturados

  Fecha             Autor             Modificacion
  =========       =========           ====================
  11/11/2014      ggamarra           Creacion.
*************************************************************************/
sbFechaPeriodo VARCHAR2(20);
BEGIN
 ut_trace.trace('Inicia LDC_DetalleFact_GasCaribe.fsbGetFechaPermmyyyy'  );
 IF (inupefacodi != -1) THEN
  SELECT to_char(to_date(pefames || '/' || pefaano, 'mm/yyyy'),'MON-YY')
    INTO sbFechaPeriodo
    FROM perifact
   WHERE pefacodi = inupefacodi;
 ELSE
  sbFechaPeriodo := '';
 END IF;
 ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fsbGetFechaPermmyyyy'  );
 RETURN sbFechaPeriodo;
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  sbFechaPeriodo := '';
  RETURN sbFechaPeriodo;
 WHEN OTHERS THEN
  Pkg_Error.setError;
  sbFechaPeriodo := '';
  RETURN sbFechaPeriodo;
END fsbGetFechaPermmyyyy;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fnuGetConsumoResidencial(
                                  inusesunuse IN servsusc.sesunuse%TYPE
                                 ,inuPericose IN conssesu.cosspecs%TYPE
                                 ) RETURN NUMBER IS
/********************************************************************************
  Propiedad intelectual de PETI (c).

  UNID         : fnuGetConsumoResidencial
  Descripcion    : Permite consultar el consumo residencial
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================
  orfcursor            Retorna los datos de los periodos facturados

  Fecha             Autor             Modificacion
  =========       =========           ====================
  11/11/2014      ggamarra           Creacion.
********************************************************************************/
nuConsumo conssesu.cosscoca%TYPE;
BEGIN
 ut_trace.trace('Inicia LDC_DetalleFact_GasCaribe.fnuGetConsumoResidencial'  );
 BEGIN
  SELECT cosssuma INTO nuConsumo
    FROM vw_cmprodconsumptions
   WHERE cosssesu = inusesunuse
     AND cosspecs = inuPericose
     AND rownum = 1;
 EXCEPTION
  WHEN no_data_found THEN
      nuConsumo := 0;
 END;
 ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fnuGetConsumoResidencial'  );
 RETURN nuConsumo;
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  nuConsumo := 0;
  RETURN nuConsumo;
 WHEN OTHERS THEN
  nuConsumo := 0;
  RETURN nuConsumo;
END fnuGetConsumoResidencial;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE rfdatosconsumohist(orfcursor OUT constants.tyrefcursor) AS
/*********************************************************************************************************************
  Propiedad intelectual de PETI (c).

  UNID         : RfDatosConsumoHist
  Descripcion    : Procedimiento para extraer los datos relacionados
                   a los consumos historicos
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================
  orfcursor            Retorna los datos consumos historicos.

  Fecha             Autor            Modificacion
  =========       =========          ====================
  19/07/2022         JJJM              OSF-407 Se desacopla el procedimiento, pasando la
                                      logica al procedimiento : ldc_pkgprocefactspoolatencli.rfdatosgenerales
                                      y haciendo el llamado desde este.
*********************************************************************************************************************/
sbfactsusc  ge_boinstancecontrol.stysbvalue;
sbfactpefa  ge_boinstancecontrol.stysbvalue;
sbfactcodi  ge_boinstancecontrol.stysbvalue;
blnregulado BOOLEAN;
BEGIN
 ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist',15);
 sbfactsusc  := obtenervalorinstancia('FACTURA', 'FACTSUSC');
 sbfactpefa  := obtenervalorinstancia('FACTURA', 'FACTPEFA');
 sbfactcodi  := obtenervalorinstancia('FACTURA', 'FACTCODI');
 blnregulado := fblnoregulado(sbfactsusc);
 ldc_pkgprocefactspoolconsu.rfdatosconsumohist(
                                               sbfactsusc
                                              ,sbfactpefa
                                              ,sbfactcodi
                                              ,blnregulado
                                              ,orfcursor
                                              );
 ut_trace.trace('Fin LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist', 15);
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  RAISE pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
  Pkg_Error.setError;
  RAISE pkg_error.CONTROLLED_ERROR;
END rfdatosconsumohist;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE RfDatosRevision(orfcursor OUT constants.tyRefCursor) IS
/****************************************************************************************************************************************
  Propiedad intelectual de PETI (c).

  UNID         : RfDatosRevision
  Descripcion    : Procedimiento para extraer los campos relacionados
                   con los datos del medidor.
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================
  orfcursor            Retorna los datos de las fechas de revision

  Fecha           Autor               Modificacion
  =========       =========           ====================
  22/04/2022    ibecerra        OSF-144 se modifica la logica para llamar al servicio <ldc_pkgprocrevperfact.RfDatosRevision>
  01/07/2021      ljlb                ca 635 se coloca para que siempre muestre la fecha de vencimiento de revision periodica
  21/10/2020       horbath            ca 465: se quita validacion cuando la edad es 60 dias
  19/12/2019      horbath             CA 27 Se mofifica logica para validar que si se esta ejecuando el FIDF
                                      y la entrega 27 este activa llene la tabla LDC_INFOPRNORP .
  1604/2019       ELAL                CA 200-2032 Se actualiza campo FECH_SUSP  y FECH_MAXIMA dependiedo el tipo de noti
  13/03/2017      KCienfuegos        CA200-1081: Se crea el cursor cuObtProductoGas para obtener el producto de gas
                                     del contrato asociado a la factura.
  20/08/2016      Sandra Muñoz       CA 200-342. Imprime fecha de suspension INMEDIATO si la fecha
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
****************************************************************************************************************************************/
BEGIN
 ut_trace.trace('INICIO ldc_detallefact_gascaribe.RfDatosRevision', 3);
  ldc_pkgprocrevperfact.RfDatosRevision(orfcursor);
 ut_trace.trace('FIN ldc_detallefact_gascaribe.RfDatosRevision', 3);
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  ut_trace.trace('ERROR CONTROLLED_ERROR ldc_detallefact_gascaribe.RfDatosRevision', 3);
  RAISE pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
  ut_trace.trace('ERROR OTHERS ldc_detallefact_gascaribe.RfDatosRevision',1);
  Pkg_Error.setError;
  RAISE pkg_error.CONTROLLED_ERROR;
END RfDatosRevision;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE rfdatosconceptos(
                           orfcursor OUT constants.tyRefCursor
                           ) IS
/*****************************************************************************************************************
    Propiedad intelectual de PETI (c).

    UNID         : RfDatosConceptos
    Descripcion    : Procedimiento para extraer los campos relacionados
                     con los datos de los conceptos.
    Autor          : Gabriel Gamarra - Horbath Technologies

    Parametros           Descripcion
    ============         ===================
  orfcursor            Retorna los datos de los conceptos.

    Fecha           Autor               Modificacion
    =========       =========           ====================
   19/07/2022         JJJM              OSF-407 Se desacopla el procedimiento, pasando la
                                        logica al procedimiento : ldc_pkgprocefactspoolfac.rfdatosconceptos
                                        y haciendo el llamado desde este.
*****************************************************************************************************************/
 sbFactsusc  ge_boInstanceControl.stysbValue;
 blNRegulado BOOLEAN;
BEGIN
 ut_trace.trace('INICIO LDC_DetalleFact_GasCaribe.RfDatosConceptos',15);
 -- Obtiene el identificador de la factura instanciada
 sbFactsusc  := obtenervalorinstancia('FACTURA', 'FACTSUSC');
 ut_trace.trace('parametro sbFactsusc : '||sbFactsusc, 15);
 blNRegulado := fblNoRegulado(sbFactsusc);
 ldc_pkgprocefactspoolfac.RfDatosConceptos(
                                           blNRegulado
                                          ,orfcursor
                                          );
 ut_trace.trace('FIN LDC_DetalleFact_GasCaribe.RfDatosConceptos', 15);
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  ut_trace.trace('ERROR CONTROLLED_ERROR', 5);
   RAISE pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
  ut_trace.trace('ERROR OTHERS', 5);
  Pkg_Error.setError;
  RAISE pkg_error.CONTROLLED_ERROR;
END RfDatosConceptos;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fnuCanConceptos RETURN NUMBER AS
/**********************************************************************************************************
  Propiedad intelectual de PETI (c).

  UNID         : fnuCanConceptos
  Descripcion    : Obtiene la cantidad de conceptos a mostrar en el detalle de la factura.
  Autor          : Alexandra Gordillo

  Fecha           Autor               Modificacion
  =========       =========           ====================
  09-10-2024      LJLB                OSF-3434: se cambia consulta de cantidad de concepto
  12-09-2016      Sandra Muñoz        Se agrupan los registros del concepto brilla para obtener
                                      el total de conceptos
  07/04/2015      Agordillo           Creacion.

**********************************************************************************************************/
sbFactsusc            ge_boInstanceControl.stysbValue;
blNRegulado           BOOLEAN;
nuCanConceptos        NUMBER;
nuServicioBrilla      ld_parameter.numeric_value%TYPE := dald_parameter.fnuGetNumeric_Value('COD_PRODUCT_TYPE_BRILLA'); -- CA200-342. Producto brilla
nuAplicaEntrega200342 NUMBER;
BEGIN
 ut_trace.trace('Inicia LDC_DetalleFact_GasCaribe.fnuCanConceptos'  );
 -- Obtiene el identificador de la factura instanciada
 sbFactsusc  := obtenervalorinstancia('FACTURA', 'FACTSUSC');
 blNRegulado := fblNoRegulado(sbFactsusc);
 IF NOT blNRegulado THEN
  nuAplicaEntrega200342 := 1;
  SELECT COUNT(1) INTO nuCanConceptos
   from ( SELECT * 
         FROM ( SELECT etiqueta
                       ,nvl(concepto_id, decode(etiqueta, 31, -1,33, -2, -3 )) concepto_id 
                       ,desc_concep
                       ,to_char(saldo_ant, 'FM999,999,999,990') saldo_ant
                       ,to_char(capital, 'FM999,999,999,990') capital
                       ,to_char(interes, 'FM999,999,999,990') interes
                       ,to_char(total, 'FM999,999,999,990') total
                       ,to_char(saldo_dif, 'FM999,999,999,990') saldo_dif                       
                       ,unidad_items
                       ,cantidad
                       ,to_char(valor_unitario, 'FM999,999,999,990') valor_unitario  
                       ,to_char(valor_iva, 'FM999,999,999,990') valor_iva               
                       ,cuotas       
               FROM (
                     SELECT id etiqueta
                           , MAX(concepto_id) concepto_id--decode(id, 31, -1,33, -2, -3 ))) concepto_id
                           ,concepto desc_concep
                           ,SUM(vencido) saldo_ant
                           ,SUM(valor_mes) capital
                           ,SUM(amortizacion) interes
                           ,SUM(presente_mes) total
                           ,SUM(saldo_diferido) saldo_dif
                           ,ltrim(rtrim(to_char(MAX(cuotas_pendientes),'FM999,999,999,990'))) cuotas
                           ,max(unidad_items) unidad_items
                           ,max(cantidad) cantidad
                           ,sum(valor_iva) valor_iva
                           ,SUM(valor_unitario) valor_unitario
                           ,MAX(orden_concepto) orden
                       FROM ldc_conc_factura_temp lcft
                      WHERE (lcft.servicio <> 7055
                         OR nuAplicaEntrega200342 = 0) AND id IS NOT NULL
                         and not exists (select 1 from concbali, concepto where concbali.COBLCOBA =  concepto_id  and concepto.conccodi = COBLCONC and CONCTICL = 4)
                      GROUP BY  id, concepto, doc_soporte, cau_cargo
                      union all
                      SELECT id etiqueta
                               , MAX(concepto_id) concepto_id
                               ,c.concdefa desc_concep
                               ,SUM(vencido) saldo_ant
                               ,SUM(valor_mes) capital
                               ,SUM(amortizacion) interes
                               ,SUM(presente_mes) total
                               ,SUM(saldo_diferido) saldo_dif
                               ,ltrim(rtrim(to_char(max(cuotas_pendientes),'FM999,999,999,990'))) cuotas
                               ,unidad_items
                               ,cantidad
                               ,sum(valor_iva) valor_iva
                               ,SUM(valor_unitario) valor_unitario
                               ,MAX(orden_concepto) orden
                           FROM ldc_conc_factura_temp lcft, concepto c
                          WHERE (lcft.servicio <> 7055
                             OR nuAplicaEntrega200342 = 0) AND id IS NOT NULL
                             and c.conccodi = concepto_id
                             and exists (select 1 from concbali, concepto where concbali.COBLCOBA =  concepto_id  and concepto.conccodi = COBLCONC and CONCTICL = 4)
                     GROUP BY id, c.concdefa, SERVICIO, unidad_items,  cantidad
                     UNION ALL
                     SELECT id etiqueta
                           ,MAX(concepto_id) concepto_id--, decode(id, 31, -1,33, -2, -3 ))) concepto_id
                           ,concepto desc_concep
                           ,SUM(vencido) saldo_ant
                           ,SUM(valor_mes) capital
                           ,SUM(amortizacion) interes
                           ,SUM(presente_mes) total
                           ,SUM(saldo_diferido) saldo_dif
                           ,ltrim(rtrim(to_char(cuotas_pendientes,'FM999,999,999,990'))) cuotas
                           ,MAX(unidad_items) unidad_items
                           ,MAX(cantidad) cantidad
                           ,SUM(valor_iva) valor_iva
                           ,SUM(valor_unitario) valor_unitario
                           ,MAX(orden_concepto) orden
                    FROM ldc_conc_factura_temp lcft
                   WHERE lcft.servicio = 7055
                     AND nuAplicaEntrega200342 = 1
                     AND id IS NOT NULL
                     and not exists (select 1 from concbali, concepto where concbali.COBLCOBA =  concepto_id  AND concepto.conccodi = COBLCONC AND CONCTICL = 4)          
                   GROUP BY id, concepto, cuotas_pendientes
                   UNION ALL
                   SELECT id etiqueta
                       , MAX(concepto_id) concepto_id
                       ,c.concdefa desc_concep
                       ,SUM(vencido) saldo_ant
                       ,SUM(valor_mes) capital
                       ,SUM(amortizacion) interes
                       ,SUM(presente_mes) total
                       ,SUM(saldo_diferido) saldo_dif
                       ,ltrim(rtrim(to_char(max(cuotas_pendientes),'FM999,999,999,990'))) cuotas
                       ,unidad_items
                       ,cantidad
                       ,sum(valor_iva) valor_iva
                       ,SUM(valor_unitario) valor_unitario
                       ,MAX(orden_concepto) orden
                  FROM ldc_conc_factura_temp lcft, concepto c
                  WHERE  lcft.servicio = 7055
                     AND nuAplicaEntrega200342 = 1
                     AND id IS NOT NULL
                     AND c.conccodi = concepto_id
                     AND exists (select 1 from concbali, concepto where concbali.COBLCOBA =  concepto_id  AND concepto.conccodi = COBLCONC AND CONCTICL = 4)
                  GROUP BY id, c.concdefa,  SERVICIO ,unidad_items,  cantidad
                 UNION ALL
                SELECT  33 etiqueta
                       ,-2 concepto_id
                       ,'TOTAL SERVICIOS:' desc_concep
                       ,NULL saldo_ant
                       ,SUM(valor_mes) capital
                       ,SUM(amortizacion) interes
                       ,SUM(presente_mes) total
                       ,SUM(saldo_diferido) saldo_dif
                       ,'' cuotas
                       ,'' unidad_items
                       ,NULL cantidad
                       ,SUM(valor_iva) valor_iva
                       ,NULL valor_unitario
                       ,100 orden
                FROM ldc_conc_factura_temp
                WHERE ID = 33
                ORDER BY orden
                )
             WHERE ( NVL(saldo_ant,0) + NVL(capital,0) + NVL(interes,0) + NVL(total,0) + NVL(saldo_dif,0) ) <> 0
                         OR nvl(etiqueta,'33') <> '32'));

 ELSE
  SELECT COUNT(1) INTO nuCanConceptos
    FROM (
           SELECT * 
          FROM ( SELECT etiqueta
                        ,concepto_id
                        ,desc_concep
                        ,saldo_ant
                        ,capital
                        ,interes
                        ,total
                        ,saldo_dif        
                        ,unidad_items
                        ,cantidad
                        ,to_char(valor_unitario, 'FM999,999,999,990') valor_unitario   
                        ,to_char(valor_iva, 'FM999,999,999,990') valor_iva          
                        ,cuotas        
                 FROM (
                       SELECT id etiqueta
                             ,MAX(nvl(concepto_id, decode(id, 31, -1,33, -2, -3 )))  concepto_id
                             ,concepto desc_concep
                             ,NULL saldo_ant
                             ,to_char(SUM(valor_mes), 'FM999,999,999,990') capital
                             ,to_char(SUM(amortizacion), 'FM999,999,999,990') interes
                             ,to_char(SUM(presente_mes), 'FM999,999,999,990') total
                             ,to_char(SUM(saldo_diferido), 'FM999,999,999,990') saldo_dif
                             ,ltrim(rtrim(to_char(MAX(producto),'FM999,999,999,990'))) cuotas
                             ,unidad_items
                             ,cantidad
                             ,sum(valor_iva) valor_iva
                             ,SUM(valor_unitario) valor_unitario
                             ,MAX(orden_concepto) orden
                         FROM ldc_conc_factura_temp
                        WHERE conc_signo NOT IN ('SA', 'PA')
                        GROUP BY id, concepto, doc_soporte, cau_cargo, unidad_items, cantidad
                        ORDER BY orden ))     );
 END IF;
 ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fnuCanConceptos'  );
 RETURN nuCanConceptos;
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  nuCanConceptos := 0;
  RETURN nuCanConceptos;
 WHEN OTHERS THEN
  Pkg_Error.setError;
  nuCanConceptos := 0;
  RETURN nuCanConceptos;
END fnuCanConceptos;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE RfDatosConcEstadoCuenta(orfcursor OUT constants.tyRefCursor) IS
/**********************************************************************************************************************************
    Propiedad intelectual de PETI (c).

    UNID         : RfDatosConcEstadoCuenta
    Descripcion    : Procedimiento para extraer los campos relacionados
                     con los datos de los conceptos en el estado de cuenta.
    Autor          : Gabriel Gamarra - Horbath Technologies

    Parametros           Descripcion
    ============         ===================
  orfcursor            Retorna los datos de los conceptos.

    Fecha           Autor               Modificacion
    =========       =========           ====================
  06-09-2016      Sandra Muñoz        CA200-342. Agrupacion conceptos brilla
    07/04/2015      Agordillo           Modificacion Incidente.140493
                                        * Se agrega a la consulta la agrupacion (group by ID, CONCEPTO,DOC_SOPORTE,CAU_CARGO)
                                        por concepto, documento de soporte y causa de cargo, y se realiza ordenamiendo
                                        por el campo ORDEN
    12/03/2015      Agordillo           Modificacion Incidente.143745
                                        * Se cambia el llamado a la tabla LDC_CONC_FACTURA_TMP por LDC_CONC_FACTURA_TEMP
    11/11/2014      ggamarra            Creacion.
**********************************************************************************************************************************/
sbFactcodi  ge_boInstanceControl.stysbValue;
sbFactsusc  ge_boInstanceControl.stysbValue;
blNRegulado BOOLEAN;
-- Numero de detalles del bloque de cargos
nuRegistrosHoja       NUMBER := 30;
nuRegBlanks           NUMBER;
nuServicioBrilla      ld_parameter.numeric_value%TYPE := dald_parameter.fnuGetNumeric_Value('COD_PRODUCT_TYPE_BRILLA'); -- CA200-342. Producto brilla
nuAplicaEntrega200342 NUMBER;
BEGIN
 ut_trace.trace('INICIO LDC_DetalleFact_GasCaribe.RfDatosConcEstadoCuenta', 5);
 -- Obtiene el identificador de la factura instanciada
 sbFactcodi  := obtenervalorinstancia('FACTURA', 'FACTCODI');
 sbFactsusc  := obtenervalorinstancia('FACTURA', 'FACTSUSC');
 blNRegulado := fblNoRegulado(sbFactsusc);
 ut_trace.trace('sbFactcodi: '||sbFactcodi, 5);
 ut_trace.trace('sbFactsusc: '||sbFactsusc, 5);
 IF NOT blNRegulado THEN
  IF MOD(gnuConcNumber, nuRegistrosHoja) = 0 THEN
    nuRegBlanks := 0;
  ELSE
    nuRegBlanks := nuRegistrosHoja - MOD(gnuConcNumber, nuRegistrosHoja);
  END IF;
  ut_trace.trace('gnuConcNumber: '||gnuConcNumber, 5);
  ut_trace.trace('nuRegBlanks: '||nuRegBlanks, 5);
  nuAplicaEntrega200342 := 1;
  ut_trace.trace('nuAplicaEntrega200342: '||nuAplicaEntrega200342, 5);
 OPEN orfcursor FOR
  SELECT etiqueta
        ,desc_concep
        ,saldo_ant
        ,capital
        ,interes
        ,total
        ,saldo_dif
        ,cuotas
    FROM (
          SELECT id etiqueta
                ,concepto desc_concep
                ,to_char(SUM(vencido), 'FM999,999,999,990') saldo_ant
                ,to_char(SUM(valor_mes), 'FM999,999,999,990') capital
                ,to_char(SUM(amortizacion), 'FM999,999,999,990') interes
                ,to_char(SUM(presente_mes), 'FM999,999,999,990') total
                ,to_char(SUM(saldo_diferido), 'FM999,999,999,990') saldo_dif
                ,MAX(cuotas_pendientes) cuotas
                ,MAX(orden_concepto) orden
                ,1 bloque
            FROM ldc_conc_factura_temp lcft
            WHERE lcft.servicio <> nuServicioBrilla OR nuAplicaEntrega200342 = 1
           GROUP BY id, concepto, doc_soporte, cau_cargo
           UNION ALL
            SELECT id etiqueta
                  ,concepto desc_concep
                  ,to_char(SUM(vencido), 'FM999,999,999,990') saldo_ant
                  ,to_char(SUM(valor_mes), 'FM999,999,999,990') capital
                  ,to_char(SUM(amortizacion), 'FM999,999,999,990') interes
                  ,to_char(SUM(presente_mes), 'FM999,999,999,990') total
                  ,to_char(SUM(saldo_diferido), 'FM999,999,999,990') saldo_dif
                  ,cuotas_pendientes cuotas
                  ,MAX(orden_concepto) orden
                  ,2 bloque
              FROM ldc_conc_factura_temp lcft
             WHERE lcft.servicio = nuServicioBrilla
               AND nuAplicaEntrega200342 = 0
             GROUP BY id, concepto, cuotas_pendientes
             ORDER BY 10,9
            )
        UNION ALL
        SELECT 34 etiqueta
             ,NULL desc_concep
             ,NULL saldo_ant
             ,NULL capital
             ,NULL interes
             ,NULL total
             ,NULL saldo_dif
             ,NULL cuotas
          FROM servsusc
         WHERE rownum <= nuRegBlanks;
 ELSE
  ut_trace.trace('blNRegulado', 5);
  OPEN orfcursor FOR
    SELECT etiqueta
         ,desc_concep
         ,saldo_ant
         ,capital
         ,interes
         ,total
         ,saldo_dif
         ,cuotas
     FROM (
           SELECT id etiqueta
                 ,concepto desc_concep
                 ,NULL saldo_ant
                 ,to_char(SUM(valor_mes), 'FM999,999,999,990') capital
                 ,to_char(SUM(amortizacion), 'FM999,999,999,990') interes
                 ,to_char(SUM(presente_mes), 'FM999,999,999,990') total
                 ,to_char(SUM(saldo_diferido), 'FM999,999,999,990') saldo_dif
                 ,MAX(producto) cuotas
                 ,MAX(orden_concepto) orden
             FROM ldc_conc_factura_temp
            WHERE conc_signo NOT IN ('PA', 'SA')
            GROUP BY id, concepto, doc_soporte, cau_cargo
            ORDER BY orden
           );
 END IF;
 ut_trace.trace('FIN LDC_DetalleFact_GasCaribe.RfDatosConcEstadoCuenta', 5);
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  ut_trace.trace('ERROR CONTROLLED_ERROR', 5);
  RAISE pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
  ut_trace.trace('ERROR OTHERS', 5);
  Pkg_Error.setError;
  RAISE pkg_error.CONTROLLED_ERROR;
END rfdatosconcestadocuenta;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fsbGetPeriodo(inunuse IN NUMBER, inuDiferido IN NUMBER) RETURN VARCHAR2 IS
/**************************************************************************************************************************************************
 Propiedad intelectual de GDC (c).

 UNID         : fsbGetPeriodo
 Descripcion    : proceso que devuelve el perorio del diferido
 Autor          : Luis Javier Lopez - Horbath Technologies

 Parametros           Descripcion
 ============         ===================
 inunuse            producto
 inuDiferido        diferido
 Fecha           Autor               Modificacion
 =========       =========           ====================
 28/05/2020      Luis Lopez          CA 379 :  se adiciona logica para mostrar descripcion del periodo a los diferidos de res 059
**************************************************************************************************************************************************/
sbPeriodo VARCHAR2(4000);
 CURSOR cuGetPeriodo IS
  SELECT ' ('||trim(to_char(fecha, 'Month'))||'-'||to_char(fecha, 'YYYY')||')' periodo
    FROM(
         SELECT add_months(to_date('01/'||pefames||'/'||pefaano,'dd/mm/yyyy'), -1) fecha
           FROM cargos c, perifact p
          WHERE cargnuse  = inunuse
            AND cargpefa = pefacodi
            AND cargdoso = 'FD-'||to_char(inuDiferido));
BEGIN
  ut_trace.trace('Inicia LDC_DetalleFact_GasCaribe.fsbGetPeriodo'  );
  OPEN cuGetPeriodo;
 FETCH cuGetPeriodo INTO sbPeriodo;
 CLOSE cuGetPeriodo;
 ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fsbGetPeriodo'  );
 RETURN sbPeriodo;
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
   RAISE pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
  Pkg_Error.setError;
  RAISE pkg_error.CONTROLLED_ERROR;
END fsbGetPeriodo;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE RfConcepParcial(orfcursor OUT constants.tyRefCursor) IS
/***********************************************************************************************************************************************
  Propiedad intelectual de PETI (c).

  UNID         : RfConcepParcial
  Descripcion    : Procedimiento para mostrar el iva y el subtotal de los no regulados.
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================

  orfcursor            Retorna los datos

  Fecha           Autor               Modificacion
  =========       =========           ====================
  19/07/2022       JJJM              OSF-407 Se desacopla el procedimiento, pasando la
                                     logica al procedimiento : ldc_pkgprocefactspoolfac.RfConcepParcial
                                     y haciendo el llamado desde este.
***********************************************************************************************************************************************/
sbFactcodi  ge_boInstanceControl.stysbValue;
sbFactsusc  ge_boInstanceControl.stysbValue;
blNRegulado BOOLEAN;
BEGIN
 ut_trace.trace('Inicio ldc_detallefact_gascaribe.RfConcepParcial', 15);
 -- Obtiene el identificador de la factura instanciada
 sbFactcodi  := obtenervalorinstancia('FACTURA', 'FACTCODI');
 ut_trace.trace('Parametro sbFactcodi : '||sbFactcodi, 15);
 sbFactsusc  := obtenervalorinstancia('FACTURA', 'FACTSUSC');
 ut_trace.trace('Parametro sbFactsusc : '||sbFactsusc, 15);
 blNRegulado := fblNoRegulado(sbFactsusc);
 ut_trace.trace('Ejecutamos el procedimiento : ldc_pkgprocefactspoolfac.rfconcepparcial', 15);
 ldc_pkgprocefactspoolfac.rfconcepparcial(
                                          sbFactcodi
                                         ,sbFactsusc
                                         ,blNRegulado
                                         ,orfcursor
                                         );
 ut_trace.trace('Fin ldc_detallefact_gascaribe.RfConcepParcial', 15);
END RfConcepParcial;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE RfRangosConsumo(orfcursor OUT constants.tyRefCursor) IS
  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   RfRangosConsumo
  Descripcion :   Obtiene los rangos tarifarios liquidados en consumos
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  21/07/2022            JJJM            OSF-407 Se desacopla el procedimiento, pasando la
                                                logica al procedimiento : ldc_pkgprocefactspoolfac.RfRangosConsumo
                                                y haciendo el llamado desde este.

****************************************************************************/
 sbFactcodi     ge_boInstanceControl.stysbValue;
 sbFactsusc     ge_boInstanceControl.stysbValue;
 blNRegulado    BOOLEAN;
 sbAplicaNET ge_boInstanceControl.stysbValue;
BEGIN
 ut_trace.trace('Inicio ldc_detallefact_gascaribe.RfRangosConsumo', 15);
 -- Obtiene el identificador de la factura instanciada
 sbFactcodi := obtenervalorinstancia('FACTURA', 'FACTCODI');
 ut_trace.trace('Parametro sbFactcodi : '||sbFactcodi, 15);
 sbFactsusc := obtenervalorinstancia('FACTURA', 'FACTSUSC');
 ut_trace.trace('Parametro sbFactsusc : '||sbFactsusc, 15);
 sbAplicaNET := obtenervalorinstancia('FACTURA', 'APLICA');
 ut_trace.trace('Parametro sbAplicaNET : '||sbAplicaNET, 15);
 IF sbAplicaNET IS NULL THEN
    sbAplicaNET := '0';
 END IF;
 blNRegulado := fblNoRegulado(sbFactsusc);
 ut_trace.trace('Ejecutamos ldc_pkgprocefactspoolfac.rfrangosconsumo', 15);
 ldc_pkgprocefactspoolfac.rfrangosconsumo(
                                          sbFactcodi
                                         ,sbFactsusc
                                         ,blNRegulado
                                         ,sbAplicaNET
                                         ,orfcursor
                                        );
 ut_trace.trace('Fin ldc_detallefact_gascaribe.RfRangosConsumo', 15);
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  RAISE pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
  Pkg_Error.setError;
  RAISE pkg_error.CONTROLLED_ERROR;
END RfRangosConsumo;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fnuConceptoComponent(isbComponente IN VARCHAR2) RETURN NUMBER IS
/*********************************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :  fnuConceptoComponent
  Descripcion : Obtiene el concepto del componente de costo dado su nombre Ej: GM,TM etc
  Parametros  : Recibe como parametro de entrada la abreviacion del componente.
  Autor       : Alexandra Gordillo

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  18-03-2015          agordillo            Creacion. Incidente.140493

*********************************************************************************************/
nuConcepto      NUMBER;
nuEqComponentes NUMBER := 15000;
BEGIN
  ut_trace.trace('Inicia LDC_DetalleFact_GasCaribe.fnuConceptoComponent'  );
  -- Consulta los componentes de costo
 SELECT to_number(target_value) INTO nuConcepto
   FROM ge_equivalenc_values
  WHERE equivalence_set_id = nuEqComponentes
    AND upper(origin_value) LIKE '%' || upper(isbComponente) || '%';
 ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fnuConceptoComponent'  );
 RETURN nuConcepto;
EXCEPTION
 WHEN no_data_found THEN
  nuConcepto := 0;
  RETURN nuConcepto;
 WHEN OTHERS THEN
  nuConcepto := 0;
  RETURN nuConcepto;
END fnuConceptoComponent;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE rfGetValCostCompValid(orfcursor OUT constants.tyRefCursor) AS
/**********************************************************************************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :  rfGetValCostCompValid
  Descripcion : Obtiene el valor de los componentes del costo
  Autor       : Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  19/07/2022           JJJM              OSF-407 Se desacopla el procedimiento, pasando la
                                                 logica al procedimiento : ldc_pkgprocefactspoolfac.rfGetValCostCompValid
                                                 y haciendo el llamado desde este.
**********************************************************************************************************************************************/
sbFactcodi   ge_boInstanceControl.stysbValue;
sbFactsusc   ge_boInstanceControl.stysbValue;
nuProducto   servsusc.sesunuse%TYPE;
blNoRegulada BOOLEAN;
BEGIN
 ut_trace.trace('Inicio ldc_detallefact_gascaribe.rfGetValCostCompValid', 15);
 --Obtiene el identificador de la factura de la instancia
 sbFactcodi   := obtenervalorinstancia('FACTURA', 'FACTCODI');
 ut_trace.trace('Parametro sbFactcodi : '||sbFactcodi, 15);
 sbFactsusc   := obtenervalorinstancia('FACTURA', 'FACTSUSC');
 ut_trace.trace('Parametro sbFactsusc : '||sbFactsusc, 15);
 nuProducto   := fnuGetProducto(sbFactcodi);
 ut_trace.trace('Parametro nuProducto : '||nuProducto, 15);
 blNoRegulada := fblNoRegulado(sbFactsusc);
 ut_trace.trace('Ejecutamos : ldc_pkgprocefactspoolfac.rfgetvalcostcompvalid', 15);
 ldc_pkgprocefactspoolfac.rfgetvalcostcompvalid(
                                                  nuProducto
                                                 ,blNoRegulada
                                                 ,orfcursor
                                                 );
 ut_trace.trace('Fin ldc_detallefact_gascaribe.rfGetValCostCompValid', 15);
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  RAISE pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
  Pkg_Error.setError;
  RAISE pkg_error.CONTROLLED_ERROR;
END rfGetValCostCompValid;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE rfGetValRates(orfcursor OUT constants.tyRefCursor) AS
/*************************************************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :  rfGetValRates
  Descripcion : Obtiene el valor de las tasas
  Autor       : Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  22/07/2022           JJJM              OSF-407 Se desacopla el procedimiento, pasando la
                                     logica al procedimiento : ldc_pkgprocefactspoolcart.rfGetValRates
                                     y haciendo el llamado desde este.
*************************************************************************************************************/
sbFactcodi   ge_boInstanceControl.stysbValue;
sbFactsusc   ge_boInstanceControl.stysbValue;
blNoRegulada BOOLEAN;
BEGIN
 ut_trace.trace('Inicio ldc_detallefact_gascaribe.rfGetValRates', 15);
 --Obtiene el identificador de la factura de la instancia
 sbFactcodi   := obtenervalorinstancia('FACTURA', 'FACTCODI');
 ut_trace.trace('Parametro sbFactcodi : '||sbFactcodi, 15);
 sbFactsusc   := obtenervalorinstancia('FACTURA', 'FACTSUSC');
 ut_trace.trace('Parametro sbFactsusc : '||sbFactsusc, 15);
 blNoRegulada := fblNoRegulado(sbFactsusc);
 -- Obtenemos resultado
 ut_trace.trace('Se ejecuta el procedimiento : ldc_pkgprocefactspoolcart.rfgetvalrates', 15);
 ldc_pkgprocefactspoolcart.rfgetvalrates
                                        (
                                         blNoRegulada
                                        ,orfcursor
                                        );
 ut_trace.trace('Fin ldc_detallefact_gascaribe.rfGetValRates', 15);
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  RAISE pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
  Pkg_Error.setError;
  RAISE pkg_error.CONTROLLED_ERROR;
END rfGetValRates;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE RfDatosCodBarras(orfcursor OUT constants.tyRefCursor) AS
/******************************************************************************************************************
  Propiedad intelectual de PETI (c).

  UNID         : RfDatosCodBarras
  Descripcion    : procedimiento para extraer los datos relacionados
                   al codigo de barras
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  19/07/2022       JJJM              OSF-407 Se desacopla el procedimiento, pasando la
                                     logica al procedimiento : ldc_pkgprocefactspoolfac.RfDatosCodBarras
                                     y haciendo el llamado desde este.

******************************************************************************************************************/
sbFactcodi  ge_boInstanceControl.stysbValue;
BEGIN
 ut_trace.trace('Inicio ldc_detallefact_gascaribe.RfDatosCodBarras', 15);
 sbFactcodi  := obtenervalorinstancia('FACTURA', 'FACTCODI');
 ut_trace.trace('Parametro sbFactcodi : '||sbFactcodi, 15);
 ut_trace.trace('Ejecutamos : ldc_pkgprocefactspoolfac.RfDatosCodBarras ', 15);
 ldc_pkgprocefactspoolfac.RfDatosCodBarras(
                                            sbFactcodi
                                           ,orfcursor
                                           );
 ut_trace.trace('Fin ldc_detallefact_gascaribe.RfDatosCodBarras', 15);
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
   RAISE pkg_error.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    Pkg_Error.setError;
    RAISE pkg_error.CONTROLLED_ERROR;
END RfDatosCodBarras;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE RfDatosBarCode(orfcursor OUT constants.tyRefCursor) AS
/************************************************************************
  Propiedad intelectual de PETI (c).

  UNID         : RfDatosBarCode
  Descripcion    : procedimiento para extraer los datos relacionados
                   al codigo de barras para el estado de cuenta
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  11/11/2014      ggamarra             Creación.
****************************************************************************/
sbFactcodi  ge_boInstanceControl.stysbValue;
BEGIN
 ut_trace.trace('Inicia LDC_DetalleFact_GasCaribe.RfDatosBarCode'  );
 sbFactcodi  := obtenervalorinstancia('FACTURA', 'FACTCODI');
 OPEN orfcursor FOR
  SELECT code, NULL image
    FROM (
          SELECT '415' ||
                 dald_parameter.fsbGetValue_Chain('COD_EAN_CODIGO_BARRAS') ||
                 '8020' || lpad(cuponume, 10, '0') || chr(200) || '3900' ||
                 lpad(cupovalo, 10, '0') || chr(200) || '96' ||
                 to_char(cucofeve, 'yyyymmdd') code
            FROM factura, cuencobr, cupon
           WHERE factcodi = sbFactcodi
             AND cupodocu = factcodi
             AND cuponume = pkbobillprintheaderrules.fsbgetcoupon()
             AND factcodi = cucofact
         )
   WHERE rownum = 1;
   ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.RfDatosBarCode'  );
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  RAISE pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
  Pkg_Error.setError;
  RAISE pkg_error.CONTROLLED_ERROR;
END RfDatosBarCode;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE insld_cupon_causal(
                             inuPackageTypeId IN NUMBER
                            ,inuCuponId       IN NUMBER
                            ,inuCausalId      IN NUMBER
                            ,inuPackagesId    IN NUMBER
                            ) IS
/***********************************************************************************************
  Propiedad intelectual de PETI (c).

  UNID         : InsLD_CUPON_CAUSAL
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
*****************************************************************************************************************************/
BEGIN
 ut_trace.trace('INICIO LDC_DetalleFact_GasCaribe.insld_cupon_causal', 2);
 ut_trace.trace('inuPackageTypeId:' || inuPackageTypeId, 2);
 ut_trace.trace(' - inuCausalId:' || inuCausalId, 2);
 ldc_duplicado_meses_ant.gTipoSolicitud := inuPackageTypeId;
 glPackage_type_Cupon_id := inuPackageTypeId;
 glCausal_Cupon_id       := inuCausalId;
 glPackage_Cupon_id      := inuPackagesId;
 ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.insld_cupon_causal', 2);
EXCEPTION
 WHEN OTHERS THEN
  Pkg_Error.setError;
END insld_cupon_causal;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fsbCuadrillaReparto(
                             inuOrden or_order.order_id%TYPE -- Orden
                            ) RETURN VARCHAR2 IS
/***********************************************************************************************
 Propiedad intelectual de Gases del Caribe.

 Nombre del Paquete: fsbCuadrillaReparto
 Descripcion:        Imita la rutina de ldc_boasigauto.prasignacion con el fin de determinar el
                        codigo de la UNID operativa a la que se asignara la orden de reparto

 Autor    : Sandra Muñoz
 Fecha    : 04-08-2016 cA200-342

 Historia de Modificaciones

 DD-MM-YYYY    <Autor>.              Modificacion
 -----------  -------------------    -------------------------------------
    13-09-2016   Sandra Muñoz           Se corrige el cursor que obtiene la categoria del producto
                                        ya que no estaba retornando uno de los productos
                                        que estaban permitidos para asignacion automatica y
                                        esto hacia que no se mostrara cuadrilla en el spool
    13-09-2016   Sandra Muñoz           Se retorna el codigo alterno o el nombre de la cuadrilla
    07-06-2016   Sandra Muñoz           Se corrigen los cierres de cursor para evitar excepciones
                                        y se eliminan los return null para evitar que no siga
                                        evaluando los registros arrojados por el cursor principal
    04-08-2016   Sandra Muñoz           Creacion
**********************************************************************************************************/
nuTipoTrabajo        or_order.task_type_id%TYPE;
nuPackType           ps_package_type.package_type_id%TYPE;
exError              EXCEPTION;
-- Cursor para validar las UNIDes opertaivas configuradas para la actividad de la orden
-- generada por la solicitud configurada en la forma de uobysol
CURSOR cuUoBySol(
                 nuOrder_id   or_order_activity.order_id%TYPE
                ,nuPackage_id or_order_activity.package_id%TYPE
                ) IS
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

 tempCuCategoria cucategoria%ROWTYPE;

 -- Cursor para validar la zona de la UNID opertaiva que sera asignada desde uobysol y que esta
 -- zona maneje el secotr operativo qeu sera asignado a la orden.
CURSOR cuGe_sectorOpe_Zona(inuOperating_sector_id or_order.operating_sector_id%TYPE,
                           inuOperating_zone_id   or_operating_unit.operating_zone_id%TYPE) IS
 SELECT gsz.*
   FROM ge_sectorope_zona gsz
  WHERE gsz.id_sector_operativo = inuOperating_sector_id
    AND gsz.id_zona_operativa = inuOperating_zone_id;

 tempCuGe_sectorope_zona cuGe_sectorope_zona%ROWTYPE;

-- Cursor para identificar el tipo de producto y si es generico
CURSOR cuTipoProducto(nuProduct_id or_order_activity.product_id%TYPE) IS
 SELECT NVL(p.product_type_id, 0) tipo_producto
   FROM pr_product p
  WHERE p.product_id = nuProduct_id
    AND p.product_type_id = dald_parameter.fnuGetNumeric_Value('COD_PRO_GEN', NULL);

rtCuTipoProducto cuTipoProducto%ROWTYPE;

-- Cursor para obtener la categroia de la direccion de la orden si el producto es generico
CURSOR cuSegmentoCategoria(nuaddress_id or_order_activity.address_id%TYPE) IS
 SELECT nvl(s.category_, 0) categoria, s.subcategory_ subcategoria
   FROM ab_address aa, ab_segments s
  WHERE aa.address_id = nuaddress_id
    AND aa.segment_id = s.segments_id;

rtCuSegmentoCategoria cuSegmentoCategoria%ROWTYPE;

-- Cursor identificar las UNIDes operativas desactivadas en ldc_caruniope
CURSOR cuLdc_CarUniOpe(INUOPERATING_SECTOR_ID OR_ORDER.OPERATING_SECTOR_ID%TYPE) IS
 SELECT *
   FROM ldc_caruniope
  WHERE operating_unit_id = inuoperating_sector_id
    AND activo = 'N';

-- Con este cursor se valida que exista una configuración para el tipo de solicitud en la forma
-- CAMU
CURSOR cuConfMulti(inuPackageType ps_package_type.package_type_id%TYPE) IS
 SELECT tipo_trabajo
   FROM ldc_conf_asign_multi_01
  WHERE solicitud = inuPackageType
    AND asign_multi = 'S';

rtCuLdc_CarUniOpe cuLdc_CarUniOpe%ROWTYPE;

--MANEJO DE VARIABLES
sbDatain              VARCHAR2(4000);
sbUNIDOperativa     VARCHAR2(4000);
nuOperating_sector_id or_order.operating_sector_id%TYPE;
nuOperating_zone_id   or_operating_unit.operating_zone_id%TYPE;
nuControlCicloUobysol NUMBER;
sbCuadrilla           or_operating_unit.name%TYPE; -- Codigo alterno o nombre de la cuadrilla
BEGIN
 ut_trace.trace('INICIO LDC_DetalleFact_GasCaribe.fsbCuadrillaReparto', 2);
 FOR tempcuuobysol IN cuuobysol(inuorden, NULL) LOOP
  nucontrolciclouobysol := 1;
   OPEN culdc_caruniope(tempcuuobysol.operating_unit_id);
  FETCH culdc_caruniope INTO rtculdc_caruniope;
  IF culdc_caruniope%NOTFOUND THEN
   OPEN cucategoria(tempcuuobysol.product_id,
                         tempcuuobysol.address_id);
  FETCH cucategoria INTO tempcucategoria;
  CLOSE cucategoria;
  sbUNIDoperativa := NULL;
  --LLOZADA: Se obtiene el tipo de solicitud
  nuPackType := damo_packages.fnugetpackage_type_id(NULL, NULL);
  IF nuPackType IS NOT NULL THEN
    --LLOZADA: Se abre el cursor para obtener el tipo de trabajo configurado
    OPEN cuConfMulti(nuPackType);
   FETCH cuConfMulti INTO nuTipoTrabajo;
   CLOSE cuConfMulti;
   --LLOZADA: Si trae datos es porque existe una configuración
   --para multifamiliares
   IF nuTipoTrabajo IS NOT NULL THEN
      sbdatain := sbdatain || '|' || nutipotrabajo;
   END IF;
  END IF;
  /*02/07/2014 LLOZADA: Se debe dejar NUll la variable SBUNIDOPERATIVA para que
        para que realice la configuración básica de UOBYSOL*/
  IF sbUNIDoperativa = '-1' THEN
     sbUNIDoperativa := NULL;
  END IF;

  IF sbUNIDoperativa IS NULL THEN
   --CONSULTA PARA OBTENER EL SECTOR OPERATIVO DE LA ORDEN
   BEGIN
    SELECT operating_sector_id INTO nuoperating_sector_id
      FROM or_order oo
     WHERE oo.order_id = inuorden;
   END;
   --CONSULTA PARA OBTENER LA ZONA DE LA ORDEN
   BEGIN
    SELECT operating_zone_id INTO nuoperating_zone_id
      FROM or_operating_unit oou
     WHERE oou.operating_unit_id = tempcuuobysol.operating_unit_id;
   END;
    --CURSOR PARA VALIDAR SI EL SECTOR OPERATIVO ESTA
    --CONFIGURADO DENTRO DE LA ZONA;
     OPEN cuge_sectorope_zona(nuoperating_sector_id,nuoperating_zone_id);
    FETCH cuge_sectorope_zona INTO tempcuge_sectorope_zona;
    IF cuge_sectorope_zona%FOUND THEN
      OPEN cutipoproducto(tempcuuobysol.product_id);
     FETCH cutipoproducto INTO rtcutipoproducto;
      IF cutipoproducto%FOUND THEN
         OPEN cusegmentocategoria(tempcuuobysol.address_id);
        FETCH cusegmentocategoria INTO rtcusegmentocategoria;
              ut_trace.trace('LA CATEGIRIA DEL PRODUCTO GENERICO ES [' ||
                             rtcusegmentocategoria.categoria || ']',
                             10);
        CLOSE cusegmentocategoria;
      END IF;
     CLOSE cutipoproducto;
      OPEN cucategoria(tempcuuobysol.product_id,tempcuuobysol.address_id);
     FETCH cucategoria INTO tempcucategoria;
      IF cucategoria%FOUND OR tempcuuobysol.catecodi = -1 OR
       rtcusegmentocategoria.categoria = tempcuuobysol.catecodi THEN
       IF tempcucategoria.category_id = tempcuuobysol.catecodi OR
          tempcuuobysol.catecodi = -1 OR
          rtcusegmentocategoria.categoria = tempcuuobysol.catecodi THEN
           -- Se obtiene el codigo alterno o la descripcion de la UNID operativa
        BEGIN
         SELECT nvl(nvl(oou.oper_unit_code, oou.name),to_char(oou.operating_unit_id))
           INTO sbCuadrilla
           FROM or_operating_unit oou
          WHERE oou.operating_unit_id = tempcuuobysol.operating_unit_id;
        EXCEPTION
         WHEN OTHERS THEN
          sbCuadrilla := to_char(tempcuuobysol.operating_unit_id);
        END;
     RETURN sbCuadrilla;
     END IF;
    END IF; --FIN VALIDACION DE CATEGORIA
    CLOSE cucategoria;
   END IF;
   CLOSE cuge_sectorope_zona;
   END IF; --FIN VALIDACION SECTOR OPERATIVO
  END IF; --VALIDACION SBUNIDOPERATIVA IS NULL
  CLOSE culdc_caruniope;
 END LOOP;
 ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fsbCuadrillaReparto', 2);
 RETURN NULL;
EXCEPTION
 WHEN OTHERS THEN
  RETURN NULL;
END fsbCuadrillaReparto;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fsbCuadrillaReparto RETURN VARCHAR2 IS
/***************************************************************************************************
 Propiedad intelectual de Gases del Caribe.

 Nombre del Paquete: proCuadrillaReparto
 Descripcion:        Cuadrilla a la que se le asignara el reparto de la factura

 Autor    : Sandra Muñoz
 Fecha    : 14-10-2016

 Historia de Modificaciones

 DD-MM-YYYY    <Autor>.              Modificacion
 -----------  -------------------    -------------------------------------
    11-11-2016   Sandra Muñoz           CA200-849. Se trasnforma este procedimiento en funcion
                                        para que retorne la cuadrilla, sin devolver cursor
                                        referenciado
    14-10-2016   Sandra Muñoz           Creacion
***************************************************************************************************/
sbFactsusc           ge_boInstanceControl.stysbValue; -- Contrato
sbCuadrilla          or_operating_unit.name%TYPE; -- Cuadrilla que reparte la factura
nuOrdenReparto       or_order.order_id%TYPE; -- Orden de reparto
nuExiste             NUMBER; -- Indica si un elemento existe en la bd
nuTipoTrabajoReparto ld_parameter.numeric_value%TYPE; -- Tipo de trabajo
exError              EXCEPTION;
BEGIN
 ut_trace.trace('INICIO LDC_DetalleFact_GasCaribe.fsbCuadrillaReparto', 2);
 sbFactsusc := obtenervalorinstancia('FACTURA', 'FACTSUSC');
 BEGIN
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
   SELECT COUNT(1) INTO nuExiste
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
   SELECT MAX(ooa.order_id) INTO nuOrdenReparto
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
   ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fsbCuadrillaReparto', 2);
 RETURN sbCuadrilla;
EXCEPTION
 WHEN OTHERS THEN
  RETURN NULL;
END fsbCuadrillaReparto;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION fnuObservNoLectConsec(
                               inuPeriodoConsumo pericose.pecscons%TYPE, -- Periodo consumo
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

Autor    : Sandra Muñoz
Fecha    : 18-09-2016 cA200-849

Historia de Modificaciones

DD-MM-YYYY    <Autor>.              Modificacion
-----------  -------------------    -------------------------------------
18-10-2016   Sandra Muñoz           Creacion
***********************************************************************************************/
sbError                 ge_error_log.description%TYPE; -- Error
sbObservAEvaluar        ld_parameter.value_chain%TYPE; -- Observaciones a evaluar
nuCantPeriodos          ld_parameter.numeric_value%TYPE; -- Cantidad de periodos evaluar
sbTieneLectConsecutivas CHAR(1); -- Indica si existen observaciones consecutivas
nuPeriodo               NUMBER; -- Periodo evaluado
nuObservacionAnterior   lectelme.leemoble%TYPE; -- Observacion de no lectura evaluada anteriormente
onuError                NUMBER;

CURSOR cuLecturas IS
 SELECT l.leemoble
   FROM lectelme l
  WHERE l.leemsesu = inuProducto -- Producto
    AND l.leemclec = 'F' -- Solo lecturas de facturacion
    AND l.leemfele IN (SELECT MAX(l1.leemfele)
                              FROM lectelme l1
                             WHERE l1.leemsesu = l.leemsesu -- Producto
                               AND l1.leemclec = 'F' -- Solo lecturas de facturacion
                               AND l1.leempecs = l.leempecs) -- Maxima fecha de lectura encontrada para el periodo de consumo
    AND l.leempecs <= inuPeriodoConsumo -- Anterior al periodo evaluado
  ORDER BY l.leempecs DESC, l.leempefa DESC, l.leemfele DESC;
BEGIN
 ut_trace.trace('Inicio ldc_detallefact_gascaribe.fnuObservNoLectConsec',1);
 ut_trace.trace('Entrega ' || csbBSS_FAC_SMS_200849 || ' aplicada', 10);
 -- Obtener el valor del parametro SPOOL_OBSERV_CONSECUTIVAS el cual almacena las observaciones
 -- de no lectura a evaluar
 BEGIN
  sbObservAEvaluar := dald_parameter.fsbGetValue_Chain(inuparameter_id => 'SPOOL_OBSERV_CONSECUTIVAS');
 EXCEPTION
  WHEN OTHERS THEN
   sbError := 'No fue posible consultar el parametro SPOOL_OBSERV_CONSECUTIVAS. ' ;
   RAISE pkg_error.CONTROLLED_ERROR;
 END;
 IF sbObservAEvaluar IS NULL THEN
   sbError := 'No se ha definido un valor para el parametro ' ||sbObservAEvaluar;
   RAISE pkg_error.CONTROLLED_ERROR;
 END IF;
 ut_trace.trace('sbObservAEvaluar ' || sbObservAEvaluar, 10);
 -- Obtener el valor del parametro SPOOL_NRO_OBSERV_CONSECUTIVAS el cual almacena el numero
 -- de periodos a evaluar
 BEGIN
  nuCantPeriodos := dald_parameter.fnuGetNumeric_Value(inuparameter_id => 'SPOOL_NRO_OBSERV_CONSECUTIVAS');
 EXCEPTION
  WHEN OTHERS THEN
   sbError := 'No fue posible consultar el parametro SPOOL_NRO_OBSERV_CONSECUTIVAS. ';
   RAISE pkg_error.CONTROLLED_ERROR;
 END;
 IF nuCantPeriodos IS NULL THEN
   sbError := 'No se ha definido un valor para el parametro ' ||nuCantPeriodos;
   RAISE pkg_error.CONTROLLED_ERROR;
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
 WHEN pkg_error.CONTROLLED_ERROR THEN
   ut_trace.trace(sbError, 10);
   RETURN NULL;
 WHEN OTHERS THEN
  Pkg_Error.setError;
  pkg_error.geterror(onuError, sberror);
  ut_trace.trace('Error no controlado en ldc_detallefact_gascaribee.fsbTieneOservLecturaConsec' || '. ' ||sberror,10);
  RETURN NULL;
END fnuObservNoLectConsec;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fnuObservNoLectConsec RETURN NUMBER IS
/***************************** ******************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: proObservNoLectConsec
    Descripcion:        Observacion de no lectura consecutiva

    Autor    : Sandra Muñoz
    Fecha    : 10-11-2016

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    10-11-2016   Sandra Muñoz           CA200-849. Creacion
***************************** ******************************************************************/
sbFactcodi               ge_boInstanceControl.stysbValue;
sbFactsusc               ge_boInstanceControl.stysbValue;
nuObservacionConsecutiva lectelme.leemoble%TYPE; -- Observacion no lectura
nuProductoPrincipal      servsusc.sesunuse%TYPE; -- Producto personal
exError                  EXCEPTION;
BEGIN
 sbFactcodi          := obtenervalorinstancia('FACTURA', 'FACTCODI');
 sbFactsusc          := obtenervalorinstancia('FACTURA', 'FACTSUSC');
 nuProductoPrincipal := fnuProductoPrincipal(inuContrato => sbFactsusc);
 BEGIN
  ut_trace.trace('INICIO LDC_DetalleFact_GasCaribe.fnuObservNoLectConsec', 2);
  SELECT ldc_detallefact_gascaribe.fnuObservNoLectConsec(inuperiodoconsumo => pc.pecscons,
                                                         inuproducto       => s.sesunuse)
    INTO nuObservacionConsecutiva
    FROM factura  fc
        ,suscripc b
        ,servsusc s
        ,perifact pf
        ,pericose pc
   WHERE fc.factcodi = sbFactcodi
     AND fc.factsusc = b.susccodi
     AND b.susccodi  = s.sesususc
     AND pf.pefacodi = fc.factpefa
     AND pc.pecscons = ldc_boformatofactura.fnuobtperconsumo(pf.pefacicl,
                                                                  pf.pefacodi)
     AND pf.pefacodi = fc.factpefa
     AND sesunuse = nvl(nuProductoPrincipal, sesunuse)
     AND rownum = 1;
   EXCEPTION
    WHEN OTHERS THEN
     NULL;
   END;
   ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fnuObservNoLectConsec', 2);
RETURN nuObservacionConsecutiva;
EXCEPTION
 WHEN OTHERS THEN
  RETURN NULL;
END fnuObservNoLectConsec;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE proDatosSpool(orfcursor OUT constants.tyRefCursor) IS
/***************************************************************************************
 Propiedad intelectual de Gases del Caribe.

 Nombre del Paquete: proDatosSpool
 Descripcion:        Se obtienen todos los datos que solo seran mostrados en el spool

 Autor    : Sandra Muñoz
 Fecha    : 10-11-2016

 Historia de Modificaciones

 DD-MM-YYYY    <Autor>.              Modificacion
 -----------  -------------------    -------------------------------------
 10-11-2016   Sandra Muñoz           CA200-849. Creacion
***************************************************************************************/
sbProceso VARCHAR2(4000) := 'proDatosSpool';
nuPaso    NUMBER; -- Ultimo paso ejecutado antes de ocurrir el error
sbError   VARCHAR2(4000);
exError EXCEPTION; -- Error controlado
onuError             NUMBER;

BEGIN
 ut_trace.trace('INICIO ' || gsbPaquete || '.' || sbProceso);
 OPEN orfcursor FOR
  SELECT nvl(ldc_detallefact_gascaribe.fsbCuadrillaReparto, ' ') cuadrilla_reparto
        ,nvl(to_char(ldc_detallefact_gascaribe.fnuObservNoLectConsec),' ') observ_no_lect_consec
    FROM dual;
  ut_trace.trace('FIN ' || gsbPaquete || '.' || sbProceso);
EXCEPTION
 WHEN exError THEN
  ut_trace.trace('TERMINO CON ERROR ' || gsbPaquete || '.' ||sbProceso || '(' || nuPaso || '):' || sbError);
   pkg_error.setErrorMessage(isbMsgErrr =>sbError);
 WHEN OTHERS THEN
  Pkg_Error.setError;
  pkg_error.geterror(onuError, sbError);
  sbError := 'TERMINO CON ERROR NO CONTROLADO  ' || gsbPaquete || '.' ||sbProceso || '(' || nuPaso || '): ' || sbError;
  ut_trace.trace(sbError,1);
  pkg_error.setErrorMessage(isbMsgErrr =>sbError);
END proDatosSpool;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE rfdatosconsumos(orfcursor OUT constants.tyrefcursor) AS
/******************************************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   RfDatosConsumos
  Descripcion :   Obtiene datos de los consumos
  Autor       :   Carlos Alberto Ramirez - Arquitecsoft

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  13-03-2017    KCienfuegos.CA1081   Se modifican los cursores cucm_vavafacoP y cucm_vavafacoPL
                                     para obtener el valor de la columna vvfcvalo en lugar de la
                                     columna vvfcvapr, de acuerdo a lo cotizado por NLCZ.
  11-01-2017          carlosr        Creacion
******************************************************************************************************/
sbfactsusc   ge_boinstancecontrol.stysbvalue;
sbfactpefa   ge_boinstancecontrol.stysbvalue;
sbfactcodi   ge_boinstancecontrol.stysbvalue;
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
par_pod_calor       NUMBER := dald_parameter.fnugetnumeric_value('FIDF_POD_CALORIFICO');
nucicloc            NUMBER;
nuproduct           NUMBER;
blnregulado         BOOLEAN;
nugeoloc            ge_geogra_location.geograp_location_id%TYPE;
vnucite             NUMBER;

--Declaracion de cursores
CURSOR cucm_vavafacoP(nuproduct1 IN servsusc.sesunuse%TYPE) IS
 SELECT to_char(decode(nuCategoria, cnuCategoriaInd, vvfcvalo, vvfcvapr)) presion
   FROM cm_vavafaco
   WHERE vvfcsesu = nuproduct1
     AND vvfcfefv >= trunc(SYSDATE)
     AND vvfcvafc = 'PRESION_OPERACION'
   ORDER BY vvfcfefv ASC;

CURSOR cucm_vavafacoPL(nugeoloc1 IN NUMBER) IS
  SELECT to_char(decode(nuCategoria, cnuCategoriaInd, vvfcvalo, vvfcvapr)) presion
    FROM cm_vavafaco
   WHERE vvfcfefv >= trunc(SYSDATE)
     AND vvfcvafc = 'PRESION_OPERACION'
     AND vvfcubge = nugeoloc1
   ORDER BY vvfcfefv ASC;

CURSOR cucm_vavafacoPt(nuproduct1 IN servsusc.sesunuse%TYPE) IS
  SELECT to_char(vvfcvapr)
    FROM cm_vavafaco
   WHERE vvfcsesu = nuproduct1
     AND vvfcfefv >= trunc(SYSDATE)
     AND vvfcvafc = 'TEMPERATURA'
   ORDER BY vvfcfefv ASC;

CURSOR cucm_vavafacotL(nugeoloc1 IN NUMBER) IS
  SELECT to_char(vvfcvapr)
    FROM cm_vavafaco
   WHERE vvfcfefv >= trunc(SYSDATE)
     AND vvfcvafc = 'TEMPERATURA'
     AND vvfcubge = nugeoloc1
   ORDER BY vvfcfefv ASC;

-- Obtiene los historicos de consumo
PROCEDURE gethistoricos(
                        nucontrato IN NUMBER
                       ,nuproducto IN NUMBER
                       ,nuciclo    IN NUMBER
                       ,nuperiodo  IN NUMBER
                       ) AS
TYPE tytbperiodos IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;

tbperconsumo tytbperiodos;
tbperfactura tytbperiodos;

tbperiodos tytbperiodos;
frperiodos constants.tyrefcursor;

nuperfactactual perifact.pefacodi%TYPE;
nuperfactprev   perifact.pefacodi%TYPE;
nuperconsprev   pericose.pecscons%TYPE;
sbperiodos      VARCHAR2(100) := '';
nuciclof        NUMBER;

CURSOR cuconsumo(nuproducto NUMBER, tbperi tytbperiodos) IS
 SELECT SUM(c_1) consumo_1
       ,SUM(c_2) consumo_2
       ,SUM(c_3) consumo_3
       ,SUM(c_4) consumo_4
       ,SUM(c_5) consumo_5
       ,SUM(c_6) consumo_6
   FROM (
         SELECT CASE
                   WHEN pecscons = tbperi(1) THEN
                    SUM(cosssuma)
                 END c_1
                ,CASE
                   WHEN pecscons = tbperi(2) THEN
                    SUM(cosssuma)
                 END c_2
                ,CASE
                   WHEN pecscons = tbperi(3) THEN
                    SUM(cosssuma)
                 END c_3
                ,CASE
                   WHEN pecscons = tbperi(4) THEN
                    SUM(cosssuma)
                 END c_4
                ,CASE
                   WHEN pecscons = tbperi(5) THEN
                    SUM(cosssuma)
                 END c_5
                ,CASE
                   WHEN pecscons = tbperi(6) THEN
                    SUM(cosssuma)
                 END c_6
            FROM vw_cmprodconsumptions -- pericose
           WHERE cosssesu = nuproducto
             AND pecscons IN (tbperi(1),
                              tbperi(2),
                              tbperi(3),
                              tbperi(4),
                              tbperi(5),
                              tbperi(6))
           GROUP BY pecscons);
BEGIN
 ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist.getHistoricos',15);
 nuciclof := nuciclo;
 -- Periodo de facturacion Actual
 nuperfactactual := nuperiodo; -- obtenervalorinstancia('FACTURA','FACTPEFA');
 -- Obtiene los periodos facturados
 frperiodos := frfcambiociclo(nucontrato);
 FETCH frperiodos BULK COLLECT INTO tbperiodos;
 ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos Inicio Obtiene los ultimos 6 periodos facturados',15);
 -- Obtiene los ultimos 6 periodos facturados
 FOR i IN 1 .. 6 LOOP
  -- Periodo de Facturacion Anterior
  BEGIN
   nuperfactprev := pkbillingperiodmgr.fnugetperiodprevious(nuperfactactual);
  EXCEPTION
   WHEN pkg_error.CONTROLLED_ERROR THEN
        nuperfactprev := -1;
   WHEN OTHERS THEN
       nuperfactprev := -1;
  END;
  -- Se valida si el periodo obtenido es igual al facturado si no es igual, es por
  -- que el cliente cambio de ciclo
  IF (tbperiodos.exists(i + 1)) AND (tbperiodos(i + 1) != nuperfactprev) THEN
      nuperfactprev := tbperiodos(i + 1);
      nuciclof      := pktblperifact.fnugetcycle(nuperfactprev);
  END IF;
  -- Periodo de consumo Anterior
  BEGIN
   nuperconsprev := ldc_boformatofactura.fnuobtperconsumo(nuciclof,nuperfactprev);
  EXCEPTION
   WHEN pkg_error.CONTROLLED_ERROR THEN
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
  -- El Anterior queda actual para hayar los anteriores
  nuperfactactual := nuperfactprev;
 END LOOP;
 ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos Fin  Obtiene los ultimos 6 periodos facturados',15);
 ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos Inicio recorre el cursor cuconsumo',15);
 FOR i IN cuconsumo(nuproducto, tbperconsumo) LOOP
  ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_1',15);
  consumo_mes_1 := nvl(i.consumo_1, 0);
  ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_2',15);
  consumo_mes_2 := nvl(i.consumo_2, 0);
  ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_3',15);
  consumo_mes_3 := nvl(i.consumo_3, 0);
  ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_4',15);
  consumo_mes_4 := nvl(i.consumo_4, 0);
  ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_5',15);
  consumo_mes_5 := nvl(i.consumo_5, 0);
  ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_6',15);
  consumo_mes_6 := nvl(i.consumo_6, 0);
 END LOOP;
 ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos Fin recorre el cursor cuconsumo',15);
 -- Hayando meses
 fecha_cons_mes_1 := fsbgetfechapermmyyyy(tbperfactura(1));
 fecha_cons_mes_2 := fsbgetfechapermmyyyy(tbperfactura(2));
 fecha_cons_mes_3 := fsbgetfechapermmyyyy(tbperfactura(3));
 fecha_cons_mes_4 := fsbgetfechapermmyyyy(tbperfactura(4));
 fecha_cons_mes_5 := fsbgetfechapermmyyyy(tbperfactura(5));
 fecha_cons_mes_6 := fsbgetfechapermmyyyy(tbperfactura(6));
 ut_trace.trace('Fin LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist.getHistoricos',15);
END gethistoricos;
BEGIN
 ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist',15);
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
   nuperidocons := ldc_boformatofactura.fnuobtperconsumo(nucicloc,sbfactpefa);
  EXCEPTION
   WHEN OTHERS THEN
     nucicloc     := -1;
     nuperidocons := -1;
  END;
  gethistoricos(sbfactsusc, nuproduct, nucicloc, sbfactpefa);
  ut_trace.trace('LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist Obtener el origen del consumo',15);
  -- Obtener el origen del consumo
  BEGIN
   SELECT decode(cossmecc, 1, 'LEC.MEDIDOR', 'ESTIMADO') INTO calculo_cons
     FROM vw_cmprodconsumptions
    WHERE cosssesu = nuproduct
      AND cosspefa = sbfactpefa
      AND cosspecs = nuperidocons;
  EXCEPTION
   WHEN OTHERS THEN
    calculo_cons := NULL;
  END;
  ut_trace.trace('LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist VAlidacion ciclo asociado',15);
  IF calculo_cons IS NOT NULL THEN
   SELECT COUNT(*) INTO vnucite
     FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbGetValue_Chain('CICLO_TELEMEDIDOS_GDC'),
                                                  ','))
    WHERE column_value = pktblservsusc.fnugetsesucicl(nuproduct);
  END IF;
  ut_trace.trace('LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist 1 ', 15);
  BEGIN
   SELECT consumo_act
         ,to_char(fac_correccion, '0.9999')
         ,round(consumo_act)
         ,supercompres
         ,round(consumo_act) || ' M3 Equivalen a ' ||
          round(par_pod_calor * consumo_act, 2) || 'kwh',
          round((consumo_mes_1 + consumo_mes_2 + consumo_mes_3 +
                     consumo_mes_4 + consumo_mes_5 + consumo_mes_6) / 6) cons_promedio
     INTO consumo_actual
         ,sbFactor_correccion
         ,cons_correg
         ,supercompres
         ,equival_kwh
         ,consumo_promedio
     FROM (SELECT fnugetconsumoresidencial(MAX(sesunuse), MAX(cosspecs)) consumo_act
                ,MAX(fccofaco) fac_correccion
                ,MAX(fccofasc) supercompres
                ,MAX(fccofapc) * MAX(fccofaco) poder_calor
            FROM factura f
           INNER JOIN servsusc s
              ON (sesususc = factsusc AND
                  sesuserv = dald_parameter.fnugetnumeric_value('COD_SERV_GAS'))
                  LEFT OUTER JOIN conssesu c
              ON (c.cosssesu = s.sesunuse AND c.cosspefa = f.factpefa AND cossmecc = 4)
            LEFT OUTER JOIN cm_facocoss
              ON (cossfcco = fccocons)
           WHERE factcodi = sbfactcodi),
               perifact
         WHERE pefacodi = sbfactpefa;
    ut_trace.trace('LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist 2 ',15);
    BEGIN
     nugeoloc := daab_address.fnugetgeograp_location_id(dapr_product.fnugetaddress_id(nuproduct,0),0);
    END;
    ut_trace.trace('LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist 3',15);
    --se consulta presion
     OPEN cucm_vavafacoP(nuproduct);
    FETCH cucm_vavafacoP INTO presion;
     IF cucm_vavafacoP%NOTFOUND THEN
      ------si no existe configuracion de presion para el producto se consulta por localidad
       OPEN cucm_vavafacoPl(nugeoloc);
      FETCH cucm_vavafacoPl INTO presion;
       IF cucm_vavafacoPl%NOTFOUND THEN
        presion := 0;
       END IF;
      CLOSE cucm_vavafacoPl;
    END IF;
   CLOSE cucm_vavafacoP;
   ut_trace.trace('LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist 4',15);
    --se consulta la temperatura configurada por el producto
    OPEN cucm_vavafacoPt(nuproduct);
   FETCH cucm_vavafacoPt INTO temperatura;
    IF cucm_vavafacoPt%NOTFOUND THEN
     ------si no posee configuracion de temperatura por producto consulta por localidad
      OPEN cucm_vavafacotl(nugeoloc);
     FETCH cucm_vavafacotl INTO temperatura;
      IF cucm_vavafacotl%NOTFOUND THEN
       NULL;
      END IF;
     CLOSE cucm_vavafacotl;
    END IF;
   CLOSE cucm_vavafacoPt;
  EXCEPTION
   WHEN no_data_found THEN
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
    presion             := 0;
  END;
  -- Si es no regulado no muestra datos
 ELSE
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
  presion             := NULL;
 END IF;
 OPEN orfcursor FOR
  SELECT consumo_mes
        ,fecha_cons_mes
    FROM (
          SELECT consumo_mes_1    consumo_mes
                ,fecha_cons_mes_1 fecha_cons_mes
                ,1                orden_consumo
            FROM dual
           UNION
          SELECT consumo_mes_2    consumo_mes
                ,fecha_cons_mes_2 fecha_cons_mes
                ,2                orden_consumo
            FROM dual
           UNION
          SELECT consumo_mes_3    consumo_mes
                ,fecha_cons_mes_3 fecha_cons_mes
                ,3                orden_consumo
            FROM dual
           UNION
          SELECT consumo_mes_4    consumo_mes
                ,fecha_cons_mes_4 fecha_cons_mes
                ,4                orden_consumo
            FROM dual
           UNION
          SELECT consumo_mes_5    consumo_mes
                ,fecha_cons_mes_5 fecha_cons_mes
                ,5                orden_consumo
            FROM dual
           UNION
          SELECT consumo_mes_6    consumo_mes
                ,fecha_cons_mes_6 fecha_cons_mes
                ,6                orden_consumo
            FROM dual
          )
  ORDER BY orden_consumo DESC;
  ut_trace.trace('Fin LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist', 15);
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  RAISE pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
  Pkg_Error.setError;
  RAISE pkg_error.CONTROLLED_ERROR;
END rfdatosconsumos;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION FnuGetSaldoAnterior(
                             InuContrato NUMBER
                            ,InuFactura  NUMBER
                            ,Inusesunuse NUMBER
                            ) RETURN NUMBER IS
/*****************************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   FnuGetSaldoAnterior
  Descripcion :   Servicio que permitira obtener el saldo anterior de un suscriptor
  Autor       :   Jorge valiente

  Historia de Modificaciones
  Fecha               Autor              Modificacion
  =========           =========          ====================
  29/08/2023    DIANA.MONTES           OSF-1462: Se modifica cursor cusaldoanterior  para que valide
                                       cucosacu > (cucovare + cucovrap)
*****************************************************************************************/
CURSOR cusaldoanterior is
 SELECT (SUM(CUCOSACU) - SUM(CUCOVARE) - SUM(CUCOVRAP)) saldo_ant
   FROM servsusc, cuencobr
  WHERE sesususc = InuContrato
    AND sesunuse = decode(Inusesunuse, -1, sesunuse, Inusesunuse)
    AND cuconuse = sesunuse
    AND cucosacu > (cucovare + cucovrap)
    AND cucofact != InuFactura
  GROUP BY sesunuse, sesuserv;

rfcusaldoanterior cusaldoanterior%rowtype;
BEGIN
 ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.FnuGetSaldoAnterior',15);
 ut_trace.trace('Contrato[' || InuContrato || ']', 15);
 ut_trace.trace('Factura[' || InuFactura || ']', 15);
 ut_trace.trace('Servicio[' || Inusesunuse || ']', 15);
  OPEN cusaldoanterior;
 FETCH cusaldoanterior INTO rfcusaldoanterior;
 CLOSE cusaldoanterior;
 RETURN nvl(rfcusaldoanterior.saldo_ant, 0);
 ut_trace.trace('Fin LDC_DETALLEFACT_GASCARIBE.FnuGetSaldoAnterior', 15);
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  RETURN 0;
 WHEN OTHERS THEN
  RETURN 0;
END FnuGetSaldoAnterior;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE RfMarcaAguaDuplicado(orfcursor OUT constants.tyRefCursor) AS
/*****************************************************************************
  Propiedad intelectual de PETI (c).

  UNID         : RfMarcaAguaDuplicado
  Descripcion    : procedimiento para extraer los datos y establecer si
                   se aplica la maraca de agua en la plantilla .NET
  Autor          : Daniel Valiente

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
*****************************************************************************/
BEGIN
 ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.RfMarcaAguaDuplicado',15);
 OPEN orfcursor FOR
  SELECT nvl(visible, 0) visible, impreso
    FROM (
          SELECT dald_parameter.fnuGetNumeric_Value('DUPLICADO_WATERMARK',NULL) AS visible
                ,g.name_ AS impreso
            FROM ge_person g
           WHERE g.person_id = ge_bopersonal.fnugetpersonid
         )
   WHERE rownum = 1;
  ut_trace.trace('Fin LDC_DETALLEFACT_GASCARIBE.RfMarcaAguaDuplicado',15);
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  OPEN orfcursor FOR
   SELECT 0, NULL FROM dual;
  WHEN OTHERS THEN
   OPEN orfcursor FOR
    SELECT 0, NULL FROM dual;
END RfMarcaAguaDuplicado;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE RfProteccion_Datos(orfcursor OUT constants.tyRefCursor) AS
/******************************************************************************************
  Propiedad intelectual de PETI (c).

  UNID         : RfProteccion_Datos
  Descripcion    : Servicio para retonar si el funcionario tiene o no la solciitud
                   de proteccion de
                   datos activo en OSF
  Autor          : Jorge Valiente

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna caracter
                               S SI tiene proteccion de datos activo.
                               N NO tiene proteccion de datos activo.

  Fecha             Autor             Modificacion
  =========       =========           ====================
/******************************************************************************************/
sbFactcodi ge_boInstanceControl.stysbValue;
sbFactsusc ge_boInstanceControl.stysbValue;
BEGIN
 ut_trace.trace('Inicio ldc_detallefact_gascaribe.RfProteccion_Datos', 15);
 --Obtiene el identificador de la factura de la instancia
 sbFactcodi := obtenervalorinstancia('FACTURA', 'FACTCODI');
 ut_trace.trace('Parametro sbFactcodi : '||sbFactcodi, 15);
 sbFactsusc := obtenervalorinstancia('FACTURA', 'FACTSUSC');
 ut_trace.trace('Parametro sbFactsusc : '||sbFactsusc, 15);
 -- Obtenemos resultado
 ut_trace.trace('Ejecutamos el procedimiento : ldc_pkgprocefactspoolatencli.RfProteccion_Datos ', 15);
 ldc_pkgprocefactspoolatencli.RfProteccion_Datos(
                                                 sbFactsusc
                                                ,orfcursor
                                                );
 ut_trace.trace('Fin ldc_detallefact_gascaribe.RfProteccion_Datos', 15);
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  RAISE pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
  RAISE pkg_error.CONTROLLED_ERROR;
END RfProteccion_Datos;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE RfDatosAdicionales(
                             orfcursor OUT constants.tyRefCursor
                            ) IS
/**********************************************************************************************************************
  Propiedad intelectual de PETI (c).

  UNID         : RfDatosAdicionales
  Descripcion    : Procedimiento para extraer datos adicionales para mostrar en el SPOOL.
  Autor          : Jorge Valiente

  Parametros           Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  19/07/2022         JJJM              OSF-407 Se desacopla el procedimiento, pasando la
                                     logica al procedimiento : ldc_pkgprocefactspoolconsu.RfDatosAdicionales
                                     y haciendo el llamado desde este.

**********************************************************************************************************************/
 sbFactcodi  ge_boInstanceControl.stysbValue;
 sbFactsusc  ge_boInstanceControl.stysbValue;
 sbPeriodo   ge_boInstanceControl.stysbValue;
 blNRegulado BOOLEAN;
BEGIN
 ut_trace.trace('Inicio ldc_detallefact_gascaribe.rfdatosadicionales',15);
 -- Obtiene el identificador de la factura instanciada
 sbFactcodi  := obtenervalorinstancia('FACTURA', 'FACTCODI');
 ut_trace.trace('Parametro sbFactcodi: '||sbFactcodi,15);
 sbFactsusc  := obtenervalorinstancia('FACTURA', 'FACTSUSC');
 ut_trace.trace('Parametro sbFactsusc: '||sbFactsusc,15);
 sbPeriodo   := obtenervalorinstancia('FACTURA', 'FACTPEFA');
 ut_trace.trace('Parametro sbPeriodo: '||sbPeriodo,15);
 blNRegulado := fblNoRegulado(sbFactsusc);
 -- Obtenemos resultado
 ut_trace.trace('Ejecutamos el procedimiento : ldc_pkgprocefactspoolconsu.RfDatosAdicionales',15);
 ldc_pkgprocefactspoolconsu.RfDatosAdicionales
                                              (
                                               sbFactcodi
                                              ,sbFactsusc
                                              ,sbPeriodo
                                              ,blNRegulado
                                              ,orfcursor
                                              );
 ut_trace.trace('Fin LDC_DETALLEFACT_GASCARIBE.RfDatosAdicionales',15);
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  RAISE pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
  Pkg_Error.setError;
  RAISE pkg_error.CONTROLLED_ERROR;
END RfDatosAdicionales;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION FSBCategoriaUNICO(inucategoria NUMBER, inusubcategoria NUMBER) RETURN VARCHAR2 IS
/****************************************************************************************
  Propiedad intelectual de PETI (c).

  UNID         : FSBCategoriaUNICO
  Descripcion    : funcion para obtener la descripcion UNICO para las categorias
                   configuradas en el parametro COD_CAT_SPO_GDC
  Autor          : Jorge Valiente

  Parametros           Descripcion
  ============         ===================
  inuSusccodi          contrato

  Fecha             Autor             Modificacion
  =========       =========           ====================
****************************************************************************************/
CURSOR cuexiste IS
 SELECT count(1) cantidad
   FROM dual
  WHERE inucategoria IN (SELECT to_number(column_value)
                           FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_CAT_SPO_GDC',
                                                                                         NULL),
                                                        ',')));

    rfcuexiste cuexiste%ROWTYPE;
    sbunico varchar(4000) := NULL;
BEGIN
 ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.FSBCategoriaUNICO',15);
 sbunico := upper( pktblsubcateg.fsbgetdescription(
                                                  inucategoria
                                                 ,inusubcategoria
                                                 ));

  OPEN cuexiste;
 FETCH cuexiste INTO rfcuexiste;
 IF cuexiste%FOUND THEN
  IF rfcuexiste.cantidad = 1 THEN
    sbunico := 'UNICO';
  END IF;
 END IF;
 CLOSE cuexiste;
 ut_trace.trace('Fin LDC_DETALLEFACT_GASCARIBE.FSBCategoriaUNICO',15);
 RETURN sbunico;
EXCEPTION
 WHEN OTHERS THEN
  RETURN NULL;
END fsbcategoriaunico;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fsbgetCalifVariConsumos(
                                 inusesunuse IN servsusc.sesunuse%TYPE
                                ,inupericose IN conssesu.cosspecs%TYPE
                                ) RETURN VARCHAR2 IS
/*****************************************************************************
  Propiedad intelectual de PETI (c).

  UNID         : fsbgetCalifVariConsumos
  Descripcion    : Permite retronar la causa de desviacion de consumo
  Autor          : Llozada

  Parametros           Descripcion
  ============         ===================
  inusesunuse      Producto
  inupericose      Periodo de consumo

  Fecha             Autor             Modificacion
  =========       =========           ====================
  18/09/2017      llozada           Creacion.
*****************************************************************************/
CURSOR cuexiste(inucalvarcon number) IS
 SELECT count(1) cantidad
   FROM dual
  WHERE InuCalVarCon IN
       (
        SELECT to_number(column_value)
          FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_CAL_VAR_CON_GDC',
                                                                                         NULL),
                                                        ',')));
rfcuexiste         cuexiste%rowtype;
nuvariacion        conssesu.cosscavc%TYPE;
sbcausa_desviacion VARCHAR2(4000) := ' ';
BEGIN
 BEGIN
  ut_trace.trace('INICIO LDC_DetalleFact_GasCaribe.fsbgetCalifVariConsumos', 2);
  SELECT cosscavc INTO nuVariacion
    FROM vw_cmprodconsumptions
   WHERE cosssesu = inusesunuse
     AND cosspecs = inupericose
     AND rownum = 1;
   OPEN cuexiste(nuvariacion);
  FETCH cuexiste INTO rfcuexiste;
    IF cuexiste%FOUND THEN
     IF rfcuexiste.cantidad = 1 THEN
       sbcausa_desviacion := 'Desviación Significativa';
     END IF;
    END IF;
  CLOSE cuexiste;
 EXCEPTION
  WHEN no_data_found THEN
   sbcausa_desviacion := ' ';
 END;
 ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fsbgetCalifVariConsumos', 2);
 RETURN sbcausa_desviacion;
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  sbcausa_desviacion := ' ';
  RETURN sbcausa_desviacion;
 WHEN OTHERS THEN
  sbcausa_desviacion := ' ';
  RETURN sbcausa_desviacion;
END fsbgetCalifVariConsumos;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION fsbFormatoCupoBrilla (inuCupo IN NUMBER) RETURN VARCHAR2 IS
/*****************************************************************
  Propiedad intelectual de Gas caribe(c).

  UNID         : fsbFormatoCupoBrilla
  Descripcion    : retorna cupo formateado por comas
  Autor          : elal

  Parametros           Descripcion
  ============         ===================
  inuCupo      cupo de brilla


  Fecha             Autor             Modificacion
  =========       =========           ====================
  17/04/2019      elal           Creacion.
******************************************************************/
BEGIN
 RETURN TO_CHAR(inuCupo, 'FM999,999,999,990');
END fsbFormatoCupoBrilla;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE RfDatosCuenxCobrTt(orfcursor OUT constants.tyRefCursor) IS
/*************************************************************************************************
 Propiedad intelectual de GDC (c).

 UNID         : RfDatosCuenxCobrTt
 Descripcion    : funcion que devuelve el valor por cobrar de la tarifa transitoria

 Autor          : Luis Javier Lopez Barrios / Horbath

 Parametros           Descripcion
 ============         ===================
 inuSusccodi          contrato

  Fecha             Autor             Modificacion
  =========       =========           ====================
  22/07/2022       JJJM              OSF-407 Se desacopla el procedimiento, pasando la
                                     logica al procedimiento : ldc_pkgprocefactspoolfac.RfConcepParcial
                                     y haciendo el llamado desde este.
*************************************************************************************************/
sbFactsusc  ge_boInstanceControl.stysbValue;
BEGIN
 ut_trace.trace('Inicio ldc_detallefact_gascaribe.RfDatosCuenxCobrTt', 15);
 -- Obtiene el identificador del contrato instanciado
 sbFactsusc := obtenervalorinstancia('FACTURA', 'FACTSUSC');
 ut_trace.trace('Parametro sbFactsusc : '||sbFactsusc, 15);
 ut_trace.trace('Ejecutamos : ldc_pkgprocefactspoolfac.RfDatosCuenxCobrTt ', 15);
 ldc_pkgprocefactspoolfac.RfDatosCuenxCobrTt(
                                              sbFactsusc
                                             ,orfcursor
                                             );
 ut_trace.trace('Fin ldc_detallefact_gascaribe.RfDatosCuenxCobrTt', 15);
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  RAISE pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
  Pkg_Error.setError;
  RAISE pkg_error.CONTROLLED_ERROR;
END RfDatosCuenxCobrTt;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE RfDatosFinanEspecial(orfcursor OUT constants.tyRefCursor) Is
/****************************************************************************************************************************
    Propiedad intelectual de GDC (c).

    UNID         : RfDatosFinanEspecial
    Descripcion    : proceso que devuelve si un producto tiene financiacion
                     de cartera especiales
    Ticket         : 874

    Autor          : Luis Javier Lopez Barrios / Horbath

    Parametros           Descripcion
    ============         ===================


    Fecha             Autor             Modificacion
    =========       =========           ====================
    22/07/2022           JJJM          OSF-407 Se desacopla el procedimiento, pasando la
                                               logica al procedimiento : ldc_pkgprocefactspoolcart.RfDatosFinanEspecial
                                               y haciendo el llamado desde este.

****************************************************************************************************************************/
sbFactura ge_boInstanceControl.stysbValue;
BEGIN
 ut_trace.trace('Inicio ldc_detallefact_gascaribe.RfDatosFinanEspecial', 15);
 -- Obtiene el identificador del contrato instanciado
 sbFactura := obtenervalorinstancia('FACTURA', 'FACTCODI');
 ut_trace.trace('Parametro sbFactura : '||sbFactura, 15);
 -- Obtenemos resultado
 ut_trace.trace('Ejecutamos el procedimiento : ldc_pkgprocefactspoolcart.RfDatosFinanEspecial', 15);
 ldc_pkgprocefactspoolcart.RfDatosFinanEspecial(
                                                sbFactura
                                               ,orfcursor
                                               );
 ut_trace.trace('Fin ldc_detallefact_gascaribe.RfDatosFinanEspecial', 15);
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  RAISE pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
  Pkg_Error.setError;
  RAISE pkg_error.CONTROLLED_ERROR;
END RfDatosFinanEspecial;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE RfDatosMedMalubi(orfcursor OUT constants.tyRefCursor) IS
/***************************************************************************************************************
    Propiedad intelectual de GDC (c).

    UNID         : RfDatosMedMalubi
    Descripcion    : Procedimiento para extraer si el usuario tiene solicitud VSI
                     dentro del periodo de facturación
    Ticket         : OSF-72
    Fecha          : 10/05/2022
    Autor          : John Jairo Jimenez Marimon

    Parametros           Descripcion
    ============         ===================


    Fecha             Autor             Modificacion
    =========       =========           ====================
   22/07/2022       JJJM              OSF-407 Se desacopla el procedimiento, pasando la
                                     logica al procedimiento : ldc_pkgprocefactspoolfac.RfDatosMedMalubi
                                     y haciendo el llamado desde este.
***************************************************************************************************************/
sbfactpefa ge_boinstancecontrol.stysbvalue;
sbfactcodi ge_boinstancecontrol.stysbvalue;
nuproduct  servsusc.sesunuse%TYPE;
BEGIN
 ut_trace.trace('Inicio ldc_detallefact_gascaribe.RfDatosMedMalubi', 15);
 sbfactcodi := obtenervalorinstancia('FACTURA', 'FACTCODI');
 ut_trace.trace('Parametro sbFactcodi : '||sbFactcodi, 15);
 sbfactpefa := obtenervalorinstancia('FACTURA', 'FACTPEFA');
 ut_trace.trace('Parametro sbfactpefa : '||sbfactpefa, 15);
 nuproduct  := fnugetproducto(sbfactcodi);
 ut_trace.trace('Parametro nuproduct : '||nuproduct, 15);
 -- Obtenemos resultado
 ut_trace.trace('Ejecutamos el procedimiento : ldc_pkgprocefactspoolconsu.RfDatosMedMalubi', 15);
 ldc_pkgprocefactspoolconsu.RfDatosMedMalubi(
                                             sbfactpefa
                                            ,nuproduct
                                            ,orfcursor
                                            );
 ut_trace.trace('Fin ldc_detallefact_gascaribe.RfDatosMedMalubi', 15);
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
     RAISE pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
     Pkg_Error.setError;
     RAISE pkg_error.CONTROLLED_ERROR;
END RfDatosMedMalubi;

---------------------------------------------------------------------------------------------------------------------------
PROCEDURE rfdatosimpresiondig(orfcursorimpdig OUT constants.tyRefCursor) IS
/*******************************************************************************************************************
  Propiedad intelectual de GDC (c).

  UNID         : rfdatosimpresiondig
  Descripcion    : Procedimiento que valida si se imprime factuta fisica a usuario o no.
  Ticket         : OSF-65
  Fecha          : 31/05/2022

  Autor          : John Jairo Jimenez Marimon

  Parametros           Descripcion
  ============         ===================


  Fecha             Autor             Modificacion
  =========       =========           ====================
 22/07/2022       JJJM              OSF-407 Se desacopla el procedimiento, pasando la
                                     logica al procedimiento : ldc_pkgprocefactspoolfac.rfdatosimpresiondig
                                     y haciendo el llamado desde este.
*******************************************************************************************************************/
sbFactsusc ge_boInstanceControl.stysbValue;
nmsusccodi suscripc.susccodi%TYPE;
BEGIN
 ut_trace.trace('Inicio ldc_detallefact_gascaribe.rfdatosimpresiondig', 15);
 sbFactsusc := obtenervalorinstancia('FACTURA', 'FACTSUSC');
 ut_trace.trace('Parametro sbFactsusc : '||sbFactsusc, 15);
 nmsusccodi := to_number(sbFactsusc);
 ut_trace.trace('ejecutamos el procedimiento : ldc_pkgprocefactspoolfac.rfdatosimpresiondig', 15);
 ldc_pkgprocefactspoolfac.rfdatosimpresiondig(
                                               nmsusccodi
                                              ,orfcursorimpdig
                                              );
 ut_trace.trace('Fin ldc_detallefact_gascaribe.rfdatosimpresiondig', 15);
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
     RAISE pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
     Pkg_Error.setError;
     RAISE pkg_error.CONTROLLED_ERROR;
 END rfdatosimpresiondig;
--------------------------------------------------------------------------------------------------------------

PROCEDURE rfLastPayment(orfcursor OUT constants.tyRefCursor) AS
 /*********************************************************************************************************
  Propiedad intelectual de GDC (c).

  UNID         : rfLastPayment
  Descripcion    : Procedimiento que retorna el ultimo pago del usuario y la fecha de este ultimo pago.
  Ticket         : OSF-393
  Fecha          : 24/06/2022

  Autor          : John Jairo Jimenez Marimon

  Parametros           Descripcion
  ============         ===================


  Fecha             Autor             Modificacion
  =========       =========           ====================
*********************************************************************************************************/

sbFactsusc  ge_boInstanceControl.stysbValue;
BEGIN
 ut_trace.trace('Inicio ldc_detallefact_gascaribe.rfLastPayment', 15);
 --Obtiene el identificador de la factura de la instancia
 sbFactsusc := obtenervalorinstancia('FACTURA','FACTSUSC');
 ut_trace.trace('Parametro sbFactsusc : '||sbFactsusc, 15);
 ut_trace.trace('Ejecutamos el procedimiento : ldc_pkgprocefactspoolfac.rfLastPayment', 15);
 ldc_pkgprocefactspoolfac.rfLastPayment(
                                        sbFactsusc
                                       ,orfcursor
                                       );
 ut_trace.trace('Fin ldc_detallefact_gascaribe.rfLastPayment', 15);
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  RAISE pkg_error.CONTROLLED_ERROR;
 WHEN OTHERS THEN
  Pkg_Error.setError;
  RAISE pkg_error.CONTROLLED_ERROR;
END rfLastPayment;
--------------------------------------------------------------------------------------------------------------

FUNCTION fnuObtPuntos(inuContrato IN NUMBER) RETURN NUMBER IS
 /*****************************************************************
  Propiedad intelectual de Gas caribe(c).

  UNID         : fnuObtPuntos
  Descripcion    : Obtiene los puntos puntualizate de un contrato
  Autor          : Carlos Gonzalez (Horbath)

  Parametros        Descripcion
  ============      ===================
  inuContrato       Contrato

  Fecha           Autor               Modificacion
  ==========      =========           ====================
  21/07/2022      cgonzalez           Creacion.
 ******************************************************************/
 nuPuntos NUMBER;
 CURSOR cuObtPuntos(inuContrato IN NUMBER) IS
  SELECT NVL(SUM(DECODE(signo, 'DB', -cantidad, cantidad)),0) cantidad
    FROM ldc_movi_puntos_portal
   WHERE contrato = inuContrato;
BEGIN
  ut_trace.trace('INICIO LDC_DetalleFact_GasCaribe.fnuObtPuntos', 2);
  OPEN cuObtPuntos(inuContrato);
 FETCH cuObtPuntos INTO nuPuntos;
 CLOSE cuObtPuntos;
 ut_trace.trace('Fin LDC_DetalleFact_GasCaribe.fnuObtPuntos', 2);
 RETURN nuPuntos;
EXCEPTION
 WHEN pkg_error.CONTROLLED_ERROR THEN
  nuPuntos := 0;
  RETURN nuPuntos;
 WHEN OTHERS THEN
  nuPuntos := 0;
  RETURN nuPuntos;
END fnuObtPuntos;
--------------------------------------------------------------------------------------------------------------
 PROCEDURE rfGetSaldoAnterior(orfcursorsaldoante OUT constants.tyRefCursor) IS
 /******************************************************************************************
  Propiedad intelectual de GDC (c).

  UNID         : rfGetSaldoAnterior
  Descripcion    : Procedimiento que retorna saldo anterior
  Ticket         : OSF-1056
  Fecha          : 26/04/2023
  Autor          : Luis Javier Lopez Barrios

  Parametros           Descripcion
  ============         ===================


  Fecha             Autor             Modificacion
  =========       =========           ====================
 ******************************************************************************************/
 ------------------------------------------------------------------------------------------------------------------------
 BEGIN
   ut_trace.trace('Inicio ldc_detallefact_gascaribe.rfGetSaldoAnterior', 15);
   ldc_pkgprocefactspoolfac.rfGetSaldoAnterior(orfcursorsaldoante);
   ut_trace.trace('FIN ldc_detallefact_gascaribe.rfGetSaldoAnterior', 15);
 EXCEPTION
   WHEN pkg_error.CONTROLLED_ERROR THEN
    RAISE pkg_error.CONTROLLED_ERROR;
   WHEN OTHERS THEN
    Pkg_Error.setError;
    RAISE pkg_error.CONTROLLED_ERROR;
 END rfGetSaldoAnterior;

 PROCEDURE prcGetInfoAdicional(orfcursorinfoadic OUT constants.tyRefCursor) IS
 /******************************************************************************************
  Propiedad intelectual de GDC (c).

  UNID         : rfGetInfoAdicional
  Descripcion    : Procedimiento que retorna informacion adicional en el spool
  Ticket         : OSF-2494
  Fecha          : 12/04/2024
  Autor          : Luis Javier Lopez Barrios

  Parametros           Descripcion
  ============         ===================


  Fecha             Autor             Modificacion
  =========       =========           ====================
 ******************************************************************************************/
  csbMT_NAME      VARCHAR2(100) := gsbPaquete || '.prcGetInfoAdicional';
  nuError NUMBER;
  sbError VARCHAR2(4000);

  sbFactcodi  ge_boInstanceControl.stysbValue;

 BEGIN
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
     sbFactcodi := obtenervalorinstancia('FACTURA','FACTCODI');
     ldc_pkgprocefactspoolfac.prcGetInfoAdicional(sbFactcodi, orfcursorinfoadic);
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
 END prcGetInfoAdicional;

END LDC_DetalleFact_GasCaribe;
/