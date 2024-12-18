create or replace PACKAGE LDC_PKGESTIONTARITRAN IS
/*******************************************************************************
    Package:        LDC_PKGESTIONTARITRAN
    Descripcion:    Paquete Gestión Tarifa Transitoria
    Autor:          Luis Javier Lopez Barrios / Horbath
    Fecha:          26/05/2020

    Historial de Modificaciones
    =============================
    FECHA           AUTOR               DESCRIPCION
	15-05-2024	 	JSOTO			    OSF-2602 Se reemplaza uso de LDC_Email.mail por pkg_correo.prcEnviaCorreo
    29/02/2024      jcatuchemvm         OSF-2308: Se ajustan los llamados al procedimiento PRACTUALLIQINT para que se envie
                                        la diferencia tarifaria calculada cuando no es encontrada en los productos que 
                                        solo tienen consumos subsidiados en el periodo. Variable nuDifereTari
                                        Se modifican los procedimientos
                                            [proGeneraNota]
                                            [proGeneraNotaUsuario]
                                            [proGeneraNotaUsumar]
                                            [Genpositivebal]
    25/01/2024      jpinedc             OSF-2020: Se modifica el procedimiento
                                            [PRGENTRAMCANTT]
    15/03/2023      jcatuchemvm         OSF-966: Se modifica el procedimiento
                                            [PRGENENOTARETI]
                                            [PRGENTRAMCANTT]
    26/05/2020      Luis Javier Lopez   Creacion el paquete
*******************************************************************************/

  CURSOR cuObteFechaLiq(inutariConc NUMBER, inuConcepto IN NUMBER, inuValor IN NUMBER) IS
   select fecha_inicial
     from ( SELECT  d.vitcfein fecha_inicial,
               d.vitcfefi,
               CASE WHEN nvl(ravtvalo,0) != 0 THEN ravtvalo ELSE
               CASE WHEN nvl(vitcvalo,0) != 0 THEN vitcvalo ELSE
               CASE WHEN nvl(ravtporc,0) != 0 THEN ravtporc ELSE vitcporc END END END valor
       FROM OPEN.ta_tariconc A
        LEFT  JOIN OPEN.ta_vigetaco d ON (d.vitctaco = A.tacocons)
        LEFT  JOIN OPEN.ta_rangvitc e ON (e.ravtvitc = d.vitccons)
        LEFT OUTER JOIN OPEN.ta_conftaco b ON (A.tacocotc = b.cotccons)
       WHERE a.tacocons = inutariConc
       AND b.COTCCONC = inuConcepto
       )
     where valor = inuValor ;

CURSOR cuGetInfotarifa( nuTariCon NUMBER,
                            nuConcepto NUMBER,
                            nuValor NUMBER,
              IDTARIFA NUMBER  ) IS
    SELECT *
    FROM (
       SELECT  A.tacocr03 mere ,
               A.tacocr02 cate,
               A.tacocr01 suca,
         ravtliin,
               ravtliin || ' - '  || ravtlisu rango,
               d.vitcfein fecha_inicial,
               d.vitcfefi,
               CASE WHEN nvl(ravtvalo,0) != 0 THEN ravtvalo ELSE
               CASE WHEN nvl(vitcvalo,0) != 0 THEN vitcvalo ELSE
               CASE WHEN nvl(ravtporc,0) != 0 THEN ravtporc ELSE vitcporc END END END valor
       FROM OPEN.ta_tariconc A
            LEFT  JOIN OPEN.ta_vigetaco d ON (d.vitctaco = A.tacocons)
            LEFT  JOIN OPEN.ta_rangvitc e ON (e.ravtvitc = d.vitccons)
            LEFT OUTER JOIN OPEN.ta_conftaco b ON (A.tacocotc = b.cotccons)
       WHERE a.tacocons = nuTariCon
         AND b.COTCCONC = nuConcepto
     AND VITCCONS = nvl(IDTARIFA,VITCCONS)
       UNION ALL
       SELECT A.tacpcr03 mere,
              A.tacpcr02 cate,
              A.tacpcr01 suca,
        ravpliin,
              ravpliin || ' - '  ||    ravplisu rango,
              d.vitpfein,
              d.vitpfefi,
              CASE WHEN nvl(ravpvalo,0) != 0 THEN ravpvalo ELSE
              CASE WHEN nvl(vitpvalo,0) != 0 THEN vitpvalo ELSE
              CASE WHEN nvl(ravpporc,0) != 0 THEN ravpporc ELSE vitpporc END END END ravpvalo
        FROM OPEN.ta_taricopr A,
             OPEN.ta_proytari b,
             OPEN.ta_vigetacp d,
             OPEN.ta_rangvitp e,
             OPEN.ta_conftaco b1
        WHERE   A.tacpcons   = nuTariCon
          AND A.tacpprta = b.prtacons --
          AND d.vitptacp = A.tacpcons
          AND e.ravpvitp = d.vitpcons
          AND A.tacpcotc = b1.cotccons
          AND cotcconc = nuConcepto
      AND D.VITPCONS = nvl(IDTARIFA, VITPCONS)
          AND b.prtaesta IN (2, 3)
          AND d.vitptipo = 'B' )
   WHERE valor = nuValor
   order by fecha_inicial desc;


   TYPE regTarifaCon IS RECORD ( mere          NUMBER,
                                 cate          NUMBER,
                                 suca          NUMBER,
                                 rangini       NUMBER,
                                 rango         VARCHAR2(400),
                                 fecha_inicial DATE,
                                 fecha_final   DATE,
                                 valor         NUMBER );
   vregTarifaCon regTarifaCon;
   vregTarifaContri regTarifaCon;
   vregTarifaConnull regTarifaCon;

  --registro de tarifa
  TYPE regtarifa IS RECORD ( nuCate    NUMBER,
                             nusuca    NUMBER,
                             nuMere    NUMBER,
                             nutarifa  NUMBER,
                             nutaricon NUMBER,
                             rango     VARCHAR2(400));
  --se crea tabla de tarifa
  TYPE tbltarifas IS TABLE OF regtarifa INDEX BY VARCHAR2(400);
  vtbltarifas  tbltarifas;

   PROCEDURE prGeneraProcNotas( regTarifa   IN regTarifaCon,
                               inuSusc     IN factura.factsusc%type,
                               inuProducto IN cuencobr.cuconuse%TYPE,
                               inuCuenta   IN cuencobr.cucocodi%TYPE,
                               inufactura  IN cuencobr.cucofact%TYPE,
                               inuConcepto IN NUMBER,
                               inuUnidad   IN NUMBER,
                               inuTariNor  IN NUMBER,
                               inuPerifact IN cargos.CARGPEFA%type,
                               inuPeriCons IN cargos.cargpeco%type,
                               isbSigno    IN  cargos.cargsign%type,
                               inuTariconc IN OUT NUMBER,
                               inuIndice   IN NUMBER,
                               inuaccion   IN NUMBER,
                               OnuValorNota IN OUT NUMBER,
                               inuGenDife IN NUMBER DEFAULT 0,
                               onuDifetar   IN OUT NUMBER,
                 nuaplicaSubadic IN number DEFAULT 0,
                               OsbSigno     OUT VARCHAR,
                               onuerror    OUT NUMBER,
                               osbError    OUT VARCHAR2);
    /**************************************************************************
    Proceso     : prGeneraProcNotas
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2020-05-26
      Ticket      : 415
      Descripcion : genera notas de proceso

    Parametros Entrada
     regTarifa   registro de tarifa
     inuConcepto   concepto
     inuUnidad     unidad
     inuTariconc   tarifa concepto
     inuIndice     indice
     inuSusc       contrato
     inuProducto   producto
     inuCuenta     cuenta
     inufactura    factura
     inuConcepto   concepto
     inuUnidad     unidades liquidada
     inuTariNor    valor tarifa normal
     inuPerifact   periodo de facturaciom
     inuPeriCons   periodo de consumo
     isbSigno      signo
     inuaccion   accion a ejecutar
     inuGenDife  genera diferencia
    Parametros de salida
     onuerror  codigo de error 0 - exito -1 error
     osbError  mensaje de error
   nuaplicaSubadic indica si aplica subsidio adicional
   onuDifetar diferencia de tarifa
     OnuValorNota  valor de la nota
     OsbSigno signo aplicado
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
 PROCEDURE   PRJOBGENENOTATT;
 /**************************************************************************
  Proceso     : PRJOBGENENOTATT
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-05-26
  Ticket      : 415
  Descripcion : genera nota a productos marcados LDC_PRODTATT

  Parametros Entrada
  inuProducto    Codigo de producto


  Parametros de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
PROCEDURE   PRGENECUPDES( inufactura IN NUMBER,
                          inususc    IN  NUMBER,
                          inuValoCuno IN NUMBER,
                          onuValor   OUT  NUMBER,
                          onuCuponDesc OUT NUMBER,
                          onuerror  OUT NUMBER,
                          OSBERROR  OUT VARCHAR2);
  /**************************************************************************
  Proceso     : PRGENECUPDES
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-05-26
  Ticket      : 415
  Descripcion : proceso que genera cupon de descuento

  Parametros Entrada
    inufactura numero de factura
    inuSusc   suscriptor
    inuValoCuno  valor del cupon normal
  Parametros de salida
    onuCuponDesc cupon de descuento
    onuerror codigo de error
    OSBERROR  mensaje de error
    OnuValor  valor
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
PROCEDURE   PRJOBACTPRODTT;
  /**************************************************************************
  Proceso     : PRJOBACTPRODTT
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-05-26
  Ticket      : 415
  Descripcion : job que se encarga de generar nota para usuarios que paguen con cupon de
                 descuento

  Parametros Entrada

  Parametros de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/

  PROCEDURE   PRJOBGENECUPODES;
    /**************************************************************************
    Proceso     : PRJOBGENECUPODES
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-05-26
    Ticket      : 415
    Descripcion : job que genera cupon descuento

    Parametros Entrada

    Parametros de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
PROCEDURE proGeneraNotaUsumar( inuSusc       in number,
                                 inuprod      IN NUMBER,
                                 inucuenta    IN NUMBER,
                                 inufactura   IN NUMBER,
                                 inuUnidafact IN NUMBER,
                                 inuperiodo   IN NUMBER,
                                 nupericon    IN NUMBER,
                                 nuTariconc   IN number,
                                 inuConcGene  IN NUMBER,
                                 isbSigno     IN VARCHAR2,
                                 nuValorNota  IN NUMBER,
                                  isbObservacion IN VARCHAR2,
                                   inufila      IN NUMBER DEFAULT 0,
                                 inuFilaMax   IN NUMBER DEFAULT 0,
                                 onuerror     OUT  NUMBER,
                                 osberror     OUT VARCHAR2);
   /**************************************************************************
      Proceso     : proGeneraNota
        Autor       : Luis Javier Lopez Barrios / Horbath
        Fecha       : 2020-05-26
        Ticket      : 415
        Descripcion : genera notas de proceso

      Parametros Entrada
        inuSusc      contrato
        inuprod      producto
        inucuenta    cuenta
        inufactura   factura
        inuperiodo   periodo de facturacion
        nupericon    periodo de consumo
        nuTariconc   tarifa por concepto
        inuConcGene  concepto a generar
        isbSigno     signo
        nuValorNota  valor de la nota
        inuUnidafact  unidades facturadas
        isbObservacion  observacion
        inufila  fila aprocesar
        inuFilaMax  numero de fila
      Parametros de salida
       onuerror  codigo de error 0 - exito -1 error
       osbError  mensaje de error

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

   PROCEDURE proGeneraNotaUsuario( inuSusc     in number,
                                 inuprod      IN NUMBER,
                                 inucuenta    IN NUMBER,
                                 inufactura   IN NUMBER,
                                 inuUnidafact IN NUMBER,
                                 inuperiodo   IN NUMBER,
                                 nupericon    IN NUMBER,
                                 nuTariconc   IN number,
                                 inuConcGene  IN NUMBER,
                                 isbSigno     IN VARCHAR2,
                                 nuValorNota  IN NUMBER,
                                 isbObservacion IN VARCHAR2,
                 inuCausal      IN NUMBER,
                 inuPrograma    IN NUMBER,
                                 inufila        IN NUMBER DEFAULT 0,
                                 inuFilaMax     IN NUMBER DEFAULT 0,
                                 onuerror       OUT  NUMBER,
                                 osberror       OUT VARCHAR2);
   /**************************************************************************
      Proceso     : proGeneraNotaUsuario
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2020-05-26
      Ticket      : 415
      Descripcion : genera notas de usuario comparto mi energia

      Parametros Entrada
        inuSusc      contrato
        inuprod      producto
        inucuenta    cuenta
        inufactura   factura
        inuperiodo   periodo de facturacion
        nupericon    periodo de consumo
        nuTariconc   tarifa por concepto
        inuConcGene  concepto a generar
        isbSigno     signo
        nuValorNota  valor de la nota
        inuUnidafact  unidades facturadas
        isbObservacion  observacion
    inuCausal     causal de cargo
    inuPrograma   programa de cargo y nota
        inufila  fila aprocesar
        inuFilaMax  numero de fila
      Parametros de salida
       onuerror  codigo de error 0 - exito -1 error
       osbError  mensaje de error

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
 FUNCTION   FNUGETVALIPERIFIDF(inuPeriodo IN NUMBER) return number;
 /**************************************************************************
  Proceso     : FNUGETVALIPERIFIDF
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-05-26
  Ticket      : 415
  Descripcion : funcion que valida si se muestra o no el fidf

  Parametros Entrada
    inuPeriodo  periodo
  Parametros de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/

PROCEDURE PRGENTRAMCANTT( inuProducto    IN   NUMBER,
                          inuMedioRecep  IN   NUMBER DEFAULT NULL,
                          isObservacion  IN   VARCHAR2,
                          inuCliente     IN   NUMBER,
                          idtFecha       IN   DATE,
                          OnuPackage_id  OUT   NUMBER,
                          onuError       OUT   NUMBER,
                          osbError      OUT   VARCHAR2 );
/**************************************************************************
  Proceso     : PRGENTRAMCANTT
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-05-26
  Ticket      : 415
  Descripcion : proceso que genera tramite de cancelacion por xml

  Parametros Entrada
    inuProducto      codigo del producto
    inuMedioRecep      medio de recepcion
    isObservacion   observacion
    inuCliente      Cliente
    idtFecha        fecha

  Parametros de salida

    onuerror codigo de error
    OSBERROR  mensaje de error
  OnuPackage_id solicitud creada
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/

PROCEDURE PRGENENOTARETI(inuproducto IN NUMBER);
/**************************************************************************
  Proceso     : PRGENENOTARETI
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-05-26
  Ticket      : 415
  Descripcion : proceso que genera notas de retiro de un producto con tarifa transitoria


  Parametros Entrada
    inuProducto   codigo del producto

  Parametros de salida


  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
PROCEDURE PRJOBCREAJUSTT;
/**************************************************************************
  Proceso     : PRJOBCREAJUSTT
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-07-06
  Ticket      : 415
  Descripcion : proceso que genera nota de ajuste a los usuarios


  Parametros Entrada

  Parametros de salida


  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
FUNCTION FNUGETDECAPACUM(  inuProducto    IN NUMBER,
                        inuperiodo    IN NUMBER,
                        inuConcepto   IN NUMBER,
                        inuDescCapMes IN NUMBER,
                        inupericons   IN NUMBER,
                        isbRango IN VARCHAR2,
                        isbIsRecu     IN VARCHAR2) RETURN NUMBER;
/**************************************************************************
  Proceso     : FNUGETDECAPACUM
  Autor       : Horbath
  Fecha       : 2021-02-15
  Ticket      : 635
  Descripcion : Funcion que devuelve descuento capital acumulado por concepto


  Parametros Entrada
    inuProducto     codigo del producto
  inuperiodo      codigo del periodo
  inuConcepto     concepto
  inuDescCapMes   descuento capital mes
  isbRango     rango
  inupericons   periodo de consumo
  isbIsRecu  ES RECUPERADO
  Parametros de salida


  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
FUNCTION FNUGETSALDINTMES(  inuDescCapAcumMes IN NUMBER) RETURN NUMBER;
/**************************************************************************
  Proceso     : FNUGETSALDINTMES
  Autor       : Horbath
  Fecha       : 2021-02-15
  Ticket      : 635
  Descripcion : Funcion que devuelve saldo de interes mes


  Parametros Entrada
  inuDescCapAcumMes   descuento capital acumulado
  Parametros de salida


  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/

 PROCEDURE setPorcInte( idtFecha IN DATE,  onuError OUT NUMBER, osberror OUT VARCHAR);
 /**************************************************************************
  Proceso     : setPorcInte
  Autor       : Horbath
  Fecha       : 2021-02-15
  Ticket      : 635
  Descripcion : SETEA TASA DE INTERES VIGENTE


  Parametros Entrada
    idtFecha fecha de consulta
  Parametros de salida
       onuError   codigo de error
   osberror   mensaje de error

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/

 FUNCTION getPorcInte RETURN NUMBER;
 /**************************************************************************
  Proceso     : getPorcInte
  Autor       : Horbath
  Fecha       : 2021-02-15
  Ticket      : 635
  Descripcion : RETORNA TASA DE INTERES VIGENTE


  Parametros Entrada

  Parametros de salida


  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/

FUNCTION FNUGETSALTOTACUM( inuSaldIntacum IN NUMBER,
               inuDescCapacum IN NUMBER) RETURN NUMBER;
/**************************************************************************
  Proceso     : FNUGETSALTOTACUM
  Autor       : Horbath
  Fecha       : 2021-02-15
  Ticket      : 635
  Descripcion : RETORNA SALDO TOTAL ACUMULADO


  Parametros Entrada
  inuSaldIntacum   saldo de interes acumulado
  inuDescCapacum   descuento capital acumulado
  Parametros de salida


  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/

 FUNCTION FNUGETSALDINTACUM(  inuProducto    IN NUMBER,
                inuperiodo    IN NUMBER,
                inuConcepto   IN NUMBER,
                inuDescIntMes IN NUMBER,
                inuSaldIntMes IN NUMBER,
                isbrango IN VARCHAR2,
                inupericons  IN NUMBER,
                isbIsRecu     IN VARCHAR2) RETURN NUMBER;
/**************************************************************************
  Proceso     : FNUGETSALDINTACUM
  Autor       : Horbath
  Fecha       : 2021-02-15
  Ticket      : 635
  Descripcion : Funcion que devuelve saldo de interes acumulado por concepto


  Parametros Entrada
    inuProducto     codigo del producto
  inuperiodo      codigo del periodo
  inuConcepto     concepto
  inuDescIntMes   descuento interes del mes
  inuSaldIntMes   saldo de interes del mes
  isbrango  rango de consumo
  inupericons  periodo de consumo
    isbIsRecu  ES RECUPERADO
  Parametros de salida


  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
 FUNCTION FNUGETDESCINTMES( inuProducto      IN NUMBER,
              inuperiodo       IN NUMBER,
              inuConcepto      IN NUMBER,
              inuDifeTari    IN NUMBER,
              inuMetros        IN NUMBER,
              isbrango         IN VARCHAR2,
              inupericons    in number,
              isbIsRecu     IN VARCHAR2) RETURN NUMBER;
 /**************************************************************************
  Proceso     : FNUGETDESCINTMES
  Autor       : Horbath
  Fecha       : 2021-02-15
  Ticket      : 635
  Descripcion : Funcion que devuelve descuento de interes del mes por concepto


  Parametros Entrada
    inuProducto     codigo del producto
  inuperiodo      codigo del periodo
  inuConcepto     concepto
  inuDifeTari      diferencia de tarifas
  inuMetros        metros cubicos
  isbrango         rango de consumos
  inupericons      periodo de consumo
    isbIsRecu  ES RECUPERADO
  Parametros de salida


  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/

 PROCEDURE PRACTUALLIQINT( inuProducto  IN NUMBER,
                            inuperiodo   IN NUMBER,
                            inuConcepto  IN NUMBER,
                            inuDifeTari  IN NUMBER,
                            inuMetros    IN NUMBER,
                            inuDescCapMes IN NUMBER,
                            isbRango     IN VARCHAR2,
                            inupericons  IN NUMBER,
                            isbIsRecu     IN VARCHAR2,
                            isbrowid      IN VARCHAR2,
                            inuTarifaCons IN NUMBER,
                            inuTarifaTran IN NUMBER,
                            onuerror     OUT NUMBER,
                            osbError     OUT VARCHAR);
 /**************************************************************************
  Proceso     : PRACTUALLIQINT
  Autor       : Horbath
  Fecha       : 2021-02-15
  Ticket      : 635
  Descripcion : proceso que actualiza informacion de interes de


  Parametros Entrada
    inuProducto      codigo del producto
    inuperiodo       codigo del periodo
    inuConcepto      concepto
    inuDifeTari      diferencia de tarifas
    inuMetros        metros cubicos
    isbrango         rango de consumos
    inuDescCapMes    descuento capital del mes
    inupericons      periodo de consumo
    isbrowid         ROWID
    inuTarifaCons    tarifa de consumo
    inuTarifaTran    tarifa transitoria
  Parametros de salida
    onuerror   codigo de error
  osbError  mensaje de error

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/

function fnuObtPerConsAnterior (inuperiodo lectelme.leempecs%type) return number;
  /**************************************************************************
  Proceso     : fnuObtPerConsAnterior
  Autor       : Horbath
  Fecha       : 2021-02-15
  Ticket      : 635
  Descripcion : obtener periodo de consumo anterior


  Parametros Entrada
    inuperiodo  periodo de consumo
  Parametros de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
 FUNCTION fnuGetPromAcum ( inuProducto  IN NUMBER,
                            inuperiodo   IN NUMBER,
                            inupericons  IN NUMBER,
                            inuConcepto  IN NUMBER,
                            isbRango     IN VARCHAR2,
                            inuTipo     IN NUMBER ) RETURN NUMBER ;
  /**************************************************************************
  Proceso     : fnuGetPromAcum
  Autor       : Horbath
  Fecha       : 2021-02-15
  Ticket      : 635
  Descripcion : funcion que devuelve el promedio acumulado


  Parametros Entrada
    inuProducto     codigo del producto
    inuperiodo      codigo del periodo
    inupericons     periodo de consumo
    inuConcepto     concepto
    isbrango        rango de consumos
    inuTipo       tipo de consulta 0 - consumo normal 2 - recuperado o faju

  Parametros de salida
    onuerror   codigo de error
  osbError  mensaje de error

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
PROCEDURE PRGENERETIAUTO;
  /**************************************************************************
  Proceso     : PRGENERETIAUTO
  Autor       : Horbath
  Fecha       : 2023-04-21
  Ticket      : OSF-1042
  Descripcion : job que se encarga de realizar retiro de tarifa transitoria


  Parametros Entrada

  Parametros de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
PROCEDURE GENPOSITIVEBAL( inucuenta IN NUMBER, 
                            inuconcepto IN NUMBER, 
                            inunota IN NUMBER);
  /**************************************************************************
  Proceso     : GENPOSITIVEBAL
  Autor       : Horbath
  Fecha       : 2023-04-21
  Ticket      : OSF-1042
  Descripcion : Procedimiento para generar saldo a favor


  Parametros Entrada
    inucuenta cuenta de cobro
    inuconcepto concepto que genera el saldo a favor
    inunota     nota asociada al cargo 
  Parametros de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/

END LDC_PKGESTIONTARITRAN;
/

create or replace PACKAGE BODY LDC_PKGESTIONTARITRAN
IS
  nuConcepto    NUMBER         := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CONCTATT', NULL);     --se almacena concepto de tarifa transitoria
  nuConcSub     NUMBER         := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CONSUBTRAS', NULL);   -- se almacena concepto de subsisdio transitorio
  nuConcContri  NUMBER         := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CONCONTRTRAS', NULL); -- se almacena concepto de contribucion transitorio
  nuPrograma    NUMBER         := dald_parameter.fnugetnumeric_value('LDC_PROGGECATT',NULL);    --se almacena programa que genera el cargo

  nuPorcSubAdi   NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_PORCSUBADI', NULL);
  nuConcSubAdctt NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CONSUBADITT', NULL); --se alamacena subsidio adicional transitorio

   --INICIO CA 635
   nuConcInteres  NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CONCINTTT', NULL);
   nuCausaInteres NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CAUSNOTDINTT', NULL);
   nuTasaInte     NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_TASAINTTT', NULL);
   nuValorTasa   NUMBER;
   --FIN CA 635

   --INICIO CA 501
 nuCausalSubAdi NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CACASUBADI', NULL);
 nuConcSubAdi   NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CONSUBADI', NULL);
 sbFechaInicSubAdic   VARCHAR2(40) := DALD_PARAMETER.fsbgetvalue_chain('LDC_FECHINSUAD', NULL);
 sbFechaFinSubAdic   VARCHAR2(40) := DALD_PARAMETER.fsbgetvalue_chain('LDC_FECHFINSUAD', NULL);

   CURSOR cuValidaIniSubAdic(inuPericose NUMBER) IS
    SELECT 'X'
    FROM OPEN.pericose p, OPEN.perifact pe
    WHERE p.pecscico = pe.pefacicl
     AND p.pecscons = inuPericose
     AND pe.pefafimo BETWEEN p.pecsfeci AND pecsfecf
     AND TRUNC(pefaffmo) BETWEEN to_date(sbFechaInicSubAdic ,'DD/MM/YYYY')
     AND to_date(sbFechaFinSubAdic ,'DD/MM/YYYY');


  sbprograma    VARCHAR2(400)  := 'CUSTOMER';
  gnucuenta     NUMBER         := -1;
  sbfrom        VARCHAR2(4000) := dald_parameter.fsbgetvalue_chain('LDC_SMTP_SENDER'); --  se coloca el emisor del correo
  sbfromdisplay VARCHAR2(4000) := 'Open SmartFlex';                                    -- Nombre del emisor
  -- Destinatarios
  sbto      VARCHAR2(4000) := dald_parameter.fsbgetvalue_chain('LDC_EMAILNOLE');
  sbsubject VARCHAR2(4000) := 'Proceso de Tarifa Transitoria';

  CURSOR cuValorTarifaVar(inuProducto IN NUMBER, inupefa IN NUMBER, inupericose IN NUMBER ) IS
   SELECT R.RAVTVALO,
		  v.VITCFEIN,
		  c.TACOCR01,
		  c.TACOCR02,
		  c.TACOCR03
	FROM OPEN.ta_rangvitc r,
		OPEN.rangliqu rl, OPEN.TA_VIGETACO v, open.ta_tariconc c
	WHERE r.ravtvitc = rl.raliidre
	 AND rl.RALIIDRE = v.VITCCONS
	 AND c.TACOCONS = v.VITCTACO
	 AND 21 between r.ravtliin and r.RAVTLISU
	 AND rl.ralisesu = inuProducto
	 AND rl.ralipefa =  inupefa
	 AND rl.ralipeco = inupericose
	 AND rl.RALIUNLI > 0
	 and rl.raliconc = 31 ;

	 regTarifaVar cuValorTarifaVar%rowtype;
	 regTarifaVarnull cuValorTarifaVar%rowtype;
	 nuDifereTari NUMBER := 0;
	 CURSOR cuValorTarifaVarTT( idtfechaIni DATE,
								isbCriterio1 IN VARCHAR,
								isbCriterio2 IN VARCHAR,
								isbCriterio3 IN VARCHAR) IS
   SELECT R.RAVTVALO
	FROM OPEN.ta_rangvitc r, OPEN.TA_VIGETACO v, open.ta_tariconc c, open.ta_conftaco
	WHERE r.ravtvitc =  v.VITCCONS
	 AND c.TACOCONS = v.VITCTACO
	 AND 21 between r.ravtliin and r.RAVTLISU
	 AND idtfechaIni between v.VITCFEIN and v.VITCFEFI
	 AND c.TACOCR01 = isbCriterio1
	 AND c.TACOCR02 = isbCriterio2
	 AND c.TACOCR03 = isbCriterio3
	 AND COTCCONC = nuConcepto
	 AND COTCCONS = C.TACOCOTC;


  PROCEDURE prinicializavarerror(
      onuError OUT NUMBER,
      osbError OUT VARCHAR2 )
  IS
  BEGIN
    onuError := 0;
    osbError := NULL;
  END prinicializavarerror;
  FUNCTION fnuObtenerTarifa(
      inuCate     IN NUMBER,
      inusuca     IN NUMBER,
      inuMere     IN NUMBER,
      idtFechaIni IN DATE,
      nuMetros    IN NUMBER,
      nuConcepto  IN NUMBER,
      isbIndex    IN VARCHAR2,
      onuTariCo OUT NUMBER,
      osbRango OUT VARCHAR2,
      onuError OUT NUMBER,
      osbError OUT VARCHAR2)
    RETURN NUMBER
  IS
    /**************************************************************************
    Proceso     : fnuObtenerTarifa
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-05-26
    Ticket      : 415
    Descripcion : obtiene tarifa de concepto de cuoata por pagar
    Parametros Entrada
    inuCate    categoria
    inusuca    subcategoria
    inuMere    mercarelevante
    idtFecha   fecha de cargo
    nuConcepto concepto a liquidar
    isbIndex   index
    Parametros de salida
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    nuTarifa NUMBER;
    --se obtiene tarifa
    CURSOR cuGetTarifa
    IS
      SELECT ravtliin
        || ' - '
        || ravtlisu rango,
        CASE
          WHEN NVL(ravtvalo,0) != 0
          THEN ravtvalo
          ELSE
            CASE
              WHEN NVL(vitcvalo,0) != 0
              THEN vitcvalo
              ELSE
                CASE
                  WHEN NVL(ravtporc,0) != 0
                  THEN ravtporc
                  ELSE vitcporc
                END
            END
        END VALOR ,
        A.TACOCONS TARIFA
      FROM open.ta_tariconc a
      LEFT OUTER JOIN open.ta_conftaco b
      ON (a.tacocotc = b.cotccons)
      LEFT OUTER JOIN open.ta_vigetaco d
      ON (d.vitctaco = a.tacocons)
      LEFT OUTER JOIN open.ta_rangvitc e
      ON (e.ravtvitc = d.vitccons)
      WHERE cotcconc = nuConcepto
      AND a.tacocr03 = inuMere
      AND a.tacocr02 = inuCate
      AND a.tacocr01 = inusuca
      AND nuMetros BETWEEN ravtliin AND ravtlisu
      AND TRUNC(idtFechaIni) BETWEEN d.vitcfein AND d.vitcfefi
    UNION ALL
    SELECT ravpliin
      || ' - '
      || ravplisu rango,
      CASE
        WHEN NVL(ravpvalo,0) != 0
        THEN ravpvalo
        ELSE
          CASE
            WHEN NVL(vitpvalo,0) != 0
            THEN vitpvalo
            ELSE
              CASE
                WHEN NVL(ravpporc,0) != 0
                THEN ravpporc
                ELSE vitpporc
              END
          END
      END ravpvalo,
      A.tacpcons
    FROM open.TA_TARICOPR a,
      open.TA_PROYTARI b,
      open.ta_vigetacp d,
      open.TA_RANGVITP e,
      open.ta_conftaco b1
    WHERE a.tacpprta = b.prtacons --
    AND d.vitptacp   = a.tacpcons
    AND e.ravpvitp   = d.vitpcons
    AND a.tacpcotc   = b1.cotccons
    AND cotcconc     = nuConcepto
    AND TRUNC(idtFechaIni) BETWEEN d.vitpfein AND d.vitpfefi
    AND b.prtaesta IN (2, 3)
    AND d.vitptipo  = 'B'
    AND a.tacpcr03  = inuMere
    AND a.tacpcr02  = inuCate
    AND a.tacpcr01  = inusuca
    AND nuMetros BETWEEN ravpliin AND ravplisu ;
    regTarifa cuGetTarifa%rowtype;
  BEGIN
    --inicializa variables de error
    prinicializavarerror(onuError, osbError );
    IF NOT vtbltarifas.EXISTS(isbIndex) THEN
      OPEN cuGetTarifa;
      FETCH cuGetTarifa INTO regTarifa;
      IF cuGetTarifa%NOTFOUND THEN
        onuError := -1;
        osbError := 'No existe configuracion de tarifa para el concepto ['||nuConcepto||']';
      ELSE
        vtbltarifas(isbIndex).nuCate    := inuCate;
        vtbltarifas(isbIndex).nusuca    := inusuca;
        vtbltarifas(isbIndex).nuMere    := inuMere;
        vtbltarifas(isbIndex).nutarifa  := regTarifa.VALOR;
        vtbltarifas(isbIndex).nutaricon := regTarifa.TARIFA;
        vtbltarifas(isbIndex).rango     := regTarifa.rango;
        nuTarifa                        := regTarifa.VALOR;
        onuTariCo                       := regTarifa.TARIFA;
        osbRango                        := regTarifa.rango;
      END IF;
      CLOSE cuGetTarifa;
    ELSE
      nuTarifa  := vtbltarifas(isbIndex).nutarifa;
      onuTariCo := vtbltarifas(isbIndex).nutaricon;
      osbRango  := vtbltarifas(isbIndex).rango;
    END IF;
    RETURN nuTarifa;
  EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    ERRORS.GETERROR(onuError,osbError );
    RETURN -1;
  WHEN OTHERS THEN
    ERRORS.seterror;
    ERRORS.GETERROR(onuError,osbError );
    RETURN -1;
  END fnuObtenerTarifa;
  PROCEDURE prActuaLogError(
      isbRowid IN VARCHAR2,
      isberror IN VARCHAR2)
  IS
    /**************************************************************************
    Proceso     : prActuaLogError
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-05-26
    Ticket      : 415
    Descripcion : genera log de error
    Parametros Entrada
    isbRowid  row id del registro
    isberror  error presentado
    Parametros de salida
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PRAGMA AUTONOMOUS_TRANSACTION;
    onuError NUMBER;
    osbError VARCHAR2(4000);
  BEGIN
    UPDATE LDC_PRODTATT SET PRTTERRO = isberror WHERE rowid = isbRowid;
    COMMIT;
  EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    ERRORS.GETERROR(onuError,osbError );
    UPDATE LDC_PRODTATT SET PRTTERRO = osbError WHERE rowid = isbRowid;
    COMMIT;
  WHEN OTHERS THEN
    ERRORS.seterror;
    ERRORS.GETERROR(onuError,osbError );
    UPDATE LDC_PRODTATT SET PRTTERRO = osbError WHERE rowid = isbRowid;
    COMMIT;
  END prActuaLogError;
  PROCEDURE prMarcaProdtariTran(
      inuProducto IN LDC_PRODTATT.PRTTSESU%TYPE,
      inuCiclo    IN LDC_PRODTATT.PRTTCICL%TYPE,
      sbRowid OUT VARCHAR2 )
  IS
    /**************************************************************************
    Proceso     : prMarcaProdtariTran
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-05-26
    Ticket      : 415
    Descripcion : genera marcacion de producto
    Parametros Entrada
    inuProducto  codigo del producto
    inuCiclo    ciclo
    Parametros de salida
    sbRowid  ROWID
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PRAGMA AUTONOMOUS_TRANSACTION;
    onuError NUMBER;
    osbError VARCHAR2(4000);

  CURSOR cuExiste IS
  SELECT ROWID
  FROM LDC_PRODTATT
  WHERE PRTTSESU = inuProducto;


  BEGIN


  OPEN cuExiste;
  FETCH cuExiste INTO sbRowid;
  IF cuExiste%NOTFOUND THEN
     INSERT  INTO LDC_PRODTATT
      (
        PRTTSESU,
        PRTTFEIN,
        PRTTACTI,
        PRTTCICL,
        PRTTERRO,
        PRTTGENO,
        PRTTDIFE
      )
      VALUES
      (
        inuProducto,
        SYSDATE,
        'S',
        inuCiclo,
        NULL,
        NULL,
        NULL
      )
    RETURNING rowid
    INTO sbRowid ;
  ELSE
    UPDATE LDC_PRODTATT SET PRTTACTI = 'S' WHERE PRTTSESU = inuProducto;
  END IF;
  CLOSE cuExiste;

    COMMIT;
  EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    ERRORS.GETERROR(onuError,osbError );
  WHEN OTHERS THEN
    ERRORS.seterror;
    ERRORS.GETERROR(onuError,osbError );
  END prMarcaProdtariTran;
  PROCEDURE prInsertLogError
    (
      inuProducto IN LDC_PRODTATT.PRTTSESU%TYPE,
      inuCiclo    IN LDC_PRODTATT.PRTTCICL%TYPE,
      isbError    IN LDC_PRODTATT.PRTTERRO%TYPE,
      nuValorDif  IN LDC_PRODTATT.PRTTDIFE%TYPE
    )
  IS
    /**************************************************************************
    Proceso     : prInsertLogError
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-05-26
    Ticket      : 415
    Descripcion : genera log de error
    Parametros Entrada
    inuProducto  codigo del producto
    inuCiclo    ciclo
    isbError    error
    nuValorDif  valor diferencia
    Parametros de salida
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PRAGMA AUTONOMOUS_TRANSACTION;
    onuError NUMBER;
    osbError VARCHAR2(4000);
  BEGIN
    INSERT
    INTO LDC_PRODTATT
      (
        PRTTSESU,
        PRTTFEIN,
        PRTTACTI,
        PRTTCICL,
        PRTTERRO,
        PRTTGENO,
        PRTTDIFE
      )
      VALUES
      (
        inuProducto,
        SYSDATE,
        'N',
        inuCiclo,
        isbError,
        'N',
        nuValorDif
      );
    COMMIT;
  EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    ERRORS.GETERROR(onuError,osbError );
  WHEN OTHERS THEN
    ERRORS.seterror;
    ERRORS.GETERROR(onuError,osbError );
  END prInsertLogError;

   PROCEDURE prInsertLogErrorSub
    (
      inuProducto IN   LDC_DEPRSUAD.DPSASESU%TYPE,
    inuContrato IN  LDC_DEPRSUAD.DPSACONT%TYPE,
    inuCuenta   IN  LDC_DEPRSUAD.DPSACUCO%TYPE,
    inuFactura  IN  LDC_DEPRSUAD.DPSAFACT%TYPE,
    inuPeriodo  IN  LDC_DEPRSUAD.DPSAPERI%TYPE,
    inupericons IN  LDC_DEPRSUAD.DPSAPECO%TYPE,
    inuNota    IN  LDC_DEPRSUAD.DPSANUME%TYPE,
    inuConcepto IN  LDC_DEPRSUAD.DPSACONC%TYPE,
    inuValoNota IN  LDC_DEPRSUAD.DPSAVANO%TYPE,
    isbSigno    IN  LDC_DEPRSUAD.DPSASIGN%TYPE,
    inuCausal   IN  LDC_DEPRSUAD.DPSACACA%TYPE,
    inuUnidad   IN  LDC_DEPRSUAD.DPSAUNID%TYPE,
      isbError    IN LDC_DEPRSUAD.DPSAERRO%TYPE
  )
  IS
    /**************************************************************************
   Proceso     : prInsertLogErrorSub
   Autor       : Luis Javier Lopez Barrios / Horbath
   Fecha       : 2020-05-26
   Ticket      : 501
   Descripcion : genera log de error subsidiado
     Parametros Entrada
    inuProducto  codigo del producto
    inuFactura   factura
    isbError     error

  Parametros de salida
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PRAGMA AUTONOMOUS_TRANSACTION;
    onuError NUMBER;
    osbError VARCHAR2(4000);
  BEGIN
    INSERT INTO LDC_DEPRSUAD
      (
        DPSASESU ,
    DPSACONT ,
    DPSAFERE ,
    DPSACUCO ,
    DPSAFACT ,
    DPSAPERI ,
    DPSAPECO ,
    DPSANUME ,
    DPSACONC ,
    DPSAVANO ,
    DPSASIGN ,
    DPSACACA ,
    DPSAUNID ,
    DPSAERRO    )
      VALUES
      (
        inuProducto,
    inuContrato,
    SYSDATE,
    inuCuenta,
        inuFactura,
    inuPeriodo,
    inupericons,
    inuNota,
    inuConcepto,
    inuValoNota,
    isbSigno,
    inuCausal,
    inuUnidad,
    isbError
        );
    COMMIT;
  EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    ERRORS.GETERROR(onuError,osbError );
  WHEN OTHERS THEN
    ERRORS.seterror;
    ERRORS.GETERROR(onuError,osbError );
  END prInsertLogErrorSub;

  FUNCTION fnuGetPromAcum ( inuProducto  IN NUMBER,
                            inuperiodo   IN NUMBER,
                            inupericons  IN NUMBER,
                            inuConcepto  IN NUMBER,
                            isbRango     IN VARCHAR2,
                            inuTipo     IN NUMBER ) RETURN NUMBER IS
  /**************************************************************************
  Proceso     : fnuGetPromAcum
  Autor       : Horbath
  Fecha       : 2021-02-15
  Ticket      : 635
  Descripcion : funcion que devuelve el promedio acumulado


  Parametros Entrada
    inuProducto     codigo del producto
    inuperiodo      codigo del periodo
    inupericons     periodo de consumo
    inuConcepto     concepto
    isbrango        rango de consumos
    inuTipo       tipo de consulta 0 - consumo normal 2 - recuperado o faju

  Parametros de salida
    onuerror   codigo de error
  osbError  mensaje de error

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  10/08/2022   LJLB       CA OSF-490 se quita validacion de promedio por rangos
***************************************************************************/
   nuPromedio NUMBER;
    CURSOR cugetvalorPromAcuAnt IS
    SELECT  DECODE(saldtotal, 0, 0, saldcap / saldtotal)
        FROM (
            SELECT DPTTPERI, DPTTPECO, nvl( sum(nvl(DPTTDCAC,0)), 0) saldcap,
              nvl( SUM(NVL(DPTTSTAC,0)),0) saldtotal
            FROM LDC_DEPRTATT
            WHERE DPTTSESU = inuProducto
             AND DPTTPECO <= fnuObtPerConsAnterior(inuperiodo)
             AND DPTTPERI <= open.pkbillingperiodmgr.fnugetperiodprevious(inuperiodo)
             AND DPTTCONC = inuConcepto
            -- AND DPTTRANG = isbrango
        group by DPTTPERI, DPTTPECO
        order by DPTTPERI desc, DPTTPECO desc)
        where rownum = 1;

     CURSOR cugetvalorPromAcuAntRec IS
    SELECT DECODE(saldtotal, 0, 0, saldcap / saldtotal)
    FROM (
        SELECT nvl( sum(nvl(DPTTDCAC,0)), 0) saldcap,
          nvl( SUM(NVL(DPTTSTAC,0)),0) saldtotal
        FROM LDC_DEPRTATT
        WHERE DPTTSESU = inuProducto
         AND DPTTCONC = inuConcepto
        -- AND DPTTRANG = isbrango
         AND DPTTPERI = inuperiodo
         AND DPTTPECO = inupericons);

    CURSOR cugetvalorPromAcuAntFaju IS
    SELECT DECODE(saldtotal, 0, 0, saldcap / saldtotal)
    FROM (
        SELECT nvl( sum(nvl(DPTTDCAC,0)), 0) saldcap,
          nvl( SUM(NVL(DPTTSTAC,0)),0) saldtotal
        FROM LDC_DEPRTATT
        WHERE DPTTSESU = inuProducto
         AND DPTTCONC = inuConcepto
        -- AND DPTTRANG = isbrango
         AND DPTTFERE   < SYSDATE - (5/24/60)
         AND DPTTPECO = inupericons);
  BEGIN

    IF inuTipo = 0 THEN
      OPEN cugetvalorPromAcuAnt;
      FETCH cugetvalorPromAcuAnt INTO nuPromedio;
      CLOSE cugetvalorPromAcuAnt;
    ELSIF inuTipo = 2 THEN
      OPEN cugetvalorPromAcuAntRec;
      FETCH cugetvalorPromAcuAntRec INTO nuPromedio;
      CLOSE cugetvalorPromAcuAntRec;
    ELSE
      OPEN cugetvalorPromAcuAntFaju;
      FETCH cugetvalorPromAcuAntFaju INTO nuPromedio;
      CLOSE cugetvalorPromAcuAntFaju;
    END IF;

    RETURN nuPromedio;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN nuPromedio;
  END fnuGetPromAcum;

  PROCEDURE proGeneraNota
    (
      inuSusc      IN NUMBER,
      inuprod      IN NUMBER,
      inucuenta    IN NUMBER,
      inufactura   IN NUMBER,
      inuUnidafact IN NUMBER,
      inutaricons  IN NUMBER,
      inutaritras  IN NUMBER,
      inuperiodo   IN NUMBER,
      nupericon    IN NUMBER,
      nuTariconc   IN NUMBER,
      inuConcGene  IN NUMBER,
      isbSigno     IN VARCHAR2,
      inuaccion    IN NUMBER,
      nuValorNota  IN OUT NUMBER,
      isbrango     IN VARCHAR2,
    inuDifetarCon IN NUMBER,
    nuaplicaSubadic IN number DEFAULT 0,
      OsbSigno OUT VARCHAR2,
      onuerror OUT NUMBER,
      osberror OUT VARCHAR2
    )
  IS
    /**************************************************************************
    Proceso     : proGeneraNota
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-05-26
    Ticket      : 415
    Descripcion : genera notas de proceso
    Parametros Entrada
    inuSusc      contrato
    inuprod      producto
    inucuenta    cuenta
    inufactura   factura
    inuUnidafact unidad facturadas
    inutaricons  tarifa normal
    inutaritras  tarifa transitoria
    inuperiodo   periodo de facturacion
    nupericon    periodo de consumo
    nuTariconc   tarifa por concepto
    inuConcGene  concepto a generar
    isbSigno     signo
    inuaccion    acciona ejecutar 1 - inserta nota 0 - simula valor de la nota
  nuaplicaSubadic indica si aplica subsidio adicional
    Parametros de salida
    onuerror  codigo de error 0 - exito -1 error
    osbError  mensaje de error
    nuValorNota  valor de la nota
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR          DESCRIPCION
     23/11/2020   LJLB          ca 608 se coloca indicador para generar subsidio adicional transitorio
     21/02/2021   HORBATH       CA 635 se ajusta liquidacion de nota cuando la tarita tt es mayor
	 22/07/2022   LJLB          CA OSF-449 se modifica proceso para no tener ne cuenta el promedio en el calculo del consumo
	 29/02/2024   jcatuchemvm   OSF-2308: Se elimina llamado PKBILLINGNOTEMGR.SETNOTENUMBERCREATED que genera concurrencia en consecutivos notas FAJU
    ***************************************************************************/
    inuConsDocu NUMBER;        --se almacena codigo de la nota
    isbDocSop   VARCHAR2(100); -- se almacena documento de soporte
    rcCargoNull cargos%rowtype;
    rcCargo cargos%rowtype;
    regNotas NOTAS%ROWTYPE;
    nuPrograma NUMBER := dald_parameter.fnugetnumeric_value('LDC_PROGGECATT',NULL); --se almacena programa que genera el cargo
    inuCausal  NUMBER := dald_parameter.fnugetnumeric_value('LDC_CAUSCARGTT',NULL); --se almacena causal de cargos
    inuvalor   NUMBER;
    sbTipoNota notas.NOTATINO%type;
    sbDoso notas.NOTADOSO%type;
    nuTipoDocu notas.NOTACONS%type;
    sbSigno          VARCHAR2(2);
    sbSignoAplicado  VARCHAR2(2);
    nuAjusteAplicado NUMBER;
  --INICIO CA 501
  nuValorSubAdictt NUMBER := 0;
  nuValNotaSubadic NUMBER := 0;
  sbaplica608 VARCHAR2(1) :='N';
  --nuConcSubAdctt

  --FIN CA 501
  --INICIO CA 635

  nuPromedio NUMBER;
  --FINC A 635
  BEGIN
    --inicializa variables de error
    prinicializavarerror(onuerror, osbError );
    sbTipoNota     := NULL;
    sbDoso         := NULL;
    nuTipoDocu     := NULL;
    OsbSigno       := NULL;
  nuValorSubAdictt := 0;
  nuValNotaSubadic := 0;
  IF FBLAPLICAENTREGAXCASO('0000608') THEN
      sbaplica608 := 'S';
    END IF;

    IF inuConcGene <> nuConcContri THEN

      IF FBLAPLICAENTREGAXCASO('0000501') or (nuaplicaSubadic = 1 AND sbaplica608 = 'S') THEN

         IF nuConcSub = inuConcGene THEN
            nuValorSubAdictt :=  (inuDifetarCon * ( nuPorcSubAdi / 100));
            nuValNotaSubadic := ABS(ROUND(nuValorSubAdictt * inuUnidafact,0));
            inuvalor     := (inutaricons - inutaritras ) ;
            nuValorNota  := ABS(ROUND(inuvalor * inuUnidafact,0));
          ELSE
            inuvalor     := inutaricons        - inutaritras;
            nuValorNota  := ABS(ROUND(inuvalor * inuUnidafact,0));
          END IF;
      ELSE
        /* OSF-449 se quia funcionalidad
    		IF FBLAPLICAENTREGAXCASO('0000635') AND inutaricons < inutaritras AND inuConcGene  = nuconcepto THEN
            nuPromedio := fnuGetPromAcum (inuprod,
                                          inuperiodo,
                                          nupericon,
                                          inuConcGene,
                                          isbrango,
                                          inuaccion);
             inuvalor := inutaricons   - inutaritras;
             nuValorNota  := ABS( ROUND(inuvalor * inuUnidafact * nuPromedio,0));

        ELSE*/
              inuvalor     := inutaricons        - inutaritras;
              nuValorNota  := ABS(ROUND(inuvalor * inuUnidafact,0));
        --END IF;

      END IF;
    ELSE
      inuvalor    := inutaricons;
      nuValorNota := ABS(ROUND(nuValorNota * (inuvalor /100) ,0));
      --  DBMS_OUTPUT.PUT_LINE('nuValorNota '||nuValorNota ||' TARIFA '||inuvalor||' inuConcGene '||inuConcGene);
    END IF;
    IF inuvalor   > 0 AND isbSigno = 'DB' THEN
      sbTipoNota := 'C';
      nuTipoDocu := 71;
      sbDoso     :='NC_';
      OsbSigno   := 'CR';
      -- nuValorNota := round(inuvalor * inuUnidafact,0) ;
    ELSIF inuvalor > 0 AND isbSigno = 'CR' THEN
      sbTipoNota  := 'D';
      nuTipoDocu  := 70;
      sbDoso      :='ND_';
      OsbSigno    := 'DB';
      --    nuValorNota := round(inuvalor * -1 * inuUnidafact,0) ;
    ELSIF inuvalor < 0 AND isbSigno = 'CR' THEN
      sbTipoNota  := 'C';
      nuTipoDocu  := 71;
      sbDoso      :='NC_';
      OsbSigno    := 'CR';
      --  nuValorNota := round(inuvalor * inuUnidafact,0) ;
    ELSIF inuvalor < 0 AND isbSigno = 'DB' THEN
      sbTipoNota  := 'D';
      nuTipoDocu  := 70;
      sbDoso      :='ND_';
      OsbSigno    := 'DB';
      --  nuValorNota := round(inuvalor * -1 * inuUnidafact,0) ;
      /*  ELSE
      onuerror := -1;
      osberror := 'Para el periododo ['||inuperiodo||'], la diferencia entre las tarifas para el producto es cero';
      return;*/
    END IF;
    --si accion indica generar nota o simular valores
    IF inuaccion = 1 THEN
      --si el valor de la nota es mayor a cero se crea
      PKBILLINGNOTEMGR.GETNEWNOTENUMBER(inuConsDocu);
      UT_TRACE.TRACE( 'CONSECUTIVO DE LA NOTA '||inuConsDocu||' CONTRATO '||inuSusc , 10 );
      regNotas.NOTANUME := inuConsDocu ;
      regNotas.NOTASUSC := inuSusc ;
      regNotas.NOTAFACT := inufactura ;
      regNotas.NOTATINO := sbTipoNota ;
      regNotas.NOTAFECO := SYSDATE ;
      regNotas.NOTAFECR := SYSDATE ;
      regNotas.NOTAPROG := nuPrograma ;
      regNotas.NOTAUSUA := 1 ;
      regNotas.NOTATERM := NVL(userenv('TERMINAL'),'DESCO');
      regNotas.NOTACONS := nuTipoDocu;
      regNotas.NOTANUFI := NULL;
      regNotas.NOTAPREF := NULL;
      regNotas.NOTACONF := NULL;
      regNotas.NOTAIDPR := NULL;
      regNotas.NOTACOAE := NULL;
      regNotas.NOTAFEEC := NULL;
      regNotas.NOTAOBSE := 'GENERACION DE NOTA POR PROCESO DE TARIFA TRANSITORIA' ;
      regNotas.NOTADOCU := NULL ;
      regNotas.NOTADOSO := sbDoso || inuConsDocu ;
      PKTBLNOTAS.INSRECORD(regNotas);
      UT_TRACE.TRACE( 'CREANDO CARGOS, CONTRATO '||inuSusc , 10 );
      rcCargo          := rcCargoNull ;
      rcCargo.cargcuco := inucuenta;
      rcCargo.cargnuse := inuprod ;
      rcCargo.cargpefa := inuperiodo ;
      rcCargo.cargconc := inuConcGene ;
      rcCargo.cargcaca := inuCausal;
      rcCargo.cargsign := OsbSigno ;
      rcCargo.cargvalo := nuValorNota ;
      rcCargo.cargdoso := sbDoso||inuConsDocu; -- isbDocumento ;  DEBE SER DF-NRODIFERIDO o ND-NRONOTA?
      rcCargo.cargtipr := 'P';
      rcCargo.cargfecr := SYSDATE ;
      rcCargo.cargcodo := inuConsDocu; --  DEBE SER  numero de la nota
      rcCargo.cargunid := inuUnidafact ;
      rcCargo.cargcoll := NULL ;
      rcCargo.cargpeco := nupericon ;
      rcCargo.cargprog := nuPrograma; --
      rcCargo.cargusua := 1;
      rcCargo.cargtaco := nuTariconc;
      -- Adiciona el Cargo
      pktblCargos.InsRecord (rcCargo);
      UT_TRACE.TRACE( 'TERMINO DE CREAR CARGO ', 10 );
      -- Ajusta la Cuenta
      PKUPDACCORECEIV.UPDACCOREC ( PKBILLCONST.CNUSUMA_CARGO, inucuenta, inuSusc, inuprod, inuConcGene, sbSigno, nuValorNota, pkBillConst.cnuUPDATE_DB );
      --setear programa
      pkErrors.SetApplication(sbprograma);

    IF OsbSigno = 'CR' THEN
      -- Genera saldo a favor
        GenPositiveBal( inucuenta, inuConcGene, inuConsDocu );
    END IF;
    END IF;
    IF inuaccion <> 1 AND inuConcGene IS NOT NULL THEN
      --se inserta detalle del proceso
      INSERT
      INTO LDC_DEPRTATT
        (
          DPTTSESU,
          DPTTCONT,
          DPTTFERE,
          DPTTCUCO,
          DPTTFACT,
          DPTTPERI,
          DPTTNUME,
          DPTTCONC,
          DPTTVANO,
          DPTTCACA,
          DPTTTACO,
          DPTTTATT,
          DPTTDIFE,
          DPTTUNID,
          DPTTPECO,
          DPTTSIGN,
          DPTTTAPL,
          DPTTRANG
        )
        VALUES
        (
          inuprod,
          inuSusc,
          SYSDATE,
          inucuenta,
          inufactura,
          inuperiodo,
          inuConsDocu,
          inuConcGene,
          nuValorNota,
          inuCausal,
          inutaricons,
          inutaritras,
          inuvalor,
          inuUnidafact,
          nupericon,
          OsbSigno,
          nuTariconc,
          isbrango
        );

    IF nuValNotaSubadic > 0 THEN
        --se inserta detalle del proceso
      INSERT   INTO LDC_DEPRTATT
      (
        DPTTSESU,
        DPTTCONT,
        DPTTFERE,
        DPTTCUCO,
        DPTTFACT,
        DPTTPERI,
        DPTTNUME,
        DPTTCONC,
        DPTTVANO,
        DPTTCACA,
        DPTTTACO,
        DPTTTATT,
        DPTTDIFE,
        DPTTUNID,
        DPTTPECO,
        DPTTSIGN,
        DPTTTAPL,
        DPTTRANG
      )
      VALUES
      (
        inuprod,
        inuSusc,
        SYSDATE,
        inucuenta,
        inufactura,
        inuperiodo,
        inuConsDocu,
        nuConcSubAdctt,
        nuValNotaSubadic,
        inuCausal,
        inuDifetarCon,
        nuValorSubAdictt,
        nuValorSubAdictt,
        inuUnidafact,
        nupericon,
        OsbSigno,
        NULL,
        isbrango
      );

    END IF;
    END IF;
  EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    ERRORS.geterror(onuerror,osbError);
  WHEN OTHERS THEN
    ERRORS.SETERROR;
    ERRORS.geterror(onuerror,osbError);
  END proGeneraNota;

  PROCEDURE proGeneraNotaSubAdic( inuSusc      IN NUMBER,
                  inuprod      IN NUMBER,
                  inucuenta    IN NUMBER,
                  inufactura   IN NUMBER,
                  inuUnidafact IN NUMBER,
                  inuperiodo   IN NUMBER,
                  nupericon    IN NUMBER,
                  isbSigno     IN VARCHAR2,
                  isbrango     IN VARCHAR2,
                  inuDifetarCon IN NUMBER,
                                  inuDifeTarSub IN NUMBER,
                  onuerror OUT NUMBER,
                       osberror OUT VARCHAR2) IS
    --INICIO CA 501
  nuValorSubAdictt NUMBER := 0;
  nuValNotaSubadic NUMBER := 0;
  --nuConcSubAdctt
    inuCausal  NUMBER := dald_parameter.fnugetnumeric_value('LDC_CAUSCARGTT',NULL); --se almacena causal de cargos
    OsbSigno varchar2(4);
  --FIN CA 501

   BEGIN
      nuValorSubAdictt :=  (inuDifetarCon * ( nuPorcSubAdi / 100));
    nuValNotaSubadic := ABS(ROUND(nuValorSubAdictt * inuUnidafact,0));

  IF inuDifeTarSub   > 0 AND isbSigno = 'DB' THEN
      OsbSigno   := 'CR';
    ELSIF inuDifeTarSub > 0 AND isbSigno = 'CR' THEN
      OsbSigno    := 'DB';
    ELSIF inuDifeTarSub < 0 AND isbSigno = 'CR' THEN
      OsbSigno    := 'CR';
    ELSIF inuDifeTarSub < 0 AND isbSigno = 'DB' THEN
      OsbSigno    := 'DB';
    END IF;

    IF nuValNotaSubadic > 0 THEN
        --se inserta detalle del proceso
      INSERT   INTO LDC_DEPRTATT
      (
        DPTTSESU,
        DPTTCONT,
        DPTTFERE,
        DPTTCUCO,
        DPTTFACT,
        DPTTPERI,
        DPTTNUME,
        DPTTCONC,
        DPTTVANO,
        DPTTCACA,
        DPTTTACO,
        DPTTTATT,
        DPTTDIFE,
        DPTTUNID,
        DPTTPECO,
        DPTTSIGN,
        DPTTTAPL,
        DPTTRANG
      )
      VALUES
      (
        inuprod,
        inuSusc,
        SYSDATE,
        inucuenta,
        inufactura,
        inuperiodo,
        null,
        nuConcSubAdctt,
        nuValNotaSubadic,
        inuCausal,
        inuDifetarCon,
        nuValorSubAdictt,
        nuValorSubAdictt,
        inuUnidafact,
        nupericon,
        OsbSigno,
        NULL,
        isbrango
      );

    END IF;

   EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
    ERRORS.geterror(onuerror,osbError);
    WHEN OTHERS THEN
    ERRORS.SETERROR;
    ERRORS.geterror(onuerror,osbError);
  END proGeneraNotaSubAdic;

  PROCEDURE prGeneraProcNotas
    (
      regTarifa    IN regTarifaCon,
      inuSusc      IN factura.factsusc%type,
      inuProducto  IN cuencobr.cuconuse%TYPE,
      inuCuenta    IN cuencobr.cucocodi%TYPE,
      inufactura   IN cuencobr.cucofact%TYPE,
      inuConcepto  IN NUMBER,
      inuUnidad    IN NUMBER,
      inuTariNor   IN NUMBER,
      inuPerifact  IN cargos.CARGPEFA%type,
      inuPeriCons  IN cargos.cargpeco%type,
      isbSigno     IN cargos.cargsign%type,
      inuTariconc  IN OUT NUMBER,
      inuIndice    IN NUMBER,
      inuaccion    IN NUMBER,
      OnuValorNota IN OUT NUMBER,
      inuGenDife IN NUMBER DEFAULT 0,
    onuDifetar   IN OUT NUMBER,
     nuaplicaSubadic IN number DEFAULT 0,
      OsbSigno OUT VARCHAR,
      onuerror OUT NUMBER,
      osbError OUT VARCHAR2
    )
  IS
    /**************************************************************************
    Proceso     : prGeneraProcNotas
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-05-26
    Ticket      : 415
    Descripcion : genera notas de proceso
    Parametros Entrada
    regTarifa   registro de tarifa
    inuConcepto   concepto
    inuUnidad     unidad
    inuTariconc   tarifa concepto
    inuIndice     indice
    inuSusc       contrato
    inuProducto   producto
    inuCuenta     cuenta
    inufactura    factura
    inuConcepto   concepto
    inuUnidad     unidades liquidada
    inuTariNor    valor tarifa normal
    inuPerifact   periodo de facturaciom
    inuPeriCons   periodo de consumo
    isbSigno      signo
    inuaccion     accion a ejecutar
  nuaplicaSubadic indica si aplica subsidio adicional
    Parametros de salida
    onuerror  codigo de error 0 - exito -1 error
    osbError  mensaje de error
   onuDifetar   diferencia de tarifas
    OnuValorNota  valor de la nota
    OsbSigno signo aplicado
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  23/11/2020   LJLB         CA 608 se coloca indicador para procesar subsidio adicional
    ***************************************************************************/
    nutarifa    NUMBER;
    nuIndicador NUMBER;
    sbrango     VARCHAR2(400);
    sbIndex     VARCHAR2(4000);
  BEGIN
    --inicializa variables de error
    prinicializavarerror(onuerror, osbError );
    nutarifa       := NULL;
    nuIndicador    := NULL;
    IF inuConcepto <> nuConcContri THEN
      -- DBMS_OUTPUT.PUT_LINE('obtener tarifa '||inuConcepto||regTarifa.cate||' '|| regTarifa.suca||' '||regTarifa.mere);
      IF regTarifa.rangini = 0 THEN
        nuIndicador       := 0;
      ELSE
        nuIndicador := 1;
      END IF;
      sbIndex := inuIndice||inuConcepto||nuIndicador||TO_CHAR(regTarifa.fecha_inicial,'ddmmyyyy');
      --se obtiene tarifa de concepto
      nutarifa := fnuObtenerTarifa(regTarifa.cate, regTarifa.suca, regTarifa.mere, regTarifa.fecha_inicial, regTarifa.rangini, --inuUnidad,
      inuConcepto, sbIndex,                                                                                                    --inuIndice||inuConcepto||nuIndicador||,
      inuTariconc, sbrango, onuerror, osbError );
    ELSE
      nutarifa := inuTariNor;
      -- DBMS_OUTPUT.PUT_LINE('obtener tarifa '||inuConcepto||regTarifa.cate||' '|| regTarifa.suca||' '||regTarifa.mere);
      sbrango := ' 0 - 999999';
    END IF;
    IF onuerror   = 0 THEN
      onuerror   := 0;
      osbError   := NULL;
      IF nutarifa = 0 THEN
        onuerror := -1;
        osbError := 'la tarifa configurada debe ser mayor que cero';
        RETURN;
      ELSE
        if inuGenDife = 0 then
           onuDifetar := 0;
        end if;
      --se genera la nota
        proGeneraNota( inuSusc, inuProducto, inuCuenta, inufactura, inuUnidad, inuTariNor, nutarifa, inuPerifact, inuPeriCons, inuTariconc, inuConcepto, isbSigno, inuaccion, OnuValorNota, sbrango, onuDifetar, nuaplicaSubadic, OsbSigno, onuerror, osberror);
        onuDifetar := inuTariNor - nutarifa;
    END IF;
    END IF;
  EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    ERRORS.geterror(onuerror,osbError);
  WHEN OTHERS THEN
    ERRORS.SETERROR;
    ERRORS.geterror(onuerror,osbError);
  END ;
  PROCEDURE PRJOBGENENOTATT
  IS
    /**************************************************************************
    Proceso     : PRJOBGENENOTATT
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-05-26
    Ticket      : 415
    Descripcion : genera nota a productos marcados LDC_PRODTATT
    Parametros Entrada
    inuProducto    Codigo de producto
    Parametros de salida
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    18/08/2020   LJLB         CA 501 se adiciona proceso para realizar nuevo subsidio
    23/11/2020   LJLB         CA 608 se coloca indicador para ejecutar subsidio adicional en recuperado
    15/02/2021   LJLB         CA 635  se quita filtro de programa 5 para la consulta de cargos, se coloca
                            ajuste para calcular interes
	06/07/2021   LJLB         CA 794 se filtra los mercados configurados en el parametro LDC_PAMERCVALI
	01/04/2022    LJLB        CA OSF-57 -se coloca bloque de excepcion para que no se genere error si hay problema de correo
    06/05/2022    LJLB      CA OSF-159 - se arregla problema que se tiene con los recuperados que se generan doble y el problema de la contrapartida para
                            los recuperados de mas de 5  meses
    ***************************************************************************/
    --variabe para estaproc
    nuparano       NUMBER;
    nuparmes       NUMBER;
    nutsess        NUMBER;
    sbparuser      VARCHAR2(400);
    nuerror        NUMBER;
    SBERROR        VARCHAR2(4000);
    sbmsg          VARCHAR2(4000);
    sbLiquConsAct  VARCHAR2(1)   := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_LIQMEAJU', NULL); --se almacena si se liquida consumo actual
    sbcategoria    VARCHAR2(100) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_COCAPROC', NULL); --se almacena categoria a procesar
    sbestrato      VARCHAR2(100) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_COESPROC', NULL); --se almacena estratos a procesar
    sbestratoMarc  VARCHAR2(100) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_COESMAOB', NULL); --se almacena estratos 1 y 2  a procesar obligatoriamente
    sbFechaMaxVin  VARCHAR2(100) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_FECHMAVI', NULL); --Se alamacena fecha maxima de vincualcion
    nuUnidades     NUMBER;
    nutariCons     NUMBER;
    dtFechaIni     DATE;
    dtFechaFin     DATE;
    nuTariconc     NUMBER;
    nupericon      NUMBER;
    nuvaloTariCont NUMBER;
    nuValorDif LDC_PRODTATT.PRTTDIFE%TYPE;
    limit_in     NUMBER := 100;
    nutarifa     NUMBER;
    onuvalornota NUMBER;
    sbConfirma   VARCHAR2(1);
    sbIdReg      VARCHAR2(4000);
    sbSigno      VARCHAR2(2);

  sbFlagUsuNu VARCHAR2(1) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_FLAGINGUSNU', NULL);

  --INICIO CA 794
	sbMercaRele VARCHAR2(100) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_PAMERCVALI', NULL);
	sbaplicaEntrega794 VARCHAR2(1);

	--FIN CA 794

    --periodos a procesar
    CURSOR cuperiodoProc
    IS
      SELECT ROWID ID_REG,
        PEGPPERI,
        PEGPCICL
      FROM LDC_PEFAGEPTT
      WHERE PEGPESTA = 'N'
      AND PEGPPROC   = 'FGCC'
    ;
  TYPE tblPeriodos
