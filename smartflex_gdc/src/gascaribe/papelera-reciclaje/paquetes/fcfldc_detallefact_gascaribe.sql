CREATE OR REPLACE PACKAGE fcfldc_detallefact_gascaribe IS
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
  wfact  number := 2053655701;
  wsusc  number := 48005805;
  wpefa  number := 84300;
    
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

  --Inicio CASO 200-1874 Anexo al CASO 2100-1899
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
  PROCEDURE RfProteccion_Datos(orfcursor OUT constants.tyRefCursor);
  --Fin CASO 200-1874 Anexo al CASO 2100-1899

  --Inicio CASO 200-1633 Anexo al CASO 200-1899
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
  PROCEDURE RfDatosAdicionales(orfcursor OUT constants.tyRefCursor);
  --Fin CASO 200-1633 Anexo al CASO 200-1899

  --Inicio CASO 200-1633 Anexo al CASO 200-1899
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
  FUNCTION FSBCategoriaUNICO(InuCATEGORIA number, InuSubCATEGORIA number)
    RETURN VARCHAR2;
  --Fin CASO 200-1633 Anexo al CASO 200-1899

  --Inicio CASO 200-1633 Anexo al CASO 200-1899
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
  FUNCTION fsbgetCalifVariConsumos(inusesunuse IN servsusc.sesunuse%TYPE,
                                   inupericose IN conssesu.cosspecs%TYPE)
    RETURN VARCHAR2;
  --Fin CASO 200-1633 Anexo al CASO 200-1899

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

END fcfldc_detallefact_gascaribe;
/