IS
  TABLE OF cuperiodoProc%ROWTYPE INDEX BY VARCHAR2(40);
  vtblPeriodos tblPeriodos;
  --se consulta cuentas a procesar
  CURSOR cugetCuentas(nuPeriodo NUMBER)
  IS
    SELECT cucocodi CUCOCODI,
      cuconuse CUCONUSE,
      cucofact CUCOFACT,
      cucocate CUCOCATE,
      cucosuca CUCOSUCA,
      mercado MERCADO,
      ID_REG,
      factsusc,
      CUCOCATE
      ||cucosuca
      ||MERCADO indice,
      ACTIVO
    FROM
      (SELECT
        /*+ index( cu IDXCUCO_RELA)
        index( f IX_FACTURA04)
        index( s IDX_CONCPRODMAR)*/
        cu.cucocodi,
        cu.cuconuse,
        cu.cucofact,
        cucocate,
        cucosuca,
        factsusc,
        S.ROWID ID_REG,
        (SELECT m.lomrmeco
        FROM pr_product p,
          ab_address A,
          fa_locamere m
        WHERE p.product_id        = cu.cuconuse
        AND A.geograp_location_id = m.lomrloid
        AND A.address_id          = P.address_id
        ) MERCADO,
      'S' ACTIVO
    FROM cuencobr cu,
      factura f,
      LDC_PRODTATT s
    WHERE f.factpefa = nuPeriodo
    AND f.factcodi   = cu.cucofact
    AND f.factprog   = 6
    AND s.PRTTSESU   = cu.cuconuse
    AND S.PRTTACTI   = 'S'
   -- AND f.factcodi = 2067720205
    AND NOT EXISTS
      (SELECT 1 FROM LDC_DEPRTATT WHERE DPTTFACT = cu.cucofact
      )
    /* AND EXISTS ( SELECT 1
    FROM CARGOS CA
    WHERE CA.CARGCUCO = CU.CUCOCODI
    AND CA.CARGCONC = 31
    AND CA.CARGCACA = 15)*/
    UNION ALL
    SELECT
      /*+ index( cu IDXCUCO_RELA)
      index( f IX_FACTURA04)
      */
      cu.cucocodi,
      cu.cuconuse,
      cu.cucofact,
      cucocate,
      cucosuca,
      factsusc,
      NULL ID_REG,
      (SELECT m.lomrmeco
      FROM pr_product p,
        ab_address A,
        fa_locamere m
      WHERE p.product_id        = cu.cuconuse
      AND A.geograp_location_id = m.lomrloid
      AND A.address_id          = P.address_id
      ) MERCADO,
      'N' ACTIVO
    FROM cuencobr cu,
      factura f,
      SERVSUSC s
    WHERE f.factpefa = nuPeriodo
    AND f.factcodi   = cu.cucofact
    AND f.factprog   = 6
  and 'S' = sbFlagUsuNu
    AND s.SESUNUSE   = cu.cuconuse
    AND s.sesufein  <= (
      CASE
        WHEN sbFechaMaxVin IS NULL
        THEN sysdate
        ELSE to_date(sbFechaMaxVin,'dd/mm/yyyy')
      END)
    AND NOT EXISTS
      (SELECT 1 FROM LDC_PRODTATT WHERE PRTTSESU = S.SESUNUSE and PRTTACTI   = 'S'
      )
    AND s.sesucate  = 1
    AND s.sesusuca IN
      (SELECT to_number(regexp_substr(sbestratoMarc,'[^,]+', 1, LEVEL)) AS ESTRATO
      FROM dual
        CONNECT BY regexp_substr(sbestratoMarc, '[^,]+', 1, LEVEL) IS NOT NULL
      )
      )
	  	--INICIO CA 794
	WHERE sbaplicaEntrega794 = 'S' AND
	  mercado IN ( SELECT to_number(regexp_substr(sbMercaRele,'[^,]+', 1, LEVEL)) AS mercado
		      	  FROM dual
				  CONNECT BY regexp_substr(sbMercaRele, '[^,]+', 1, LEVEL) IS NOT NULL
						)
		--FIN CA 794
    ORDER BY CUCOCATE
      ||cucosuca
      ||MERCADO;
  TYPE tblProductos
IS
  TABLE OF cugetCuentas%ROWTYPE;
  vtblProductos tblProductos;
  --se consulta cuentas a procesar
  CURSOR cugetCuentasCalcularNota(nuPeriodo NUMBER, inuciclo NUMBER)
  IS
    SELECT cucocodi CUCOCODI,
      cuconuse CUCONUSE,
      cucofact CUCOFACT,
      cucocate CUCOCATE,
      cucosuca CUCOSUCA,
      mercado MERCADO,
      factsusc,
      CUCOCATE
      ||cucosuca
      ||MERCADO indice
    FROM
      (SELECT
        /*+ index( cu IDXCUCO_RELA)
        index( f IX_FACTURA04)
        */
        cu.cucocodi,
        cu.cuconuse,
        cu.cucofact,
        cucocate,
        cucosuca,
        factsusc,
        (SELECT m.lomrmeco
        FROM pr_product p,
          ab_address A,
          fa_locamere m
        WHERE p.product_id        = cu.cuconuse
        AND A.geograp_location_id = m.lomrloid
        AND A.address_id          = P.address_id
        ) MERCADO
    FROM cuencobr cu,
      factura f,
      servsusc s
    WHERE f.factpefa = nuPeriodo
    AND f.factcodi   = cu.cucofact
    AND f.factprog   = 6
    AND s.sesunuse   = cu.cuconuse
    AND s.sesuserv   = 7014
  --AND s.sesunuse = 27000565
    AND s.sesucate  IN
      (SELECT to_number(regexp_substr(sbcategoria,'[^,]+', 1, LEVEL)) AS estacort
      FROM dual
        CONNECT BY regexp_substr(sbcategoria, '[^,]+', 1, LEVEL) IS NOT NULL
      )
    AND s.sesusuca IN
      (SELECT to_number(regexp_substr(sbestrato,'[^,]+', 1, LEVEL)) AS ESTRATO
      FROM dual
        CONNECT BY regexp_substr(sbestrato, '[^,]+', 1, LEVEL) IS NOT NULL
      )
    AND NOT EXISTS
      ( SELECT 1 FROM LDC_PRODTATT pr WHERE pr.PRTTSESU = cu.cuconuse
      )
      /* AND EXISTS ( SELECT 1
      FROM CARGOS CA
      WHERE CA.CARGCUCO = CU.CUCOCODI
      AND CA.CARGCONC = 31
      AND CA.CARGCACA = 15)*/
      )
    ORDER BY CUCOCATE
      ||cucosuca
      ||MERCADO;
  TYPE tblProdNoMar
IS
  TABLE OF cugetCuentasCalcularNota%ROWTYPE;
  vtblProdNoMar tblProdNoMar;
  --se consulta consumo actual
  CURSOR cuGetCargosConsActu (inucuenta NUMBER, inunuse NUMBER)
  IS
    SELECT cargpeco,
      cargconc,
      cargtaco,
      cargpefa,
      cargunid,
      cargsign
    FROM cargos
    WHERE cargcuco = inucuenta
    AND cargnuse   = inunuse
    AND cargconc   = 31
    AND cargcaca   = 15
  --  AND cargprog   = 5
    AND upper(cargdoso) NOT LIKE 'CO-PR%';
  regCargosAct cuGetCargosConsActu%rowtype;
  regCargosActnull cuGetCargosConsActu%rowtype;
  OsbSigno VARCHAR2(2);
  --se consulta conceptos recuperados
  CURSOR cuGetCargosConsRecu (inucuenta NUMBER, inunuse NUMBER)
  IS
    SELECT cargnuse,
      cargpeco,
      cargconc,
      cargtaco,
      cargpefa,
      cargunid,
      cargsign
    FROM cargos c1
    WHERE cargcuco = inucuenta
    AND cargnuse   = inunuse
      --AND cargconc = 31
    AND cargcaca = 15
   -- AND cargprog = 5
    --INICIO OSF - 159
	 AND 0 <> (SELECT NVL(SUM(decode(c.cargsign, 'CR',-c.cargvalo, c.cargvalo)),0)
			 FROM open.cargos c
			 WHERE c.cargcuco = c1.cargcuco
			   AND c.cargnuse   = c1.cargnuse
			   AND C.CARGCONC = c1.CARGCONC
			   AND C.CARGSIGN in ('DB', 'CR')
			   AND c.cargcaca = 15
			   AND c.cargdoso = c1.cargdoso  )
	--FIN OSF - 159
    AND upper(cargdoso) LIKE '%-PR%'
    ORDER BY cargnuse,
      cargpeco,
      cargconc;
  regCargosRecu cuGetCargosConsRecu%rowtype;
  regCargosRecunull cuGetCargosConsRecu%rowtype;
  nuPeriConAnte NUMBER := -1;
  nuPeriCoNAct  NUMBER;
  --se consulta consumo liquidado
  CURSOR cuGetLiquProd(inuNuse NUMBER, inuPericons NUMBER, inuconc NUMBER, inuperifact NUMBER)
  IS
    SELECT *
    FROM open.LDC_DEPRTATT
    WHERE DPTTSESU = inuNuse    --nunuse
    AND DPTTPECO   = inuPericons--nupericons
      -- AND DPTTFERE < SYSDATE - (5/24/60)
    AND DPTTPERI <> inuperifact
    AND DPTTCONC  = DECODE(inuconc, 31, nuConcepto, 196, nuConcSub, 37, nuConcContri);
  regLiquiProd cuGetLiquProd%rowtype;
  regLiquiProdnull cuGetLiquProd%rowtype;
  --se consulta consumo liquidado
  CURSOR cuGetLiquProdRang1(inuNuse NUMBER, inuPericons NUMBER, inuperifact NUMBER)
  IS
    SELECT *
    FROM open.LDC_DEPRTATT
    WHERE DPTTSESU = inuNuse    --nunuse
    AND DPTTPECO   = inuPericons--nupericons
      -- AND DPTTFERE < SYSDATE - (5/24/60)
    AND DPTTPERI <> inuperifact
    AND DPTTCONC  = nuConcepto
    AND DPTTRANG LIKE '0 -%';
  regLiquProdRang1 cuGetLiquProdRang1%rowtype;
  regLiquProdRang1null cuGetLiquProdRang1%rowtype;
  --se consulta consumo liquidado
  CURSOR cuGetLiquProdRang2(inuNuse NUMBER, inuPericons NUMBER, inuperifact NUMBER)
  IS
    SELECT *
    FROM open.LDC_DEPRTATT
    WHERE DPTTSESU = inuNuse    --nunuse
    AND DPTTPECO   = inuPericons--nupericons
      -- AND DPTTFERE < SYSDATE - (5/24/60)
    AND DPTTPERI <> inuperifact
    AND DPTTCONC  = nuConcepto
    AND DPTTRANG LIKE '21 -%';
  regLiquProdRang2 cuGetLiquProdRang2%rowtype;
  regLiquProdRang2null cuGetLiquProdRang2%rowtype;
  --se consulta contribucion
  CURSOR cuGetCargosContri (inucuenta NUMBER, inunuse NUMBER)
  IS
    SELECT cargpeco,
      cargconc,
      cargtaco,
      cargpefa,
      cargunid,
      cargsign
    FROM cargos
    WHERE cargcuco = inucuenta
    AND cargnuse   = inunuse
    AND cargconc   = 37
    AND cargcaca   = 15
   -- AND cargprog   = 5
    AND upper(cargdoso) NOT LIKE 'CN-PR%';
  CURSOR cuGetInfotarifaCont( nuTariCon NUMBER, nuConcepto NUMBER, dtFecha DATE )
  IS
    SELECT *
    FROM
      (SELECT
        CASE
          WHEN NVL(ravtvalo,0) != 0
          THEN ravtvalo
          ELSE
            CASE
              WHEN NVL(vitcvalo,0) != 0
              THEN vitcvalo
              ELSE
                CASE
                  WHEN NVL(ravtporc,0) != 0
                  THEN ravtporc
                  ELSE vitcporc
                END
            END
        END valor
      FROM OPEN.ta_tariconc A
      LEFT JOIN OPEN.ta_vigetaco d
      ON (d.vitctaco = A.tacocons)
      LEFT JOIN OPEN.ta_rangvitc e
      ON (e.ravtvitc = d.vitccons)
      LEFT OUTER JOIN OPEN.ta_conftaco b
      ON (A.tacocotc   = b.cotccons)
      WHERE a.tacocons = nuTariCon
      AND b.COTCCONC   = nuConcepto
      AND dtFecha BETWEEN d.vitcfein AND d.vitcfefi
    UNION ALL
    SELECT
      CASE
        WHEN NVL(ravpvalo,0) != 0
        THEN ravpvalo
        ELSE
          CASE
            WHEN NVL(vitpvalo,0) != 0
            THEN vitpvalo
            ELSE
              CASE
                WHEN NVL(ravpporc,0) != 0
                THEN ravpporc
                ELSE vitpporc
              END
          END
      END ravpvalo
    FROM OPEN.ta_taricopr A,
      OPEN.ta_proytari b,
      OPEN.ta_vigetacp d,
      OPEN.ta_rangvitp e,
      OPEN.ta_conftaco b1
    WHERE A.tacpcons = nuTariCon
    AND A.tacpprta   = b.prtacons --
    AND d.vitptacp   = A.tacpcons
    AND e.ravpvitp   = d.vitpcons
    AND A.tacpcotc   = b1.cotccons
    AND cotcconc     = nuConcepto
    AND b.prtaesta  IN (2, 3)
    AND d.vitptipo   = 'B'
    AND dtFecha BETWEEN d.vitpfein AND d.vitpfefi
      );
    regCargosContri cuGetCargosContri%rowtype;
    regCargosContrinull cuGetCargosContri%rowtype;
    --rango liquidados del consumo
    CURSOR cuValorConsumo(inuNuse NUMBER, InuPeriActu NUMBER, inupericose NUMBER)
    IS
      SELECT  RALIIDRE IDTARIFA, RALILIIR rango_inicial,
        RALILISR RANGO_FINAL,
        RALIUNLI UNIDAD_LIQUIDA,
        RALIVAUL VALOR_UNIDAD,
        RALIVASU VALOR_SUBSIDIO,
        RALIVALO TARIFA_VALOR
      FROM RANGLIQU
      WHERE RALISESU = inuNuse
      AND RALIPEFA   = InuPeriActu
      AND RALICONC   = 31
      AND ralipeco   = inupericose
      AND RALIUNLI   > 0;
    CURSOR cuValorConsumosUB(inuNuse NUMBER, InuPeriActu NUMBER, inupericose NUMBER)
    IS
      SELECT RALIIDRE IDTARIFA, RALILIIR rango_inicial,
        RALILISR RANGO_FINAL,
        RALIUNLI UNIDAD_LIQUIDA,
        RALIVAUL VALOR_UNIDAD,
        RALIVASU/RALIUNLI VALOR_SUBSIDIO,
        RALIVALO TARIFA_VALOR
      FROM RANGLIQU
      WHERE RALISESU      = inuNuse
      AND RALIPEFA        = InuPeriActu
      AND RALICONC        = 31
      AND NVL(RALIVASU,0) > 0
      AND ralipeco        = inupericose
      AND RALIUNLI        > 0;
    CURSOR cuCalValorNota(inuproducto NUMBER, inufactura NUMBER, inupericose number)
    IS
      SELECT d.*,
        ROWNUM fila,
        MAX(ROWNUM) OVER (PARTITION BY '1') maxrownum
      FROM
       (SELECT *
    FROM (SELECT DPTTPERI,
          DPTTPECO,
          DPTTTAPL,
          DPTTCONC,
          round(SUM(DECODE(DPTTSIGN, 'CR', -DPTTVANO, DPTTVANO )),0) VALOR,
          SUM(DPTTUNID) UNIDAD
        FROM LDC_DEPRTATT
        WHERE DPTTSESU = inuproducto
        AND DPTTFACT   = inufactura
		AND dpttpeco = inupericose
        GROUP BY DPTTPERI,
          DPTTPECO,
          DPTTTAPL,
          DPTTCONC
        )
    WHERE VALOR <> 0
  order by valor desc) d;
    CURSOR cuCalValorNotaRecu(inuproducto NUMBER, inuPeriodo NUMBER, nuPeriFact NUMBER)
    IS
      SELECT d.*,
        ROWNUM fila,
        MAX(ROWNUM) OVER (PARTITION BY '1') maxrownum
      FROM
      ( SELECT *
        FROM   (SELECT DPTTPERI,
          DPTTPECO,
          DPTTTAPL,
          DPTTCONC,
          DPTTCONT,
          DPTTCUCO,
          DPTTFACT,
          round(SUM(DECODE(DPTTSIGN, 'CR', -DPTTVANO, DPTTVANO )),0) VALOR,
          SUM(DPTTUNID) UNIDAD
        FROM LDC_DEPRTATT
        WHERE DPTTSESU = inuproducto
        AND DPTTPECO   = inuPeriodo
        AND DPTTPERI   = nuPeriFact
        AND DPTTFERE BETWEEN SYSDATE - (5/24/60) AND SYSDATE
        GROUP BY DPTTPERI,
          DPTTPECO,
          DPTTTAPL,
          DPTTCONC,
          DPTTCONT,
          DPTTCUCO,
          DPTTFACT)
    WHERE VALOR <> 0
  order by valor desc) d;
    sbIndex       VARCHAR2(400);
    sbRowId       VARCHAR2(4000);
    sbSignoAplica VARCHAR2(2);
    sbAplicaca440 VARCHAR2(1) := 'N';
   -- nuUnidLigRag1 NUMBER;
    nuUnidLigRag2 NUMBER;
    nuDifer       NUMBER;
    sbAumenta     VARCHAR2(1);
    sbrango       VARCHAR2(400);
  nuErrorProd   NUMBER := 0;



  --se consultan facturas no inscritas a tarifa transitoria
  CURSOR cuGetFacturaSubAdic(nuPeriodo NUMBER) IS
   SELECT cucocodi CUCOCODI,
      cuconuse CUCONUSE,
      cucofact CUCOFACT,
      cucocate CUCOCATE,
      cucosuca CUCOSUCA,
      mercado MERCADO,
      factsusc,
      CUCOCATE
      ||cucosuca
      ||MERCADO indice
    FROM
      (SELECT
      /*+ index( cu IDXCUCO_RELA)
        index( f IX_FACTURA04)
      */
      cu.cucocodi,
      cu.cuconuse,
      cu.cucofact,
      cucocate,
      cucosuca,
      factsusc,
      (SELECT m.lomrmeco
      FROM pr_product p,
        ab_address A,
        fa_locamere m
      WHERE p.product_id        = cu.cuconuse
      AND A.geograp_location_id = m.lomrloid
      AND A.address_id          = P.address_id
      ) MERCADO
    FROM cuencobr cu,
      factura f,
      servsusc s
    WHERE f.factpefa = nuPeriodo
    AND f.factcodi   = cu.cucofact
    AND f.factprog   = 6
    AND s.sesunuse   = cu.cuconuse
    AND s.sesuserv   = 7014
    AND s.sesucate  = 1
  --AND s.sesunuse = 27000565
    AND s.sesusuca IN
      ( SELECT to_number(regexp_substr(sbestratoMarc,'[^,]+', 1, LEVEL)) AS ESTRATO
       FROM dual
        CONNECT BY regexp_substr(sbestratoMarc, '[^,]+', 1, LEVEL) IS NOT NULL
            )
    AND NOT EXISTS
      ( SELECT 1 FROM LDC_DEPRSUAD pr WHERE pr.DPSAFACT = cu.cucofact  )
    )

    ORDER BY CUCOCATE
      ||cucosuca
      ||MERCADO;

  TYPE tblProdSubadic IS  TABLE OF cuGetFacturaSubAdic%ROWTYPE;
  vtblProdSubadic tblProdSubadic;



  CURSOR cugetSubSidioAdi(inufactura number) IS
  SELECT dpttperi peri_fact,
       dpttpeco peri_consumo,
           sum(round(dptttatt  * dpttunid))* (nuPorcSubAdi/100) valor ,
           sum(dpttunid) unidades
  FROM OPEN.ldc_deprtatt
  WHERE dpttfact = inufactura
    AND dpttrang = '0 - 20'
    AND dpttconc = nuConcepto
  GROUP BY dpttperi, dpttpeco;

  sbAplicaso501 VARCHAR2(1) := 'N';
  nuDifetari NUMBER;
   nuApliDescAdic NUMBER;
   sbExistSubAdic VARCHAR2(1);

  CURSOR cuExisteSubadic(inuFactura NUMBER, inuPeriodo NUMBER, inuPericons NUMBER) IS
 SELECT 'X'
 FROM OPEN.LDC_DEPRSUAD
 WHERE DPSAFACT = inuFactura
-- AND DPSAPERI = inuPeriodo
  AND DPSAPECO = inuPericons
  AND DPSACONC = nuConcSubAdi;

  --se consultan facturas no inscritas a tarifa transitoria para recuperadp
  CURSOR cuGetFacturaSubAdicRecu(nuPeriodo NUMBER) IS
   SELECT cucocodi CUCOCODI,
      cuconuse CUCONUSE,
      cucofact CUCOFACT,
      cucocate CUCOCATE,
      cucosuca CUCOSUCA,
      mercado MERCADO,
      factsusc,
      CUCOCATE
      ||cucosuca
      ||MERCADO indice
    FROM
      (SELECT
      /*+ index( cu IDXCUCO_RELA)
        index( f IX_FACTURA04)
      */
      cu.cucocodi,
      cu.cuconuse,
      cu.cucofact,
      cucocate,
      cucosuca,
      factsusc,
      (SELECT m.lomrmeco
      FROM pr_product p,
        ab_address A,
        fa_locamere m
      WHERE p.product_id        = cu.cuconuse
      AND A.geograp_location_id = m.lomrloid
      AND A.address_id          = P.address_id
      ) MERCADO
    FROM cuencobr cu,
      factura f,
      servsusc s
    WHERE f.factpefa = nuPeriodo
    AND f.factcodi   = cu.cucofact
    AND f.factprog   = 6
    AND s.sesunuse   = cu.cuconuse
    AND s.sesuserv   = 7014
    AND s.sesucate  = 1
  --AND s.sesunuse = 27000565
    AND s.sesusuca IN
      ( SELECT to_number(regexp_substr(sbestratoMarc,'[^,]+', 1, LEVEL)) AS ESTRATO
       FROM dual
        CONNECT BY regexp_substr(sbestratoMarc, '[^,]+', 1, LEVEL) IS NOT NULL
            )
    AND NOT EXISTS
      ( SELECT 1 FROM LDC_PRODTATT pr WHERE pr.prttsesu = cu.cuconuse AND pr.prttacti = 'S'  )
    )

    ORDER BY CUCOCATE
      ||cucosuca
      ||MERCADO;

      TYPE tblProduSubAdicRec IS  TABLE OF cuGetFacturaSubAdicRecu%ROWTYPE;
      vtblProduSubAdicRec tblProduSubAdicRec;

     --se consulta conceptos recuperados subsidio adic
  CURSOR cuGetCargosConsRecuAdic (inucuenta NUMBER, inunuse NUMBER)
  IS
    SELECT cargnuse,
      cargpeco,
      cargconc,
      cargtaco,
      cargpefa,
      cargunid,
      cargsign
    FROM cargos
    WHERE cargcuco = inucuenta
    AND cargnuse   = inunuse
    AND cargconc = 31
    AND cargcaca = 15
  --  AND cargprog = 5
    AND upper(cargdoso) LIKE '%-PR%'
    ORDER BY cargnuse,
      cargpeco,
      cargconc;
  regCargosRecuAdic cuGetCargosConsRecuAdic%rowtype;
  regCargosRecuAdicnull cuGetCargosConsRecuAdic%rowtype;
   nuLiquMet2 number;
   nuUnidLigRag1 number;

      CURSOR cuExisteSubadicSub(inuproducto NUMBER, inuPericons NUMBER) IS
 SELECT DPSAUNID
 FROM oPEN.LDC_DEPRSUAD
 where DPSASESU = inuproducto
  and DPSAPECO =inuPericons
  AND DPSACONC = nuConcSubAdi;

  nuUnidadSub NUMBER;

  --rango liquidados del consumo
  CURSOR cuValorConsumorang2(inuNuse NUMBER/*, InuPeriActu NUMBER*/, inupericose NUMBER)
  IS
    SELECT RALIUNLI UNIDAD_LIQUIDA
    FROM RANGLIQU
    WHERE RALISESU = inuNuse
    --AND RALIPEFA   = InuPeriActu
    AND RALICONC   = 31
    AND ralipeco   = inupericose
    AND RALIUNLI   > 0
    AND RALILIIR > 0 ;
  --  nuUnidLigRag1 number;
    sbExisteadic VARCHAR2(1);
  nuTarifaConsumo number;
  nuDifetariSub number;
sbaplica608 VARCHAR2(1) := 'N';
  --FIN CA 501

  --INICIO CA 635
  sbAplicaca635 VARCHAR2(1) := 'N';
  nuPromedio NUMBER;
  nuValorNota NUMBER;

  CURSOR cuCalValorNotaInte(inuproducto NUMBER, inufactura NUMBER, inupericose number)
    IS
    with tarifas as
        (
         SELECT dpttdife diferencia, d1.dptttaco tarifa_consumo, d1.dptttatt tarifa_transitoria
         FROM OPEN.ldc_deprtatt d1
         WHERE d1.dpttsesu = inuproducto
          AND d1.dpttfact = inufactura
          AND d1.dpttconc = nuConcepto
          AND INSTR(d1.dpttrang,'21 - ') > 0

        )
      SELECT ROWID id_reg,
             dpttperi perifact,
             decode(dpttsign,'CR', -1, 1) signo,
             dpttpeco pericons,
             dptttapl tarifa,
             dpttconc concepto,
			  dptttatt tari_trans,
             decode(dpttrang,'0 - 20', nvl(( SELECT tarifa_consumo
                                            FROM tarifas
                                            WHERE ROWNUM < 2),0),dptttaco ) tarifa_consumo,
             decode(dpttrang,'0 - 20', nvl(( SELECT tarifa_transitoria
                                           FROM tarifas
                                           WHERE ROWNUM < 2),0),dptttatt ) tarifa_transitoria,
             decode(dpttrang,'0 - 20', nvl(( SELECT diferencia
                                             FROM tarifas
                                             WHERE ROWNUM < 2),0),dpttdife ) diferencia,
              nvl(dpttunid,0) metros,
              dpttrang rango
          FROM OPEN.ldc_deprtatt d
          WHERE dpttsesu = inuproducto
              AND dpttfact   = inufactura
              AND dpttconc = nuConcepto
			  and dpttpeco = inupericose;

  CURSOR cuCalValorNotaInteAgru(inuproducto NUMBER, inufactura NUMBER, inupericose number)
    IS
      SELECT d.*,
        ROWNUM fila,
        MAX(ROWNUM) OVER (PARTITION BY '1') maxrownum
      FROM
       (SELECT *
    FROM (SELECT DPTTPERI,
           DPTTPECO,
           nuConcInteres DPTTCONC,
           round(SUM( nvl(DPTTSIME,0) + nvl(DPTTDIME,0)),0) VALOR
        FROM LDC_DEPRTATT
        WHERE DPTTSESU = inuproducto
        AND DPTTFACT   = inufactura
        and DPTTCONC = nuConcepto
		 and dpttpeco = inupericose
        GROUP BY DPTTPERI,
          DPTTPECO
        )
    WHERE VALOR <> 0
  order by valor desc) d;

-- valores de interes recuperado
  CURSOR cuCalValorNotaInteRecu(inuproducto NUMBER, inuPeriodo NUMBER, nuPeriFact NUMBER) IS
  with tarifas as
    (
     SELECT dpttdife diferencia, d1.dptttaco tarifa_consumo, d1.dptttatt tarifa_transitoria
     FROM OPEN.ldc_deprtatt d1
     WHERE d1.dpttsesu = inuproducto
      AND DPTTPECO   = inuPeriodo
      AND DPTTPERI   = nuPeriFact
      AND DPTTFERE BETWEEN SYSDATE - (5/24/60) AND SYSDATE
      AND d1.dpttconc = NUCONCEPTO
      AND INSTR(d1.dpttrang,'21 - ') > 0

    )
  SELECT ROWID id_reg,
         dpttperi perifact,
         decode(dpttsign,'CR', -1, 1) signo,
         dpttpeco pericons,
         dptttapl tarifa,
         dpttconc concepto,
		 dptttatt tari_trans,
         decode(dpttrang,'0 - 20', nvl(( SELECT tarifa_consumo
                                        FROM tarifas
                                        WHERE ROWNUM < 2),0),dptttaco ) tarifa_consumo,
         decode(dpttrang,'0 - 20', nvl(( SELECT tarifa_transitoria
                                       FROM tarifas
                                       WHERE ROWNUM < 2),0),dptttatt ) tarifa_transitoria,
         decode(dpttrang,'0 - 20', nvl(( SELECT diferencia
                                         FROM tarifas
                                         WHERE ROWNUM < 2),0),dpttdife ) diferencia,
          nvl(dpttunid,0) metros,
          dpttrang rango
      FROM OPEN.ldc_deprtatt d
      WHERE dpttsesu = inuproducto
        AND DPTTPECO   = inuPeriodo
        AND DPTTPERI   = nuPeriFact
        AND DPTTFERE BETWEEN SYSDATE - (5/24/60) AND SYSDATE
        AND dpttconc = NUCONCEPTO  ;

  CURSOR cuCalValorNotaInteAgruRecu(inuproducto NUMBER, inuPeriodo NUMBER, nuPeriFact NUMBER)
    IS
      SELECT d.*,
        ROWNUM fila,
        MAX(ROWNUM) OVER (PARTITION BY '1') maxrownum
      FROM
       (SELECT *
    FROM (SELECT DPTTPERI,
           DPTTPECO,
           nuConcInteres DPTTCONC,
           round(SUM( nvl(DPTTSIME,0) + nvl(DPTTDIME,0)),0) VALOR
        FROM LDC_DEPRTATT
        WHERE  DPTTSESU = inuproducto
        AND DPTTPECO   = inuPeriodo
        AND DPTTPERI   = nuPeriFact
    and DPTTCONC = nuConcepto
        AND DPTTFERE BETWEEN SYSDATE - (5/24/60) AND SYSDATE
        GROUP BY DPTTPERI,
          DPTTPECO
        )
    WHERE VALOR <> 0
  order by valor desc) d;




	 nuValorTariVariTT NUMBER;
	 dtFechaInitar DATE;

     dtFechaInic DATE;
     nuProdAnte NUMBER := -1;
     nuValorTariConsumo number;

  --FIN CA 635
    --INICIO CA OSF-57
  sbentregaOSF57 VARCHAR2(1) := 'N';

  --FIN CA OSF-57

    --Setea las variables
    PROCEDURE setvariables
    IS
    BEGIN
      nuUnidades       := NULL;
      nutariCons       := NULL;
      dtFechaIni       := NULL;
      dtFechaFin       := NULL;
      nuerror          := NULL;
      sbError          := NULL;
      nutarifa         := NULL;
      nupericon        := NULL;
      regCargosAct     := regCargosActnull;
      vregTarifaCon    := vregTarifaConnull;
      vregTarifaContri := vregTarifaConnull;
      regCargosContri  := regCargosContriNULL;
      onuvalornota     := NULL;
      nuvaloTariCont   := NULL;
      sbConfirma       := 'N';
      nuValorDif       := 0;
      sbRowId          := NULL;
      sbmsg            := NULL;
      sbSignoAplica    := NULL;
	  nuErrorProd     := 0;
	  nuDifetari := 0;
	  nuApliDescAdic := 0;
	  sbExistSubAdic := NULL;
	  nuTarifaConsumo := null;
	  sbExisteadic  := null;
	  nuDifetariSub := 0;
	  dtFechaInitar := NULL;
	  nuValorTariVariTT := 0;
    nuValorTariConsumo := 0;
	  regTarifaVar := regTarifaVarnull;
    nuDifereTari := 0;
    END setvariables;
  BEGIN
    -- Consultamos datos para inicializar el proceso
    SELECT to_number(TO_CHAR(SYSDATE,'YYYY')) ,
      to_number(TO_CHAR(SYSDATE,'MM')) ,
      userenv('SESSIONID') ,
      USER
    INTO nuparano,
      nuparmes,
      nutsess,
      sbparuser
    FROM dual;
    IF FBLAPLICAENTREGAXCASO('0000440') THEN
      sbAplicaca440 := 'S';
    END IF;

  IF FBLAPLICAENTREGAXCASO('0000608') THEN
      sbaplica608 := 'S';
    END IF;

  IF FBLAPLICAENTREGAXCASO('0000501') THEN
    sbAplicaso501 := 'S';
  END IF;
  --INICIO CA 635
  IF FBLAPLICAENTREGAXCASO('0000635') THEN
    sbAplicaca635 := 'S';
  END IF;
  --FIN CA 635

	    --INICIO CA OSF-57
  IF FBLAPLICAENTREGAXCASO('OSF-57') THEN
    sbentregaOSF57 := 'S';
  END IF;
  --FIN CA OSF-57
  --INICIO CA 794
	IF FBLAPLICAENTREGAXCASO('0000794') THEN
      sbaplicaEntrega794 := 'S';
    ELSE
	  sbaplicaEntrega794 := 'N';
	END IF;
	--FIN CA 794

    IF FBLAPLICAENTREGAXCASO('0000415') THEN
      --setear programa
      pkErrors.SetApplication(sbprograma);
      vtblPeriodos.DELETE;
      -- Inicializamos el proceso
      ldc_proinsertaestaprog(nuparano,nuparmes,'PRJOBGENENOTATT','En ejecucion',nutsess,sbparuser);
      --INIICO CA 635
      /*IF sbAplicaca635 = 'S' THEN
          setPorcInte( SYSDATE, nuerror, sbError );
      IF nuerror <> -1 THEN
        ERRORS.SETERROR(2741, sbError);
      END IF;
    END IF;*/
      --FIN CA 635
      FOR reg IN cuperiodoProc
      LOOP
        --se coloca registro en procesando
        UPDATE LDC_PEFAGEPTT
        SET PEGPESTA = 'P'
        WHERE ROWID  = reg.ID_REG;
        COMMIT;
        IF NOT vtblPeriodos.EXISTS(reg.PEGPPERI) THEN
          vtblPeriodos(reg.PEGPPERI).ID_REG   := reg.ID_REG;
          vtblPeriodos(reg.PEGPPERI).PEGPPERI := reg.PEGPPERI;
          vtblPeriodos(reg.PEGPPERI).PEGPCICL := reg.PEGPCICL;
        END IF;
      END LOOP;
      IF vtblPeriodos.COUNT > 0 THEN
        sbIndex            := vtblPeriodos.FIRST;
        LOOP
          EXIT
        WHEN sbIndex IS NULL;
          sbIdReg    := vtblPeriodos(sbIndex).ID_REG;


       IF sbAplicaso501 = 'S' THEN
        --se realiza proceso de subsidio adicional
        OPEN cuGetFacturaSubAdic(vtblPeriodos(sbIndex).PEGPPERI);
        LOOP
        FETCH cuGetFacturaSubAdic BULK COLLECT INTO vtblProdSubadic LIMIT limit_in;
         FOR idx IN 1..vtblProdSubadic.COUNT LOOP
             --se cosnultan cargos actuales
           OPEN cuGetCargosConsActu(vtblProdSubadic(idx).cucocodi, vtblProdSubadic(idx).cuconuse);
           FETCH cuGetCargosConsActu INTO regCargosAct;
           CLOSE cuGetCargosConsActu;
            --DBMS_OUTPUT.PUT_LINE('cuGetCargosConsActu '||regCargosAct.cargunid);
           IF NVL(regCargosAct.cargunid,0) > 0 THEN
             FOR indRang IN cuValorConsumo(vtblProdSubadic(idx).CUCONUSE, regCargosAct.CARGPEFA, regCargosAct.CARGPECO) LOOP
                IF indRang.rango_inicial = 0 THEN
                 nuerror := 0;
                sbError := NULL;
                proGeneraNotaUsuario( vtblProdSubadic(idx).factsusc,
                      vtblProdSubadic(idx).CUCONUSE,
                      vtblProdSubadic(idx).CUCOcodi,
                      vtblProdSubadic(idx).CUCOfact,
                      indRang.UNIDAD_LIQUIDA,
                      regCargosAct.CARGPEFA,
                      regCargosAct.CARGPECO,
                      NULL,
                      nuConcSubAdi,
                      'CR',
                      round(indRang.VALOR_UNIDAD * (nuPorcSubAdi/100),0),
                      'NOTA GENERADA POR PROCESO DE SUNSIDIO ADICIONAL',
                      nuCausalSubAdi,
                      nuPrograma,
                      1,
                      1,
                      nuerror,
                      sbError);
                IF nuerror <> 0 THEN
                   prInsertLogErrorSub( vtblProdSubadic(idx).CUCONUSE,
                      vtblProdSubadic(idx).factsusc,
                      vtblProdSubadic(idx).CUCOcodi,
                      vtblProdSubadic(idx).CUCOfact,
                      regCargosAct.CARGPEFA,
                       regCargosAct.CARGPECO,
                      null,
                      nuConcSubAdi,
                      round(indRang.VALOR_UNIDAD * (nuPorcSubAdi/100),0),
                      'CR',
                      nuCausalSubAdi,
                      indRang.UNIDAD_LIQUIDA,
                      sbError
                      );
                   ROLLBACK;
                ELSE
                   prInsertLogErrorSub( vtblProdSubadic(idx).CUCONUSE,
                      vtblProdSubadic(idx).factsusc,
                      vtblProdSubadic(idx).CUCOcodi,
                      vtblProdSubadic(idx).CUCOfact,
                      regCargosAct.CARGPEFA,
                        regCargosAct.CARGPECO,
                      null,
                      nuConcSubAdi,
                      round(indRang.VALOR_UNIDAD * (nuPorcSubAdi/100),0),
                      'CR',
                      nuCausalSubAdi,
                      indRang.UNIDAD_LIQUIDA,
                      sbError
                      );
                   COMMIT;
              END IF;
             END IF;
          END LOOP;
          END IF;
         END LOOP;
          EXIT   WHEN cuGetFacturaSubAdic%NOTFOUND;
        END LOOP;
        CLOSE cuGetFacturaSubAdic;
      END IF;


      IF sbaplica608 = 'S' THEN
       --se realiza proceso de subsidio adicional recuperado
        OPEN cuGetFacturaSubAdicRecu(vtblPeriodos(sbIndex).PEGPPERI);
        LOOP
        FETCH cuGetFacturaSubAdicRecu BULK COLLECT INTO vtblProduSubAdicRec LIMIT limit_in;
         FOR idx IN 1..vtblProduSubAdicRec.COUNT LOOP
          FOR reg IN cuGetCargosConsRecuAdic(vtblProduSubAdicRec(idx).cucocodi, vtblProduSubAdicRec(idx).cuconuse) LOOP

            nuerror       := NULL;
            sberror       := NULL;
            nuLiquMet2    := 0;
            nuDifer := 0;
            sbAumenta := null;
            nuUnidades := 0;
            nuUnidLigRag1 := 0;
            nuUnidadSub := null;
            sbExisteadic := null;

            IF REG.cargsign    = 'CR' AND reg.cargconc = 31 THEN
             sbAumenta       := 'N';
             nuUnidades      := -1 * reg.cargunid;
            ELSIF REG.cargsign = 'DB' AND reg.cargconc = 31 THEN
              sbAumenta       := 'S';
              nuUnidades      := reg.cargunid;
             END IF;

             IF cuExisteSubadicSub%ISOPEN THEN
              CLOSE cuExisteSubadicSub;
             END IF;

              IF cuValidaIniSubAdic%ISOPEN THEN
              CLOSE cuValidaIniSubAdic;
             END IF;

             OPEN cuExisteSubadicSub(REG.CARGNUSE, REG.CARGPECO);
             FETCH cuExisteSubadicSub INTO nuUnidadSub;
             CLOSE cuExisteSubadicSub;

             OPEN cuValidaIniSubAdic(reg.cargpeco);
             FETCH cuValidaIniSubAdic INTO sbExisteadic;
             CLOSE cuValidaIniSubAdic;

             IF nuUnidadSub > 0 OR sbExisteadic IS NOT NULL THEN
              nuDifer             := 20 - NVL(nuUnidadSub,0) ;
              IF sbAumenta         = 'S' THEN
                 IF nuDifer         > 0 THEN
                  IF nuUnidades    > nuDifer THEN
                  nuUnidades    := nuUnidades - nuDifer;
                  nuUnidLigRag1 := nuDifer;
                  ELSE
                  nuUnidLigRag1 := nuUnidades;
                  nuUnidades    := 0;
                  END IF;
                 END IF;
              ELSE
                 IF cuValorConsumorang2%ISOPEN THEN
                CLOSE cuValorConsumorang2;
                 END IF;
                 OPEN cuValorConsumorang2(REG.cargnuse, REG.cargpeco);
                 FETCH cuValorConsumorang2 INTO nuLiquMet2;
                 CLOSE cuValorConsumorang2;

                 IF ABS(nuUnidades) > NVL(nuLiquMet2,0) THEN
                  nuUnidades      := nuUnidades + NVL(nuLiquMet2,0);
                  --nuUnidLigRag2   := regLiquProdRang2.DPTTUNID;
                  nuUnidLigRag1 := ABS(nuUnidades);
                ELSE
                  --  nuUnidLigRag2 := ABS(nuUnidades);
                  nuUnidades    := 0;
                  nuUnidLigRag1 := 0;
                END IF;
              END IF;

               IF nuUnidLigRag1 > 0 THEN
                FOR indRang IN cuValorConsumo(vtblProduSubAdicRec(idx).CUCONUSE, reg.CARGPEFA, reg.CARGPECO) LOOP
                 IF indRang.rango_inicial = 0 THEN
                  nuerror := 0;
                  sbError := NULL;
                  proGeneraNotaUsuario( vtblProduSubAdicRec(idx).factsusc,
                              vtblProduSubAdicRec(idx).CUCONUSE,
                              vtblProduSubAdicRec(idx).CUCOcodi,
                              vtblProduSubAdicRec(idx).CUCOfact,
                              nuUnidLigRag1,--indRang.UNIDAD_LIQUIDA,
                              reg.CARGPEFA,
                              reg.CARGPECO,
                              NULL,
                              nuConcSubAdi,
                              (case when REG.CARGSIGN =  'CR' then 'DB' else 'CR' end),
                              round(indRang.TARIFA_VALOR * nuUnidLigRag1 * (nuPorcSubAdi/100),0),
                              'NOTA GENERADA POR PROCESO DE SUNSIDIO ADICIONAL',
                              nuCausalSubAdi,
                              nuPrograma,
                              1,
                              1,
                              nuerror,
                              sbError);
                    IF nuerror <> 0 THEN
                     prInsertLogErrorSub( vtblProduSubAdicRec(idx).CUCONUSE,
                      vtblProduSubAdicRec(idx).factsusc,
                      vtblProduSubAdicRec(idx).CUCOcodi,
                      vtblProduSubAdicRec(idx).CUCOfact,
                      REG.CARGPEFA,
                       REG.CARGPECO,
                      null,
                      nuConcSubAdi,
                      round(indRang.TARIFA_VALOR * nuUnidLigRag1 * (nuPorcSubAdi/100),0),
                      (case when REG.CARGSIGN =  'CR' then 'DB' else 'CR' end),
                      nuCausalSubAdi,
                      nuUnidLigRag1 ,--indRang.UNIDAD_LIQUIDA,
                      sbError
                      );
                     ROLLBACK;
                    ELSE
                     prInsertLogErrorSub( vtblProduSubAdicRec(idx).CUCONUSE,
                      vtblProduSubAdicRec(idx).factsusc,
                      vtblProduSubAdicRec(idx).CUCOcodi,
                      vtblProduSubAdicRec(idx).CUCOfact,
                      REG.CARGPEFA,
                        REG.CARGPECO,
                      null,
                      nuConcSubAdi,
                      round(indRang.TARIFA_VALOR * nuUnidLigRag1 * (nuPorcSubAdi/100),0),
                      (case when REG.CARGSIGN =  'CR' then 'DB' else 'CR' end),
                      nuCausalSubAdi,
                      nuUnidLigRag1,--indRang.UNIDAD_LIQUIDA,
                      sbError
                      );
                     COMMIT;
                    END IF;
                END IF;
              END LOOP;
             END IF;
              END IF;
             END LOOP;
         END LOOP;

            EXIT   WHEN cuGetFacturaSubAdicRecu%NOTFOUND;
            END LOOP;
            CLOSE cuGetFacturaSubAdicRecu;
            END IF;

      --liquidacion de porductos marcados
      OPEN cugetCuentas(vtblPeriodos(sbIndex).PEGPPERI);
          LOOP
            FETCH cugetCuentas BULK COLLECT INTO vtblProductos LIMIT limit_in;
            FOR idx IN 1..vtblProductos.COUNT
            LOOP
              setvariables; --se setean las variables
              --DBMS_OUTPUT.PUT_LINE('INGRESO AQUI'||vtblProductos(idx).cucocodi);
              --actualiza producto
               prActuaLogError(sbRowId,null);

              --Marcar producto
              IF vtblProductos(idx).ACTIVO = 'N' THEN
                prMarcaProdtariTran( vtblProductos(idx).cuconuse, vtblPeriodos(sbIndex).PEGPCICL, sbRowId );
              ELSE
                sbRowId := vtblProductos(idx).ID_REG;
              END IF;

              sbConfirma    := 'S';
              nuPeriConAnte := -1;
               --se consulta los valores recuperados
              FOR reg IN cuGetCargosConsRecu(vtblProductos(idx).cucocodi, vtblProductos(idx).cuconuse)
              LOOP
                nuerror            := NULL;
                sberror            := NULL;
                nutarifa           := NULL;
                 sbExisteadic       := NULL;
                --nuUnidLigRag1      := 0;
                nuUnidLigRag2      := 0;
                nuDifer            := 0;
                nuPeriConACT       := reg.cargpeco;
                IF nuPeriConAnte   <> nuPeriConACT THEN
                  IF nuPeriConAnte <> -1 THEN
                    IF sbConfirma   = 'S' THEN
                      --INICIO CA 635
                      IF sbAplicaca635 = 'S' THEN
                        FOR regInt IN cuCalValorNotaInteRecu( vtblProductos(idx).cuconuse, nuPeriConAnte, vtblPeriodos(sbIndex).PEGPPERI) LOOP
                          nuerror       := NULL;
                          sbError       := NULL;
                          dtFechaInic   :=  NULL;
                          nuPromedio := 0;
                          nuValorNota := 0;
                          nuValorTariVariTT := 0;
                          nuValorTariConsumo := 0;
                        --  IF vtblProductos(idx).cuconuse <> nuProdAnte OR nuProdAnte = -1 THEN

                        open cuObteFechaLiq(regInt.tarifa, regInt.CONCEPTO,regInt.tari_trans );
                        fetch cuObteFechaLiq into dtFechaInic;
                        CLOSE cuObteFechaLiq;

                        setPorcInte( dtFechaInic, nuerror, sbError );
                        IF nuerror <> 0 THEN
                          ERRORS.SETERROR(2741, sbError);
                           RAISE EX.CONTROLLED_ERROR;
                        END IF;

                        if regInt.DIFERENCIA =  0 then
                             OPEN cuValorTarifaVar(vtblProductos(idx).cuconuse, vtblPeriodos(sbIndex).PEGPPERI, nuPeriConAnte);
                             FETCH cuValorTarifaVar INTO regTarifaVar;
                             IF cuValorTarifaVar%NOTFOUND THEN
                                  prActuaLogError(sbRowId
                                /*vtblProductos(idx).ID_REG*/
                                ,'El producto ['||vtblProductos(idx).cuconuse||' no tiene tarifa en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']');
                                ROLLBACK;
                                sbConfirma := 'N';
                                nuErrorProd := -1;
                                CLOSE cuValorTarifaVar;
                                EXIT;
                             else
                               OPEN cuValorTarifaVarTT( regTarifaVar.VITCFEIN,
                                                        regTarifaVar.TACOCR01,
                                                        regTarifaVar.TACOCR02,
                                                        regTarifaVar.TACOCR03);
                               FETCH cuValorTarifaVarTT INTO nuValorTariVariTT;
                               CLOSE cuValorTarifaVarTT;

                               nuDifereTari := regTarifaVar.RAVTVALO - NVL(nuValorTariVariTT,0);
                             END IF;
                             CLOSE cuValorTarifaVar;

                             nuValorTariConsumo := regTarifaVar.RAVTVALO;

                          ELSE
                            nuDifereTari := regInt.DIFERENCIA;
                            nuValorTariVariTT := regInt.TARIFA_TRANSITORIA;
                            nuValorTariConsumo := regInt.TARIFA_CONSUMO;
                          end if;


                        -- nuProdAnte :=  vtblProductos(idx).cuconuse;
                         --   END IF;

                            IF nuDifereTari < 0 THEN
                              nuPromedio := fnuGetPromAcum (vtblProductos(idx).cuconuse,
                                                              vtblPeriodos(sbIndex).PEGPPERI,
                                                              nuPeriConAnte,
                                                              nuConcepto,
                                                              regInt.RANGO,
                                                              2);

                               nuValorNota  := abs( ROUND(nuDifereTari * regInt.METROS * nuPromedio,0))  * regInt.signo;
                            ELSE
                              nuValorNota  := abs(ROUND(nuDifereTari * regInt.METROS,0)) * regInt.signo;
                            END IF;
                             --se actualiza valor para acumulado e interes
                           PRACTUALLIQINT( vtblProductos(idx).CUCONUSE,
                                            regInt.PERIFACT,
                                            regInt.CONCEPTO,
                                            nuDifereTari, --regInt.DIFERENCIA,
                                            regInt.METROS,
                                            nuValorNota,--regInt.DESCCAPMES,
                                            regInt.RANGO,
                                            regInt.PERICONS,
                                            'S',
                                            regInt.ID_REG,
                                            nuValorTariConsumo,
                                            nuValorTariVariTT,
                                            nuerror,
                                            sbError);
                            IF nuerror <> 0 THEN
                            prActuaLogError(sbRowId
                            /*vtblProductos(idx).ID_REG*/
                            ,sbError||'  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']');
                            ROLLBACK;
                            sbConfirma := 'N';
                            nuErrorProd := -1;
                            EXIT;
                            ELSE
                            sbConfirma := 'S';
                            END IF;

                       END LOOP;

                       IF sbConfirma = 'S' THEN
                          FOR regNotInt IN cuCalValorNotaInteAgruRecu(vtblProductos(idx).cuconuse, nuPeriConAnte, vtblPeriodos(sbIndex).PEGPPERI) LOOP
                           nuerror       := NULL;
                          sbError       := NULL;
                          sbSigno       := NULL;
                          IF regNotInt.VALOR < 0 THEN
                            sbSigno     := 'CR';
                          ELSE
                            sbSigno := 'DB';
                          END IF;
                          --se genera nota
                          proGeneraNotaUsuario( vtblProductos(idx).factsusc,
                                               vtblProductos(idx).CUCONUSE,
                                               vtblProductos(idx).CUCOcodi,
                                               vtblProductos(idx).CUCOfact,
                                               0,
                                               regNotInt.DPTTPERI,
                                               regNotInt.DPTTPECO,
                                               NULL,
                                               regNotInt.DPTTCONC,
                                               sbSigno,
                                               ROUND(ABS(regNotInt.VALOR),0),
                                               'NOTA DE INTERES POR PROCESO DE TARIFA TRANSITORIA',
                                               nuCausaInteres,
                                               nuPrograma,
                                               regNotInt.fila,
                                               regNotInt.maxrownum,
                                               nuerror,
                                               sbError);

                          IF nuerror <> 0 THEN
                            prActuaLogError(sbRowId
                            /*vtblProductos(idx).ID_REG*/
                            ,sbError||'  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']');
                            ROLLBACK;
                            sbConfirma := 'N';
                            nuErrorProd := -1;
                            EXIT;
                          ELSE
                           IF sbSigno = 'DB' THEN
                             sbSigno := 'CR';
                           ELSE
                             sbSigno := 'DB';
                           END IF;
                            --se genera nota contraria
                           proGeneraNotaUsuario( vtblProductos(idx).factsusc,
                                               vtblProductos(idx).CUCONUSE,
                                               vtblProductos(idx).CUCOcodi,
                                               vtblProductos(idx).CUCOfact,
                                               0,
                                               regNotInt.DPTTPERI,
                                               regNotInt.DPTTPECO,
                                               NULL,
                                               regNotInt.DPTTCONC,
                                               sbSigno,
                                               ROUND(ABS(regNotInt.VALOR),0),
                                               'NOTA DE INTERES POR PROCESO DE TARIFA TRANSITORIA',
                                               nuCausaInteres,
                                               nuPrograma,
                                               regNotInt.fila,
                                               regNotInt.maxrownum,
                                               nuerror,
                                               sbError);
                              IF nuerror <> 0 THEN
                                prActuaLogError(sbRowId
                                /*vtblProductos(idx).ID_REG*/
                                ,sbError||'  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']');
                                ROLLBACK;
                                sbConfirma := 'N';
                                nuErrorProd := -1;
                                EXIT;
                              ELSE
                                 sbConfirma := 'S';
                              END IF;
                          END IF;
                        END LOOP;
                       END IF;
                      END IF;
                      IF sbConfirma = 'S' THEN
                          FOR regcA IN cuCalValorNotaRecu(vtblProductos(idx).cuconuse, nuPeriConAnte, vtblPeriodos(sbIndex).PEGPPERI)
                          LOOP
                            sbSigno       := NULL;
                            nuerror       := NULL;
                            sbError       := NULL;
                            IF regcA.VALOR < 0 THEN
                              sbSigno     := 'CR';
                            ELSE
                              sbSigno := 'DB';
                            END IF;
                            --se genera nota
                            proGeneraNotaUsumar( regcA.DPTTCONT, vtblProductos(idx).cuconuse, regcA.DPTTCUCO, regcA.DPTTFACT, regcA.UNIDAD, regcA.DPTTPERI, regcA.DPTTPECO, regcA.DPTTTAPL, regcA.DPTTCONC, sbSigno, ABS(regcA.VALOR), 'NOTA POR PROCESO DE TARIFA TRANSITORIA', regcA.fila, regcA.maxrownum, nuerror, sbError);
                            IF nuerror <> 0 THEN
                              prActuaLogError(sbRowId,sbError||', en el periodo de consumo ['||nuPeriConAnte||']  [RECUPERADO]');
                              ROLLBACK;
                              sbConfirma := 'N';
                              EXIT;
                            ELSE
                              sbConfirma := 'S';
                            END IF;
                          END LOOP;
                      END IF;
                      IF sbConfirma = 'S' THEN
                        COMMIT;
                          IF nuErrorProd =  0 THEN
                            prActuaLogError(sbRowId,NULL);
                          END IF;
                       ELSE
                           ROLLBACK;
                      END IF;
                    END IF;
                  END IF;
                  nuPeriConAnte :=nuPeriConACT;
                  sbConfirma := 'S';
                END IF;
                IF cuGetLiquProdRang1%ISOPEN THEN
                  CLOSE cuGetLiquProdRang1;
                END IF;
                IF cuGetLiquProdRang2%ISOPEN THEN
                  CLOSE cuGetLiquProdRang2;
                END IF;
                IF cuGetLiquProd%ISOPEN THEN
                  CLOSE cuGetLiquProd;
                END IF;

                IF cuValidaIniSubAdic%ISOPEN THEN
                  CLOSE cuValidaIniSubAdic;
                END IF;

               --se valida si el usuario tiene subsidio
                IF vtblProductos(idx).cucocate = 1 AND vtblProductos(idx).cucosuca IN (1,2) THEN
                  IF REG.cargsign              = 'CR' AND reg.cargconc = 31 THEN
                    sbAumenta                 := 'N';
                    nuUnidades                := -1 * reg.cargunid;
                  ELSIF REG.cargsign           = 'DB' AND reg.cargconc = 31 THEN
                    sbAumenta                 := 'S';
                    nuUnidades                := reg.cargunid;
                  END IF;
                  IF reg.cargconc     = 31 THEN
                    regLiquProdRang1 := regLiquProdRang1null;
                    regLiquProdRang2 := regLiquProdRang2null;

                    nuTarifaConsumo := 0;
                    --se cargan rangos liquidados de 0 a 20
                    OPEN cuGetLiquProdRang1(reg.cargnuse, REG.cargpeco, vtblPeriodos(sbIndex).PEGPPERI);
                    FETCH cuGetLiquProdRang1 INTO regLiquProdRang1;
                    IF cuGetLiquProdRang1%NOTFOUND THEN
                      FOR indRang IN cuValorConsumo(vtblProductos(idx).CUCONUSE, reg.CARGPEFA, reg.CARGPECO)
                      LOOP
                        --  DBMS_OUTPUT.PUT_LINE('RANGOS  '||vtblProductos(idx).CUCONUSE||' '||indRang.TARIFA_VALOR);
                        vregTarifaCon  := vregTarifaConnull;
                        onuvalornota   := NULL;
                        nuvaloTariCont := NULL;
                        --se valida tarifa aplicada
                        OPEN cuGetInfotarifa(reg.CARGTACO, reg.CARGCONC, indRang.TARIFA_VALOR,indRang.IDTARIFA );
                        FETCH cuGetInfotarifa INTO vregTarifaCon;
                        CLOSE cuGetInfotarifa;
                        --  DBMS_OUTPUT.PUT_LINE('TARIFAS  '||vregTarifaCon.mere);
                        IF vregTarifaCon.mere IS NOT NULL THEN

                           if indRang.rango_inicial = 0 then
                             OPEN cuValidaIniSubAdic(reg.cargpeco);
                             FETCH cuValidaIniSubAdic INTO sbExisteadic;
                             CLOSE cuValidaIniSubAdic;
                           end if;

                           IF sbExisteadic IS NOT NULL and indRang.rango_inicial = 0 AND sbaplica608 = 'S' THEN
                              --se genera nota de consumo
                              prGeneraProcNotas( vregTarifaCon, vtblProductos(idx).factsusc, vtblProductos(idx).CUCONUSE, vtblProductos(idx).CUCOcodi, vtblProductos(idx).CUCOfact, nuConcepto, indRang.UNIDAD_LIQUIDA, indRang.tarifa_valor, reg.CARGpefa, reg.CARGpeco, reg.CARGsign, nuTariconc, vtblProductos(idx).indice, 2, onuvalornota,1, nuDifetari, 0,sbSignoAplica, nuerror, sbError );
                              nuDifetariSub := nuDifetari;
                           ELSE
                              --se genera nota de consumo
                             prGeneraProcNotas( vregTarifaCon, vtblProductos(idx).factsusc, vtblProductos(idx).CUCONUSE, vtblProductos(idx).CUCOcodi, vtblProductos(idx).CUCOfact, nuConcepto, indRang.UNIDAD_LIQUIDA, indRang.tarifa_valor, reg.CARGpefa, reg.CARGpeco, reg.CARGsign, nuTariconc, vtblProductos(idx).indice, 2, onuvalornota,0, nuDifetari,0,sbSignoAplica, nuerror, sbError );
                           END IF;
                          --  DBMS_OUTPUT.PUT_LINE('TERMINO prGeneraProcNotas   '||sbError);
                          IF nuerror <> 0 THEN
                            prActuaLogError(sbRowId ,sbError||'  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']  [RECUPERADO]');
                            ROLLBACK;
                            sbConfirma := 'N';
                            EXIT;
                          ELSE

                           if indRang.rango_inicial = 0 AND sbExisteadic IS NOT NULL then
                            IF sbAumenta = 'S'  THEN
                               nuApliDescAdic := 1;
                            ELSE
                               nuApliDescAdic := -1;
                            END IF;
                            nuUnidLigRag1 := indRang.UNIDAD_LIQUIDA;
                            nuTarifaConsumo := indRang.tarifa_valor;
                           END IF;

                         END IF;
                      ELSE
                          prActuaLogError(sbRowId ,'No se encontro informacion de tarifa del producto  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']  [RECUPERADO]');
                          ROLLBACK;
                          sbConfirma := 'N';
                          EXIT;
                        END IF;
                      END LOOP;
                    ELSE
                      nuDifer             := 20 - regLiquProdRang1.DPTTUNID ;
                      IF sbAumenta         = 'S' THEN
                        IF nuDifer         > 0 THEN
                          IF nuUnidades    > nuDifer THEN
                            nuUnidades    := nuUnidades - nuDifer;
                            nuUnidLigRag1 := nuDifer;
                          ELSE
                            nuUnidLigRag1 := nuUnidades;
                            nuUnidades    := 0;
                          END IF;
                          --se genera la nota
                          proGeneraNota( vtblProductos(idx).factsusc, REG.cargnuse, vtblProductos(idx).CUCOcodi, vtblProductos(idx).CUCOfact, nuUnidLigRag1, regLiquProdRang1.DPTTTACO, regLiquProdRang1.DPTTTATT, REG.cargpefa, REG.cargpeco, regLiquProdRang1.DPTTTAPL, regLiquProdRang1.DPTTCONC, REG.cargsign, 2, OnuValorNota, regLiquProdRang1.DPTTRANG, 0, 0, OsbSigno, nuerror, sberror);
                          IF nuerror <> 0 THEN
                            prActuaLogError(sbRowId, sberror||' [RECUPERADO]');
                            ROLLBACK;
                            sbConfirma := 'N';
                           -- EXIT;
                          END IF;
                      nuApliDescAdic := 1;

                        END IF;
                        IF ( nuUnidades) > 0 THEN
                          --se cargan rangos liquidados de 21 en adelante
                          OPEN cuGetLiquProdRang2(reg.cargnuse, REG.cargpeco, vtblPeriodos(sbIndex).PEGPPERI);
                          FETCH cuGetLiquProdRang2 INTO regLiquProdRang2;
                          IF cuGetLiquProdRang2%NOTFOUND THEN
                            --se busca tarifa de liquidacion para rango 2
                            vregTarifaCon := vregTarifaConnull;
                            onuvalornota  := NULL;
                            --se valida tarifa aplicada
                            OPEN cuGetInfotarifa(regLiquProdRang1.DPTTTAPL, nuConcepto, regLiquProdRang1.DPTTTATT, null );
                            FETCH cuGetInfotarifa INTO vregTarifaCon;
                            CLOSE cuGetInfotarifa;
                            --  DBMS_OUTPUT.PUT_LINE('TARIFAS  '||vregTarifaCon.mere);
                            IF vregTarifaCon.mere   IS NOT NULL THEN
                              vregTarifaCon.rangini := 21;
                              vregTarifaCon.rango   := '21 - 999999999';
                              --se obtiene tarifa de concepto
                              nutarifa := fnuObtenerTarifa(vregTarifaCon.cate, vregTarifaCon.suca, vregTarifaCon.mere, vregTarifaCon.fecha_inicial, 21, --inuUnidad,
                              31, vregTarifaCon.cate||vregTarifaCon.suca||vregTarifaCon.mere||'311'||TO_CHAR(vregTarifaCon.fecha_inicial,'ddmmyyyy'), nuTariconc, sbrango, nuerror, sbError );
                              IF nuerror <> 0 THEN
                                prActuaLogError(sbRowId, sberror||' [RECUPERADO]');
                                ROLLBACK;
                                sbConfirma := 'N';
                                CLOSE cuGetLiquProdRang2;
                               -- EXIT;
                              ELSE
                                --se genera nota de consumo
                                prGeneraProcNotas( vregTarifaCon, vtblProductos(idx).factsusc, REG.cargnuse, vtblProductos(idx).CUCOcodi, vtblProductos(idx).CUCOfact, nuConcepto, nuUnidades, nutarifa, reg.CARGpefa, reg.CARGpeco, reg.CARGsign, nuTariconc, vregTarifaCon.cate||vregTarifaCon.suca||vregTarifaCon.mere, 2, OnuValorNota,0, nuDifetari, 0,OsbSigno, nuerror, sbError );
                                IF nuerror <> 0 THEN
                                  prActuaLogError(sbRowId, sberror||' [RECUPERADO]');
                                  ROLLBACK;
                                  sbConfirma := 'N';
                                  CLOSE cuGetLiquProdRang2;
                                  --EXIT;
                                END IF;
                              END IF;
                            END IF;
                          ELSE
                            --se genera la nota
                            proGeneraNota( vtblProductos(idx).factsusc, REG.cargnuse, vtblProductos(idx).CUCOcodi, vtblProductos(idx).CUCOfact, nuUnidades, regLiquProdRang2.DPTTTACO, regLiquProdRang2.DPTTTATT, REG.cargpefa, REG.cargpeco, regLiquProdRang2.DPTTTAPL, regLiquProdRang2.DPTTCONC, REG.cargsign, 2, OnuValorNota, regLiquProdRang2.DPTTRANG, 0,0,OsbSigno, nuerror, sberror);
                            IF nuerror <> 0 THEN
                              prActuaLogError(sbRowId, sberror||' [RECUPERADO]');
                              ROLLBACK;
                              sbConfirma := 'N';
                              CLOSE cuGetLiquProdRang2;
                            --  EXIT;
                            END IF;
                          END IF;
                          CLOSE cuGetLiquProdRang2;
                        END IF;
                      ELSE
                        --se cargan rangos liquidados de 21 en adelante
                        OPEN cuGetLiquProdRang2(reg.cargnuse, REG.cargpeco, vtblPeriodos(sbIndex).PEGPPERI);
                        FETCH cuGetLiquProdRang2 INTO regLiquProdRang2;
                        IF cuGetLiquProdRang2%FOUND THEN
                          IF ABS(nuUnidades) > regLiquProdRang2.DPTTUNID THEN
                            nuUnidades      := nuUnidades + regLiquProdRang2.DPTTUNID;
                            nuUnidLigRag2   := regLiquProdRang2.DPTTUNID;
                          ELSE
                            nuUnidLigRag2 := ABS(nuUnidades);
                            nuUnidades    := 0;
                          END IF;
                          --se genera la nota
                          proGeneraNota( vtblProductos(idx).factsusc, REG.cargnuse, vtblProductos(idx).CUCOcodi, vtblProductos(idx).CUCOfact, nuUnidLigRag2, regLiquProdRang2.DPTTTACO, regLiquProdRang2.DPTTTATT, REG.cargpefa, REG.cargpeco, regLiquProdRang2.DPTTTAPL, regLiquProdRang2.DPTTCONC, REG.cargsign, 2, OnuValorNota, regLiquProdRang2.DPTTRANG, 0,0,OsbSigno, nuerror, sberror);
                          IF nuerror <> 0 THEN
                            prActuaLogError(sbRowId, sberror||' [RECUPERADO]');
                            ROLLBACK;
                            sbConfirma := 'N';
                            CLOSE cuGetLiquProdRang2;
                           -- EXIT;
                          END IF;
                        END IF;
                        CLOSE cuGetLiquProdRang2;
                        IF nuUnidades   <> 0 THEN
                          nuUnidLigRag1 := ABS(nuUnidades);
                          --se genera la nota
                          proGeneraNota( vtblProductos(idx).factsusc, REG.cargnuse, vtblProductos(idx).CUCOcodi, vtblProductos(idx).CUCOfact, nuUnidLigRag1, regLiquProdRang1.DPTTTACO, regLiquProdRang1.DPTTTATT, REG.cargpefa, REG.cargpeco, regLiquProdRang1.DPTTTAPL, regLiquProdRang1.DPTTCONC, REG.cargsign, 2, OnuValorNota, regLiquProdRang1.DPTTRANG, 0, 0, OsbSigno, nuerror, sberror);
                          IF nuerror <> 0 THEN
                            prActuaLogError(sbRowId, sberror||'  [RECUPERADO]');
                            ROLLBACK;
                            sbConfirma := 'N';
                           -- EXIT;
                          END IF;
              nuApliDescAdic := -1;
                        END IF;
                      END IF;
                    END IF;
                    CLOSE cuGetLiquProdRang1;

          IF  sbConfirma = 'S' AND nuApliDescAdic <> 0 AND sbaplica608 = 'S' THEN
             OPEN cuExisteSubadic(regLiquProdRang1.DPTTFACT,REG.cargpefa, REG.cargpeco);
             FETCH cuExisteSubadic INTO sbExistSubAdic;
             CLOSE cuExisteSubadic;

             OPEN cuValidaIniSubAdic(reg.cargpeco);
             FETCH cuValidaIniSubAdic INTO sbExisteadic;
             CLOSE cuValidaIniSubAdic;


           IF sbExistSubAdic IS NOT NULL or sbExisteadic IS NOT NULL THEN
             nuerror := 0;
             sbError := NULL;
             if nvl(regLiquProdRang1.DPTTTACO, 0) > 0 then
                nuTarifaConsumo := regLiquProdRang1.DPTTTACO;
             end if;

                     proGeneraNotaUsuario( vtblProductos(idx).factsusc,
                                REG.cargnuse,
                                vtblProductos(idx).CUCOcodi,
                                vtblProductos(idx).CUCOfact,
                                nuUnidLigRag1,
                                REG.cargpefa,
                                REG.cargpeco,
                                NULL,
                                nuConcSubAdi,
                               ( case when nuApliDescAdic =  1 then 'CR' else 'DB' end) ,
                                round( nuTarifaConsumo/*regLiquProdRang1.DPTTTACO*/ * nuUnidLigRag1  * (nuPorcSubAdi/100),0),
                                'NOTA GENERADA POR PROCESO DE SUSIDIO ADICIONAL',
                                nuCausalSubAdi,
                                nuPrograma,
                                1,
                                1,
                                nuerror,
                                sbError);
                      IF nuerror <> 0 THEN
                         prInsertLogErrorSub( REG.cargnuse,
                                  vtblProductos(idx).factsusc,
                                   vtblProductos(idx).CUCOcodi,
                                vtblProductos(idx).CUCOfact,
                                  REG.cargpefa,
                                  REG.cargpeco,
                                  null,
                                  nuConcSubAdi,
                                  round( nuTarifaConsumo/*regLiquProdRang1.DPTTTACO*/ * nuUnidLigRag1  * (nuPorcSubAdi/100),0),
                                  ( case when nuApliDescAdic =  1 then 'CR' else 'DB' end),
                                  nuCausalSubAdi,
                                  nuUnidLigRag1,
                                  sbError
                                  );
                         ROLLBACK;
                         sbConfirma := 'N';
                        exit;
                      ELSE
                         prInsertLogErrorSub( REG.cargnuse,
                                  vtblProductos(idx).factsusc,
                                   vtblProductos(idx).CUCOcodi,
                                       vtblProductos(idx).CUCOfact,
                                  REG.cargpefa,
                                  REG.cargpeco,
                                  null,
                                  nuConcSubAdi,
                                  round( nuTarifaConsumo/*regLiquProdRang1.DPTTTACO*/ * nuUnidLigRag1  * (nuPorcSubAdi/100),0),
                                  ( case when nuApliDescAdic =  1 then 'CR' else 'DB' end),
                                  nuCausalSubAdi,
                                   nuUnidLigRag1,
                                  sbError
                                  );
                      END IF;

                       END IF;

                    END IF;

                  ELSE
                    regLiquiProd := regLiquiProdnull;
                    OPEN cuGetLiquProd(reg.cargnuse, REG.cargpeco, reg.cargconc, vtblPeriodos(sbIndex).PEGPPERI);
                    FETCH cuGetLiquProd INTO regLiquiProd;
                    IF cuGetLiquProd%NOTFOUND THEN
                      IF reg.cargconc = 196 THEN
                        FOR indRang IN cuValorConsumosUB(vtblProductos(idx).CUCONUSE, reg.CARGPEFA, reg.CARGPECO)
                        LOOP
                          vregTarifaCon := vregTarifaConnull;
                          onuvalornota  := NULL;
                          --se valida tarifa aplicada
                          OPEN cuGetInfotarifa(reg.CARGTACO, reg.CARGCONC, indRang.VALOR_SUBSIDIO, null/*,indRang.IDTARIFA*/ );
                          FETCH cuGetInfotarifa INTO vregTarifaCon;
                          CLOSE cuGetInfotarifa;
                          --  DBMS_OUTPUT.PUT_LINE('TARIFAS  '||vregTarifaCon.mere);
                          IF vregTarifaCon.mere IS NOT NULL THEN

                             OPEN cuValidaIniSubAdic(reg.cargpeco);
                           FETCH cuValidaIniSubAdic INTO sbExisteadic;
                           CLOSE cuValidaIniSubAdic;

                             IF sbExisteadic IS NOT NULL AND sbaplica608 = 'S' THEN
                                --se genera nota de SUBSIDIO
                                prGeneraProcNotas( vregTarifaCon, vtblProductos(idx).factsusc, vtblProductos(idx).CUCONUSE, vtblProductos(idx).CUCOcodi, vtblProductos(idx).CUCOfact, nuConcSub, indRang.UNIDAD_LIQUIDA, (indRang.VALOR_SUBSIDIO ) , REG.CARGpefa, REG.CARGpeco, REG.CARGSIGN, nuTariconc, vtblProductos(idx).indice, 2, onuvalornota,  1, nuDifetariSub,1,sbSignoAplica, nuerror, sbError );
                             ELSE
                                 prGeneraProcNotas( vregTarifaCon, vtblProductos(idx).factsusc, vtblProductos(idx).CUCONUSE, vtblProductos(idx).CUCOcodi, vtblProductos(idx).CUCOfact, nuConcSub, indRang.UNIDAD_LIQUIDA, (indRang.VALOR_SUBSIDIO ) , REG.CARGpefa, REG.CARGpeco, REG.CARGSIGN, nuTariconc, vtblProductos(idx).indice, 2, onuvalornota,  0, nuDifetari,0,sbSignoAplica, nuerror, sbError );
                               END IF;

              --  DBMS_OUTPUT.PUT_LINE('TERMINO prGeneraProcNotas   '||sbError);
                            IF nuerror <> 0 THEN
                              prActuaLogError(sbRowId ,sbError||'  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']  [RECUPERADO]');
                              ROLLBACK;
                              sbConfirma := 'N';
                              EXIT;
                            END IF;
                          ELSE
                            prActuaLogError(sbRowId ,'No se encontro informacion de tarifa del producto  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']  [RECUPERADO]');
                            ROLLBACK;
                            sbConfirma := 'N';
                            EXIT;
                          END IF;
                        END LOOP;
                      END IF;
                    ELSE
            --se genera la nota
                    proGeneraNota( vtblProductos(idx).factsusc, REG.cargnuse, vtblProductos(idx).CUCOcodi, vtblProductos(idx).CUCOfact, REG.cargunid, regLiquiProd.DPTTTACO, regLiquiProd.DPTTTATT, REG.cargpefa, REG.cargpeco, regLiquiProd.DPTTTAPL, regLiquiProd.DPTTCONC, REG.cargsign, 2, OnuValorNota, regLiquiProd.DPTTRANG, 0,0,OsbSigno, nuerror, sberror);
                    IF nuerror <> 0 THEN
                      prActuaLogError(sbRowId, sberror||' [RECUPERADO]');
                      ROLLBACK;
                      sbConfirma := 'N';
                     -- EXIT;
                    END IF;
                        END IF;
                    CLOSE cuGetLiquProd;

          --aqui
            if regLiquiProd.DPTTconc = nuConcSub AND  sbaplica608 = 'S' THEN
                   OPEN cuExisteSubadic(regLiquiProd.DPTTFACT,REG.cargpefa, REG.cargpeco);
                   FETCH cuExisteSubadic INTO sbExistSubAdic;
                   CLOSE cuExisteSubadic;

                   OPEN cuValidaIniSubAdic(reg.cargpeco);
                   FETCH cuValidaIniSubAdic INTO sbExisteadic;
                   CLOSE cuValidaIniSubAdic;


             IF sbExistSubAdic IS NOT NULL OR sbExisteadic IS NOT NULL THEN
              --se ajusta subsidio adicional transitorio
              proGeneraNotaSubAdic( vtblProductos(idx).factsusc,
                           REG.cargnuse,
                           vtblProductos(idx).CUCOcodi,
                           vtblProductos(idx).CUCOfact,
                           reg.cargunid,--nuUnidLigRag1,
                           REG.cargpefa,
                           REG.cargpeco,
                           REG.cargsign,
                           regLiquiProd.DPTTRANG,
                           ( regLiquProdRang1.DPTTTACO - regLiquProdRang1.DPTTTATT),
                          (regLiquiProd.DPTTTACO - regLiquiProd.DPTTTATT),
                          nuerror,
                          sbError);
                      IF nuerror <> 0 THEN
                         ROLLBACK;
                         sbConfirma := 'N';
                         prActuaLogError(sbRowId, sberror||' [RECUPERADO]');
                         exit;
                      END IF;
                    END IF;
                  END IF;
                  END IF;
                ELSE
                  regLiquiProd := regLiquiProdnull;
                  OPEN cuGetLiquProd(reg.cargnuse, REG.cargpeco, reg.cargconc,vtblPeriodos(sbIndex).PEGPPERI );
                  FETCH cuGetLiquProd INTO regLiquiProd;
                  IF cuGetLiquProd%NOTFOUND THEN
                    nuvaloTariCont := NULL;
                    IF reg.cargconc = 31 THEN
                      FOR indRang IN cuValorConsumo(vtblProductos(idx).CUCONUSE, reg.CARGPEFA, reg.CARGPECO)
                      LOOP
                        --  DBMS_OUTPUT.PUT_LINE('RANGOS  '||vtblProductos(idx).CUCONUSE||' '||indRang.TARIFA_VALOR);
                        vregTarifaCon  := vregTarifaConnull;
                        onuvalornota   := NULL;
                        nuvaloTariCont := NULL;
                        --se valida tarifa aplicada
                        OPEN cuGetInfotarifa(reg.CARGTACO, reg.CARGCONC, indRang.TARIFA_VALOR,indRang.IDTARIFA );
                        FETCH cuGetInfotarifa INTO vregTarifaCon;
                        CLOSE cuGetInfotarifa;
                        --  DBMS_OUTPUT.PUT_LINE('TARIFAS  '||vregTarifaCon.mere);
                        IF vregTarifaCon.mere IS NOT NULL THEN
                          --se genera nota de consumo
                          prGeneraProcNotas( vregTarifaCon, vtblProductos(idx).factsusc, vtblProductos(idx).CUCONUSE, vtblProductos(idx).CUCOcodi, vtblProductos(idx).CUCOfact, nuConcepto, indRang.UNIDAD_LIQUIDA, indRang.tarifa_valor, reg.CARGpefa, reg.CARGpeco, reg.CARGsign, nuTariconc, vtblProductos(idx).indice, 2, onuvalornota, 0, nuDifetari,0,sbSignoAplica, nuerror, sbError );
                          --  DBMS_OUTPUT.PUT_LINE('TERMINO prGeneraProcNotas   '||sbError);
                          IF nuerror <> 0 THEN
                            prActuaLogError(sbRowId ,sbError||'  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']  [RECUPERADO]');
                            ROLLBACK;
                            sbConfirma := 'N';
                            EXIT;
                          END IF;
                        ELSE
                          prActuaLogError(sbRowId ,'No se encontro informacion de tarifa del producto  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']  [RECUPERADO]');
                          ROLLBACK;
                          sbConfirma := 'N';
                          EXIT;
                        END IF;
                      END LOOP;
                    ELSE
                      --se consulta infromacion de contribucion
                      OPEN cuGetInfotarifaCont(REG.CARGTACO, REG.cargconc, vregTarifaCon.fecha_inicial);
                      FETCH cuGetInfotarifaCont INTO nuvaloTariCont;
                      CLOSE cuGetInfotarifaCont;
                      --se genera nota de contribucion
                      prGeneraProcNotas( vregTarifaCon, vtblProductos(idx).factsusc, vtblProductos(idx).CUCONUSE, vtblProductos(idx).CUCOcodi, vtblProductos(idx).CUCOfact, nuConcContri, NULL, nuvaloTariCont, regCargosContri.CARGpefa, regCargosContri.CARGpeco, regCargosContri.CARGsign, nuTariconc, vtblProductos(idx).indice, 2, onuvalornota, 0, nuDifetari,0,sbSignoAplica, nuerror, sbError );
                      IF nuerror <> 0 THEN
                        prActuaLogError(sbRowId
                        /*vtblProductos(idx).ID_REG*/
                        ,sbError||'  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']  [RECUPERADO]');
                        ROLLBACK;
                        sbConfirma := 'N';
                       -- EXIT;
                      ELSE
                        sbConfirma := 'S';
                      END IF;
                    END IF;
                  ELSE
                    --se genera la nota
                    proGeneraNota( vtblProductos(idx).factsusc, REG.cargnuse, vtblProductos(idx).CUCOcodi, vtblProductos(idx).CUCOfact, REG.cargunid, regLiquiProd.DPTTTACO, regLiquiProd.DPTTTATT, REG.cargpefa, REG.cargpeco, regLiquiProd.DPTTTAPL, regLiquiProd.DPTTCONC, REG.cargsign, 2, OnuValorNota, regLiquiProd.DPTTRANG, 0,0,OsbSigno, nuerror, sberror);
                    IF nuerror <> 0 THEN
                      prActuaLogError(sbRowId, sberror||' [RECUPERADO]');
                      ROLLBACK;
                      sbConfirma := 'N';
                      --EXIT;
                    END IF;
                  END IF;
                  CLOSE cuGetLiquProd;
               END IF;
              END LOOP;
              IF sbConfirma = 'S' AND nuPeriConAnte = nuPeriConACT THEN
                --INICIO CA 635
                      IF sbAplicaca635 = 'S' THEN
                        FOR regInt IN cuCalValorNotaInteRecu( vtblProductos(idx).cuconuse, nuPeriConAnte, vtblPeriodos(sbIndex).PEGPPERI) LOOP
                          nuerror       := NULL;
                          sbError       := NULL;
                          nuPromedio := 0;
                          nuDifereTari := 0;
                          nuValorNota := 0;
                          nuValorTariVariTT := 0;
                          nuValorTariConsumo := 0;
                          open cuObteFechaLiq(regInt.tarifa, regInt.CONCEPTO,regInt.tari_trans );
                          fetch cuObteFechaLiq into dtFechaInic;
                          CLOSE cuObteFechaLiq;

                          setPorcInte( dtFechaInic, nuerror, sbError );
                          IF nuerror <> 0 THEN
                            ERRORS.SETERROR(2741, sbError);
                             RAISE EX.CONTROLLED_ERROR;
                          END IF;

                          if regInt.DIFERENCIA =  0 then
                             OPEN cuValorTarifaVar(vtblProductos(idx).cuconuse, vtblPeriodos(sbIndex).PEGPPERI, nuPeriConAnte);
                             FETCH cuValorTarifaVar INTO regTarifaVar;
                             IF cuValorTarifaVar%NOTFOUND THEN
                                  prActuaLogError(sbRowId
                                /*vtblProductos(idx).ID_REG*/
                                ,'El producto ['||vtblProductos(idx).cuconuse||' no tiene tarifa en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']');
                                ROLLBACK;
                                sbConfirma := 'N';
                                nuErrorProd := -1;
                                CLOSE cuValorTarifaVar;
                                EXIT;
                             else
                               OPEN cuValorTarifaVarTT( regTarifaVar.VITCFEIN,
                                                        regTarifaVar.TACOCR01,
                                                        regTarifaVar.TACOCR02,
                                                        regTarifaVar.TACOCR03);
                               FETCH cuValorTarifaVarTT INTO nuValorTariVariTT;
                               CLOSE cuValorTarifaVarTT;

                               nuDifereTari := regTarifaVar.RAVTVALO - NVL(nuValorTariVariTT,0) ;
                             END IF;
                             CLOSE cuValorTarifaVar;
                              nuValorTariConsumo := regTarifaVar.RAVTVALO;

                           ELSE
                              nuDifereTari := regInt.DIFERENCIA;
                              nuValorTariVariTT := regInt.TARIFA_TRANSITORIA;
                              nuValorTariConsumo := regInt.TARIFA_CONSUMO;
                           end if;

                             IF nuDifereTari < 0 THEN
                              nuPromedio := fnuGetPromAcum (vtblProductos(idx).cuconuse,
                                                              vtblPeriodos(sbIndex).PEGPPERI,
                                                              nuPeriConAnte,
                                                              NUcONCEPTO,
                                                              regInt.RANGO,
                                                              2);
                               nuValorNota  := abs( ROUND(nuDifereTari * regInt.METROS * nuPromedio,0))* regInt.signo;
                            ELSE
                              nuValorNota  := abs(ROUND(nuDifereTari * regInt.METROS,0)) * regInt.signo;
                            END IF;
                           --se actualiza valor para acumulado e interes
                         PRACTUALLIQINT( vtblProductos(idx).CUCONUSE,
                                        regInt.PERIFACT,
                                        regInt.CONCEPTO,
                                        nuDifereTari, --regInt.DIFERENCIA,
                                        regInt.METROS,
                                        nuValorNota,--regInt.DESCCAPMES,
                                        regInt.RANGO,
                                        regInt.PERICONS,
                                        'S',
                                        regInt.ID_REG,
                                        nuValorTariConsumo,
                                        nuValorTariVariTT,
                                        nuerror,
                                        sbError);
                          IF nuerror <> 0 THEN
                            prActuaLogError(sbRowId
                            /*vtblProductos(idx).ID_REG*/
                            ,sbError||'  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']');
                            ROLLBACK;
                            sbConfirma := 'N';
                            nuErrorProd := -1;
                            EXIT;
                          ELSE
                            sbConfirma := 'S';
                          END IF;
                       END LOOP;

                       IF sbConfirma = 'S' THEN
                          FOR regNotInt IN cuCalValorNotaInteAgruRecu(vtblProductos(idx).cuconuse, nuPeriConAnte, vtblPeriodos(sbIndex).PEGPPERI) LOOP
                           nuerror       := NULL;
                          sbError       := NULL;
                          sbSigno       := NULL;
                          IF regNotInt.VALOR < 0 THEN
                            sbSigno     := 'CR';
                          ELSE
                            sbSigno := 'DB';
                          END IF;
                          --se genera nota
                          proGeneraNotaUsuario( vtblProductos(idx).factsusc,
                                               vtblProductos(idx).CUCONUSE,
                                               vtblProductos(idx).CUCOcodi,
                                               vtblProductos(idx).CUCOfact,
                                               0,
                                               regNotInt.DPTTPERI,
                                               regNotInt.DPTTPECO,
                                               NULL,
                                               regNotInt.DPTTCONC,
                                               sbSigno,
                                               ROUND(ABS(regNotInt.VALOR),0),
                                               'NOTA DE INTERES POR PROCESO DE TARIFA TRANSITORIA',
                                               nuCausaInteres,
                                               nuPrograma,
                                               regNotInt.fila,
                                               regNotInt.maxrownum,
                                               nuerror,
                                               sbError);

                          IF nuerror <> 0 THEN
                            prActuaLogError(sbRowId
                            /*vtblProductos(idx).ID_REG*/
                            ,sbError||'  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']');
                            ROLLBACK;
                            sbConfirma := 'N';
                            nuErrorProd := -1;
                            EXIT;
                          ELSE
                           IF sbSigno = 'DB' THEN
                             sbSigno := 'CR';
                           ELSE
                             sbSigno := 'DB';
                           END IF;
                            --se genera nota contraria
                           proGeneraNotaUsuario( vtblProductos(idx).factsusc,
                                               vtblProductos(idx).CUCONUSE,
                                               vtblProductos(idx).CUCOcodi,
                                               vtblProductos(idx).CUCOfact,
                                               0,
                                               regNotInt.DPTTPERI,
                                               regNotInt.DPTTPECO,
                                               NULL,
                                               regNotInt.DPTTCONC,
                                               sbSigno,
                                               ROUND(ABS(regNotInt.VALOR),0),
                                               'NOTA DE INTERES POR PROCESO DE TARIFA TRANSITORIA',
                                               nuCausaInteres,
                                               nuPrograma,
                                               regNotInt.fila,
                                               regNotInt.maxrownum,
                                               nuerror,
                                               sbError);
                              IF nuerror <> 0 THEN
                                prActuaLogError(sbRowId
                                /*vtblProductos(idx).ID_REG*/
                                ,sbError||'  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']');
                                ROLLBACK;
                                sbConfirma := 'N';
                                nuErrorProd := -1;
                                EXIT;
                              ELSE
                                 sbConfirma := 'S';
                              END IF;
                          END IF;
                        END LOOP;
                       END IF;
                 END IF;

                 IF sbConfirma = 'S' THEN
                    FOR regcA IN cuCalValorNotaRecu(vtblProductos(idx).cuconuse, nuPeriConAnte, vtblPeriodos(sbIndex).PEGPPERI)
                    LOOP
                      sbSigno       := NULL;
                      nuerror       := NULL;
                      sbError       := NULL;
                      IF regcA.VALOR < 0 THEN
                        sbSigno     := 'CR';
                      ELSE
                        sbSigno := 'DB';
                      END IF;
                      --se genera nota
                      proGeneraNotaUsumar( regcA.DPTTCONT, vtblProductos(idx).cuconuse, regcA.DPTTCUCO, regcA.DPTTFACT, regcA.UNIDAD, regcA.DPTTPERI, regcA.DPTTPECO, regcA.DPTTTAPL, regcA.DPTTCONC, sbSigno, ABS(regcA.VALOR), 'NOTA POR PROCESO DE TARIFA TRANSITORIA', regcA.fila, regcA.maxrownum, nuerror, sbError);
                      IF nuerror <> 0 THEN
                        prActuaLogError(sbRowId,sbError||', en el periodo de consumo ['||nuPeriConACT||']  [RECUPERADO]');
                        ROLLBACK;
                        sbConfirma := 'N';
                        EXIT;
                      ELSE
                        sbConfirma := 'S';
                      END IF;
                    END LOOP;
                  END IF;
                  IF sbConfirma = 'S' THEN
                    COMMIT;
                    IF nuErrorProd =  0 THEN
                    prActuaLogError(sbRowId,NULL);
                    END IF;
                   ELSE
                     ROLLBACK;
                  END IF;
              END IF;

              sbConfirma := 'N';
              IF cuGetCargosConsActu%ISOPEN THEN
                CLOSE cuGetCargosConsActu;
              END IF;
              --se cosnultan cargos actuales
              OPEN cuGetCargosConsActu(vtblProductos(idx).cucocodi, vtblProductos(idx).cuconuse);
              FETCH cuGetCargosConsActu INTO regCargosAct;
              CLOSE cuGetCargosConsActu;
              --DBMS_OUTPUT.PUT_LINE('cuGetCargosConsActu '||regCargosAct.cargunid);
              IF NVL(regCargosAct.cargunid,0) > 0 THEN
                FOR indRang IN cuValorConsumo(vtblProductos(idx).CUCONUSE, regCargosAct.CARGPEFA, regCargosAct.CARGPECO)
                LOOP
                  --  DBMS_OUTPUT.PUT_LINE('RANGOS  '||vtblProductos(idx).CUCONUSE||' '||indRang.TARIFA_VALOR);
                  vregTarifaCon  := vregTarifaConnull;
                  onuvalornota   := NULL;
                  nuvaloTariCont := NULL;
                  --se valida tarifa aplicada
                  OPEN cuGetInfotarifa(regCargosAct.CARGTACO, regCargosAct.CARGCONC, indRang.TARIFA_VALOR,indRang.IDTARIFA );
                  FETCH cuGetInfotarifa INTO vregTarifaCon;
                  CLOSE cuGetInfotarifa;
                  --  DBMS_OUTPUT.PUT_LINE('TARIFAS  '||vregTarifaCon.mere);
                  IF vregTarifaCon.mere IS NOT NULL THEN
                    --se genera nota de consumo
                    prGeneraProcNotas( vregTarifaCon, vtblProductos(idx).factsusc, vtblProductos(idx).CUCONUSE, vtblProductos(idx).CUCOcodi, vtblProductos(idx).CUCOfact, nuConcepto, indRang.UNIDAD_LIQUIDA, indRang.tarifa_valor, regCargosAct.CARGpefa, regCargosAct.CARGpeco, regCargosAct.CARGsign, nuTariconc, vtblProductos(idx).indice, 0, onuvalornota, 1, nuDifetari, 0, sbSignoAplica, nuerror, sbError );
                    --  DBMS_OUTPUT.PUT_LINE('TERMINO prGeneraProcNotas   '||sbError);
                    IF nuerror = 0 THEN
                      sbConfirma := 'S';
                     --validamos si hubo subsidio
                      IF vregTarifaCon.CATE        = 1 AND vregTarifaCon.SUCA IN (1,2) THEN
                        IF indRang.VALOR_SUBSIDIO IS NOT NULL THEN
                          --se genera nota de consumo
                          prGeneraProcNotas( vregTarifaCon, vtblProductos(idx).factsusc, vtblProductos(idx).CUCONUSE, vtblProductos(idx).CUCOcodi, vtblProductos(idx).CUCOfact, nuConcSub, indRang.UNIDAD_LIQUIDA, (indRang.VALOR_SUBSIDIO /indRang.UNIDAD_LIQUIDA) , regCargosAct.CARGpefa, regCargosAct.CARGpeco, 'CR', nuTariconc, vtblProductos(idx).indice, 0, onuvalornota, 1, nuDifetari,0, sbSignoAplica, nuerror, sbError );
                          IF nuerror <> 0 THEN
                            prActuaLogError(sbRowId
                            /*vtblProductos(idx).ID_REG*/
                            ,sbError||'  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']');
                            ROLLBACK;
                            sbConfirma := 'N';
              nuErrorProd := -1;
                            EXIT;
                          ELSE
                            sbConfirma := 'S';
                          END IF;
                        END IF;
                      ELSE
                        IF cuGetCargosContri%ISOPEN THEN
                          CLOSE cuGetCargosContri;
                        END IF;
                        OPEN cuGetCargosContri(vtblProductos(idx).cucocodi, vtblProductos(idx).cuconuse);
                        FETCH cuGetCargosContri INTO regCargosContri;
                        IF cuGetCargosContri%FOUND THEN
                          IF cuGetInfotarifaCont%ISOPEN THEN
                            CLOSE cuGetInfotarifaCont;
                          END IF;
                          --   DBMS_OUTPUT.PUT_LINE('contribucion    '||regCargosContri.cargconc||' '||vregTarifaCon.fecha_inicial);
                          --se consulta infromacion de contribucion
                          OPEN cuGetInfotarifaCont(regCargosContri.CARGTACO, regCargosContri.cargconc, vregTarifaCon.fecha_inicial);
                          FETCH cuGetInfotarifaCont INTO nuvaloTariCont;
                          CLOSE cuGetInfotarifaCont;
                          --se genera nota de contribucion
                          prGeneraProcNotas( vregTarifaCon, vtblProductos(idx).factsusc, vtblProductos(idx).CUCONUSE, vtblProductos(idx).CUCOcodi, vtblProductos(idx).CUCOfact, nuConcContri, NULL, nuvaloTariCont, regCargosContri.CARGpefa, regCargosContri.CARGpeco, regCargosContri.CARGsign, nuTariconc, vtblProductos(idx).indice, 0, onuvalornota,0, nuDifetari,0, sbSignoAplica, nuerror, sbError );
                          IF nuerror <> 0 THEN
                            prActuaLogError(sbRowId
                            /*vtblProductos(idx).ID_REG*/
                            ,sbError||'  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']');
                            ROLLBACK;
                            sbConfirma := 'N';
                             nuErrorProd := -1;
                            EXIT;
                          ELSE
                            sbConfirma := 'S';
                          END IF;
                        END IF;
                        CLOSE cuGetCargosContri;
                      END IF;
                    ELSE
                      prActuaLogError(sbRowId
                      /*vtblProductos(idx).ID_REG*/
                      ,sbError||'  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']');
                      ROLLBACK;
                      sbConfirma := 'N';
            nuErrorProd := -1;
                      EXIT;
                    END IF;
                  ELSE
                    prActuaLogError(sbRowId
                    /*vtblProductos(idx).ID_REG*/
                    ,'No se encontro informacion de tarifa del producto  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']');
                    ROLLBACK;
                    sbConfirma := 'N';
          nuErrorProd := -1;
                    EXIT;
                  END IF;
                END LOOP;
                IF sbConfirma = 'S' THEN

              --INICIO CA 635
                IF sbAplicaca635 = 'S' THEN
                  setPorcInte( vregTarifaCon.fecha_inicial, nuerror, sbError );
                  IF nuerror <> 0 THEN
                    ERRORS.SETERROR(2741, sbError);
                     RAISE EX.CONTROLLED_ERROR;
                  END IF;

                 FOR regInt IN cuCalValorNotaInte( vtblProductos(idx).CUCONUSE, vtblProductos(idx).CUCOfact, regCargosAct.CARGPECO) LOOP
                      nuerror       := NULL;
                      sbError       := NULL;
                      nuValorTariVariTT := 0;
                      nuDifereTari := 0;
                      nuPromedio := 0;
                      nuValorNota := 0;
                      nuValorTariConsumo := 0;

                      if regInt.DIFERENCIA =  0 then
                         OPEN cuValorTarifaVar(vtblProductos(idx).cuconuse, vtblPeriodos(sbIndex).PEGPPERI, regInt.PERICONS);
                         FETCH cuValorTarifaVar INTO regTarifaVar;
                         IF cuValorTarifaVar%NOTFOUND THEN
                              prActuaLogError(sbRowId
                            /*vtblProductos(idx).ID_REG*/
                            ,'El producto ['||vtblProductos(idx).cuconuse||' no tiene tarifa en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']');
                            ROLLBACK;
                            sbConfirma := 'N';
                            nuErrorProd := -1;
                            CLOSE cuValorTarifaVar;
                            EXIT;
                         else
                           OPEN cuValorTarifaVarTT( regTarifaVar.VITCFEIN,
                                                    regTarifaVar.TACOCR01,
                                                    regTarifaVar.TACOCR02,
                                                    regTarifaVar.TACOCR03);
                           FETCH cuValorTarifaVarTT INTO nuValorTariVariTT;
                           CLOSE cuValorTarifaVarTT;

                           nuDifereTari := regTarifaVar.RAVTVALO -  NVL(nuValorTariVariTT,0) ;
                         END IF;
                         CLOSE cuValorTarifaVar;
                        nuValorTariConsumo := regTarifaVar.RAVTVALO;

                     ELSE
                        nuDifereTari := regInt.DIFERENCIA;
                        nuValorTariVariTT := regInt.TARIFA_TRANSITORIA;
                        nuValorTariConsumo := regInt.TARIFA_CONSUMO;
                      end if;

                      IF nuDifereTari < 0 THEN
                         nuPromedio := fnuGetPromAcum (vtblProductos(idx).cuconuse,
                                                        vtblPeriodos(sbIndex).PEGPPERI,
                                                        regInt.PERICONS,
                                                        NUcONCEPTO,
                                                        regInt.RANGO,
                                                        0);
                         nuValorNota  := abs( ROUND(nuDifereTari * regInt.METROS * nuPromedio,0))  * regInt.signo;
                      ELSE
                        nuValorNota  := abs(ROUND(nuDifereTari * regInt.METROS,0))  * regInt.signo;
                      END IF;
                      --se actualiza valor para acumulado e interes
                     PRACTUALLIQINT( vtblProductos(idx).CUCONUSE,
                                  regInt.PERIFACT,
                                  regInt.CONCEPTO,
                                  nuDifereTari, --regInt.DIFERENCIA,
                                  regInt.METROS,
                                  nuValorNota,--regInt.DESCCAPMES,
                                  regInt.RANGO,
                                  regInt.PERICONS,
                                  'N',
                                  regInt.ID_REG,
                                  nuValorTariConsumo,
                                  nuValorTariVariTT,
                                  nuerror,
                                  sbError);
                    IF nuerror <> 0 THEN
                      prActuaLogError(sbRowId
                      /*vtblProductos(idx).ID_REG*/
                      ,sbError||'  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']');
                      ROLLBACK;
                      sbConfirma := 'N';
                      nuErrorProd := -1;
                      EXIT;
                    ELSE
                      sbConfirma := 'S';
                    END IF;
             END LOOP;

             IF sbConfirma = 'S' THEN
                FOR regNotInt IN cuCalValorNotaInteAgru(vtblProductos(idx).CUCONUSE, vtblProductos(idx).CUCOfact, regCargosAct.CARGPECO) LOOP
                 nuerror       := NULL;
                sbError       := NULL;
                sbSigno       := NULL;
                IF regNotInt.VALOR < 0 THEN
                  sbSigno     := 'CR';
                ELSE
                  sbSigno := 'DB';
                END IF;
                --se genera nota
                proGeneraNotaUsuario( vtblProductos(idx).factsusc,
                                     vtblProductos(idx).CUCONUSE,
                                     vtblProductos(idx).CUCOcodi,
                                     vtblProductos(idx).CUCOfact,
                                     0,
                                     regNotInt.DPTTPERI,
                                     regNotInt.DPTTPECO,
                                     NULL,
                                     regNotInt.DPTTCONC,
                                     sbSigno,
                                     ROUND(ABS(regNotInt.VALOR),0),
                                     'NOTA DE INTERES POR PROCESO DE TARIFA TRANSITORIA',
                                     nuCausaInteres,
                                     nuPrograma,
                                     regNotInt.fila,
                                     regNotInt.maxrownum,
                                     nuerror,
                                     sbError);

                IF nuerror <> 0 THEN
                  prActuaLogError(sbRowId
                  /*vtblProductos(idx).ID_REG*/
                  ,sbError||'  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']');
                  ROLLBACK;
                  sbConfirma := 'N';
                  nuErrorProd := -1;
                  EXIT;
                ELSE
                 IF sbSigno = 'DB' THEN
                   sbSigno := 'CR';
                 ELSE
                   sbSigno := 'DB';
                 END IF;
                  --se genera nota contraria
                 proGeneraNotaUsuario( vtblProductos(idx).factsusc,
                                     vtblProductos(idx).CUCONUSE,
                                     vtblProductos(idx).CUCOcodi,
                                     vtblProductos(idx).CUCOfact,
                                     0,
                                     regNotInt.DPTTPERI,
                                     regNotInt.DPTTPECO,
                                     NULL,
                                     regNotInt.DPTTCONC,
                                     sbSigno,
                                     ROUND(ABS(regNotInt.VALOR),0),
                                     'NOTA DE INTERES POR PROCESO DE TARIFA TRANSITORIA',
                                     nuCausaInteres,
                                     nuPrograma,
                                     regNotInt.fila,
                                     regNotInt.maxrownum,
                                     nuerror,
                                     sbError);
                    IF nuerror <> 0 THEN
                      prActuaLogError(sbRowId
                      /*vtblProductos(idx).ID_REG*/
                      ,sbError||'  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']');
                      ROLLBACK;
                      sbConfirma := 'N';
                      nuErrorProd := -1;
                      EXIT;
                    ELSE
                       sbConfirma := 'S';
                    END IF;
                END IF;
              END LOOP;
             END IF;
                END IF;
              IF sbConfirma = 'S' THEN
                FOR regcA IN cuCalValorNota( vtblProductos(idx).CUCONUSE, vtblProductos(idx).CUCOfact, regCargosAct.CARGPECO)
                LOOP
                sbSigno       := NULL;
                nuerror       := NULL;
                sbError       := NULL;
                IF regcA.VALOR < 0 THEN
                  sbSigno     := 'CR';
                ELSE
                  sbSigno := 'DB';
                END IF;
                --dbms_output.put_line(vtblProductos(idx).CUCOcodi||' - '|| vtblProductos(idx).CUCOfact||'-'|| regcA.DPTTCONC);
                --se genera nota
                proGeneraNotaUsumar( vtblProductos(idx).factsusc, vtblProductos(idx).CUCONUSE, vtblProductos(idx).CUCOcodi, vtblProductos(idx).CUCOfact, regcA.UNIDAD, regcA.DPTTPERI, regcA.DPTTPECO, regcA.DPTTTAPL, regcA.DPTTCONC, sbSigno, ABS(regcA.VALOR), 'NOTA POR PROCESO DE TARIFA TRANSITORIA', regcA.fila, regcA.maxrownum, nuerror, sbError);
                IF nuerror <> 0 THEN
                  prActuaLogError(sbRowId
                  /*vtblProductos(idx).ID_REG*/
                  ,sbError||'  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']');
                  ROLLBACK;
                  sbConfirma := 'N';
                  nuErrorProd := -1;
                  EXIT;
                ELSE
                  sbConfirma := 'S';
                END IF;
                END LOOP;
              END IF;
                  IF sbConfirma = 'S' THEN
                    COMMIT;

          /*IF sbAplicaso501 = 'S' THEN
            nuerror := 0;
            sbError := NULL;
            FOR regSub IN cugetSubSidioAdi(vtblProductos(idx).CUCOfact) LOOP
              proGeneraNotaUsuario( vtblProductos(idx).factsusc,
                          vtblProductos(idx).CUCONUSE,
                          vtblProductos(idx).CUCOcodi,
                          vtblProductos(idx).CUCOfact,
                          regSub.unidades,
                          regSub.peri_fact,
                          regSub.peri_consumo,
                          NULL,
                          nuConcSubAdi,
                          'CR',
                          regSub.valor,
                          'NOTA GENERADA POR PROCESO DE SUNSIDIO ADICIONAL',
                          nuCausalSubAdi,
                          nuPrograma,
                          1,
                          1,
                          nuerror,
                          sbError);
              IF nuerror <> 0 THEN
                 prInsertLogErrorSub( vtblProductos(idx).CUCONUSE,
                          vtblProductos(idx).factsusc,
                          vtblProductos(idx).CUCOcodi,
                          vtblProductos(idx).CUCOfact,
                          regSub.peri_fact,
                          regSub.peri_consumo,
                          null,
                          nuConcSubAdi,
                          regSub.valor,
                          'CR',
                          nuCausalSubAdi,
                          regSub.unidades,
                          sbError
                          );
                 ROLLBACK;
              ELSE
                 prInsertLogErrorSub( vtblProductos(idx).CUCONUSE,
                          vtblProductos(idx).factsusc,
                          vtblProductos(idx).CUCOcodi,
                          vtblProductos(idx).CUCOfact,
                          regSub.peri_fact,
                          regSub.peri_consumo,
                          null,
                          nuConcSubAdi,
                          regSub.valor,
                          'CR',
                          nuCausalSubAdi,
                          regSub.unidades,
                          sbError
                          );
                 COMMIT;
              END IF;
            END LOOP;
          END IF;  */

                  ELSE
                     ROLLBACK;
                  END IF;
                END IF;




              ELSE
                prActuaLogError(sbRowId
                /*vtblProductos(idx).ID_REG*/
                , 'No se encontro consumo para el producto en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']');
                ROLLBACK;
              END IF;


            END LOOP;

            IF sbConfirma = 'S' THEN
              COMMIT;
            ELSE
              ROLLBACK;
            END IF;

            EXIT   WHEN cugetCuentas%NOTFOUND;
          END LOOP;
          CLOSE cugetCuentas;

     --liquidacion de productos a marcar
          OPEN cugetCuentasCalcularNota(vtblPeriodos(sbIndex).PEGPPERI, vtblPeriodos(sbIndex).PEGPCICL);
          LOOP
            FETCH cugetCuentasCalcularNota BULK COLLECT INTO vtblProdNoMar LIMIT limit_in;
            FOR idx IN 1..vtblProdNoMar.COUNT
            LOOP
              setvariables; --se setean las variables
              IF cuGetCargosConsActu%ISOPEN THEN
                CLOSE cuGetCargosConsActu;
              END IF;
              --se cosnultan cargos actuales
              OPEN cuGetCargosConsActu(vtblProdNoMar(idx).cucocodi, vtblProdNoMar(idx).cuconuse);
              FETCH cuGetCargosConsActu INTO regCargosAct;
              CLOSE cuGetCargosConsActu;
              IF NVL(regCargosAct.cargunid,0) > 0 THEN
                FOR indRang IN cuValorConsumo(vtblProdNoMar(idx).CUCONUSE, regCargosAct.CARGPEFA, regCargosAct.CARGPECO)
                LOOP
                  vregTarifaCon  := vregTarifaConnull;
                  onuvalornota   := NULL;
                  nuvaloTariCont := NULL;
                  --se valida tarifa aplicada
                  OPEN cuGetInfotarifa(regCargosAct.CARGTACO, regCargosAct.CARGCONC, indRang.TARIFA_VALOR, indRang.IDTARIFA );
                  FETCH cuGetInfotarifa INTO vregTarifaCon;
                  CLOSE cuGetInfotarifa;
                  -- DBMS_OUTPUT.PUT_LINE('rango tarifa    '||regCargosAct.CARGCONC||' '||vregTarifaCon.valor);
                  IF vregTarifaCon.mere IS NOT NULL THEN
                    --se genera nota de consumo
                    prGeneraProcNotas( vregTarifaCon, vtblProdNoMar(idx).factsusc, vtblProdNoMar(idx).CUCONUSE, vtblProdNoMar(idx).CUCOcodi, vtblProdNoMar(idx).CUCOfact, nuConcepto, indRang.UNIDAD_LIQUIDA, indRang.tarifa_valor, regCargosAct.CARGpefa, regCargosAct.CARGpeco, regCargosAct.CARGsign, nuTariconc, vtblProdNoMar(idx).indice, 0, onuvalornota, 0, nuDifetari,0,sbSignoAplica, nuerror, sbError );
                    IF nuerror = 0 THEN
                      IF cuGetCargosContri%ISOPEN THEN
                        CLOSE cuGetCargosContri;
                      END IF;
                      OPEN cuGetCargosContri(vtblProdNoMar(idx).cucocodi, vtblProdNoMar(idx).cuconuse);
                      FETCH cuGetCargosContri INTO regCargosContri;
                      IF cuGetCargosContri%FOUND THEN
                        IF cuGetInfotarifaCont%ISOPEN THEN
                          CLOSE cuGetInfotarifaCont;
                        END IF;
                        --     DBMS_OUTPUT.PUT_LINE('rango tarifa    '||regCargosAct.CARGCONC||' '||vregTarifaCon.valor);
                        --se consulta infromacion de contribucion
                        OPEN cuGetInfotarifaCont(regCargosContri.CARGTACO, regCargosContri.cargconc, vregTarifaCon.fecha_inicial);
                        FETCH cuGetInfotarifaCont INTO nuvaloTariCont;
                        CLOSE cuGetInfotarifaCont;
                        --      DBMS_OUTPUT.PUT_LINE('tarifa contri    '||nuvaloTariCont||' valor '||onuvalornota);
                        --se genera nota de contribucion
                        prGeneraProcNotas( vregTarifaCon, vtblProdNoMar(idx).factsusc, vtblProdNoMar(idx).CUCONUSE, vtblProdNoMar(idx).CUCOcodi, vtblProdNoMar(idx).CUCOfact, nuConcContri, NULL, nuvaloTariCont, regCargosContri.CARGpefa, regCargosContri.CARGpeco, regCargosContri.CARGsign, nuTariconc, vtblProdNoMar(idx).indice, 0, onuvalornota,0, nuDifetari,0, sbSignoAplica, nuerror, sbError );
                        IF nuerror <> 0 THEN
                          CLOSE cuGetCargosContri;
                          ROLLBACK;
                          sbError    := sbError||'  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']';
                          sbConfirma := 'N';
                          EXIT;
                        ELSE
                          sbConfirma := 'S';
                        END IF;
                      END IF;
                      CLOSE cuGetCargosContri;
                    ELSE
                      ROLLBACK;
                      sbError    := sbError||'  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']';
                      sbConfirma := 'N';
                      EXIT;
                    END IF;
                  ELSE
                    sbError    := 'No se encontro informacion de tarifa del producto  en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']';
                    sbConfirma := 'N';
                    EXIT;
                  END IF;
                END LOOP;
                IF sbConfirma = 'S' THEN
                  COMMIT;
                  SELECT SUM(DECODE(DPTTSIGN, 'DB', NVL(DPTTVANO,0), 'CR', -NVL(DPTTVANO,0)))
                  INTO nuValorDif
                  FROM LDC_DEPRTATT
                  WHERE DPTTSESU = vtblProdNoMar(idx).CUCONUSE;
                  prInsertLogError( vtblProdNoMar(idx).CUCONUSE, vtblPeriodos(sbIndex).PEGPCICL, sbError, nuValorDif );
                ELSE
                  prInsertLogError( vtblProdNoMar(idx).CUCONUSE, vtblPeriodos(sbIndex).PEGPCICL, sbError, 0);
                  ROLLBACK;
                END IF;
              ELSE
                prInsertLogError( vtblProdNoMar(idx).CUCONUSE, vtblPeriodos(sbIndex).PEGPCICL, 'No se encontro consumo para el producto en el periodo ['||vtblPeriodos(sbIndex).PEGPPERI||']', 0 );
                ROLLBACK;
        END IF;
            END LOOP;
            IF sbConfirma = 'S' THEN
              COMMIT;
            ELSE
              ROLLBACK;
            END IF;
            EXIT
          WHEN cugetCuentasCalcularNota%NOTFOUND;
          END LOOP;
          CLOSE cugetCuentasCalcularNota;

      --Se realiza proceso de comparto mi energia
          IF sbAplicaca440 = 'S' THEN
            --  ldc_proinsertaestaprog(nuparano,nuparmes,'LDC_PRVALMERCRELEVCONTRATO','En ejecucion',nutsess,sbparuser);
            LDC_PKGENNOTACOMENER.LDC_PRVALMERCRELEVCONTRATO(vtblPeriodos(sbIndex).PEGPPERI);
            --ldc_proactualizaestaprog(nutsess,SBERROR,'LDC_PRVALMERCRELEVCONTRATO','OK');
          END IF;

          --FIN CA 635
          --se coloca registro en procesando
          UPDATE LDC_PEFAGEPTT
          SET PEGPESTA = 'T'
          WHERE ROWID  = sbIdReg;
          COMMIT;
          sbmsg := 'Proceso de Liquidacion de Tarifa Transitoria Termino para el ciclo ['||vtblPeriodos(sbIndex).PEGPCICL||']';
          --se envia correo
           --se envia correo
          IF sbentregaOSF57 = 'N' THEN
		  
		   	  pkg_Correo.prcEnviaCorreo
										(
											isbRemitente        => sbfrom,
											isbDestinatarios    => sbto,
											isbAsunto           => sbsubject,
											isbMensaje          => sbmsg
										);

		  ELSE
		     BEGIN

			pkg_Correo.prcEnviaCorreo
										(
											isbRemitente        => sbfrom,
											isbDestinatarios    => sbto,
											isbAsunto           => sbsubject,
											isbMensaje          => sbmsg
										);
			 EXCEPTION
			    WHEN OTHERS THEN
				   ERRORS.SETERROR;
				   ERRORS.GETERROR(nuerror,SBERROR);
				   ldc_proactualizaestaprog(nutsess,SBERROR,'PRJOBGENENOTATT','error');
			 END;
		  END IF;
          sbIndex := vtblPeriodos.NEXT(sbIndex);
        END LOOP;
      END IF;
      ldc_proactualizaestaprog(nutsess,SBERROR,'PRJOBGENENOTATT','OK');
    END IF;
  EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    ERRORS.geterror(nuerror,SBERROR);
    ldc_proactualizaestaprog(nutsess,SBERROR,'PRJOBGENENOTATT','error');
    ROLLBACK;
    UPDATE LDC_PEFAGEPTT SET PEGPESTA = 'N' WHERE ROWID = sbIdReg;
    COMMIT;
  WHEN OTHERS THEN
    ERRORS.seterror;
    ERRORS.geterror(nuerror,SBERROR);
    ldc_proactualizaestaprog(nutsess,SBERROR,'PRJOBGENENOTATT','error');
    ROLLBACK;
    UPDATE LDC_PEFAGEPTT SET PEGPESTA = 'N' WHERE ROWID = sbIdReg;
    COMMIT;
  END PRJOBGENENOTATT;
  PROCEDURE PRGENECUPDES(
      inufactura  IN NUMBER,
      inususc     IN NUMBER,
      inuValoCuno IN NUMBER,
      onuValor OUT NUMBER,
      onuCuponDesc OUT NUMBER,
      onuerror OUT NUMBER,
      OSBERROR OUT VARCHAR2)
  IS
    /**************************************************************************
    Proceso     : PRGENECUPDES
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-05-26
    Ticket      : 415
    Descripcion : proceso que genera cupon de descuento
    Parametros Entrada
    inufactura numero de factura
    inuSusc   suscriptor
    inuValoCuno  valor del cupon normal
    Parametros de salida
    onuCuponDesc cupon de descuento
    onuerror codigo de error
    OSBERROR  mensaje de error
    OnuValor  valor
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    regCupon CUPON%ROWTYPE;
    nuValor    NUMBER ;
    sbPrograma VARCHAR2(40) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_NOMBPRCU',NULL);
    CURSOR cugetValorNota
    IS
      SELECT NVL(SUM(DECODE( DPTTSIGN, 'DB', NVL(DPTTVANO,0), -NVL(DPTTVANO,0))),0) valor
      FROM LDC_DEPRTATT
      WHERE DPTTFACT = inufactura;
  BEGIN
    --inicializa variables de error
    prinicializavarerror(onuerror, osbError );
    OPEN cugetValorNota;
    FETCH cugetValorNota INTO nuValor;
    CLOSE cugetValorNota;
    -- IF abs(nuValor) > 0  THEN
    nuValor   := inuValoCuno - NVL(nuValor,0);
    IF nuValor > 0 THEN
      FA_BOPOLITICAREDONDEO.VALIDAPOLITICACONT( inususc, nuValor );
      regCupon.CUPONUME := PKCOUPONMGR.FNUGETNEWCOUPONNUM;
      regCupon.CUPOTIPO := 'FA';
      regCupon.CUPODOCU := TO_CHAR(inufactura);
      regCupon.CUPOVALO := nuValor;
      regCupon.CUPOFECH := PKGENERALSERVICES.FDTGETSYSTEMDATE;
      regCupon.CUPOPROG := sbPrograma;
      regCupon.CUPOCUPA := NULL;
      regCupon.CUPOSUSC := inususc;
      regCupon.CUPOFLPA := PKCONSTANTE.NO;
      PKTBLCUPON.INSRECORD( regCupon );
      onuValor     := nuValor;
      onuCuponDesc := regCupon.CUPONUME;
    ELSE
      onuerror := -1;
      osbError := 'Producto no tiene notas generadas para el periodo';
    END IF;
    --  END IF;
    /*pkCouponMgr.GenerateCouponService( isbTipo       => 'FA',
    isbDocumento  => inufactura,
    inuValor      => inuValor,
    inuCuponPadre => NULL,
    idtCupoFech   => NULL,
    onuCuponCurr  => onuCuponDesc);*/
  EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    ERRORS.GETERROR(onuError,osbError );
  WHEN OTHERS THEN
    ERRORS.seterror;
    ERRORS.GETERROR(onuError,osbError );
  END PRGENECUPDES;
  PROCEDURE proGeneraNotaUsuario(
      inuSusc        IN NUMBER,
      inuprod        IN NUMBER,
      inucuenta      IN NUMBER,
      inufactura     IN NUMBER,
      inuUnidafact   IN NUMBER,
      inuperiodo     IN NUMBER,
      nupericon      IN NUMBER,
      nuTariconc     IN NUMBER,
      inuConcGene    IN NUMBER,
      isbSigno       IN VARCHAR2,
      nuValorNota    IN NUMBER,
      isbObservacion IN VARCHAR2,
      inuCausal      IN NUMBER,
      inuPrograma    IN NUMBER,
      inufila        IN NUMBER DEFAULT 0,
      inuFilaMax     IN NUMBER DEFAULT 0,
      onuerror OUT NUMBER,
      osberror OUT VARCHAR2)
  IS
    /**************************************************************************
    Proceso     : proGeneraNotaUsuario
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-05-26
    Ticket      : 415
    Descripcion : genera notas de usuario comparto mi energia
    Parametros Entrada
    inuSusc      contrato
    inuprod      producto
    inucuenta    cuenta
    inufactura   factura
    inuperiodo   periodo de facturacion
    nupericon    periodo de consumo
    nuTariconc   tarifa por concepto
    inuConcGene  concepto a generar
    isbSigno     signo
    nuValorNota  valor de la nota
    inuUnidafact  unidades facturadas
    isbObservacion  observacion
    inuCausal     causal de cargo
    inuPrograma   programa de cargo y nota
    inufila  fila aprocesar
    inuFilaMax  numero de fila
    Parametros de salida
    onuerror  codigo de error 0 - exito -1 error
    osbError  mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA       AUTOR           DESCRIPCION
    26/05/2020  LJLB            Creación   
    29/02/2024  jcatuchemvm     OSF-2308: Se elimina llamado PKBILLINGNOTEMGR.SETNOTENUMBERCREATED que genera concurrencia en consecutivos notas FAJU
    ***************************************************************************/
    inuConsDocu NUMBER;        --se almacena codigo de la nota
    isbDocSop   VARCHAR2(100); -- se almacena documento de soporte
    rcCargoNull cargos%rowtype;
    rcCargo cargos%rowtype;
    regNotas NOTAS%ROWTYPE;
    sbTipoNota notas.NOTATINO%type;
    sbDoso notas.NOTADOSO%type;
    nuTipoDocu notas.NOTACONS%type;
    sbSigno VARCHAR2(2);
  BEGIN
    onuerror      := 0;
    sbTipoNota    := NULL;
    sbDoso        := NULL;
    nuTipoDocu    := NULL;
    sbSigno       := NULL;
    IF isbSigno    = 'DB' THEN
      sbTipoNota  := 'D';
      nuTipoDocu  := 70;
      sbDoso      :='ND_';
      sbSigno     := 'DB';
    ELSIF isbSigno = 'CR' THEN
      sbTipoNota  := 'C';
      nuTipoDocu  := 71;
      sbDoso      :='NC_';
      sbSigno     := 'CR';
    END IF;
    --si el valor de la nota es mayor a cero se crea
    PKBILLINGNOTEMGR.GETNEWNOTENUMBER(inuConsDocu);
    UT_TRACE.TRACE( 'CONSECUTIVO DE LA NOTA '||inuConsDocu||' CONTRATO '||inuSusc , 10 );
    regNotas.NOTANUME := inuConsDocu ;
    regNotas.NOTASUSC := inuSusc ;
    regNotas.NOTAFACT := inufactura ;
    regNotas.NOTATINO := sbTipoNota ;
    regNotas.NOTAFECO := SYSDATE ;
    regNotas.NOTAFECR := SYSDATE ;
    regNotas.NOTAPROG := inuPrograma ;
    regNotas.NOTAUSUA := 1 ;
    regNotas.NOTATERM := NVL(userenv('TERMINAL'),'DESCO');
    regNotas.NOTACONS := nuTipoDocu;
    regNotas.NOTANUFI := NULL;
    regNotas.NOTAPREF := NULL;
    regNotas.NOTACONF := NULL;
    regNotas.NOTAIDPR := NULL;
    regNotas.NOTACOAE := NULL;
    regNotas.NOTAFEEC := NULL;
    regNotas.NOTAOBSE := isbObservacion ;
    regNotas.NOTADOCU := NULL ;
    regNotas.NOTADOSO := sbDoso || inuConsDocu ;
    PKTBLNOTAS.INSRECORD(regNotas);
    UT_TRACE.TRACE( 'CREANDO CARGOS, CONTRATO '||inuSusc , 10 );
    rcCargo          := rcCargoNull ;
    rcCargo.cargcuco := inucuenta;
    rcCargo.cargnuse := inuprod ;
    rcCargo.cargpefa := inuperiodo ;
    rcCargo.cargconc := inuConcGene ;
    rcCargo.cargcaca := inuCausal;
    rcCargo.cargsign := sbSigno ;
    rcCargo.cargvalo := nuValorNota ;
    rcCargo.cargdoso := sbDoso||inuConsDocu; -- isbDocumento ;  DEBE SER DF-NRODIFERIDO o ND-NRONOTA?
    rcCargo.cargtipr := 'P'
    /*pkBillConst.AUTOMATICO*/
    ;
    rcCargo.cargfecr := SYSDATE ;
    rcCargo.cargcodo := inuConsDocu; --  DEBE SER  numero de la nota
    rcCargo.cargunid := inuUnidafact ;
    rcCargo.cargcoll := NULL ;
    rcCargo.cargpeco := nupericon ;
    rcCargo.cargprog := inuPrograma; --
    rcCargo.cargusua := 1;
    rcCargo.cargtaco := nuTariconc;
    -- Adiciona el Cargo
    pktblCargos.InsRecord (rcCargo);
    UT_TRACE.TRACE( 'TERMINO DE CREAR CARGO ', 10 );
    -- Ajusta la Cuenta
    PKUPDACCORECEIV.UPDACCOREC ( PKBILLCONST.CNUSUMA_CARGO, inucuenta, inuSusc, inuprod, inuConcGene, sbSigno, nuValorNota, pkBillConst.cnuUPDATE_DB );
    IF inufila = inuFilaMax  and inuConcGene <> nuConcInteres THEN
    -- Genera saldo a favor
      GenPositiveBal( inucuenta, inuConcGene, inuConsDocu);
    END IF;
  EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    ERRORS.geterror(onuerror,osbError);
  WHEN OTHERS THEN
    ERRORS.SETERROR;
    ERRORS.geterror(onuerror,osbError);
  END proGeneraNotaUsuario;
  PROCEDURE proGeneraNotaUsumar(
      inuSusc        IN NUMBER,
      inuprod        IN NUMBER,
      inucuenta      IN NUMBER,
      inufactura     IN NUMBER,
      inuUnidafact   IN NUMBER,
      inuperiodo     IN NUMBER,
      nupericon      IN NUMBER,
      nuTariconc     IN NUMBER,
      inuConcGene    IN NUMBER,
      isbSigno       IN VARCHAR2,
      nuValorNota    IN NUMBER,
      isbObservacion IN VARCHAR2,
      inufila        IN NUMBER DEFAULT 0,
      inuFilaMax     IN NUMBER DEFAULT 0,
      onuerror OUT NUMBER,
      osberror OUT VARCHAR2)
  IS
    /**************************************************************************
    Proceso     : proGeneraNotaUsumar
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-05-26
    Ticket      : 415
    Descripcion : genera notas de proceso
    Parametros Entrada
    inuSusc      contrato
    inuprod      producto
    inucuenta    cuenta
    inufactura   factura
    inuperiodo   periodo de facturacion
    nupericon    periodo de consumo
    nuTariconc   tarifa por concepto
    inuConcGene  concepto a generar
    isbSigno     signo
    nuValorNota  valor de la nota
    inuUnidafact  unidades facturadas
    isbObservacion  observacion
    Parametros de salida
    onuerror  codigo de error 0 - exito -1 error
    osbError  mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA       AUTOR           DESCRIPCION
    26/05/2020  LJLB            Creación 
    29/02/2024  jcatuchemvm     OSF-2308: Se elimina llamado PKBILLINGNOTEMGR.SETNOTENUMBERCREATED que genera concurrencia en consecutivos notas FAJU
    ***************************************************************************/
    inuConsDocu NUMBER;        --se almacena codigo de la nota
    isbDocSop   VARCHAR2(100); -- se almacena documento de soporte
    rcCargoNull cargos%rowtype;
    rcCargo cargos%rowtype;
    regNotas NOTAS%ROWTYPE;
    inuCausal NUMBER := dald_parameter.fnugetnumeric_value('LDC_CAUSCARGTT',NULL); --se almacena causal de cargos
    sbTipoNota notas.NOTATINO%type;
    sbDoso notas.NOTADOSO%type;
    nuTipoDocu notas.NOTACONS%type;
    sbSigno          VARCHAR2(2);
    sbSignoAplicado  VARCHAR2(2);
    nuAjusteAplicado NUMBER;
  BEGIN
    onuerror      := 0;
    sbTipoNota    := NULL;
    sbDoso        := NULL;
    nuTipoDocu    := NULL;
    sbSigno       := NULL;
    IF isbSigno    = 'DB' THEN
      sbTipoNota  := 'D';
      nuTipoDocu  := 70;
      sbDoso      :='ND_';
      sbSigno     := 'DB';
    ELSIF isbSigno = 'CR' THEN
      sbTipoNota  := 'C';
      nuTipoDocu  := 71;
      sbDoso      :='NC_';
      sbSigno     := 'CR';
    END IF;
    --si el valor de la nota es mayor a cero se crea
    PKBILLINGNOTEMGR.GETNEWNOTENUMBER(inuConsDocu);
    UT_TRACE.TRACE( 'CONSECUTIVO DE LA NOTA '||inuConsDocu||' CONTRATO '||inuSusc , 10 );
    regNotas.NOTANUME := inuConsDocu ;
    regNotas.NOTASUSC := inuSusc ;
    regNotas.NOTAFACT := inufactura ;
    regNotas.NOTATINO := sbTipoNota ;
    regNotas.NOTAFECO := SYSDATE ;
    regNotas.NOTAFECR := SYSDATE ;
    regNotas.NOTAPROG := nuPrograma ;
    regNotas.NOTAUSUA := 1 ;
    regNotas.NOTATERM := NVL(userenv('TERMINAL'),'DESCO');
    regNotas.NOTACONS := nuTipoDocu;
    regNotas.NOTANUFI := NULL;
    regNotas.NOTAPREF := NULL;
    regNotas.NOTACONF := NULL;
    regNotas.NOTAIDPR := NULL;
    regNotas.NOTACOAE := NULL;
    regNotas.NOTAFEEC := NULL;
    regNotas.NOTAOBSE := isbObservacion ;
    regNotas.NOTADOCU := NULL ;
    regNotas.NOTADOSO := sbDoso || inuConsDocu ;
    PKTBLNOTAS.INSRECORD(regNotas);
    UT_TRACE.TRACE( 'CREANDO CARGOS, CONTRATO '||inuSusc , 10 );
    rcCargo          := rcCargoNull ;
    rcCargo.cargcuco := inucuenta;
    rcCargo.cargnuse := inuprod ;
    rcCargo.cargpefa := inuperiodo ;
    rcCargo.cargconc := inuConcGene ;
    rcCargo.cargcaca := inuCausal;
    rcCargo.cargsign := sbSigno ;
    rcCargo.cargvalo := nuValorNota ;
    rcCargo.cargdoso := sbDoso||inuConsDocu; -- isbDocumento ;  DEBE SER DF-NRODIFERIDO o ND-NRONOTA?
    rcCargo.cargtipr := 'P'
    /*pkBillConst.AUTOMATICO*/
    ;
    rcCargo.cargfecr := SYSDATE ;
    rcCargo.cargcodo := inuConsDocu; --  DEBE SER  numero de la nota
    rcCargo.cargunid := inuUnidafact ;
    rcCargo.cargcoll := NULL ;
    rcCargo.cargpeco := nupericon ;
    rcCargo.cargprog := nuPrograma; --
    rcCargo.cargusua := 1;
    rcCargo.cargtaco := nuTariconc;
    -- Adiciona el Cargo
    pktblCargos.InsRecord (rcCargo);
    UT_TRACE.TRACE( 'TERMINO DE CREAR CARGO ', 10 );
    /* pkAccountMgr.AdjustAccount
    (
    inucuenta,
    inuprod,
    inuCausal,
    nuPrograma,
    pkBillConst.cnuUPDATE_DB,
    sbSignoAplicado,
    nuAjusteAplicado,
    pkbillconst.POST_FACTURACION
    );*/
    -- Ajusta la Cuenta
    PKUPDACCORECEIV.UPDACCOREC ( PKBILLCONST.CNUSUMA_CARGO, inucuenta, inuSusc, inuprod, inuConcGene, sbSigno, nuValorNota, pkBillConst.cnuUPDATE_DB );
    IF inufila = inuFilaMax  THEN
      GenPositiveBal( inucuenta, inuConcGene,inuConsDocu );
    END IF;
  EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    ERRORS.geterror(onuerror,osbError);
  WHEN OTHERS THEN
    ERRORS.SETERROR;
    ERRORS.geterror(onuerror,osbError);
  END proGeneraNotaUsumar;
  PROCEDURE PRJOBACTPRODTT
  IS
    /**************************************************************************
    Proceso     : PRJOBACTPRODTT
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-05-26
    Ticket      : 415
    Descripcion : job que se encarga de generar nota para usuarios que paguen con cupon de
    descuento
    Parametros Entrada
    Parametros de salida
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    --variabe para estaproc
    nuparano   NUMBER;
    nuparmes   NUMBER;
    nutsess    NUMBER;
    sbparuser  VARCHAR2(400);
    nuerror    NUMBER;
    SBERROR    VARCHAR2(4000);
    sbConfirma VARCHAR2(1);
    CURSOR cuGetProdActiv
    IS
      SELECT p.ROWID id_reg,
        p.prttsesu ,
        p.PRTTCICL ciclo
      FROM ldc_prodtatt p
      WHERE p.prttgeno = 'S'
      AND p.prttacti   = 'N';
  TYPE tblProductoApr
IS
  TABLE OF cuGetProdActiv%ROWTYPE INDEX BY VARCHAR2(400);
TYPE tblProductos
IS
  TABLE OF cuGetProdActiv%ROWTYPE;
  vtblProductos tblProductos;
  vtblProductoApr tblProductoApr;
  CURSOR cuGetDetalleNota(inuProducto NUMBER)
  IS
    SELECT DPTTSESU ,
      DPTTCONT ,
      DPTTFERE ,
      DPTTCUCO ,
      DPTTFACT ,
      DPTTPERI ,
      DPTTPECO ,
      DPTTNUME ,
      DPTTCONC ,
      DPTTVANO ,
      DPTTSIGN ,
      DPTTCACA ,
      DPTTTAPL ,
      DPTTTACO ,
      DPTTTATT ,
      DPTTDIFE ,
      DPTTUNID ,
      DPTTRANG ,
      ROWNUM fila,
      MAX(ROWNUM) OVER (PARTITION BY '1') maxrownum
    FROM LDC_DEPRTATT
    WHERE DPTTSESU = inuProducto
    AND DPTTVANO   > 0
  order by DPTTSIGN desc;
  --se obtiene periodo actual
  CURSOR cuGetPerioactual(inuciclo NUMBER)
  IS
    SELECT pefacodi,
      pefafimo,
      pefaffmo
    FROM perifact
    WHERE pefacicl = inuciclo
    AND pefaactu   = 'S';
  nuPeriodo perifact.pefacodi%TYPE;
  dtFechaIni perifact.pefafimo%TYPE;
  dtFechaFin perifact.pefaffmo%TYPE;
  --se obtiene periodo de consumo actual
  CURSOR cugetPeriCons( inuciclo NUMBER, dttfechIni DATE, dttfechFin DATE )
  IS
    SELECT pc.PECSCONS
    FROM pericose pc
    WHERE pc.pecsfecf BETWEEN dttfechIni AND dttfechFin
    AND pc.pecscico = inuciclo;
  limit_in    NUMBER  := 100;
  nuCiclact   NUMBER  := -1;
  nuperiCons  NUMBER;
  nuErrorfact NUMBER;
  sbIndex     VARCHAR2(400);
BEGIN
  -- Consultamos datos para inicializar el proceso
  SELECT to_number(TO_CHAR(SYSDATE,'YYYY')) ,
    to_number(TO_CHAR(SYSDATE,'MM')) ,
    userenv('SESSIONID') ,
    USER
  INTO nuparano,
    nuparmes,
    nutsess,
    sbparuser
  FROM dual;
  -- Inicializamos el proceso
  ldc_proinsertaestaprog(nuparano,nuparmes,'PRJOBACTPRODTT','En ejecucion',nutsess,sbparuser);
  IF FBLAPLICAENTREGAXCASO('0000415') THEN
    --setear programa
    pkErrors.SetApplication(sbprograma);
    vtblProductoApr.DELETE;
    OPEN cuGetProdActiv;
    LOOP
      FETCH cuGetProdActiv BULK COLLECT INTO vtblProductos LIMIT limit_in;
      FOR idx IN 1..vtblProductos.COUNT
      LOOP
        UPDATE ldc_prodtatt
        SET prttgeno = 'P'
        WHERE ROWID  = vtblProductos(idx).id_reg;
        COMMIT;
        IF NOT vtblProductoApr.EXISTS(vtblProductos(idx).prttsesu) THEN
          vtblProductoApr(vtblProductos(idx).prttsesu).id_reg   := vtblProductos(idx).id_reg;
          vtblProductoApr(vtblProductos(idx).prttsesu).prttsesu := vtblProductos(idx).prttsesu;
          vtblProductoApr(vtblProductos(idx).prttsesu).ciclo    := vtblProductos(idx).ciclo;
        END IF;
      END LOOP;
      EXIT
    WHEN cuGetProdActiv%NOTFOUND;
    END LOOP;
    CLOSE cuGetProdActiv;
    IF vtblProductoApr.COUNT > 0 THEN
      sbIndex               := vtblProductoApr.FIRST;
      LOOP
        nuerror       := 0;
        sberror       := NULL;
        sbConfirma    := 'S';
        IF nuCiclact  <> vtblProductoApr(sbIndex).ciclo THEN
          nuCiclact   := vtblProductoApr(sbIndex).ciclo;
          nuPeriodo   := NULL;
          dtFechaIni  := NULL;
          dtFechaFin  := NULL;
          nuperiCons  := NULL;
          nuErrorfact := 0;
          --valida si el ciclo
          IF cuGetPerioactual%ISOPEN THEN
            CLOSE cuGetPerioactual;
          END IF;
          --se obtiene periodo actual
          OPEN cuGetPerioactual(vtblProductoApr(sbIndex).ciclo);
          FETCH cuGetPerioactual INTO nuPeriodo, dtFechaIni,dtFechaFin;
          IF cuGetPerioactual%NOTFOUND THEN
            nuErrorfact := -1;
            sberror     := 'Producto no tiene periodo de facturacion vigente activo';
          END IF;
          CLOSE cuGetPerioactual;
          IF nuErrorfact <> -1 THEN
            --se obtiene periodo de consumo
            OPEN cugetPeriCons(vtblProductoApr(sbIndex).ciclo, dtFechaIni,dtFechaFin);
            FETCH cugetPeriCons INTO nuperiCons;
            IF cugetPeriCons%NOTFOUND THEN
              nuErrorfact := -1;
              sberror     := 'No se encontro periodo de consumo vigente';
            END IF;
            CLOSE cugetPeriCons;
          END IF;
        END IF;
        IF nuErrorfact = -1 THEN
          prActuaLogError(vtblProductoApr(sbIndex).ID_REG,sbError);
        ELSE
          --se realiza detalle de notas
          FOR reg IN cuGetDetalleNota(vtblProductoApr(sbIndex).prttsesu)
          LOOP
            nuerror := 0;
            sberror := NULL;
            proGeneraNotaUsumar( inuSusc => reg.DPTTCONT, inuprod => reg.DPTTSESU, inucuenta => reg.DPTTCUCO, inufactura => reg.DPTTFACT, inuUnidafact => reg.DPTTUNID, inuperiodo => nuPeriodo, nupericon => nuperiCons, nuTariconc => reg.DPTTTAPL, inuConcGene => reg.DPTTCONC, isbSigno => reg.DPTTSIGN, nuValorNota => reg.DPTTVANO, isbObservacion => 'NOTA POR PROCESO DE TARIFA TRANSITORIA', inufila => reg.fila, inuFilaMax => reg.maxrownum , onuerror => nuerror, osberror => sberror);
            IF nuerror <> 0 THEN
              prActuaLogError(vtblProductoApr(sbIndex).ID_REG,sbError);
              ROLLBACK;
              sbConfirma := 'N';
              EXIT;
            ELSE
              sbConfirma := 'S';
            END IF;
          END LOOP;
        END IF;
        IF sbConfirma = 'S' THEN
          UPDATE ldc_prodtatt
          SET prttacti = 'S' ,
            PRTTERRO   = NULL
          WHERE ROWID  = vtblProductoApr(sbIndex).ID_REG;
          COMMIT;
        END IF;
        sbIndex := vtblProductoApr.NEXT(sbIndex);
      END LOOP;
    END IF;
  END IF;
ldc_proactualizaestaprog(nutsess,SBERROR,'PRJOBACTPRODTT','OK');
EXCEPTION
WHEN EX.CONTROLLED_ERROR THEN
  ERRORS.geterror(nuerror,SBERROR);
  ldc_proactualizaestaprog(nutsess,SBERROR,'PRJOBACTPRODTT','error');
  ROLLBACK;
WHEN OTHERS THEN
  ERRORS.seterror;
  ERRORS.geterror(nuerror,SBERROR);
  ldc_proactualizaestaprog(nutsess,SBERROR,'PRJOBACTPRODTT','error');
  ROLLBACK;
END PRJOBACTPRODTT;
FUNCTION FNUGETVALIPERIFIDF(
    inuPeriodo IN NUMBER)
  RETURN NUMBER
IS
  /**************************************************************************
  Proceso     : FNUGETVALIPERIFIDF
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-05-26
  Ticket      : 415
  Descripcion : funcion que valida si se muestra o no el fidf
  Parametros Entrada
  inuPeriodo  periodo
  Parametros de salida
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  nuerror NUMBER;
  SBERROR VARCHAR2(4000);
  sbestado LDC_PEFAGEPTT.PEGPESTA%TYPE;
  nuExiste NUMBER := 1;
  CURSOR cuGetProceTe
  IS
    SELECT PEGPESTA
    FROM LDC_PEFAGEPTT
    WHERE PEGPPERI = inuPeriodo
    AND PEGPPROC   = 'FGCC';
BEGIN
  IF FBLAPLICAENTREGAXCASO('0000415') THEN
    OPEN cuGetProceTe;
    FETCH cuGetProceTe INTO sbestado;
    IF cuGetProceTe%NOTFOUND THEN
      CLOSE cuGetProceTe;
      RETURN 1;
    END IF;
    CLOSE cuGetProceTe;
    IF sbestado <> 'T' THEN
      nuExiste  := 0;
    END IF;
  END IF;
  RETURN nuExiste;
EXCEPTION
WHEN EX.CONTROLLED_ERROR THEN
  ERRORS.geterror(nuerror,SBERROR);
  RETURN nuExiste;
WHEN OTHERS THEN
  ERRORS.seterror;
  ERRORS.geterror(nuerror,SBERROR);
  RETURN nuExiste;
END FNUGETVALIPERIFIDF;
PROCEDURE PRJOBGENECUPODES
IS
  /**************************************************************************
  Proceso     : PRJOBGENECUPODES
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-05-26
  Ticket      : 415
  Descripcion : job que genera cupon descuento
  Parametros Entrada
  Parametros de salida
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  --variabe para estaproc
  nuparano    NUMBER;
  nuparmes    NUMBER;
  nutsess     NUMBER;
  sbparuser   VARCHAR2(400);
  SBERROR     VARCHAR2(4000);
  nuerror     NUMBER;
  nuValorDesc NUMBER;
  nuCuponDesc NUMBER;
  SBROWID     VARCHAR2(400);
  --periodos a procesar
  CURSOR cuperiodoProc
  IS
    SELECT ROWID ID_REG,
      PEGPPERI,
      PEGPCICL
    FROM LDC_PEFAGEPTT
    WHERE PEGPESTA = 'N'
    AND PEGPPROC   = 'FIDF';
TYPE tblPeriodos
IS
  TABLE OF cuperiodoProc%ROWTYPE INDEX BY VARCHAR2(40);
  vtblPeriodos tblPeriodos;
  --se consultan productos
  CURSOR cugetProductoProce(inuperiodo NUMBER)
  IS
    SELECT id_reg,
      contrato,
      factura,
      cupon,
      (SELECT cupovalo FROM cupon WHERE cuponume = cupon
      ) valor
  FROM
    (SELECT t.rowid id_reg,
      SESUSUSC contrato,
      factcodi factura,
      (SELECT MAX(cuponume)
      FROM cupon
      WHERE cupodocu = TO_CHAR(factcodi)
      AND cupotipo   = 'FA'
      ) cupon
    FROM LDC_PRODTATT t,
      servsusc s,
      factura
    WHERE PRTTSESU = sesunuse
    AND PRTTACTI   = 'N'
    AND PRTTGENO   = 'N'
    AND PRTTERRO  IS NULL
    AND factpefa   = inuperiodo
    AND sesususc   = factsusc
    AND factprog   = 6
    )
  WHERE cupon IS NOT NULL;
type tbProductos
IS
  TABLE OF cugetProductoProce%ROWTYPE;
  vtbProductos tbProductos;
  limit_in NUMBER := 100;
  sbIndex  VARCHAR2(400);
  sbmsg    VARCHAR2(4000);
BEGIN
  -- Consultamos datos para inicializar el proceso
  SELECT to_number(TO_CHAR(SYSDATE,'YYYY')) ,
    to_number(TO_CHAR(SYSDATE,'MM')) ,
    userenv('SESSIONID') ,
    USER
  INTO nuparano,
    nuparmes,
    nutsess,
    sbparuser
  FROM dual;
  -- Inicializamos el proceso
  ldc_proinsertaestaprog(nuparano,nuparmes,'PRJOBGENECUPODES','En ejecucion',nutsess,sbparuser);
  IF FBLAPLICAENTREGAXCASO('0000415') THEN
    vtblPeriodos.DELETE;
    FOR reg IN cuperiodoProc
    LOOP
      --se coloca registro en procesando
      UPDATE LDC_PEFAGEPTT
      SET PEGPESTA = 'P'
      WHERE ROWID  = reg.ID_REG;
      COMMIT;
      IF NOT vtblPeriodos.EXISTS(reg.PEGPPERI) THEN
        vtblPeriodos(reg.PEGPPERI).ID_REG   := reg.ID_REG;
        vtblPeriodos(reg.PEGPPERI).PEGPPERI := reg.PEGPPERI;
        vtblPeriodos(reg.PEGPPERI).PEGPCICL := reg.PEGPCICL;
      END IF;
    END LOOP;
    IF vtblPeriodos.COUNT > 0 THEN
      sbIndex            := vtblPeriodos.FIRST;
      LOOP
        EXIT
      WHEN sbIndex IS NULL;
        -- FOR reg IN cuperiodoProc LOOP
        SBROWID := vtblPeriodos(sbIndex).ID_REG;
        /*UPDATE LDC_PEFAGEPTT SET PEGPESTA = 'P' WHERE ROWID = REG.ID_REG;
        COMMIT;*/
        OPEN cugetProductoProce(vtblPeriodos(sbIndex).PEGPPERI);
        LOOP
          FETCH cugetProductoProce BULK COLLECT INTO vtbProductos LIMIT limit_in;
          FOR idx IN 1..vtbProductos.COUNT
          LOOP
            nuValorDesc := NULL;
            nuCuponDesc := NULL;
            nuerror     := 0;
            SBERROR     := NULL;
            sbmsg       := NULL;
            --se genera cupon de descuento
            LDC_PKGESTIONTARITRAN.PRGENECUPDES( vtbProductos(idx).factura, vtbProductos(idx).contrato, vtbProductos(idx).valor, nuValorDesc, nuCuponDesc , nuerror , SBERROR );
            IF nuerror <> 0 THEN
              UPDATE LDC_PRODTATT
              SET PRTTERRO = SBERROR
              WHERE ROWID  = vtbProductos(idx).id_reg;
            ELSE
              UPDATE LDC_PRODTATT
              SET PRTTCUDE = nuCuponDesc,
                PRTTCUPR   = vtbProductos(idx).cupon,
                PRTTVACU   = nuValorDesc,
                PRTTDIFE   = ( vtbProductos(idx).valor - nuValorDesc)
              WHERE ROWID  = vtbProductos(idx).id_reg;
            END IF;
          END LOOP;
          EXIT
        WHEN cugetProductoProce%NOTFOUND;
        END LOOP;
        CLOSE cugetProductoProce;
        UPDATE LDC_PEFAGEPTT
        SET PEGPESTA = 'T'
        WHERE ROWID  = vtblPeriodos(sbIndex).ID_REG;
        COMMIT;
        sbmsg := 'Proceso de Doble cupon Termino para el ciclo ['||vtblPeriodos(sbIndex).PEGPCICL||']';
        --se envia correo
		  pkg_Correo.prcEnviaCorreo
									(
										isbRemitente        => sbfrom,
										isbDestinatarios    => sbto,
										isbAsunto           => sbsubject,
										isbMensaje          => sbmsg
									);
        -- END LOOP;
        sbIndex := vtblPeriodos.NEXT(sbIndex);
      END LOOP;
    END IF;
  END IF;
  ldc_proactualizaestaprog(nutsess,SBERROR,'PRJOBGENECUPODES','OK');
EXCEPTION
WHEN EX.CONTROLLED_ERROR THEN
  ERRORS.geterror(nuerror,SBERROR);
  ldc_proactualizaestaprog(nutsess,SBERROR,'PRJOBGENECUPODES','error');
  ROLLBACK;
  UPDATE LDC_PEFAGEPTT SET PEGPESTA = 'N' WHERE ROWID = SBROWID;
  COMMIT;
WHEN OTHERS THEN
  ERRORS.seterror;
  ERRORS.geterror(nuerror,SBERROR);
  ldc_proactualizaestaprog(nutsess,SBERROR,'PRJOBGENECUPODES','error');
  ROLLBACK;
  UPDATE LDC_PEFAGEPTT SET PEGPESTA = 'N' WHERE ROWID = SBROWID;
  COMMIT;
END PRJOBGENECUPODES;
PROCEDURE PRGENTRAMCANTT(
    inuProducto   IN NUMBER,
    inuMedioRecep IN NUMBER DEFAULT NULL,
    isObservacion IN VARCHAR2,
    inuCliente    IN NUMBER,
    idtFecha      IN DATE,
    OnuPackage_id OUT NUMBER,
    onuError OUT NUMBER,
    osbError OUT VARCHAR2 )
IS
  /**************************************************************************
  Proceso     : PRGENTRAMCANTT
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-05-26
  Ticket      : 415
  Descripcion : proceso que genera tramite de cancelacion por xml
  Parametros Entrada
  inuProducto      codigo del producto
  inuMedioRecep     medio de recepcion
  isObservacion   observacion
  inuCliente      Cliente
  idtFecha        fecha
  Parametros de salida
  onuerror codigo de error
  OSBERROR  mensaje de error
  OnuPackage_id solicitud creada
  HISTORIA DE MODIFICACIONES
  FECHA         AUTOR             DESCRIPCION
  25/01/2024    jpinedc           OSF-2020: Se cambia OS_REGISTERREQUESTWITHXML 
                                  por API_REGISTERREQUESTBYXML.
                                  Se quita fblAplicaEntregaxCaso  
  15/03/2023    jcatuchemvm       OSF-966 : Se ajusta cursor cuValidaProd para
                                  validación correcta de contrato
  26/05/2020    Luis Javier Lopez Creacion
  ***************************************************************************/
  sbRequestXML   VARCHAR2(4000);--se almacena xml
  dtFecha_inicio DATE;          --fecha de suspension
  nuContrato     NUMBER;
  numedioRec     NUMBER := DALD_PARAMETER.fnugetnumeric_value('LDC_MERETRCA', NULL);
  CURSOR cuValidaProd
  IS
    SELECT sesususc
    FROM LDC_PRODTATT,
      servsusc
    WHERE PRTTSESU = sesunuse
    AND PRTTACTI   = 'S'
    AND sesunuse   = inuProducto;
    onuMotiveId NUMBER;
BEGIN
    onuError := 0;
    osbError := NULL;

    IF idtFecha      IS NULL THEN
      dtFecha_inicio := SYSDATE + 1 / 24 / 60;
    ELSE
      dtFecha_inicio := idtFecha ;
    END IF;
    IF inuMedioRecep IS NOT NULL THEN
      numedioRec     := inuMedioRecep;
    END IF;
    IF isObservacion IS NULL THEN
      onuError       := -1;
      osbError       := 'Observacion debe ser obligatoria';
      RETURN;
    END IF;
    OPEN cuValidaProd;
    FETCH cuValidaProd INTO nuContrato;
    IF cuValidaProd%NOTFOUND THEN
      onuError := -1;
      osbError := 'Producto ['||inuProducto||'] no existe o no esta activo con tarifa transitoria';
    END IF;
    CLOSE cuValidaProd;
    IF onuError     = 0 THEN
      sbRequestXML := '<?xml version="1.0" encoding="ISO-8859-1"?>
<P_CANCELACION_DE_TARIFA_TRANSITORIA_100347 ID_TIPOPAQUETE="100347">
<FECHA_DE_SOLICITUD>'||dtFecha_inicio||'</FECHA_DE_SOLICITUD>
<RECEPTION_TYPE_ID>'||numedioRec||'</RECEPTION_TYPE_ID>
<CONTACT_ID>'||inuCliente||'</CONTACT_ID>
<COMMENT_>'||isObservacion||'</COMMENT_>
<M_CANCELACION_DE_TARIFA_TRANSITORIA_100313>
<PRODUCTO>'||inuProducto||'</PRODUCTO>
<CONTRATO>'||nuContrato||'</CONTRATO>
</M_CANCELACION_DE_TARIFA_TRANSITORIA_100313>
</P_CANCELACION_DE_TARIFA_TRANSITORIA_100347>';
      API_REGISTERREQUESTBYXML(sbRequestXML,OnuPackage_id,onuMotiveId,onuerror,OsbError);
    END IF;
EXCEPTION
WHEN EX.CONTROLLED_ERROR THEN
  ERRORS.geterror(onuError,osbError);
WHEN OTHERS THEN
  ERRORS.seterror;
  ERRORS.geterror(onuError,osbError);
END PRGENTRAMCANTT;
PROCEDURE PRGENENOTARETI(
    inuproducto IN NUMBER)
IS
  /**************************************************************************
  Proceso     : PRGENENOTARETI
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-05-26
  Ticket      : 415
  Descripcion : proceso que genera notas de retiro de un producto con tarifa transitoria
  Parametros Entrada
  inuProducto   codigo del producto
  Parametros de salida
  HISTORIA DE MODIFICACIONES
  FECHA         AUTOR             DESCRIPCION
  15/03/2023    jcatuchemvm       OSF-966 : Por directriz interna, en el retiro de tarifa transitoria
                                  solo considerar el concepto 130 - CONSUMO - RESCREG048. No se consideran
                                  los conceptos de subsidio en el retiro de tarifa transitoria
  26/05/2020    Luis Javier Lopez Creacion
  ***************************************************************************/
  CURSOR cuGetNotas
  IS
    SELECT CONCEPTO,
      valor,
      rOWNUM fila,
      MAX(ROWNUM) OVER (PARTITION BY '1') maxrownum

  FROM ( SELECT *
       FROM(
         SELECT DPTTCONC CONCEPTO,
        ROUND(SUM(DECODE(DPTTSIGN, 'CR', NVL(DPTTVANO,0), -NVL(DPTTVANO,0))),0) VALOR
        FROM LDC_DEPRTATT
        WHERE DPTTSESU = inuproducto
        AND   DPTTCONC = nuConcepto
        GROUP BY DPTTCONC
        )
      WHERE VALOR > 0
      ORDER BY VALOR DESC);
  --se obtiene periodo actual
  CURSOR cuGetPerioactual
  IS
    SELECT pefacodi,
      pefafimo,
      pefaffmo,
      sesucicl
    FROM perifact,
      servsusc
    WHERE pefacicl = sesucicl
    AND pefaactu   = 'S'
    AND sesunuse   = inuproducto;
  nuPeriodo perifact.pefacodi%TYPE;
  dtFechaIni perifact.pefafimo%TYPE;
  dtFechaFin perifact.pefaffmo%TYPE;
  nuCiclo servsusc.sesucicl%TYPE;
  --se obtiene periodo de consumo actual
  CURSOR cugetPeriCons( inuciclo NUMBER, dttfechIni DATE, dttfechFin DATE )
  IS
    SELECT pc.PECSCONS
    FROM pericose pc
    WHERE pc.pecsfecf BETWEEN dttfechIni AND dttfechFin
    AND pc.pecscico = inuciclo;
  nuperiCons  NUMBER;
  nuerror     NUMBER;
  sberror     VARCHAR2(4000);
  sbSigno     VARCHAR2(2);
  nuvalor     NUMBER;
  inuContrato NUMBER;
  onuFactura  NUMBER;
  onuCuenta   NUMBER;
  rcContrato suscripc%ROWTYPE;
  rcProducto servsusc%ROWTYPE;
  --se obtiene contrato
  CURSOR cugetContrato
  IS
    SELECT sesususc FROM servsusc WHERE sesunuse = inuproducto;
  sbConfirma  VARCHAR2(1);
  v_out       NUMBER;
  nuSolicitud NUMBER;
  sbinstance  VARCHAR2(4000);
BEGIN
  IF FBLAPLICAENTREGAXCASO('0000415') THEN
    nuPeriodo  := NULL;
    dtFechaIni := NULL;
    dtFechaFin := NULL;
    nuperiCons := NULL;
    sbConfirma := 'S';
    --setear programa
    pkErrors.SetApplication(sbprograma);
    --se obtiene periodo actual
    OPEN cuGetPerioactual;
    FETCH cuGetPerioactual INTO nuPeriodo, dtFechaIni,dtFechaFin, nuCiclo;
    IF cuGetPerioactual%NOTFOUND THEN
      CLOSE cuGetPerioactual;
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'Producto ['||inuproducto||'] no tiene periodo de facturacion vigente activo');
    END IF;
    CLOSE cuGetPerioactual;
    --se obtiene periodo de consumo
    OPEN cugetPeriCons(nuCiclo, dtFechaIni,dtFechaFin);
    FETCH cugetPeriCons INTO nuperiCons;
    IF cugetPeriCons%NOTFOUND THEN
      CLOSE cugetPeriCons;
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'No se encontro periodo de consumo vigente para el ciclo ['||nuCiclo||'] del Producto ['||inuproducto||']');
    END IF;
    CLOSE cugetPeriCons;
    OPEN cugetContrato;
    FETCH cugetContrato INTO inuContrato;
    IF cugetContrato%NOTFOUND THEN
      CLOSE cugetContrato;
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'No existe contrato para el  Producto ['||inuproducto||']');
    END IF;
    CLOSE cugetContrato;
    FOR reg IN cuGetNotas
    LOOP
      nuerror     := 0;
      sberror     := NULL;
      sbSigno     := NULL;
      nuValor     := NULL;
      IF REG.VALOR < 0 THEN
        sbSigno   := 'CR';
      ELSE
        sbSigno := 'DB';
      END IF;
      nuValor       := ABS(REG.VALOR);
      IF onuFactura IS NULL THEN
        --genera cuenta
        -- Se obtiene numero de factura
        pkAccountStatusMgr.GetNewAccoStatusNum(onuFactura);
        --Se obtiene el record del contrato
        rcContrato := pktblSuscripc.frcGetRecord(inuContrato);
        -- Se crea la nueva factura
        pkAccountStatusMgr.AddNewRecord(onuFactura, nuPrograma,
        /*pkGeneralServices.fnuIDProceso*/
        rcContrato, GE_BOconstants.fnuGetDocTypeCons);
        -- Se obtiene el consecutivo de la cuenta de cobro
        pkAccountMgr.GetNewAccountNum(onuCuenta);
        -- Se obtienen el record del producto
        rcProducto := pktblservsusc.frcgetrecord(inuProducto);
        -- Crea una nueva cuenta de cobro
        pkAccountMgr.AddNewRecord(onuFactura, onuCuenta, rcProducto);
        --procesa numeracion fiscal
        pkAccountStatusMgr.ProcesoNumeracionFiscal;
      END IF;
      --se genera nota
      proGeneraNotaUsumar( inuSusc => inuContrato, inuprod => inuProducto, inucuenta => onuCuenta, inufactura => onuFactura, inuUnidafact => NULL, inuperiodo => nuPeriodo, nupericon => nuperiCons, nuTariconc => NULL, inuConcGene => REG.CONCEPTO, isbSigno => sbSigno, nuValorNota => nuValor, isbObservacion => 'GENERACION DE NOTA POR RETIRO DE TARIFA TRANSITORIA', inufila => REG.fila, inuFilaMax => REG.maxrownum, onuerror => nuerror, osberror => sberror);
      IF sberror   <> 0 THEN
        sbConfirma := 'N';
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'Error al generar la nota al  Producto ['||inuproducto||'], erorr: '||sberror);
      END IF;
    END LOOP;
    IF sbConfirma = 'S' THEN
      GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbinstance);
      IF GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(sbinstance, NULL, 'MO_MOTIVE', 'PACKAGE_ID', v_out) = GE_BOCONSTANTS.GETTRUE THEN
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbinstance,NULL,'MO_MOTIVE','PACKAGE_ID',nuSolicitud);
      END IF;
      UPDATE LDC_PRODTATT
      SET PRTTACTI   = 'N',
        PRTTSOLI     = nuSolicitud ,
        PRTTUSUA     = USER,
        PRTTTERM     = NVL(userenv('TERMINAL'),'DESCO'),
        PRTTFEFI     = SYSDATE
      WHERE PRTTSESU = inuProducto;
    END IF;
  END IF;
EXCEPTION
WHEN EX.CONTROLLED_ERROR THEN
  RAISE EX.CONTROLLED_ERROR;
WHEN OTHERS THEN
  ERRORS.seterror;
  RAISE EX.CONTROLLED_ERROR;
END PRGENENOTARETI;
PROCEDURE prActuaErrorProd(
    isbRowid IN VARCHAR2,
    isberror IN VARCHAR2)
IS
  /**************************************************************************
  Proceso     : prActuaErrorProd
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-05-26
  Ticket      : 415
  Descripcion : Actualiza error a productos ajustado
  Parametros Entrada
  isbRowid  row id del registro
  isberror  error presentado
  Parametros de salida
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  PRAGMA AUTONOMOUS_TRANSACTION;
  onuError NUMBER;
  osbError VARCHAR2(4000);
BEGIN
  UPDATE LDC_PROAJUTT
  SET PRAJERRO = isberror,
    PRAJFEER   = SYSDATE
  WHERE rowid  = isbRowid;
  COMMIT;
EXCEPTION
WHEN EX.CONTROLLED_ERROR THEN
  ERRORS.GETERROR(onuError,osbError );
  UPDATE LDC_PROAJUTT
  SET PRAJERRO = osbError,
    PRAJFEER   = SYSDATE
  WHERE rowid  = isbRowid;
  COMMIT;
WHEN OTHERS THEN
  ERRORS.seterror;
  ERRORS.GETERROR(onuError,osbError );
  UPDATE LDC_PROAJUTT
  SET PRAJERRO = osbError,
    PRAJFEER   = SYSDATE
  WHERE rowid  = isbRowid;
  COMMIT;
END prActuaErrorProd;
PROCEDURE PRJOBCREAJUSTT
IS
  /**************************************************************************
  Proceso     : PRJOBCREAJUSTT
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-07-06
  Ticket      : 415
  Descripcion : proceso que genera nota de ajuste a los usuarios
  Parametros Entrada
  Parametros de salida
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  21/02/2021   HORBATH   CA 635 se realiza ajuste para calculo de interes
  ***************************************************************************/
  --variabe para estaproc
  nuparano     NUMBER;
  nuparmes     NUMBER;
  nutsess      NUMBER;
  sbparuser    VARCHAR2(400);
  SBERROR      VARCHAR2(4000);
  nuerror      NUMBER;
  sbProgfaju   VARCHAR2(400) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_PROGAJUFACT', NULL); --se almacena codigo del programa de ajuste
  OnuValorNota NUMBER;
  sbConfirma   VARCHAR2(1);
  OsbSigno     VARCHAR2(4000);
  sbSigno      VARCHAR2(2);
  nuUnidades   NUMBER;
  sbAumenta    VARCHAR2(1);
  nudifetari NUMBER;
  CURSOR cugetProductos
  IS
    SELECT ROWID ID_REG,
      PRAJSESU,
      PRAJPECO,
      PRAJCICL,
    PRAJSESU||PRAJPECO indice
    FROM LDC_PROAJUTT
    WHERE PRAJESTA = 'N'
   and prajproc = 'TARITRAN'
   order by PRAJPECO;
TYPE tblProdAjus
IS
  TABLE OF cugetProductos%ROWTYPE INDEX BY VARCHAR2(100);
  vtblProdAjus tblProdAjus;
  sbIndexProd VARCHAR2(100);

  CURSOR cugetProductosAdic
  IS
    SELECT ROWID ID_REG,
      PRAJSESU,
      PRAJPECO,
      PRAJCICL,
    PRAJSESU||PRAJPECO indice
    FROM LDC_PROAJUTT
    WHERE PRAJESTA = 'N'
   and prajproc = 'SUBDADIC';
TYPE tblProdAjusAdic
IS
  TABLE OF cugetProductosAdic%ROWTYPE INDEX BY VARCHAR2(100);
  vtblProdAjusAdic tblProdAjusAdic;
  sbIndexProdAdic VARCHAR2(100);

    CURSOR cugetCargosajuADIC(inuNuse NUMBER, inuPericons NUMBER)
  IS
    SELECT cargnuse,
      sesususc,
      cargconc,
      cargpeco,
      cargpefa,
      cargcuco,
      cucofact,
      cargunid,
       cargsign ,
      cucocate,
      cucosuca
    FROM open.cargos,
      open.cuencobr,
      open.servsusc
    WHERE cargcuco = cucocodi
    AND cargnuse   = inuNuse
    AND sesunuse   = cargnuse
    AND cargprog  IN
      (SELECT to_number(regexp_substr(sbProgfaju,'[^,]+', 1, LEVEL)) AS programa
      FROM dual
        CONNECT BY regexp_substr(sbProgfaju, '[^,]+', 1, LEVEL) IS NOT NULL
      )
  AND CARGSIGN IN ('DB', 'CR')
  AND CARGCONC = 31
  AND CARGPECO  = inuPericons
  ORDER BY cargnuse,
    cargconc;


  CURSOR cugetCargosaju(inuNuse NUMBER, inuPericons NUMBER)
  IS
    SELECT cargnuse,
      sesususc,
      cargconc,
      cargpeco,
      cargpefa,
      cargcuco,
      cucofact,
      cargunid,
      DECODE(CARGCONC, 37, NVL(OsbSigno,cargsign),cargsign) cargsign ,
      cucocate,
      cucosuca
    FROM open.cargos,
      open.cuencobr,
      open.servsusc
    WHERE cargcuco = cucocodi
    AND cargnuse   = inuNuse
    AND sesunuse   = cargnuse
    AND cargprog  IN
      (SELECT to_number(regexp_substr(sbProgfaju,'[^,]+', 1, LEVEL)) AS programa
      FROM dual
        CONNECT BY regexp_substr(sbProgfaju, '[^,]+', 1, LEVEL) IS NOT NULL
      )
  AND CARGSIGN IN ('DB', 'CR')
  AND CARGPECO  = inuPericons
  ORDER BY cargnuse,
    cargconc;
  --se consulta consumo liquidado
  CURSOR cuGetLiquProd(inuNuse NUMBER, inuPericons NUMBER, inuconc NUMBER)
  IS
    SELECT *
    FROM open.LDC_DEPRTATT
    WHERE DPTTSESU = inuNuse    --nunuse
    AND DPTTPECO   = inuPericons--nupericons
    AND DPTTCONC   = DECODE(inuconc, 31, nuConcepto, 196, nuConcSub, 37, nuConcContri)
  AND DPTTFERE   < SYSDATE - (5/24/60);
  regLiquiProd cuGetLiquProd%rowtype;
  regLiquiProdnull cuGetLiquProd%rowtype;
  --se consulta consumo liquidado
  CURSOR cuGetLiquProdRang1(inuNuse NUMBER, inuPericons NUMBER)
  IS
    SELECT *
    FROM open.LDC_DEPRTATT
    WHERE DPTTSESU = inuNuse    --nunuse
    AND DPTTPECO   = inuPericons--nupericons
    AND DPTTCONC   = nuConcepto
    AND DPTTRANG LIKE '0 -%'
  AND DPTTFERE   < SYSDATE - (5/24/60);
  regLiquProdRang1 cuGetLiquProdRang1%rowtype;
  regLiquProdRang1null cuGetLiquProdRang1%rowtype;
  --se consulta consumo liquidado
  CURSOR cuGetLiquProdRang2(inuNuse NUMBER, inuPericons NUMBER)
  IS
    SELECT *
    FROM open.LDC_DEPRTATT
    WHERE DPTTSESU = inuNuse    --nunuse
    AND DPTTPECO   = inuPericons--nupericons
    AND DPTTCONC   = nuConcepto
    AND DPTTRANG LIKE '21 -%'
  AND DPTTFERE   < SYSDATE - (5/24/60);
  regLiquProdRang2 cuGetLiquProdRang2%rowtype;
  regLiquProdRang2null cuGetLiquProdRang2%rowtype;
  CURSOR cuCalValorNota(inuproducto NUMBER, inuPeriodo NUMBER)
  IS
    SELECT d.*,
      ROWNUM fila,
      MAX(ROWNUM) OVER (PARTITION BY '1') maxrownum
    FROM
      (SELECT DPTTPERI,
        DPTTPECO,
        DPTTTAPL,
        DPTTCONC,
        DPTTCONT,
        DPTTCUCO,
        DPTTFACT,
        SUM(DECODE(DPTTSIGN, 'CR', -DPTTVANO, DPTTVANO )) VALOR,
        SUM(DPTTUNID) UNIDAD
      FROM LDC_DEPRTATT
      WHERE DPTTSESU = inuproducto
      AND DPTTPECO   = inuPeriodo
      AND DPTTFERE BETWEEN SYSDATE - (5/24/60) AND SYSDATE
      GROUP BY DPTTPERI,
        DPTTPECO,
        DPTTTAPL,
        DPTTCONC,
        DPTTCONT,
        DPTTCUCO,
        DPTTFACT
      ) d
  WHERE VALOR <> 0;

  nuTariconc    NUMBER;
  sbrango       VARCHAR2(400);
  nutarifa      NUMBER;
  nuUnidLigRag1 NUMBER;
  nuUnidLigRag2 NUMBER;
  nuDifer       NUMBER;
  idx           VARCHAR2(4000);
  --INICIO CA 501
  sbAplicaso501 VARCHAR2(2);

 CURSOR cuExisteSubadic(inuFactura NUMBER, inuPeriodo NUMBER, inuPericons NUMBER) IS
 SELECT 'X'
 FROM OPEN.LDC_DEPRSUAD
 WHERE DPSAFACT = inuFactura
-- AND DPSAPERI = inuPeriodo
  AND DPSAPECO = inuPericons
  AND DPSACONC = nuConcSubAdi;

  sbExistSubAdic VARCHAR2(1);
  nuApliDescAdic NUMBER;

   CURSOR cuExisteSubadicSub(inuproducto NUMBER, inuPericons NUMBER) IS
 SELECT DPSAUNID
 FROM oPEN.LDC_DEPRSUAD
 where DPSASESU = inuproducto
  and DPSAPECO =inuPericons
  AND DPSACONC = nuConcSubAdi;

  nuUnidadSub NUMBER;
   --rango liquidados del consumo
CURSOR cuValorConsumo(inuNuse NUMBER/*, InuPeriActu NUMBER*/, inupericose NUMBER)
IS
  SELECT RALILIIR rango_inicial,
  RALILISR RANGO_FINAL,
  RALIUNLI UNIDAD_LIQUIDA,
  RALIVAUL VALOR_UNIDAD,
  RALIVASU VALOR_SUBSIDIO,
  RALIVALO TARIFA_VALOR
  FROM RANGLIQU
  WHERE RALISESU = inuNuse
  --AND RALIPEFA   = InuPeriActu
  AND RALICONC   = 31
  AND ralipeco   = inupericose
  AND RALIUNLI   > 0
  AND RALILIIR = 0 ;

     --rango liquidados del consumo
CURSOR cuValorConsumorang2(inuNuse NUMBER/*, InuPeriActu NUMBER*/, inupericose NUMBER)
IS
  SELECT RALIUNLI UNIDAD_LIQUIDA
  FROM RANGLIQU
  WHERE RALISESU = inuNuse
  --AND RALIPEFA   = InuPeriActu
  AND RALICONC   = 31
  AND ralipeco   = inupericose
  AND RALIUNLI   > 0
  AND RALILIIR > 0 ;

  nuLiquMet2 NUMBER;
  sbExisteadic VARCHAR2(1);

  sbaplica608 VARCHAR2(1) :='N';

  --FIN CA 501

  --INICIO CA 635
  sbAplicaca635 VARCHAR2(1) := 'N';
  nuValorTariVariTT  number;
  nuDifereTari NUMBER;
  nuPromedio NUMBER;
  nuValorNota NUMBER;
  sbAplicaInte VARCHAR2(1) := 'S';

   CURSOR cuCalValorNotaInteFaju(inuproducto NUMBER, inuPeriodo NUMBER)
  IS
    with tarifas as
    (
     SELECT dpttdife diferencia, d1.dptttaco tarifa_consumo, d1.dptttatt tarifa_transitoria
     FROM OPEN.ldc_deprtatt d1
     WHERE DPTTSESU = inuproducto
      AND DPTTPECO   = inuPeriodo
      And DPTTCONC = nuConcepto
      AND DPTTFERE BETWEEN SYSDATE - (5/24/60) AND SYSDATE
      AND INSTR(d1.dpttrang,'21 - ') > 0

    )
    SELECT   ROWID id_reg,
            dpttperi perifact,
            decode(dpttsign,'CR', -1, 1) signo,
            dpttpeco pericons,
            dptttapl tarifa,
            dpttconc concepto,
			dptttatt tari_trans,
            decode(dpttrang,'0 - 20', nvl(( SELECT tarifa_consumo
                                            FROM tarifas
                                            WHERE ROWNUM < 2),0),dptttaco ) tarifa_consumo,
            decode(dpttrang,'0 - 20', nvl(( SELECT tarifa_transitoria
                                             FROM tarifas
                                             WHERE ROWNUM < 2),0),dptttatt ) tarifa_transitoria,
            decode(dpttrang,'0 - 20', nvl(( SELECT diferencia
                                           FROM tarifas
                                           WHERE ROWNUM < 2),0),dpttdife )
                                      diferencia,
            nvl(dpttunid,0) metros,
            dpttrang rango
      FROM LDC_DEPRTATT d
      WHERE DPTTSESU = inuproducto
        AND DPTTPECO   = inuPeriodo
        and DPTTCONC = nuConcepto
        AND DPTTFERE BETWEEN SYSDATE - (5/24/60) AND SYSDATE
      ;--group by DPTTPERI,ROWID, DPTTPECO,DPTTSIGN, DPTTCONC, DPTTRANG;

    CURSOR cuCalValorNotaInteAgruFaju(inuproducto NUMBER, inuPeriodo NUMBER) IS
       SELECT d.*,
      ROWNUM fila,
      MAX(ROWNUM) OVER (PARTITION BY '1') maxrownum
    FROM
      (SELECT DPTTCONT,
        DPTTCUCO,
        DPTTFACT,
        DPTTPERI,
        DPTTPECO,
        nuConcInteres DPTTCONC,
        SUM( nvl(DPTTSIME,0) + nvl(DPTTDIME,0)) VALOR
      FROM LDC_DEPRTATT
      WHERE DPTTSESU = inuproducto
      AND DPTTPECO   = inuPeriodo
    and DPTTCONC = nuConcepto
      AND DPTTFERE BETWEEN SYSDATE - (5/24/60) AND SYSDATE
      GROUP BY DPTTCONT,
        DPTTCUCO,
        DPTTFACT,
        DPTTPERI,
        DPTTPECO
      ) d
  WHERE VALOR <> 0;

  CURSOR cuValorTarifaVarFaju(inuProducto IN NUMBER, inupericose IN NUMBER ) IS
   SELECT R.RAVTVALO,
		  v.VITCFEIN,
		  c.TACOCR01,
		  c.TACOCR02,
		  c.TACOCR03
	FROM OPEN.ta_rangvitc r,
		OPEN.rangliqu rl, OPEN.TA_VIGETACO v, open.ta_tariconc c
	WHERE r.ravtvitc = rl.raliidre
	 AND rl.RALIIDRE = v.VITCCONS
	 AND c.TACOCONS = v.VITCTACO
	 AND 21 between r.ravtliin and r.RAVTLISU
	 AND rl.ralisesu = inuProducto
	 AND rl.ralipeco = inupericose
	 AND rl.RALIUNLI > 0
	 and rl.raliconc = 31 ;

  dtFechaInic DATE;
  nuProdAnte NUMBER := -1;
  nuValorTariConsumo NUMBER;
  --FIN CA 635
BEGIN
  -- Consultamos datos para inicializar el proceso
  SELECT to_number(TO_CHAR(SYSDATE,'YYYY')) ,
    to_number(TO_CHAR(SYSDATE,'MM')) ,
    userenv('SESSIONID') ,
    USER
  INTO nuparano,
    nuparmes,
    nutsess,
    sbparuser
  FROM dual;
  -- Inicializamos el proceso
  ldc_proinsertaestaprog(nuparano,nuparmes,'PRJOBCREAJUSTT','En ejecucion',nutsess,sbparuser);
  IF FBLAPLICAENTREGAXCASO('0000415') THEN


  IF FBLAPLICAENTREGAXCASO('0000608') THEN
      sbaplica608 := 'S';
    END IF;

    --INICIO CA 635
    IF FBLAPLICAENTREGAXCASO('0000635') THEN
      sbAplicaca635 := 'S';
    END IF;
    --FIN CA 635


  vtblProdAjus.DELETE;
  --setear programa
      pkErrors.SetApplication(sbprograma);

    FOR reg IN cugetProductos
    LOOP
      --se coloca registro en procesando
      UPDATE LDC_PROAJUTT
      SET PRAJESTA = 'P'
      WHERE ROWID  = reg.ID_REG;
      COMMIT;
      IF NOT vtblProdAjus.EXISTS(reg.indice) THEN
        vtblProdAjus(reg.indice).ID_REG   := reg.ID_REG;
        vtblProdAjus(reg.indice).PRAJSESU := reg.PRAJSESU;
        vtblProdAjus(reg.indice).PRAJPECO := reg.PRAJPECO;
        vtblProdAjus(reg.indice).PRAJCICL := reg.PRAJCICL;
      END IF;
    END LOOP;
    --FOR idx IN 1..vtblProdAjus.COUNT LOOP
    IF vtblProdAjus.COUNT > 0 THEN
      idx                := vtblProdAjus.FIRST;
      LOOP
        EXIT
      WHEN idx       IS NULL;
        sbConfirma   := 'S';
        OsbSigno     := NULL;
        OnuValorNota := 0;
        sbAumenta    := NULL;
        nuUnidades   := NULL;
        nuApliDescAdic := 0;
        --se consultan consumo ajustados
        FOR reg IN cugetCargosaju(vtblProdAjus(idx).PRAJSESU, vtblProdAjus(idx).PRAJPECO)
        LOOP
          nuerror       := NULL;
          sberror       := NULL;
          nutarifa      := NULL;
          --nuUnidLigRag1 := 0;
          nuUnidLigRag2 := 0;
          nuDifer       := 0;
      sbExistSubAdic := NULL;
      sbExisteadic := null;

          IF cuGetLiquProdRang1%ISOPEN THEN
            CLOSE cuGetLiquProdRang1;
          END IF;
          IF cuGetLiquProdRang2%ISOPEN THEN
            CLOSE cuGetLiquProdRang2;
          END IF;
          IF cuGetLiquProd%ISOPEN THEN
            CLOSE cuGetLiquProd;
          END IF;
          IF cuGetInfotarifa%ISOPEN THEN
            CLOSE cuGetInfotarifa;
          END IF;


          --se valida si el usuario tiene subsidio
          IF reg.cucocate      = 1 AND reg.cucosuca IN (1,2) THEN
            IF REG.cargsign    = 'CR' AND reg.cargconc = 31 THEN
              sbAumenta       := 'N';
              nuUnidades      := -1 * reg.cargunid;
            ELSIF REG.cargsign = 'DB' AND reg.cargconc = 31 THEN
              sbAumenta       := 'S';
              nuUnidades      := reg.cargunid;
            END IF;
            IF reg.cargconc     = 31 THEN
              regLiquProdRang1 := regLiquProdRang1null;
              regLiquProdRang2 := regLiquProdRang2null;
              --se cargan rangos liquidados de 0 a 20
              OPEN cuGetLiquProdRang1(reg.cargnuse, REG.cargpeco);
              FETCH cuGetLiquProdRang1 INTO regLiquProdRang1;
              CLOSE cuGetLiquProdRang1;
              nuDifer             := 20 - regLiquProdRang1.DPTTUNID ;
              IF sbAumenta         = 'S' THEN
                IF nuDifer         > 0 THEN
                  IF nuUnidades    > nuDifer THEN
                    nuUnidades    := nuUnidades - nuDifer;
                    nuUnidLigRag1 := nuDifer;
                  ELSE
                    nuUnidLigRag1 := nuUnidades;
                    nuUnidades    := 0;
                  END IF;
                  --se genera la nota
                  proGeneraNota( REG.sesususc,
                                 REG.cargnuse,
                               REG.cargcuco,
                               REG.cucofact,
                               nuUnidLigRag1,
                               regLiquProdRang1.DPTTTACO,
                               regLiquProdRang1.DPTTTATT,
                               REG.cargpefa,
                               REG.cargpeco,
                               regLiquProdRang1.DPTTTAPL,
                               regLiquProdRang1.DPTTCONC,
                               REG.cargsign,
                               3,
                               OnuValorNota,
                               regLiquProdRang1.DPTTRANG,
                               0,
                               0,
                               OsbSigno,
                               nuerror,
                               sberror);


          IF nuerror <> 0 THEN
                    prActuaErrorProd(vtblProdAjus(idx).ID_REG, sberror);
                    ROLLBACK;
                    sbConfirma := 'N';
                    EXIT;
                  END IF;

          nuApliDescAdic := 1;
                END IF;
                IF ( nuUnidades) > 0 THEN
                  --se cargan rangos liquidados de 21 en adelante
                  OPEN cuGetLiquProdRang2(reg.cargnuse, REG.cargpeco);
                  FETCH cuGetLiquProdRang2 INTO regLiquProdRang2;
                  IF cuGetLiquProdRang2%NOTFOUND THEN
                    --se busca tarifa de liquidacion para rango 2
                    vregTarifaCon := vregTarifaConnull;
                    onuvalornota  := NULL;
                    --se valida tarifa aplicada
                    OPEN cuGetInfotarifa(regLiquProdRang1.DPTTTAPL, nuConcepto, regLiquProdRang1.DPTTTATT , null);
                    FETCH cuGetInfotarifa INTO vregTarifaCon;
                    CLOSE cuGetInfotarifa;
                    --  DBMS_OUTPUT.PUT_LINE('TARIFAS  '||vregTarifaCon.mere);
                    IF vregTarifaCon.mere   IS NOT NULL THEN
                      vregTarifaCon.rangini := 21;
                      vregTarifaCon.rango   := '21 - 999999999';
                      --se obtiene tarifa de concepto
                      nutarifa := fnuObtenerTarifa(vregTarifaCon.cate, vregTarifaCon.suca, vregTarifaCon.mere, vregTarifaCon.fecha_inicial, 21, --inuUnidad,
                      31, vregTarifaCon.cate||vregTarifaCon.suca||vregTarifaCon.mere||'311'||TO_CHAR(vregTarifaCon.fecha_inicial,'ddmmyyyy'), nuTariconc, sbrango, nuerror, sbError );
                      IF nuerror <> 0 THEN
                        prActuaErrorProd(vtblProdAjus(idx).ID_REG, sberror);
                        ROLLBACK;
                        sbConfirma := 'N';
                        CLOSE cuGetLiquProdRang2;
                        EXIT;
                      ELSE
                        --se genera nota de consumo
                        prGeneraProcNotas( vregTarifaCon, REG.sesususc, REG.cargnuse, REG.cargcuco, REG.cucofact, nuConcepto, nuUnidades, nutarifa, reg.CARGpefa, reg.CARGpeco, reg.CARGsign, nuTariconc, vregTarifaCon.cate||vregTarifaCon.suca||vregTarifaCon.mere, 3, OnuValorNota,0, nudifetari,0, OsbSigno, nuerror, sbError );
                        IF nuerror <> 0 THEN
                          prActuaErrorProd(vtblProdAjus(idx).ID_REG, sberror);
                          ROLLBACK;
                          sbConfirma := 'N';
                          CLOSE cuGetLiquProdRang2;
                          EXIT;
                        END IF;
                      END IF;
                    END IF;
                  ELSE
                    --se genera la nota
                    proGeneraNota( REG.sesususc, REG.cargnuse, REG.cargcuco, REG.cucofact, nuUnidades, regLiquProdRang2.DPTTTACO, regLiquProdRang2.DPTTTATT, REG.cargpefa, REG.cargpeco, regLiquProdRang2.DPTTTAPL, regLiquProdRang2.DPTTCONC, REG.cargsign, 3, OnuValorNota, regLiquProdRang2.DPTTRANG, 0,0,OsbSigno, nuerror, sberror);
                    IF nuerror <> 0 THEN
                      prActuaErrorProd(vtblProdAjus(idx).ID_REG, sberror);
                      ROLLBACK;
                      sbConfirma := 'N';
                      CLOSE cuGetLiquProdRang2;
                      EXIT;
                    END IF;
                  END IF;
                  CLOSE cuGetLiquProdRang2;
                END IF;
              ELSE
                --se cargan rangos liquidados de 21 en adelante
                OPEN cuGetLiquProdRang2(reg.cargnuse, REG.cargpeco);
                FETCH cuGetLiquProdRang2 INTO regLiquProdRang2;
                IF cuGetLiquProdRang2%FOUND THEN
                  IF ABS(nuUnidades) > regLiquProdRang2.DPTTUNID THEN
                    nuUnidades      := nuUnidades + regLiquProdRang2.DPTTUNID;
                    nuUnidLigRag2   := regLiquProdRang2.DPTTUNID;
                  ELSE
                    nuUnidLigRag2 := ABS(nuUnidades);
                    nuUnidades    := 0;
                  END IF;
                  --se genera la nota
                  proGeneraNota( REG.sesususc, REG.cargnuse, REG.cargcuco, REG.cucofact, nuUnidLigRag2, regLiquProdRang2.DPTTTACO, regLiquProdRang2.DPTTTATT, REG.cargpefa, REG.cargpeco, regLiquProdRang2.DPTTTAPL, regLiquProdRang2.DPTTCONC, REG.cargsign, 3, OnuValorNota, regLiquProdRang2.DPTTRANG, 0,0,OsbSigno, nuerror, sberror);
                  IF nuerror <> 0 THEN
                    prActuaErrorProd(vtblProdAjus(idx).ID_REG, sberror);
                    ROLLBACK;
                    sbConfirma := 'N';
                    CLOSE cuGetLiquProdRang2;
                    EXIT;
                  END IF;
                END IF;
                CLOSE cuGetLiquProdRang2;
                IF nuUnidades   <> 0 THEN
                  nuUnidLigRag1 := ABS(nuUnidades);
                  --se genera la nota
                  proGeneraNota( REG.sesususc, REG.cargnuse, REG.cargcuco, REG.cucofact, nuUnidLigRag1, regLiquProdRang1.DPTTTACO, regLiquProdRang1.DPTTTATT, REG.cargpefa, REG.cargpeco, regLiquProdRang1.DPTTTAPL, regLiquProdRang1.DPTTCONC, REG.cargsign, 3, OnuValorNota, regLiquProdRang1.DPTTRANG, 0,0,OsbSigno, nuerror, sberror);
                  IF nuerror <> 0 THEN
                    prActuaErrorProd(vtblProdAjus(idx).ID_REG, sberror);
                    ROLLBACK;
                    sbConfirma := 'N';
                    EXIT;
                  END IF;

          nuApliDescAdic := -1;

                END IF;
              END IF;

        IF  sbConfirma = 'S' AND nuApliDescAdic <> 0  AND sbaplica608 = 'S' THEN
             OPEN cuExisteSubadic(regLiquProdRang1.DPTTFACT,REG.cargpefa, REG.cargpeco);
             FETCH cuExisteSubadic INTO sbExistSubAdic;
             CLOSE cuExisteSubadic;

             OPEN cuValidaIniSubAdic(reg.cargpeco);
               FETCH cuValidaIniSubAdic INTO sbExisteadic;
               CLOSE cuValidaIniSubAdic;

         IF sbExistSubAdic IS NOT NULL or sbExisteadic is not null THEN
           nuerror := 0;
           sbError := NULL;
           proGeneraNotaUsuario( REG.sesususc,
                      REG.cargnuse,
                      REG.cargcuco,
                      REG.cucofact,
                      nuUnidLigRag1,
                      REG.cargpefa,
                      REG.cargpeco,
                      NULL,
                      nuConcSubAdi,
                     ( case when nuApliDescAdic =  1 then 'CR' else 'DB' end) ,
                      round( regLiquProdRang1.DPTTTACO * nuUnidLigRag1  * (nuPorcSubAdi/100),0),
                      'NOTA GENERADA POR PROCESO DE SUSIDIO ADICIONAL',
                      nuCausalSubAdi,
                      nuPrograma,
                      1,
                      1,
                      nuerror,
                      sbError);
            IF nuerror <> 0 THEN
               prInsertLogErrorSub( REG.cargnuse,
                        REG.sesususc,
                        REG.cargcuco,
                        REG.cucofact,
                        REG.cargpefa,
                        REG.cargpeco,
                        null,
                        nuConcSubAdi,
                        round( regLiquProdRang1.DPTTTACO * nuUnidLigRag1  * (nuPorcSubAdi/100),0),
                        ( case when nuApliDescAdic =  1 then 'CR' else 'DB' end),
                        nuCausalSubAdi,
                        nuUnidLigRag1,
                        sbError
                        );
               ROLLBACK;
               sbConfirma := 'N';
              exit;
            ELSE
               prInsertLogErrorSub( REG.cargnuse,
                        REG.sesususc,
                        REG.cargcuco,
                        REG.cucofact,
                        REG.cargpefa,
                        REG.cargpeco,
                        null,
                        nuConcSubAdi,
                        round( regLiquProdRang1.DPTTTACO * nuUnidLigRag1  * (nuPorcSubAdi/100),0),
                        ( case when nuApliDescAdic =  1 then 'CR' else 'DB' end),
                        nuCausalSubAdi,
                         nuUnidLigRag1,
                        sbError
                        );
            END IF;



         END IF;


        END IF;

            ELSE
              regLiquiProd := regLiquiProdnull;
              OPEN cuGetLiquProd(reg.cargnuse, REG.cargpeco, reg.cargconc);
              FETCH cuGetLiquProd INTO regLiquiProd;
              CLOSE cuGetLiquProd;
              --se genera la nota
              proGeneraNota( REG.sesususc, REG.cargnuse, REG.cargcuco, REG.cucofact, REG.cargunid, regLiquiProd.DPTTTACO, regLiquiProd.DPTTTATT, REG.cargpefa, REG.cargpeco, regLiquiProd.DPTTTAPL, regLiquiProd.DPTTCONC, REG.cargsign, 3, OnuValorNota, regLiquiProd.DPTTRANG, 0, 0,OsbSigno, nuerror, sberror);
              IF nuerror <> 0 THEN
                prActuaErrorProd(vtblProdAjus(idx).ID_REG, sberror);
                ROLLBACK;
                sbConfirma := 'N';
                EXIT;
              END IF;

          if regLiquiProd.DPTTconc = nuConcSub AND sbaplica608 = 'S' THEN

               OPEN cuExisteSubadic(regLiquiProd.DPTTFACT,REG.cargpefa, REG.cargpeco);
               FETCH cuExisteSubadic INTO sbExistSubAdic;
               CLOSE cuExisteSubadic;

               OPEN cuValidaIniSubAdic(reg.cargpeco);
                 FETCH cuValidaIniSubAdic INTO sbExisteadic;
                 CLOSE cuValidaIniSubAdic;

         IF sbExistSubAdic IS NOT NULL or sbExisteadic is not null THEN

          --se ajusta subsidio adicional transitorio
          proGeneraNotaSubAdic( REG.sesususc,
                       REG.cargnuse,
                       REG.cargcuco,
                       REG.cucofact,
                        REG.cargunid,--nuUnidLigRag1,
                       REG.cargpefa,
                       REG.cargpeco,
                       REG.cargsign,
                       regLiquiProd.DPTTRANG,
                       ( regLiquProdRang1.DPTTTACO - regLiquProdRang1.DPTTTATT),
                      (regLiquiProd.DPTTTACO - regLiquiProd.DPTTTATT),
                      nuerror,
                      sbError);
            IF nuerror <> 0 THEN
               ROLLBACK;
               sbConfirma := 'N';
               prActuaErrorProd(vtblProdAjus(idx).ID_REG, sberror);
               exit;
            END IF;
         END IF;
        END IF;
            END IF;
          ELSE
            regLiquiProd := regLiquiProdnull;
            OPEN cuGetLiquProd(reg.cargnuse, REG.cargpeco, reg.cargconc);
            FETCH cuGetLiquProd INTO regLiquiProd;
            CLOSE cuGetLiquProd;
            --se genera la nota
            proGeneraNota( REG.sesususc, REG.cargnuse, REG.cargcuco, REG.cucofact, REG.cargunid, regLiquiProd.DPTTTACO, regLiquiProd.DPTTTATT, REG.cargpefa, REG.cargpeco, regLiquiProd.DPTTTAPL, regLiquiProd.DPTTCONC, REG.cargsign, 3, OnuValorNota, regLiquiProd.DPTTRANG, 0, 0,OsbSigno, nuerror, sberror);
            IF nuerror <> 0 THEN
              prActuaErrorProd(vtblProdAjus(idx).ID_REG, sberror);
              ROLLBACK;
              sbConfirma := 'N';
              EXIT;
            END IF;


          END IF;
        END LOOP;
        IF sbConfirma = 'S' THEN
            --INICIO CA 635
          IF sbAplicaca635 = 'S' THEN
              FOR regInt IN cuCalValorNotaInteFaju( vtblProdAjus(idx).PRAJSESU, vtblProdAjus(idx).PRAJPECO) LOOP
                 nuerror       := NULL;
                 sbError       := NULL;
                 nuPromedio := 0;
                 nuValorNota := 0;
                --  IF nuProdAnte = -1 or nuProdAnte <> vtblProdAjus(idx).PRAJSESU THEN
                  nuValorTariVariTT := 0;
                   nuDifereTari := 0;
                   nuPromedio := 0;
                   nuValorTariConsumo := 0;
                   IF cuObteFechaLiq%ISOPEN THEN
                      CLOSE cuObteFechaLiq;
                   END IF;

                  open cuObteFechaLiq(regInt.tarifa, regInt.CONCEPTO,regInt.tari_trans );
                  fetch cuObteFechaLiq into dtFechaInic;
                  CLOSE cuObteFechaLiq;


                  setPorcInte(dtFechaInic,  nuerror, sbError );
                  IF nuerror <> 0 THEN
                    ERRORS.SETERROR(2741, sbError);
                     RAISE EX.CONTROLLED_ERROR;
                  END IF;

                   if regInt.DIFERENCIA =  0 then

                     IF cuValorTarifaVarFaju%ISOPEN THEN
                          CLOSE cuValorTarifaVarFaju;
                     END IF;

                     OPEN cuValorTarifaVarFaju(vtblProdAjus(idx).PRAJSESU, vtblProdAjus(idx).PRAJPECO);
                     FETCH cuValorTarifaVarFaju INTO regTarifaVar;
                     IF cuValorTarifaVarFaju%NOTFOUND THEN
                         prActuaErrorProd(vtblProdAjus(idx).ID_REG, 'El producto ['||vtblProdAjus(idx).PRAJSESU||' no tiene tarifa en el periodo ['||regInt.perifact||'] para calculo de interes');
                         CLOSE cuValorTarifaVarFaju;
                         sbAplicaInte := 'N';
                         EXIT;
                     else
                       IF cuValorTarifaVarTT%ISOPEN THEN
                          CLOSE cuValorTarifaVarTT;
                       END IF;
                       OPEN cuValorTarifaVarTT( regTarifaVar.VITCFEIN,
                                                regTarifaVar.TACOCR01,
                                                regTarifaVar.TACOCR02,
                                                regTarifaVar.TACOCR03);
                       FETCH cuValorTarifaVarTT INTO nuValorTariVariTT;
                       CLOSE cuValorTarifaVarTT;

                       nuDifereTari := regTarifaVar.RAVTVALO - NVL(nuValorTariVariTT,0) ;
                     END IF;
                     CLOSE cuValorTarifaVarFaju;
                    nuValorTariConsumo := regTarifaVar.RAVTVALO;
                  ELSE
                     nuDifereTari := regInt.DIFERENCIA;
                     nuValorTariConsumo := regInt.TARIFA_CONSUMO;
                     nuValorTariVariTT := regInt.TARIFA_TRANSITORIA;
                  end if;

                  --nuProdAnte := vtblProdAjus(idx).PRAJSESU;
                  --END IF;

                  IF nuDifereTari < 0 THEN
                    nuPromedio := fnuGetPromAcum ( vtblProdAjus(idx).PRAJSESU,
                                                     regInt.perifact,
                                                    vtblProdAjus(idx).PRAJPECO,
                                                    NUcONCEPTO,
                                                    regInt.RANGO,
                                                    3);
                     nuValorNota  := abs( ROUND(nuDifereTari * regInt.METROS * nuPromedio,0)) * regInt.signo;
                  ELSE
                    nuValorNota  := abs(ROUND(nuDifereTari * regInt.METROS,0))  * regInt.signo;
                  END IF;
                 --se actualiza valor para acumulado e interes
                 PRACTUALLIQINT( vtblProdAjus(idx).PRAJSESU,
                                regInt.PERIFACT,
                                regInt.CONCEPTO,
                                nuDifereTari, --regInt.DIFERENCIA,
                                regInt.METROS,
                                nuValorNota,--regInt.DESCCAPMES,
                                regInt.RANGO,
                                regInt.PERICONS,
                                'F',
                                regInt.ID_REG,
                                nuValorTariConsumo,
                                nuValorTariVariTT,
                                nuerror,
                                sbError);
                  IF nuerror <> 0 THEN
                    prActuaErrorProd(vtblProdAjus(idx).ID_REG, sberror);
                      ROLLBACK;
                      sbConfirma := 'N';
                      EXIT;
                  ELSE
                    sbConfirma := 'S';
                  END IF;
               END LOOP;

               IF sbConfirma = 'S' AND sbAplicaInte = 'S' THEN
                  FOR regNotInt IN cuCalValorNotaInteAgruFaju(vtblProdAjus(idx).PRAJSESU, vtblProdAjus(idx).PRAJPECO) LOOP
                     nuerror       := NULL;
                    sbError       := NULL;
                    sbSigno       := NULL;
                    IF regNotInt.VALOR < 0 THEN
                      sbSigno     := 'CR';
                    ELSE
                      sbSigno := 'DB';
                    END IF;
                     --se genera nota
                    proGeneraNotaUsuario( regNotInt.DPTTCONT,
                                         vtblProdAjus(idx).PRAJSESU,
                                         regNotInt.DPTTCUCO,
                                         regNotInt.DPTTFACT,
                                         0,
                                         regNotInt.DPTTPERI,
                                         regNotInt.DPTTPECO,
                                         NULL,
                                         regNotInt.DPTTCONC,
                                         sbSigno,
                                         ROUND(ABS(regNotInt.VALOR),0),
                                         'NOTA DE INTERES POR PROCESO DE TARIFA TRANSITORIA',
                                         nuCausaInteres,
                                         nuPrograma,
                                         regNotInt.fila,
                                         regNotInt.maxrownum,
                                         nuerror,
                                         sbError);

                    IF nuerror <> 0 THEN
                      prActuaErrorProd(vtblProdAjus(idx).ID_REG, sberror);
                      ROLLBACK;
                      sbConfirma := 'N';
                      EXIT;
                    ELSE
                     IF sbSigno = 'DB' THEN
                       sbSigno := 'CR';
                     ELSE
                       sbSigno := 'DB';
                     END IF;
                      --se genera nota contraria
                     proGeneraNotaUsuario( regNotInt.DPTTCONT,
                                         vtblProdAjus(idx).PRAJSESU,
                                         regNotInt.DPTTCUCO,
                                         regNotInt.DPTTFACT,
                                         0,
                                         regNotInt.DPTTPERI,
                                         regNotInt.DPTTPECO,
                                         NULL,
                                         regNotInt.DPTTCONC,
                                         sbSigno,
                                         ROUND(ABS(regNotInt.VALOR),0),
                                         'NOTA DE INTERES POR PROCESO DE TARIFA TRANSITORIA',
                                         nuCausaInteres,
                                         nuPrograma,
                                         regNotInt.fila,
                                         regNotInt.maxrownum,
                                         nuerror,
                                         sbError);
                        IF nuerror <> 0 THEN
                         prActuaErrorProd(vtblProdAjus(idx).ID_REG, sberror);
                          ROLLBACK;
                          sbConfirma := 'N';
                          EXIT;
                        ELSE
                           sbConfirma := 'S';
                        END IF;
                     END IF;
               END LOOP;
            END IF;
          END IF;

          FOR regcA IN cuCalValorNota(vtblProdAjus(idx).PRAJSESU, vtblProdAjus(idx).PRAJPECO)
          LOOP
            sbSigno       := NULL;
            nuerror       := NULL;
            sbError       := NULL;
            IF regcA.VALOR < 0 THEN
              sbSigno     := 'CR';
            ELSE
              sbSigno := 'DB';
            END IF;
            --se genera nota
            proGeneraNotaUsumar( regcA.DPTTCONT, vtblProdAjus(idx).PRAJSESU, regcA.DPTTCUCO, regcA.DPTTFACT, regcA.UNIDAD, regcA.DPTTPERI, regcA.DPTTPECO, regcA.DPTTTAPL, regcA.DPTTCONC, sbSigno, ABS(regcA.VALOR), 'NOTA POR PROCESO DE TARIFA TRANSITORIA', regcA.fila, regcA.maxrownum, nuerror, sbError);
            IF nuerror <> 0 THEN
              prActuaErrorProd(vtblProdAjus(idx).ID_REG,sbError||', en el periodo de consumo ['||vtblProdAjus(idx).PRAJPECO||']');
              ROLLBACK;
              sbConfirma := 'N';
              EXIT;
            ELSE
              sbConfirma := 'S';
            END IF;
          END LOOP;
          IF sbConfirma = 'S' THEN
            COMMIT;
      ELSE
        ROLLBACK;
          END IF;
        END IF;
        UPDATE LDC_PROAJUTT SET PRAJESTA = 'T' WHERE ROWID = vtblProdAjus(idx).ID_REG;
        COMMIT;
        idx := vtblProdAjus.NEXT(idx);
      END LOOP;
    END IF;

  vtblProdAjusAdic.DELETE;
  --setear programa
    --  pkErrors.SetApplication(sbprograma);
   IF sbaplica608 = 'S' THEN
    FOR reg IN cugetProductosAdic
    LOOP
      --se coloca registro en procesando
      UPDATE LDC_PROAJUTT
      SET PRAJESTA = 'P'
      WHERE ROWID  = reg.ID_REG;
      COMMIT;
      IF NOT vtblProdAjusAdic.EXISTS(reg.indice) THEN
      vtblProdAjusAdic(reg.indice).ID_REG   := reg.ID_REG;
      vtblProdAjusAdic(reg.indice).PRAJSESU := reg.PRAJSESU;
      vtblProdAjusAdic(reg.indice).PRAJPECO := reg.PRAJPECO;
      vtblProdAjusAdic(reg.indice).PRAJCICL := reg.PRAJCICL;
      END IF;
    END LOOP;
    --FOR idx IN 1..vtblProdAjus.COUNT LOOP
    IF vtblProdAjusAdic.COUNT > 0 THEN
      idx                := vtblProdAjusAdic.FIRST;
      LOOP
      EXIT   WHEN idx       IS NULL;
      sbConfirma   := 'S';
      nuUnidades := 0;
      nuUnidadSub := 0;

       --se consultan consumo ajustados
      FOR reg IN cugetCargosajuADIC(vtblProdAjusAdic(idx).PRAJSESU, vtblProdAjusAdic(idx).PRAJPECO)
      LOOP
        nuerror       := NULL;
        sberror       := NULL;
        nuLiquMet2    := 0;
        sbExisteadic  := NULL;

        IF REG.cargsign    = 'CR' AND reg.cargconc = 31 THEN
         sbAumenta       := 'N';
         nuUnidades      := -1 * reg.cargunid;
         ELSIF REG.cargsign = 'DB' AND reg.cargconc = 31 THEN
          sbAumenta       := 'S';
          nuUnidades      := reg.cargunid;
         END IF;

         IF cuExisteSubadicSub%ISOPEN THEN
          CLOSE cuExisteSubadicSub;
         END IF;

         OPEN cuExisteSubadicSub(REG.CARGNUSE, REG.CARGPECO);
         FETCH cuExisteSubadicSub INTO nuUnidadSub;
         CLOSE cuExisteSubadicSub;

         OPEN cuValidaIniSubAdic(reg.cargpeco);
         FETCH cuValidaIniSubAdic INTO sbExisteadic;
         CLOSE cuValidaIniSubAdic;


         IF nuUnidadSub > 0 OR sbExisteadic IS NOT NULL THEN
           nuDifer             := 20 - NVL(nuUnidadSub,0) ;
          IF sbAumenta         = 'S' THEN
          IF nuDifer         > 0 THEN
            IF nuUnidades    > nuDifer THEN
            nuUnidades    := nuUnidades - nuDifer;
            nuUnidLigRag1 := nuDifer;
            ELSE
            nuUnidLigRag1 := nuUnidades;
            nuUnidades    := 0;
            END IF;
           END IF;
          ELSE
           IF cuValorConsumorang2%ISOPEN THEN
            CLOSE cuValorConsumorang2;
           END IF;
           OPEN cuValorConsumorang2(REG.cargnuse, REG.cargpeco);
           FETCH cuValorConsumorang2 INTO nuLiquMet2;
           CLOSE cuValorConsumorang2;

           IF ABS(nuUnidades) > NVL(nuLiquMet2,0) THEN
            nuUnidades      := nuUnidades + NVL(nuLiquMet2,0);
            --nuUnidLigRag2   := regLiquProdRang2.DPTTUNID;
            nuUnidLigRag1 := ABS(nuUnidades);
            ELSE
            --  nuUnidLigRag2 := ABS(nuUnidades);
            nuUnidades    := 0;
            nuUnidLigRag1 := 0;
            END IF;
          END IF;

         IF nuUnidLigRag1 > 0 THEN
          FOR regCon IN cuValorConsumo(REG.cargnuse, REG.cargpeco) LOOP
            proGeneraNotaUsuario( REG.sesususc,
                      REG.cargnuse,
                      REG.cargcuco,
                      REG.cucofact,
                      nuUnidLigRag1,
                      REG.cargpefa,
                      REG.cargpeco,
                      NULL,
                      nuConcSubAdi,
                     ( case when reg.CARGSIGN =  'DB' then 'CR' else 'DB' end) ,
                      round( regCon.TARIFA_VALOR * nuUnidLigRag1  * (nuPorcSubAdi/100),0),
                      'NOTA GENERADA POR PROCESO DE SUSIDIO ADICIONAL',
                      nuCausalSubAdi,
                      nuPrograma,
                      1,
                      1,
                      nuerror,
                      sbError);
            IF nuerror <> 0 THEN
               prInsertLogErrorSub( REG.cargnuse,
                        REG.sesususc,
                        REG.cargcuco,
                        REG.cucofact,
                        REG.cargpefa,
                        REG.cargpeco,
                        null,
                        nuConcSubAdi,
                        round(  regCon.TARIFA_VALOR * nuUnidLigRag1  * (nuPorcSubAdi/100),0),
                        ( case when reg.CARGSIGN =  'DB' then 'CR' else 'DB' end),
                        nuCausalSubAdi,
                        nuUnidLigRag1,
                        sbError
                        );
               ROLLBACK;
               sbConfirma := 'N';
              exit;
            ELSE
               prInsertLogErrorSub( REG.cargnuse,
                                    REG.sesususc,
                                    REG.cargcuco,
                                    REG.cucofact,
                                    REG.cargpefa,
                                    REG.cargpeco,
                                    null,
                                    nuConcSubAdi,
                                    round(  regCon.TARIFA_VALOR * nuUnidLigRag1  * (nuPorcSubAdi/100),0),
                                    ( case when reg.CARGSIGN =  'DB'  then 'CR' else 'DB' end),
                                    nuCausalSubAdi,
                                     nuUnidLigRag1,
                                    sbError
                                    );
            END IF;
          END LOOP;

         END IF;
        END IF;
       END LOOP;
       UPDATE LDC_PROAJUTT SET PRAJESTA = 'T' WHERE ROWID = vtblProdAjusAdic(idx).ID_REG;
      COMMIT;
      idx := vtblProdAjusAdic.NEXT(idx);
      END LOOP;
    END IF;
    END IF;
  END IF;
  ldc_proactualizaestaprog(nutsess,SBERROR,'PRJOBCREAJUSTT','OK');
EXCEPTION
WHEN EX.CONTROLLED_ERROR THEN
  ERRORS.geterror(nuerror,SBERROR);
  ldc_proactualizaestaprog(nutsess,SBERROR,'PRJOBCREAJUSTT','error');
  ROLLBACK;
WHEN OTHERS THEN
  ERRORS.seterror;
  ERRORS.geterror(nuerror,SBERROR);
  ldc_proactualizaestaprog(nutsess,SBERROR,'PRJOBCREAJUSTT','error');
  ROLLBACK;
END PRJOBCREAJUSTT;

 FUNCTION FNUGETDECAPACUM(  inuProducto    IN NUMBER,
                            inuperiodo    IN NUMBER,
                            inuConcepto   IN NUMBER,
                            inuDescCapMes IN NUMBER,
                            inupericons   IN NUMBER,
                            isbRango IN VARCHAR2,
                            isbIsRecu     IN VARCHAR2) RETURN NUMBER IS
/**************************************************************************
  Proceso     : FNUGETDECAPACUM
  Autor       : Horbath
  Fecha       : 2021-02-15
  Ticket      : 635
  Descripcion : Funcion que devuelve descuento capital acumulado por concepto


  Parametros Entrada
    inuProducto     codigo del producto
  inuperiodo      codigo del periodo
  inuConcepto     concepto
  inuDescCapMes   descuento capital mes
  isbRango     rango
  inupericons   periodo de consumo
  isbIsRecu  ES RECUPERADO
  Parametros de salida


  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
  nuDescCapAcum NUMBER := 0;

  CURSOR cugetvalorAcumAnt IS
  select NVL(SUM(NVL(DPTTDCAC,0)),0)
  from (
        SELECT *
        FROM LDC_DEPRTATT
        WHERE DPTTSESU = inuProducto
         AND DPTTPECO <= fnuObtPerConsAnterior(inuperiodo)
         AND DPTTPERI <= open.pkbillingperiodmgr.fnugetperiodprevious(inuperiodo)
         AND DPTTCONC = inuConcepto
         AND DPTTRANG = isbrango
         order by dpttperi desc)
  where rownum = 1 ;

    CURSOR cugetvalorAcumAntRec IS
    SELECT NVL(SUM(NVL(DPTTDCAC,0)),0)
    FROM LDC_DEPRTATT
    WHERE DPTTSESU = inuProducto
     AND DPTTPECO =  inupericons
     AND DPTTPERI <> inuperiodo
     AND DPTTCONC = inuConcepto
     AND DPTTRANG = isbrango
      ;

     CURSOR cugetvalorAcumAntFaju IS
    SELECT NVL(SUM(NVL(DPTTDCAC,0)),0)
    FROM LDC_DEPRTATT
    WHERE DPTTSESU = inuProducto
     AND DPTTPECO =  fnuObtPerConsAnte(inuProducto, inupericons)
     AND DPTTCONC = inuConcepto
     AND DPTTRANG = isbrango
     ;

 BEGIN
   IF isbIsRecu = 'N' THEN
     OPEN cugetvalorAcumAnt;
     FETCH cugetvalorAcumAnt INTO nuDescCapAcum;
     CLOSE cugetvalorAcumAnt;
   ELSE
      OPEN cugetvalorAcumAntFaju;
     FETCH cugetvalorAcumAntFaju INTO nuDescCapAcum;
     CLOSE cugetvalorAcumAntFaju;
   END IF;

   nuDescCapAcum := NVL(nuDescCapAcum,0) + NVL(inuDescCapMes,0);

   RETURN nuDescCapAcum;

 EXCEPTION
   WHEN OTHERS THEN
     return nuDescCapAcum;
 END FNUGETDECAPACUM;

 FUNCTION FNUGETSALDINTMES(  inuDescCapAcumMes IN NUMBER) RETURN NUMBER IS
/**************************************************************************
  Proceso     : FNUGETSALDINTMES
  Autor       : Horbath
  Fecha       : 2021-02-15
  Ticket      : 635
  Descripcion : Funcion que devuelve saldo de interes mes


  Parametros Entrada
  inuDescCapAcumMes   descuento capital acumulado
  Parametros de salida


  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
  nuSaldIntmes NUMBER := 0;

 BEGIN
     nuSaldIntmes :=  ROUND(inuDescCapAcumMes * (getPorcInte/100),2);

   RETURN nuSaldIntmes;
 EXCEPTION
   WHEN OTHERS THEN
      RETURN nuSaldIntmes;

 END FNUGETSALDINTMES;

  PROCEDURE setPorcInte( idtFecha IN DATE,  onuError OUT NUMBER, osberror OUT VARCHAR) IS
 /**************************************************************************
  Proceso     : setPorcInte
  Autor       : Horbath
  Fecha       : 2021-02-15
  Ticket      : 635
  Descripcion : SETEA TASA DE INTERES VIGENTE


  Parametros Entrada
    idtFecha fecha de consulta
  Parametros de salida
       onuError   codigo de error
   osberror   mensaje de error

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
   sbExiste VARCHAR2(1);

   CURSOR cuExistasa IS
   SELECT 'X'
   FROM tasainte
   WHERE TAINCODI = nuTasaInte;

   CURSOR cuGetValor IS
   SELECT cotiporc
  FROM conftain
   WHERE TRUNC(idtFecha) BETWEEN cotifein AND cotifefi
   AND cotitain = nuTasaInte ;


 BEGIN
  onuError := 0;
  OPEN cuExistasa;
  FETCH cuExistasa INTO sbExiste;
  IF cuExistasa%NOTFOUND THEN
     onuError := -1;
     osberror :='Tasa de interes ['||nuTasaInte||'] no existe';
  ELSE
     OPEN cuGetValor;
     FETCH cuGetValor INTO nuValorTasa;
     IF cuGetValor%NOTFOUND THEN
        onuError := -1;
        osberror :='Tasa de interes ['||nuTasaInte||'] no se encuentra vigente';
     END IF;
     CLOSE cuGetValor;

  END IF;
  CLOSE cuExistasa;


 EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    ERRORS.geterror(onuError,osberror);
  WHEN OTHERS THEN
    ERRORS.seterror;
    ERRORS.geterror(onuError,osberror);
 END setPorcInte;

 FUNCTION getPorcInte RETURN NUMBER IS
 /**************************************************************************
  Proceso     : getPorcInte
  Autor       : Horbath
  Fecha       : 2021-02-15
  Ticket      : 635
  Descripcion : RETORNA TASA DE INTERES VIGENTE


  Parametros Entrada

  Parametros de salida


  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
 BEGIN
   RETURN nuValorTasa;
 END getPorcInte;

 FUNCTION FNUGETSALTOTACUM( inuSaldIntacum IN NUMBER,
                            inuDescCapacum IN NUMBER) RETURN NUMBER IS
 /**************************************************************************
    Proceso     : FNUGETSALTOTACUM
    Autor       : Horbath
    Fecha       : 2021-02-15
    Ticket      : 635
    Descripcion : RETORNA SALDO TOTAL ACUMULADO


    Parametros Entrada
    inuSaldIntacum   saldo de interes acumulado
    inuDescCapacum   descuento capital acumulado
    Parametros de salida


    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
 ***************************************************************************/
  nusaldTotal NUMBER;
 BEGIN
   nusaldTotal := NVL(inuSaldIntacum,0) + NVL(inuDescCapacum,0);
    RETURN  nusaldTotal;
 EXCEPTION
   WHEN OTHERS THEN
     RETURN  nusaldTotal;
 END FNUGETSALTOTACUM;
  FUNCTION FNUGETSALDINTACUM(  inuProducto    IN NUMBER,
                              inuperiodo    IN NUMBER,
                              inuConcepto   IN NUMBER,
                              inuDescIntMes IN NUMBER,
                              inuSaldIntMes IN NUMBER,
                              isbrango IN VARCHAR2,
                              inupericons  IN NUMBER,
                              isbIsRecu     IN VARCHAR2) RETURN NUMBER IS
/**************************************************************************
  Proceso     : FNUGETSALDINTACUM
  Autor       : Horbath
  Fecha       : 2021-02-15
  Ticket      : 635
  Descripcion : Funcion que devuelve saldo de interes acumulado por concepto


  Parametros Entrada
    inuProducto     codigo del producto
  inuperiodo      codigo del periodo
  inuConcepto     concepto
  inuDescIntMes   descuento interes del mes
  inuSaldIntMes   saldo de interes del mes
  isbrango        rango de consumo
  inupericons     periodo de consumo
  isbIsRecu      ES RECUPERADO
  Parametros de salida


  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
 nusaldIntacum NUMBER;

  CURSOR cugetvalorIntAcumAnt IS
  select NVL(SUM(NVL(DPTTSIAC,0)),0)
  from (
      SELECT *
      FROM LDC_DEPRTATT
      WHERE DPTTSESU = inuProducto
       AND DPTTPECO <= fnuObtPerConsAnterior(inuperiodo)
       AND DPTTPERI <= open.pkbillingperiodmgr.fnugetperiodprevious(inuperiodo)
       AND DPTTCONC = inuConcepto
       AND DPTTRANG = isbrango
       order by DPTTPERI desc)
   where rownum = 1
   ;

   CURSOR cugetvalorIntAcumAntRec IS
  SELECT NVL(SUM(NVL(DPTTSIAC,0)),0)
  FROM LDC_DEPRTATT
  WHERE DPTTSESU = inuProducto
   AND DPTTPECO = inupericons
   AND DPTTPERI <> inuperiodo
   AND DPTTCONC = inuConcepto
   AND DPTTRANG = isbrango
   ;

    CURSOR cugetvalorIntAcumAntFaju IS
  SELECT NVL(SUM(NVL(DPTTSIAC,0)),0)
  FROM LDC_DEPRTATT
  WHERE DPTTSESU = inuProducto
   AND DPTTPECO = fnuObtPerConsAnte(inuProducto, inupericons)
   AND DPTTCONC = inuConcepto
   AND DPTTRANG = isbrango ;
BEGIN
   IF isbIsRecu = 'N' THEN
     OPEN cugetvalorIntAcumAnt;
     FETCH cugetvalorIntAcumAnt INTO nusaldIntacum;
     CLOSE cugetvalorIntAcumAnt;

  ELSE
     OPEN cugetvalorIntAcumAntFaju;
     FETCH cugetvalorIntAcumAntFaju INTO nusaldIntacum;
     CLOSE cugetvalorIntAcumAntFaju;
  END IF;


    nusaldIntacum := NVL(nusaldIntacum,0) + NVL( inuDescIntMes,0) + NVL(inuSaldIntMes,0);


   RETURN nusaldIntacum;

EXCEPTION
   WHEN OTHERS THEN
     RETURN  nusaldIntacum;
 END FNUGETSALDINTACUM;
  FUNCTION FNUGETDESCINTMES( inuProducto      IN NUMBER,
                            inuperiodo       IN NUMBER,
                            inuConcepto      IN NUMBER,
                            inuDifeTari    IN NUMBER,
                            inuMetros        IN NUMBER,
                            isbrango         IN VARCHAR2,
                            inupericons  IN NUMBER,
                            isbIsRecu     IN VARCHAR2) RETURN NUMBER IS
 /**************************************************************************
  Proceso     : FNUGETDESCINTMES
  Autor       : Horbath
  Fecha       : 2021-02-15
  Ticket      : 635
  Descripcion : Funcion que devuelve descuento de interes del mes por concepto


  Parametros Entrada
    inuProducto     codigo del producto
  inuperiodo      codigo del periodo
  inuConcepto     concepto
  inuDifeTari      diferencia de tarifas
  inuMetros        metros cubicos
  isbrango         rango de consumo
  inupericons      periodo de consumo
  isbIsRecu        es recuperado
  Parametros de salida


  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  10/08/2022   LJLB       CA OSF-490 se quita validacion de promedio por rangos
***************************************************************************/
   nuDescIntmes NUMBER;

   nuSaldant NUMBER;

  CURSOR cugetvalorAcumAnt IS
  SELECT  DECODE(saldtotal, 0, 0, saldint / saldtotal)
  FROM (
      SELECT DPTTPERI, DPTTPECO, nvl( sum(nvl(DPTTSIAC,0)), 0) saldint,
        nvl( SUM(NVL(DPTTSTAC,0)),0) saldtotal
      FROM LDC_DEPRTATT
      WHERE DPTTSESU = inuProducto
       AND DPTTPECO <= LDC_PKGESTIONTARITRAN.fnuObtPerConsAnterior(inuperiodo)
       AND DPTTPERI <= open.pkbillingperiodmgr.fnugetperiodprevious(inuperiodo)
       AND DPTTCONC = inuConcepto
      -- AND DPTTRANG = isbrango
  group by DPTTPERI, DPTTPECO
  order by DPTTPERI desc, DPTTPECO desc)
  where rownum = 1;


     CURSOR cugetvalorAcumAntRec IS
    SELECT DECODE(saldtotal, 0, 0, saldint / saldtotal)
    FROM (
        SELECT nvl( sum(nvl(DPTTSIAC,0)), 0) saldint,
          nvl( SUM(NVL(DPTTSTAC,0)),0) saldtotal
        FROM LDC_DEPRTATT
        WHERE DPTTSESU = inuProducto
          AND DPTTPECO =  inupericons
     AND DPTTPERI <> inuperiodo
         AND DPTTCONC = inuConcepto
        -- AND DPTTRANG = isbrango
        );

    CURSOR cugetvalorAcumAntFaju IS
    SELECT DECODE(saldtotal, 0, 0, saldint / saldtotal)
    FROM (
        SELECT nvl( sum(nvl(DPTTSIAC,0)), 0) saldint,
          nvl( SUM(NVL(DPTTSTAC,0)),0) saldtotal
        FROM LDC_DEPRTATT
        WHERE DPTTSESU = inuProducto
         AND DPTTPECO =  fnuObtPerConsAnte(inuProducto, inupericons)
         AND DPTTCONC = inuConcepto
       --  AND DPTTRANG = isbrango

         );
 BEGIN
    IF inuDifeTari < 0 THEN
       IF isbIsRecu = 'N' THEN
          OPEN cugetvalorAcumAnt;
          FETCH cugetvalorAcumAnt INTO nuSaldant;
          CLOSE cugetvalorAcumAnt;

       ELSE
          OPEN cugetvalorAcumAntFaju;
          FETCH cugetvalorAcumAntFaju INTO nuSaldant;
          CLOSE cugetvalorAcumAntFaju;
       END IF;

       nuDescIntmes :=  ROUND(inuDifeTari * inuMetros * NVL(nuSaldant,0),2) * -1;

    ELSE
      nuDescIntmes := 0;
    END IF;

   RETURN nuDescIntmes;
 EXCEPTION
   WHEN OTHERS THEN
     RETURN nuDescIntmes;
 END FNUGETDESCINTMES;

 PROCEDURE PRACTUALLIQINT( inuProducto  IN NUMBER,
                            inuperiodo   IN NUMBER,
                            inuConcepto  IN NUMBER,
                            inuDifeTari  IN NUMBER,
                            inuMetros    IN NUMBER,
                            inuDescCapMes IN NUMBER,
                            isbRango     IN VARCHAR2,
                            inupericons  IN NUMBER,
                            isbIsRecu     IN VARCHAR2,
                            isbrowid      IN VARCHAR2,
                            inuTarifaCons IN NUMBER,
                            inuTarifaTran IN NUMBER,
                            onuerror     OUT NUMBER,
                            osbError     OUT VARCHAR) IS
 /**************************************************************************
  Proceso     : PRACTUALLIQINT
  Autor       : Horbath
  Fecha       : 2021-02-15
  Ticket      : 635
  Descripcion : proceso que actualiza informacion de interes de


  Parametros Entrada
    inuProducto      codigo del producto
    inuperiodo       codigo del periodo
    inuConcepto      concepto
    inuDifeTari      diferencia de tarifas
    inuMetros        metros cubicos
    isbrango         rango de consumos
    inuDescCapMes    descuento capital del mes
    inupericons      periodo de consumo
    isbrowid         ROWID
    inuTarifaCons    tarifa de consumo
    inuTarifaTran    tarifa transitoria
  Parametros de salida
    onuerror   codigo de error
  osbError  mensaje de error

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  nuDescCapAcum NUMBER;
  nuSaldoIntmes NUMBER;
  nuDescInteMes NUMBER;
  nuSaldIntAcum  NUMBER;
  nuSaldTotalAcum NUMBER;
 BEGIN
     onuerror := 0;

  --dbms_output.put_line(' inuperiodo '||inuperiodo||' inuConcepto '||inuConcepto||' inuDescCapMes '||inuDescCapMes||'  inupericons '||inupericons||' isbRango '||isbRango||' isbIsRecu '||isbIsRecu);
     --se calcula descuento capital acumulado||
   nuDescCapAcum := FNUGETDECAPACUM(  inuProducto,
                                      inuperiodo ,
                                      inuConcepto,
                                      inuDescCapMes,
                                      inupericons,
                                      isbRango,
                                      isbIsRecu);

  --se calcula saldo interes mes
    nuSaldoIntmes := FNUGETSALDINTMES(nuDescCapAcum);

  --DBMS_OUTPUT.PUT_LINE(' isbrango '||isbrango||' inupericons '||inupericons||' isbIsRecu '||isbIsRecu);
  --DBMS_OUTPUT.PUT_LINE(' inuDifeTari '||inuDifeTari||' inuMetros '||inuMetros||' inuConcepto '||inuConcepto);
  --se calcula descuento interes del mes
  nuDescInteMes  := FNUGETDESCINTMES( inuProducto,
                    inuperiodo,
                    inuConcepto,
                    inuDifeTari,
                    inuMetros,
                    isbrango,
                    inupericons,
                    isbIsRecu);

  --Se calcula saldo de interes acumulado
  nuSaldIntAcum := FNUGETSALDINTACUM(  inuProducto,
                      inuperiodo,
                      inuConcepto,
                      nuDescInteMes,
                      nuSaldoIntmes,
                      isbrango,
                      inupericons,
                      isbIsRecu);
  --se calcula saldo total acumulado
  nuSaldTotalAcum := FNUGETSALTOTACUM( nuSaldIntAcum,
                    nuDescCapAcum);

  --se realiza modificacion a la tabla de detalle
  UPDATE LDC_DEPRTATT SET DPTTSTAC = nuSaldTotalAcum,
            DPTTSIAC = nuSaldIntAcum,
            DPTTSIME = nuSaldoIntmes,
            DPTTDIME = nuDescInteMes,
            DPTTDCAC = nuDescCapAcum,
            DPTTTCAC = inuTarifaCons ,
            DPTTTTAC = inuTarifaTran,
            DPTTVABA = inuDescCapMes
   WHERE rowid = isbrowid;

 EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    ERRORS.geterror(onuError,osberror);
  WHEN OTHERS THEN
    ERRORS.seterror;
    ERRORS.geterror(onuError,osberror);
 END PRACTUALLIQINT;
 function fnuObtPerConsAnterior (inuperiodo lectelme.leempecs%type) return number is
  /**************************************************************************
  Proceso     : fnuObtPerConsAnterior
  Autor       : Horbath
  Fecha       : 2021-02-15
  Ticket      : 635
  Descripcion : obtener periodo de consumo anterior


  Parametros Entrada
    inuperiodo  periodo de consumo
  Parametros de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
 nupericons number;

   cursor cuperiodo is
   select p2.pecscons
  from perifact p1, pericose p2
  where p2.pecsfecf between p1.pefafimo and p1.pefaffmo
   and p2.pecscico = p1.pefacicl
   and p1.pefacodi = pkbillingperiodmgr.fnugetperiodprevious(inuperiodo);
 begin
    open cuperiodo;
  fetch cuperiodo into nupericons;
  close cuperiodo;
   return nupericons;
 exception
   when others then
     return nupericons;
 end fnuObtPerConsAnterior;

 PROCEDURE PRGENERETIAUTO IS
  /**************************************************************************
  Proceso     : PRGENERETIAUTO
  Autor       : Horbath
  Fecha       : 2023-04-21
  Ticket      : OSF-1042
  Descripcion : job que se encarga de realizar retiro de tarifa transitoria


  Parametros Entrada

  Parametros de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
    nuparano     NUMBER;
    nuparmes     NUMBER;
    nutsess      NUMBER;
    sbparuser    VARCHAR2(400);
    SBERROR      VARCHAR2(4000);
    nuerror      NUMBER;
    nuConcepto  NUMBER := dald_parameter.fnugetnumeric_value('LDC_CONCTATT', null);

    CURSOR cuGetPeriodosProc IS
    SELECT PREJCOPE
    FROM procejec
    WHERE TRUNC(PREJFECH) = TRUNC(SYSDATE -1)
     AND PREJPROG = 'FGCC'
     AND PREJESPR = 'T';

    CURSOR cuGetProdRetirar(inuperiodo factura.factpefa%type) IS
    SELECT servsusc.sesunuse, suscripc.suscclie
    FROM LDC_PRODTATT, servsusc, suscripc, perifact
    WHERE pefacodi = inuperiodo
     AND servsusc.sesucicl = pefacicl
     AND servsusc.sesususc = suscripc.susccodi
     and servsusc.sesunuse = LDC_PRODTATT.PRTTSESU
     AND LDC_PRODTATT.PRTTACTI = 'S'
     AND 0 >= (select SUM(decode(ld.dpttsign, 'DB', -ld.dpttvano, ld.dpttvano)) valornota
                from OPEN.LDC_DEPRTATT ld
                where ld.dpttcont = servsusc.sesususc
                AND ld.dpttconc = nuConcepto);

  nuSolicitud  NUMBER;
  nuMedioRecep NUMBER := dald_parameter.fnugetnumeric_value('LDC_MEDIRECE_RETTRAN', null);

BEGIN
  -- Consultamos datos para inicializar el proceso
  SELECT to_number(TO_CHAR(SYSDATE,'YYYY')) ,
    to_number(TO_CHAR(SYSDATE,'MM')) ,
    userenv('SESSIONID') ,
    USER
  INTO nuparano,
    nuparmes,
    nutsess,
    sbparuser
  FROM dual;
  -- Inicializamos el proceso
  ldc_proinsertaestaprog(nuparano,nuparmes,'PRGENERETIAUTO','En ejecucion',nutsess,sbparuser);

  FOR reg IN cuGetPeriodosProc LOOP
     FOR regProd IN cuGetProdRetirar(reg.PREJCOPE) LOOP
         nuSolicitud := NULL;
         nuerror := 0;
         SBERROR := NULL;
         PRGENTRAMCANTT(
                        regProd.sesunuse,
                        nuMedioRecep,
                        'RETIRO AUTOMATICO POR SALDO TOTAL PAGADO',
                        regProd.suscclie,
                        SYSDATE,
                        nuSolicitud ,
                        nuerror ,
                        SBERROR );
         IF nuerror = 0 THEN
             UPDATE LDC_PRODTATT
              SET PRTTACTI = 'N',
                  PRTTSOLI = nuSolicitud ,
                  PRTTUSUA = USER,
                  PRTTTERM = NVL(userenv('TERMINAL'),'DESCO'),
                  PRTTFEFI = SYSDATE
              WHERE PRTTSESU =  regProd.sesunuse;
              commit;
          ELSE
            ROLLBACK;
            UPDATE LDC_PRODTATT
              SET PRTTERRO = 'ERROR REALIZANDO RETIRO '||SBERROR
            WHERE PRTTSESU =  regProd.sesunuse;
            commit;
          END IF;
      END LOOP;
  END LOOP;
  ldc_proactualizaestaprog(nutsess,SBERROR,'PRGENERETIAUTO','OK');
EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    ERRORS.geterror(nuerror,SBERROR);
    ldc_proactualizaestaprog(nutsess,SBERROR,'PRGENERETIAUTO','error');
    ROLLBACK;
  WHEN OTHERS THEN
    ERRORS.seterror;
    ERRORS.geterror(nuerror,SBERROR);
    ldc_proactualizaestaprog(nutsess,SBERROR,'PRGENERETIAUTO','error');
    ROLLBACK;
END PRGENERETIAUTO;

    PROCEDURE GENPOSITIVEBAL(inucuenta IN NUMBER, inuconcepto IN NUMBER, inunota IN NUMBER) IS
    /**************************************************************************
    Proceso     : GENPOSITIVEBAL
    Autor       : Horbath
    Fecha       : 2023-04-21
    Ticket      : OSF-1042
    Descripcion : Procedimiento encargado de generar Saldo a favor


    Parametros Entrada
        inucuenta   : cuenta de cobro
        inuconcepto : concepto que genera el saldo a favor
        inunota     : nota asociada al cargo 
  
    Parametros de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
        nusaldo     cuencobr.cucosacu%type;
        sbdocumento cargos.cargdoso%type;
        nucausa     cargos.cargcaca%type;
        nuproducto  servsusc.sesunuse%type;
        nucontarto  suscripc.susccodi%type;
        dtfecha     cargos.cargfecr%type;
        
        nuciclo         perifact.pefacicl%type;
        nuano           perifact.pefaano%type;
        numes           perifact.pefames%type;
        nuperiodo       perifact.pefacodi%type;
        rccargo         cargos%rowtype;
        rccargonull     cargos%rowtype;
        nusafacons      saldfavo.safacons%type;
        
    BEGIN
        
        nusaldo := pktblcuencobr.fnugetbalance(inucuenta,0);
        
        if nusaldo >= 0 then
            return;
        else
            nusaldo := abs(nusaldo);
        end if;
        
        sbdocumento := Pkbosupportdocumentmgr.Fsbgetnegativeaccount(inucuenta);
        nucausa := Fa_Bochargecauses.Fnugenericchcause(-1);
        nuproducto := Pktblcuencobr.Fnugetservicenumber(inucuenta);
        nucontarto := Pktblservsusc.Fnugetsuscription(nuproducto);
        nuciclo := Pktblsuscripc.Fnugetbillingcycle( nucontarto );
        Pkbillingperiodmgr.Acccurrentperiod( nuciclo, nuano, numes, nuperiodo );
        dtfecha := sysdate;
        
        rccargo := rccargonull;
        rccargo.cargcuco := inucuenta;
        rccargo.cargnuse := nuproducto;
        rccargo.cargpefa := nuperiodo;
        rccargo.cargconc := inuconcepto;
        rccargo.cargcaca := nucausa;
        rccargo.cargsign := Pkbillconst.Saldofavor;
        rccargo.cargvalo := nusaldo;
        rccargo.cargdoso := sbdocumento;
        rccargo.cargtipr := Pkbillconst.Post_Facturacion;
        rccargo.cargfecr := dtfecha;
        rccargo.cargcodo := nvl(inunota,0);
        rccargo.cargprog := Pkgeneralservices.Fnuidproceso;
        rccargo.cargusua := Sa_Bosystem.Getsystemuserid;
        
        Pktblcargos.Insrecord (rccargo);
    	
    	Pkupdaccoreceiv.Updaccorec
    	(
    		Pkbillconst.Cnusuma_Cargo,
    		inucuenta,
    		nucontarto,
    		nuproducto,
    		inuconcepto,
    		Pkbillconst.Saldofavor,
    		nusaldo,
    		Pkbillconst.Cnuupdate_Db
    	);

        
        Pkbcsaldfavo.Createrecord
        (
            nuproducto,
            'CTN',
            inucuenta,
            trunc(dtfecha),
            nusaldo,
            nusafacons
        );
        
        PKBCMOVISAFA.CREATERECORD 
        (
            nuproducto,
            nusafacons,
            trunc(dtfecha),
            nusaldo,
            inucuenta,
            inunota,
            null
        );
    EXCEPTION
        WHEN PKG_ERROR.CONTROLLED_ERROR THEN
            raise PKG_ERROR.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            PKG_ERROR.seterror;
            raise PKG_ERROR.CONTROLLED_ERROR;
    END GENPOSITIVEBAL;
END LDC_PKGESTIONTARITRAN;
/

