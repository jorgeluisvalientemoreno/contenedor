CREATE OR REPLACE PACKAGE "IC_BCLISIMPROVGEN" AS
  /*
      Propiedad intelectual de Open International Systems. (c).

      Paquete       :   IC_BCLisimProv
      Descripci?n   :   Componente para obtener consultas para el proceso de
                      Provisi?n de Cartera usando el m?todo LISIM.

      Autor     :   Claudia Liliana Rodr?guez
      Fecha       :   27-03-2012 10:26:00

      Historia de Modificaciones
      Fecha     IDEntrega

      17-07-2013  hlopez.SAO212472
      Se adiciona el atributo Clasificaci?n Contable del Contrato.
      - Se modifica el m?todo <InsMovDesProvision>

      01-10-2012  gduque.SAO183760
      Se elimina el m?todo <fnuConCartCoco>.
      Se adiciona el m?todo <GetProcessInitData>.

      29-08-2012  gduqueSAO189287
      Se modifica el metodo <GetDifeByProduct> para eliminar los parametros
      idtFechIni y idtFechFin.


      16-08-2012   gduqueSAO188626
      Se adiciona los metodos <fnuDaysOnDefByProduct> y <frfGetPortfolioCharges>.


      13-08-2012   gduqueSAO188355
      Se adiciona parametro A?o el metodo <GetIndicatorValueSMMLV>
      Se adiciona los metodos <DelTmpMovProvCart> y <InsMovDesProvision>.

      27-03-2012  crodriguezSAO180613
      Creaci?n.
  */

  ---------------
  -- VARIABLES
  ---------------
  TYPE tytbCuentaxProd IS RECORD(
    CUCOCODI pktblcuencobr.tyCUCOCODI,
    CUCOVAAP pktblcuencobr.tyCUCOVAAP,
    CUCOVARE pktblcuencobr.tyCUCOVARE,
    CUCOVAAB pktblcuencobr.tyCUCOVAAB,
    CUCOVATO pktblcuencobr.tyCUCOVATO,
    CUCOFEPA pktblcuencobr.tyCUCOFEPA,
    CUCONUSE pktblcuencobr.tyCUCONUSE,
    CUCOSACU pktblcuencobr.tyCUCOSACU,
    CUCOVRAP pktblcuencobr.tyCUCOVRAP,
    CUCOFACT pktblcuencobr.tyCUCOFACT,
    CUCOFEVE pktblcuencobr.tyCUCOFEVE,
    CUCOVAFA pktblcuencobr.tyCUCOVAFA,
    CUCOFEGE pktblfactura.tyFACTFEGE,
    CUCODIMO pktblic_detlisim.tyDelidimo,
    CUCOPEFA pktblfactura.tyFACTPEFA);

  ---------------
  -- VARIABLES
  ---------------
  TYPE tytbCuentaxDife IS RECORD(
    CUCOCODI pktblcuencobr.tyCUCOCODI,
    CUCONUSE pktblcuencobr.tyCUCONUSE

    );

  TYPE tytbDifexProd IS RECORD(
    difecodi pktbldiferido.tyDifecodi,
    difenucu pktbldiferido.tyDifenucu,
    difesape pktbldiferido.tyDifesape,
    difeconc pktbldiferido.tyDifeconc,
    difesign pktbldiferido.tyDifesign);

  ----------------------------------------------------------------------------
  -- M?todos
  ----------------------------------------------------------------------------

  -- Obtiene versi?n actual de paquete
  FUNCTION fsbVersion RETURN VARCHAR2;

  -- Obtiene los registros de Cartera para la provisi?n de LISIM
  PROCEDURE ObtCartera(idtFechGen   IN ic_cartcoco.caccfege%TYPE,
                       inuPivote    IN NUMBER,
                       isbTyPrEx    IN VARCHAR2,
                       inuNumHilos  IN NUMBER,
                       inuHilo      IN NUMBER,
                       orctbCartera OUT NOCOPY pktblic_cartprov.tytbIc_Cartprov);

  -- Obtiene Cuentas de Cobro por Producto en un rango de fechas
  PROCEDURE GetAccountsByProduct(idtFechIni   IN factura.factfege%TYPE,
                                 idtFechFin   IN factura.factfege%TYPE,
                                 inuProducto  IN servsusc.sesunuse%TYPE,
                                 orctbCuentas OUT NOCOPY tytbCuentaxProd);

  PROCEDURE GetProcessInitData(idtfecha    IN ic_cartcoco.caccfege%TYPE,
                               isbTyPrEx   IN VARCHAR2,
                               inuNumHilos IN NUMBER,
                               inuHilo     IN NUMBER,
                               onuCount    OUT NUMBER,
                               onuFirst    OUT ic_cartcoco.cacccons%TYPE

                               );

  -- Obtiene Diferidos con Saldo Pendiente del Producto
  PROCEDURE GetDifeByProduct(inuProducto IN servsusc.sesunuse%TYPE,
                             orctbdife   OUT NOCOPY tytbDifexProd,
                             idtProcDate IN DATE DEFAULT SYSDATE);

  PROCEDURE GetIndicatorValueSMMLV(inuIndicator      IN ge_indicator_values.indicator_id%TYPE,
                                   inuYear           IN ge_indicator_values.indicator_Year%TYPE,
                                   orctbIc_ConfSMMLV OUT NOCOPY dage_indicator_values.tyrcGE_indicator_values);

  PROCEDURE GetAccountsByDife(isbDocuSopo  IN cargos.cargdoso%TYPE,
                              inuProducto  IN cargos.cargnuse%TYPE,
                              orctbCuentas OUT NOCOPY tytbCuentaxDife);

  PROCEDURE DelTmpMovProvCart(inuTipDocu   IN ic_tipodoco.tidccodi%TYPE,
                              isbTyPrEx    IN VARCHAR2,
                              odlFlagDatos OUT BOOLEAN);

  PROCEDURE InsMovDesProvision(inuTipDocu IN ic_tipodoco.tidccodi%TYPE,
                               isbTyPrEx  IN VARCHAR2,
                               isbVarCar  IN VARCHAR2);

  FUNCTION fnuDaysOnDefByProduct(idtfecha    IN ic_cartcoco.caccfege%TYPE,
                                 inuProducto IN servsusc.sesunuse%TYPE)
    RETURN NUMBER;

  FUNCTION frfGetPortfolioCharges(inuCucocodi IN cuencobr.cucocodi%TYPE)
    RETURN pkConstante.tyRefCursor;

  FUNCTION fnuGetUsedQuotaByProdDate(inuProductId     IN servsusc.sesunuse%TYPE,
                                     idtProvisionDate IN DATE) RETURN NUMBER;

  FUNCTION fnuGetAccoutsBalance(inuProductId IN servsusc.sesunuse%TYPE)
    RETURN NUMBER;

END IC_BCLisimProvGen;
/
CREATE OR REPLACE PACKAGE BODY "IC_BCLISIMPROVGEN" AS
  /*
      Propiedad intelectual de Open International Systems. (c).

      Paquete       :   IC_BCLisimProv
      Descripci?n   :   Variables, procedimientos y funciones privados del
                      paquete IC_BCLisimProvGen.

      Autor     :   Claudia Liliana Rodr?guez
      Fecha     :   27-03-2012 10:26:00

      Historia de Modificaciones
      Fecha     IDEntrega

      11-06-2014  aesguerra.3811
      Se modifica <<GetAccountsByProduct>> y <<GetDifeByProduct>>

      03-06-2014  aesguerra.3722
      Se crea <<fnuGetUsedQuotaByProdDate>>

      02-04-2014  aesguerra.3551
      Se modifica <fnuDaysOnDefByProduct>.

      11-10-2013  sgomez.SAO219973
      Se corrige error de rendimiento.

      17-07-2013  hlopez.SAO212472
      Se adiciona el atributo Clasificaci?n Contable del Contrato.
      - Se modifica el m?todo <InsMovDesProvision>

      08-04-2013   sgomez.SAO205719
      Se modifica <Provisi?n LISIM> por impacto en <Hechos Econ?micos>
      (adici?n de atributo <?tem>).

      01-10-2012  gduque.SAO183760
      Se elimina el m?todo <fnuConCartCoco>.
      Se adiciona el m?todo <GetProcessInitData>.
      Se modifica el m?todo <ObtCartera>.

      12-09-2012  gduque.SAO190015
      Se modifica el m?todo <ObtCartera>

      29-08-2012  gduqueSAO189287
      Se modifica los metodos <GetDifeByProduct>,<GetAccountsByProduct>,
      <ObtCartera> y <fnuConCartCoco>.

      29-08-2012  sgomez.SAO188677
      Se eliminan referencias a la columna <IC_MOVIPROV.MVPRTIAC>.

      16-08-2012  gduqueSAO188626
      Se modifica los metodos <InsMovDesProvision>, <GetAccountsByProduct>,
      <fnuConCartCoco>
      Se adiciona los metodos <fnuDaysOnDefByProduct> y <frfGetPortfolioCharges>.

      13-08-2012   gduqueSAO188355
      Se adiciona parametro A?o el metodo <GetIndicatorValueSMMLV>.
      Se adiciona los metodos <DelTmpMovProvCart> y <InsMovDesProvision>.

      27-03-2012  crodriguezSAO180613
      Creaci?n.
  */

  ----------------------------------------------------------------------------
  -- Constantes
  ----------------------------------------------------------------------------

  -- Versi?n de paquete
  csbVersion CONSTANT VARCHAR2(250) := '3811';
  -- Limite de datos a Procesar
  cnulimit CONSTANT NUMBER := 100;
  -- Identificador Cartera Financiada
  cnuCartFinan CONSTANT VARCHAR2(1) := 'F';

  ----------------------------------------------------------------------------
  -- Variables
  ----------------------------------------------------------------------------
  -- Descripci?n mensaje de error
  sbMensajeError ge_error_log.description%TYPE;

  csbBSS_FAC_LFG_10031316 VARCHAR2(100) := 'BSS_CAR_LFG_10031316_2';

  ----------------------------------------------------------------------------
  -- M?todos
  ----------------------------------------------------------------------------

  /*
      Propiedad intelectual de Open International Systems. (c).

      Funci?n     :   fsbVersion
      Descripcion   :   Obtiene SAO que identifica versi?n asociada a ?ltima
                      entrega del paquete.

      Retorno     :
          csbVersion      Versi?n de paquete.

      Autor     :   Claudia Liliana Rodr?guez
      Fecha     :   27-03-2012 10:26:00

      Historia de Modificaciones
      Fecha     IDEntrega

      27-03-2012  crodriguezSAO180613
      Creaci?n.
  */

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  BEGIN

    pkErrors.Push('IC_BCLisimProvGen.fsbVersion');

    pkErrors.Pop;

    RETURN IC_BCLisimProvGen.csbVersion;

  EXCEPTION
    WHEN LOGIN_DENIED THEN
      pkErrors.Pop;
      RAISE LOGIN_DENIED;
    WHEN pkConstante.exERROR_LEVEL2 THEN
      pkErrors.Pop;
      RAISE pkConstante.exERROR_LEVEL2;
    WHEN OTHERS THEN
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           IC_BCLisimProvGen.sbMensajeError);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2,
                              IC_BCLisimProvGen.sbMensajeError);
  END fsbVersion;

  /*
      Propiedad intelectual de Open International Systems (c).

      Procedimiento : GetAccountsByProduct
      Descripci?n   : Obtiene Cuentas de Cobro del Producto generadas para
                      un rango de fechas.

      Par?metros    :
            idtFechIni  Fecha Inicial
            idtFechFin  Fecha Final
            inuProducto Producto

      Retorna
            orctbCuentas  Cuentas de Cobro

      Autor     :   Claudia Liliana Rodr?guez
      Fecha     :   27-03-2012 10:26:00

      Historia de Modificaciones
      Fecha     IDEntrega

      14-09-2016  Sandra Mu?oz. CA 100-9314.
      Se ajusta el cursor cuCuentasProducto para que tome el indice de IC_CARTCOCO

      14-08-2016  Sandra Mu?oz. CA 100-9314
      Generar la informacion para la provision basados en la informacion del cierre

      11-06-2014  aesguerra.3811
      Se incluye el periodo de facturaci?n entre los campos retornados

      11-10-2013  sgomez.SAO219973
      Se modifican hints para acceder primero a CUENCOBR (CUCONUSE) con el
      fin de mejorar el rendimiento.

      29-08-2012  gduqueSAO189287
      Se estructura de cero el hint de la sentencia para mejor rendimiento

      19-08-2012  gduqueSAO188626
      Se modifica hint para utilizar el indice IX_FACTURA02

      27-03-2012  crodriguezSAO180613
      Creaci?n.
  */

  PROCEDURE GetAccountsByProduct(idtFechIni   IN factura.factfege%TYPE,
                                 idtFechFin   IN factura.factfege%TYPE,
                                 inuProducto  IN servsusc.sesunuse%TYPE,
                                 orctbCuentas OUT NOCOPY tytbCuentaxProd) IS

    ------------------------------------------------------------------------
    -- Cursores
    ------------------------------------------------------------------------
    -- Obtiene las cuentas de cobro del producto

    nuAplicaEntrega NUMBER; -- Indica si una entrega esta aplicada o no

    CURSOR cuCuentasProducto(idtFechIni IN factura.factfege%TYPE, idtFechFin IN factura.factfege%TYPE, inuProducto IN servsusc.sesunuse%TYPE) IS
      SELECT /*+
                                                                                                                                                                                                                              ordered
                                                                                                                                                                                                                              use_nl(cuencobr factura)
                                                                                                                                                                                                                              index_rs_asc(cuencobr IX_CUENCOBR03)
                                                                                                                                                                                                                              index(factura PK_FACTURA)
                                                                                                                                                                                                                          */
       cucocodi,
       cucovaap,
       cucovare,
       cucovaab,
       cucovato,
       cucofepa,
       cuconuse,
       SUM(decode(nuAplicaEntrega, 0, cucosacu, NVL(icc.caccsape, 0))) cucosacu, -- CA 100-9314
       cucovrap,
       cucofact,
       cucofeve,
       cucovafa,
       factfege,
       factpefa
        FROM cuencobr,
             factura, /*+ IC_BCLisimProvGen.GetAccountsbyProduct */
             ic_cartcoco icc -- CA 100-9314
       WHERE cuconuse = inuProducto
         AND cucofact = factcodi
         AND icc.cacccuco = cucocodi -- CA 100-9314
         AND icc.caccnuse = cuconuse -- CA 100-9314
         AND icc.caccfege = ic_boLisimProvGen.dtProcessDate -- CA 100-9314
         AND factfege BETWEEN idtFechIni AND idtFechFin
       GROUP BY cucocodi,
                cucovaap,
                cucovare,
                cucovaab,
                cucovato,
                cucofepa,
                cuconuse,
                cucovrap,
                cucofact,
                cucofeve,
                cucovafa,
                factfege,
                factpefa
      UNION --SE INCLUYE LOS REGISTROS QUE NO TIENEN FACTURA
      SELECT nvl(l.cacccuco, -1) cucocodi,
             NULL cucovaap,
             NULL cucovare,
             NULL cucovaab,
             SUM(l.caccsape) cucovato,
             NULL cucofepa,
             l.caccnuse cuconuse,
             SUM(l.caccsape) cucosacu, -- CA 100-9314
             NULL cucovrap,
             NULL cucofact,
             l.caccfeve cucofeve,
             NULL cucovafa,
             l.caccfege factfege,
             (SELECT pefacodi
                FROM PERIFACT t
               WHERE t.pefaano = to_number(to_char(ic_boLisimProvGen.dtProcessDate,
                                                   'yyyy'))
                 AND t.pefames =
                     to_number(to_char(ic_boLisimProvGen.dtProcessDate, 'mm'))
                 AND pefacicl = l.CACCCICL) factpefa
        FROM ic_cartcoco l
       WHERE l.caccnuse = inuProducto
         AND l.caccfege = ic_boLisimProvGen.dtProcessDate
            -- and l.Caccserv=7055
         AND NOT EXISTS
       (SELECT *
                FROM cuencobr,
                     factura, /*+ IC_BCLisimProvGen.GetAccountsbyProduct */
                     ic_cartcoco icc -- CA 100-9314
               WHERE cuconuse = l.caccnuse
                 AND cucofact = factcodi
                 AND icc.cacccuco = cucocodi -- CA 100-9314
                 AND icc.caccnuse = cuconuse -- CA 100-9314
                 AND icc.caccfege = ic_boLisimProvGen.dtProcessDate
                 AND factfege BETWEEN idtFechIni AND idtFechFin)
       GROUP BY nvl(l.cacccuco, -1),
                l.caccnuse,
                l.caccfeve,
                l.caccfege,
                l.CACCCICL;

  BEGIN

    pkerrors.Push('IC_BCLisimProvGen.GetAccountsByProduct');

    IF (cuCuentasProducto%ISOPEN) THEN
      CLOSE cuCuentasProducto;
    END IF;

    -- INICIO CA 100-9314
    IF fblAplicaEntrega(csbBSS_FAC_LFG_10031316) THEN
      nuAplicaEntrega := 1;
    ELSE
      nuAplicaEntrega := 0;
    END IF;
    -- FIN CA 100-9314

    OPEN cuCuentasProducto(idtFechIni, idtFechFin, inuProducto);

    FETCH cuCuentasProducto BULK COLLECT
      INTO orctbCuentas.cucocodi, orctbCuentas.cucovaap, orctbCuentas.cucovare, orctbCuentas.cucovaab, orctbCuentas.cucovato, orctbCuentas.cucofepa, orctbCuentas.cuconuse, orctbCuentas.cucosacu, orctbCuentas.cucovrap, orctbCuentas.cucofact, orctbCuentas.cucofeve, orctbCuentas.cucovafa, orctbCuentas.cucofege, orctbCuentas.cucopefa;

    CLOSE cuCuentasProducto;
    pkerrors.Pop;
  EXCEPTION
    WHEN LOGIN_DENIED OR ex.CONTROLLED_ERROR THEN
      pkErrors.Pop;
      IF (cuCuentasProducto%ISOPEN) THEN
        CLOSE cuCuentasProducto;
      END IF;
      RAISE LOGIN_DENIED;
    WHEN pkConstante.exERROR_LEVEL2 THEN
      pkErrors.Pop;
      IF (cuCuentasProducto%ISOPEN) THEN
        CLOSE cuCuentasProducto;
      END IF;
      RAISE pkConstante.exERROR_LEVEL2;
    WHEN OTHERS THEN
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           IC_BCLisimProvGen.sbMensajeError);
      pkErrors.Pop;
      IF (cuCuentasProducto%ISOPEN) THEN
        CLOSE cuCuentasProducto;
      END IF;
      raise_application_error(pkConstante.nuERROR_LEVEL2,
                              IC_BCLisimProvGen.sbMensajeError);
  END GetAccountsByProduct;

  /*
  Propiedad intelectual de Open International Systems (c).

  Procedimiento : GetDifeByProduct
  Descripci?n   : Obtiene los diferidos por producto para un rango de fechas.

  Par?metros    :
        idtFechIni  Fecha Inicial
        idtFechFin  Fecha Final
        inuProducto Producto

  Retorna
        orctbDife  Cuentas de Cobro

  Autor     :   Claudia Liliana Rodr?guez
  Fecha     :   27-03-2012 10:26:00

  Historia de Modificaciones
  Fecha     IDEntrega

  11-06-2014  aesguerra.3811
  Se modifica para calcular el valor de los diferidos a la fecha de provisi?n y as? obtener
  el de la mayor cantidad de cuotas

  29-08-2012  gduqueSAO189287
  Se obtiene todos los diferidos con saldo pendiente mayor a cero.
  Se eliminan los parametros idtFechIni y idtFechFin

  27-03-2012  crodriguezSAO180613
  Creaci?n.
  */
  PROCEDURE GetDifeByProduct(inuProducto IN servsusc.sesunuse%TYPE,
                             orctbdife   OUT NOCOPY tytbDifexProd,
                             idtProcDate IN DATE DEFAULT SYSDATE) IS

    ------------------------------------------------------------------------
    -- Cursores
    ------------------------------------------------------------------------
    -- Obtiene las cuentas de cobro del producto

    CURSOR cuDifeProduct(inuProducto IN servsusc.sesunuse%TYPE) IS
      SELECT
      /*+
                      index_asc( diferido IX_DIFE_NUSE )
                  */
       difecodi, difenucu, difesape, difesign, difeconc
        FROM diferido /*+ IC_BCLisimProvGen.GetDifeByProduct */
       WHERE difenuse = inuProducto
         AND difesape > 0;

    CURSOR cuDifeByProdDate(inuProducto IN servsusc.sesunuse%TYPE, idtProcessDate IN DATE) IS
      SELECT a.difecodi,
             a.difenucu,
             SUM(decode(b.modisign, 'DB', b.modivacu, -b.modivacu)) difesape,
             a.difesign,
             a.difeconc
        FROM diferido a, movidife b
       WHERE a.difecodi = b.modidife
         AND a.difenuse = inuProducto
         AND b.modifech < idtProcessDate HAVING
       SUM(decode(b.modisign, 'DB', b.modivacu, -b.modivacu)) > 0
       GROUP BY a.difecodi, a.difenucu, a.difesape, a.difesign, a.difeconc;

  BEGIN

    pkerrors.Push('IC_BCLisimProvGen.GetDifeByProduct');

    IF (cuDifeByProdDate%ISOPEN) THEN
      CLOSE cuDifeByProdDate;
    END IF;

    OPEN cuDifeByProdDate(inuProducto, idtProcDate);

    FETCH cuDifeByProdDate BULK COLLECT
      INTO orctbDife.difecodi, orctbDife.difenucu, orctbDife.difesape, orctbDife.difesign, orctbDife.difeconc;

    CLOSE cuDifeByProdDate;
    pkerrors.Pop;
  EXCEPTION
    WHEN LOGIN_DENIED OR ex.CONTROLLED_ERROR THEN
      pkErrors.Pop;
      IF (cuDifeByProdDate%ISOPEN) THEN
        CLOSE cuDifeByProdDate;
      END IF;
      RAISE LOGIN_DENIED;
    WHEN pkConstante.exERROR_LEVEL2 THEN
      pkErrors.Pop;
      IF (cuDifeByProdDate%ISOPEN) THEN
        CLOSE cuDifeByProdDate;
      END IF;
      RAISE pkConstante.exERROR_LEVEL2;
    WHEN OTHERS THEN
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           IC_BCLisimProvGen.sbMensajeError);
      pkErrors.Pop;
      IF (cuDifeByProdDate%ISOPEN) THEN
        CLOSE cuDifeByProdDate;
      END IF;
      raise_application_error(pkConstante.nuERROR_LEVEL2,
                              IC_BCLisimProvGen.sbMensajeError);

  END GetDifeByProduct;

  /*
      Propiedad intelectual de Open International Systems (c).

      Procedimiento : ObtCartera
      Descripci?n   : Obtiene cartera por concepto

      Par?metros    :
            idtFechGen  Fecha de Generaci?n del proceso
            inuPivote   Contiene el valor del Pivote

      Autor     :   Claudia Liliana Rodr?guez
      Fecha     :   14-02-2012 10:26:00

      Historia de Modificaciones
      Fecha     IDEntrega

      01-10-2012  gduque.SAO183760
      Se elimina ORDER BY  y se utiliza el indice de la PK

      12-09-2012  gduque.SAO190015
      Se adiciona ORDER BY para que funcione correctamente el pivote.

      29-08-2012  gduqueSAO189287
      Se estructura nuevamente sentencia por rendimiento.

      14-02-2012  crodriguezSAO180613
      Creaci?n.
  */

  PROCEDURE ObtCartera(idtFechGen   IN ic_cartcoco.caccfege%TYPE,
                       inuPivote    IN NUMBER,
                       isbTyPrEx    IN VARCHAR2,
                       inuNumHilos  IN NUMBER,
                       inuHilo      IN NUMBER,
                       orctbCartera OUT NOCOPY pktblic_cartprov.tytbIc_Cartprov) IS

    ------------------------------------------------------------------------
    -- Cursores
    ------------------------------------------------------------------------
    -- Obtiene los registros de la entidad de cartera con fecha de generaci?n
    -- menor o igual a la del mes anterior
    CURSOR cuDatosCartera(idtFech IN ic_cartcoco.caccfege%TYPE, inuPivote IN NUMBER, isbTyPrEx IN VARCHAR2, inuNumHilos IN NUMBER, inuHilo IN NUMBER) IS
      SELECT --+ index(ic_cartcoco, PK_IC_CARTCOCO)
       cacccons,
       caccnaca,
       caccticl,
       caccidcl,
       caccclie,
       caccsusc,
       caccserv,
       caccnuse,
       caccesco,
       cacccate,
       caccsuca,
       cacctico,
       caccpref,
       caccnufi,
       cacccomp,
       cacccuco,
       caccconc,
       caccfeve,
       caccfege,
       caccsape,
       caccubg1,
       caccubg2,
       caccubg3,
       caccubg4,
       caccubg5,
       cacccicl
        FROM ic_cartcoco /*+ IC_BCLisimProvGen.ObtCartera */
       WHERE caccfege = idtFech
         AND caccnuse not in (select idproducto from detalisim_tmp)
         AND CACCNUSE NOT IN (SELECT DELINUSE FROM detlisim2_31012018)
         AND CACCNUSE NOT IN (SELECT DELINUSE FROM detlisim3_31012018)
         AND CACCNUSE NOT IN
             (1001029, 1999626, 50580250, 1999681, 50073849, 14521181)
            /*AND
                             caccnuse IN
                             (6545723, 50499484 \*, 6546335, 6546969, 6547545, 6547829, 6547913, 6548132, 6548143, 6548309, 6548313, 6548397, 6548406, 6548428, 6549257, 6549709, 6549713, 6549907, 6550166, 6550634, 6550639, 6551141, 6551142, 6551154, 6551261, 6551272, 6551743, 6551747, 6551994, 6552016, 6552195, 6552234, 6552522, 6552631, 6552707, 6552749, 6552899, 6552943, 6553600, 6553756, 6553796, 6554140, 6554271, 6554502, 6554546, 6554673, 6554810, 6554880, 6554977, 6555497, 6555650, 6555802, 6555828, 6555905, 6556144, 6556181, 6556185, 6556289, 6556354, 6556356, 6556385, 6556415, 6556615, 6556622, 6556751, 6556854, 6556937, 6557348, 6557394, 6557906, 6557907, 6558197, 6558608, 6558778, 6558835, 6558891, 6558978, 6559904, 6560228, 6560387, 6560436, 6560461, 6560492, 6561326, 6562644, 6563034, 6563083, 6563154, 6563156, 6563479, 6563898, 6565757, 6566074, 6566711, 6566837, 6567017, 6567457, 6567458, 6568586, 6568780, 6569423*\)*/
         AND cacccons > inuPivote
            -- Tipos de producto a provisionar por m?todo LISIM (BRILLA)
         AND instr(',' || isbTyPrEx || ',', ',' || caccserv || ',', 1, 1) <> 0
         AND MOD(caccnuse, inuNumHilos) + 1 = inuHilo;

  BEGIN

    pkerrors.Push('IC_BCLisimProvGen.ObtCartera');

    td('inuPivote ' || inuPivote);
    IF (cuDatosCartera%ISOPEN) THEN
      CLOSE cuDatosCartera;
    END IF;

    OPEN cuDatosCartera(idtFechGen,
                        inuPivote,
                        isbTyPrEx,
                        inuNumHilos,
                        inuHilo);

    FETCH cuDatosCartera BULK COLLECT
      INTO orctbCartera.caprcons, orctbCartera.caprnaca, orctbCartera.caprticl, orctbCartera.capridcl, orctbCartera.caprclie, orctbCartera.caprsusc, orctbCartera.caprserv, orctbCartera.caprnuse, orctbCartera.capresco, orctbCartera.caprcate, orctbCartera.caprsuca, orctbCartera.caprtico, orctbCartera.caprpref, orctbCartera.caprnufi, orctbCartera.caprcomp, orctbCartera.caprcuco, orctbCartera.caprconc, orctbCartera.caprfeve, orctbCartera.caprfege, orctbCartera.caprsape, orctbCartera.caprubg1, orctbCartera.caprubg2, orctbCartera.caprubg3, orctbCartera.caprubg4, orctbCartera.caprubg5, orctbCartera.caprcicl LIMIT cnuLimit;

    CLOSE cuDatosCartera;
    pkerrors.Pop;
  EXCEPTION
    WHEN LOGIN_DENIED OR ex.CONTROLLED_ERROR THEN
      pkErrors.Pop;
      IF (cuDatosCartera%ISOPEN) THEN
        CLOSE cuDatosCartera;
      END IF;
      RAISE LOGIN_DENIED;
    WHEN pkConstante.exERROR_LEVEL2 THEN
      pkErrors.Pop;
      IF (cuDatosCartera%ISOPEN) THEN
        CLOSE cuDatosCartera;
      END IF;
      RAISE pkConstante.exERROR_LEVEL2;
    WHEN OTHERS THEN
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           IC_BCLisimProvGen.sbMensajeError);
      pkErrors.Pop;
      IF (cuDatosCartera%ISOPEN) THEN
        CLOSE cuDatosCartera;
      END IF;
      raise_application_error(pkConstante.nuERROR_LEVEL2,
                              IC_BCLisimProvGen.sbMensajeError);

  END ObtCartera;

  /*
      Propiedad intelectual de Open International Systems. (c).

      Procedimiento :   GetProcessInitData
      Descripci?n     :   Cuenta los registros de Cartera y el primer registro
                        a usar.

      Par?metros    :
          idtfecha     Fecha Generaci?n
          isbTyPrEx    Tipos de Producto a Excluir
          inuNumHilos  N?mero de Hilos
          inuHilo      Hilo Actual

      Retorno     :
          onuCount        N?mero de registros
          onuFirst        Primer Registro a Evaluar

      Autor     :   German Alexis Duque
      Fecha     :   01-10-2012

      Historia de Modificaciones
      Fecha     IDEntrega

      01-10-2012  gduque.SAO189287
      Creaci?n.

  */

  PROCEDURE GetProcessInitData(idtfecha    IN ic_cartcoco.caccfege%TYPE,
                               isbTyPrEx   IN VARCHAR2,
                               inuNumHilos IN NUMBER,
                               inuHilo     IN NUMBER,
                               onuCount    OUT NUMBER,
                               onuFirst    OUT ic_cartcoco.cacccons%TYPE

                               ) IS

    ------------------------------------------------------------------------
    -- Variables
    ------------------------------------------------------------------------

    ------------------------------------------------------------------------
    -- Cursores
    ------------------------------------------------------------------------
    -- Cuenta registros a procesar en Cartera por Concepto
    CURSOR cuCartcoco(idtFecha IN ic_cartcoco.caccfege%TYPE, inuNumHilos IN NUMBER, inuHilo IN NUMBER) IS
      SELECT --+ index(ic_cartcoco, IX_IC_CARTCOCO03)
       COUNT(1), MIN(cacccons)
        FROM ic_cartcoco i
      /*+ IC_BCLisimProvGen.GetProcessInitData */
       WHERE caccfege = idtFecha
         AND caccnuse not in (select idproducto from detalisim_tmp)
         AND CACCNUSE NOT IN (SELECT DELINUSE FROM detlisim2_31012018)
         AND CACCNUSE NOT IN (SELECT DELINUSE FROM detlisim3_31012018)
         AND CACCNUSE NOT IN
             (1001029, 1999626, 50580250, 1999681, 50073849, 14521181)
         AND instr(',' || isbTyPrEx || ',', ',' || caccserv || ',', 1, 1) <> 0
         AND MOD(caccnuse, inuNumHilos) + 1 = inuHilo;

  BEGIN

    pkErrors.Push('IC_BCLisimProvGen.GetProcessInitData');

    IF (cuCartcoco%ISOPEN) THEN
      CLOSE cuCartcoco;
    END IF;

    OPEN cuCartcoco(idtfecha, inuNumHilos, inuHilo);

    -- Se cuentan facturas
    -- Obtiene los datos
    FETCH cuCartcoco
      INTO onuCount, onuFirst;

    CLOSE cuCartcoco;

    pkErrors.Pop;

  EXCEPTION
    WHEN LOGIN_DENIED OR ex.CONTROLLED_ERROR THEN
      pkErrors.Pop;
      IF (cuCartcoco%ISOPEN) THEN
        CLOSE cuCartcoco;
      END IF;
      RAISE LOGIN_DENIED;
    WHEN pkConstante.exERROR_LEVEL2 THEN
      pkErrors.Pop;
      IF (cuCartcoco%ISOPEN) THEN
        CLOSE cuCartcoco;
      END IF;
      RAISE pkConstante.exERROR_LEVEL2;
    WHEN OTHERS THEN
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           IC_BCLisimProvGen.sbMensajeError);
      pkErrors.Pop;
      IF (cuCartcoco%ISOPEN) THEN
        CLOSE cuCartcoco;
      END IF;
      raise_application_error(pkConstante.nuERROR_LEVEL2,
                              IC_BCLisimProvGen.sbMensajeError);
  END GetProcessInitData;

  /*
  Propiedad intelectual de Open International Systems (c).

  Procedimiento : GetIndicatorValueSMMLV
  Descripci?n   : Obtiene SMMLV.

  Par?metros    :
        inuIndicator  Indicador
  Retorna
        orctbIc_ConfSMMLV  Tabla con Salarios

  Autor     :   Claudia Liliana Rodr?guez
  Fecha     :   27-03-2012 10:26:00

  Historia de Modificaciones
  Fecha     IDEntrega

  13-08-2012   gduqueSAO188355
  Se adiciona parametro A?o.

  27-03-2012  crodriguezSAO180613
  Creaci?n.
  */

  PROCEDURE GetIndicatorValueSMMLV(inuIndicator      IN ge_indicator_values.indicator_id%TYPE,
                                   inuYear           IN ge_indicator_values.indicator_Year%TYPE,
                                   orctbIc_ConfSMMLV OUT NOCOPY dage_indicator_values.tyrcGE_indicator_values) IS

    ------------------------------------------------------------------------
    -- Cursores
    ------------------------------------------------------------------------
    -- Obtiene las cuentas de cobro del producto

    CURSOR cuIndicatorValue(inuIndicator IN ge_indicator_values.indicator_id%TYPE) IS
      SELECT
      /*+
                      index_desc( ge_indicator_values UX_GE_INDICATOR_VALUES01 )
                  */
       *
        FROM ge_indicator_values /*+ IC_BCLisimProv.GetIndicatorValueSMMLV */
       WHERE indicator_id = inuIndicator
         AND indicator_Year = inuYear;

  BEGIN

    pkerrors.Push('IC_BCLisimProvGen.GetIndicatorValueSMMLV');

    IF (cuIndicatorValue%ISOPEN) THEN
      CLOSE cuIndicatorValue;
    END IF;

    OPEN cuIndicatorValue(inuIndicator);

    FETCH cuIndicatorValue BULK COLLECT
      INTO orctbIc_ConfSMMLV.Indicator_Value_Cons, orctbIc_ConfSMMLV.Indicator_Id, orctbIc_ConfSMMLV.Indicator_Year, orctbIc_ConfSMMLV.Indicator_Month, orctbIc_ConfSMMLV.Indicator_Value;
    CLOSE cuIndicatorValue;

    pkerrors.Pop;
  EXCEPTION
    WHEN LOGIN_DENIED OR ex.CONTROLLED_ERROR THEN
      pkErrors.Pop;
      IF (cuIndicatorValue%ISOPEN) THEN
        CLOSE cuIndicatorValue;
      END IF;
      RAISE LOGIN_DENIED;
    WHEN pkConstante.exERROR_LEVEL2 THEN
      pkErrors.Pop;
      IF (cuIndicatorValue%ISOPEN) THEN
        CLOSE cuIndicatorValue;
      END IF;
      RAISE pkConstante.exERROR_LEVEL2;
    WHEN OTHERS THEN
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           IC_BCLisimProvGen.sbMensajeError);
      pkErrors.Pop;
      IF (cuIndicatorValue%ISOPEN) THEN
        CLOSE cuIndicatorValue;
      END IF;
      raise_application_error(pkConstante.nuERROR_LEVEL2,
                              IC_BCLisimProvGen.sbMensajeError);

  END GetIndicatorValueSMMLV;

  /***************************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Procedure   :  GetAccountsByDife
  Descripcion   :  Obtiene Cuentas de Cobro por diferido.

  Par?metros    :
        isbDocuSopo  Documento de Soporte
        inuProducto  Producto
  Retorna
        orctbCuentas  Tabla con Cuentas

  Autor       :  German Alexis Duque
  Fecha       :  21-02-2012



  Historia de Modificaciones
  Fecha           Autor
  Modificacion

  21-02-2012  gduqueSAO180618
  Creaci?n.
  ***************************************************************************/
  PROCEDURE GetAccountsByDife(isbDocuSopo  IN cargos.cargdoso%TYPE,
                              inuProducto  IN cargos.cargnuse%TYPE,
                              orctbCuentas OUT NOCOPY tytbCuentaxDife) IS
    CURSOR cuCuentasDiferido IS
      SELECT
      /*+
                    ordered
                    use_nl( cargos cuencobr )
                    index_asc( cargos IX_CARGOS010 )
                    index_asc( cuencobr PK_CUENCOBR )
                  */
       cucocodi, cuconuse
        FROM cargos, cuencobr /*+ IC_BCLisimProv.GetAccountsByDife */
       WHERE cargnuse = inuProducto
         AND cargdoso = isbDocuSopo
         AND cucocodi = cargcuco
         AND cucosacu > 0;

  BEGIN
    pkErrors.Push('IC_BCLisimProvGen.GetAccountsByDife');

    IF (cuCuentasDiferido%ISOPEN) THEN
      CLOSE cuCuentasDiferido;
    END IF;

    OPEN cuCuentasDiferido;

    FETCH cuCuentasDiferido BULK COLLECT
      INTO orctbCuentas.cucocodi, orctbCuentas.cuconuse;

    CLOSE cuCuentasDiferido;

    pkErrors.Pop;
  EXCEPTION
    WHEN LOGIN_DENIED OR ex.CONTROLLED_ERROR THEN
      pkErrors.Pop;
      IF (cuCuentasDiferido%ISOPEN) THEN
        CLOSE cuCuentasDiferido;
      END IF;
      RAISE LOGIN_DENIED;
    WHEN pkConstante.exERROR_LEVEL2 THEN
      pkErrors.Pop;
      IF (cuCuentasDiferido%ISOPEN) THEN
        CLOSE cuCuentasDiferido;
      END IF;
      RAISE pkConstante.exERROR_LEVEL2;
    WHEN OTHERS THEN
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           IC_BCLisimProvGen.sbMensajeError);
      pkErrors.Pop;
      IF (cuCuentasDiferido%ISOPEN) THEN
        CLOSE cuCuentasDiferido;
      END IF;
      raise_application_error(pkConstante.nuERROR_LEVEL2,
                              IC_BCLisimProvGen.sbMensajeError);
  END GetAccountsByDife;

  /*
  Propiedad intelectual de Open International Systems. (c).

  Procedure : DelTmpMovProvCart

  Descripcion   : Eliminar movimientos provisionados de la entidad temporal de
                Cartera.

  Parametros  : Descripcion
      inuTipDocu  Tipo de Documento
      isbTyPrEx   Tipos de Producto a Excluir
  Retorno     :
      odlFlagDatos  Exito

  Autor : German Alexis Duque
  Fecha : 13-08-2012

  Historia de Modificaciones
  Fecha ID Entrega

  13-08-2012    gduqueSAO188355
  creacion
  */
  PROCEDURE DelTmpMovProvCart(inuTipDocu   IN ic_tipodoco.tidccodi%TYPE,
                              isbTyPrEx    IN VARCHAR2,
                              odlFlagDatos OUT BOOLEAN) IS
  BEGIN
    pkErrors.Push('IC_BCLisimProvGen.DelTmpMovProvCart');

    odlFlagDatos := TRUE;

    DELETE --+ index(tmp_ic_moviprov, IX_TMP_IC_MOVIPROV01)
    tmp_ic_moviprov /*+IC_BCLisimProvGen.DelTmpMovProvCart*/
     WHERE mvprtido = inuTipDocu
       AND instr(',' || isbTyPrEx || ',', ',' || mvprserv || ',', 1, 1) != 0
       AND ROWNUM <= cnuLimit;

    IF (SQL%ROWCOUNT = 0) THEN
      odlFlagDatos := FALSE;
    END IF;

    pkErrors.Pop;

  EXCEPTION
    WHEN LOGIN_DENIED THEN
      pkErrors.Pop;
      RAISE LOGIN_DENIED;

    WHEN pkConstante.exERROR_LEVEL2 THEN
      pkErrors.Pop;
      RAISE pkConstante.exERROR_LEVEL2;

    WHEN OTHERS THEN
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           IC_BCLisimProvGen.sbMensajeError);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2,
                              IC_BCLisimProvGen.sbMensajeError);

  END DelTmpMovProvCart;

  /*
      Propiedad intelectual de Open International Systems. (c).

      Procedure : InsMovDesProvision
      Descripcion   : Insertar movimientos a desprovisionar

      Parametros  : Descripcion
          inuTipDocu Tipo de Documento,
          isbTyPrEx  Tipos de Prodcuto Brilla,
          isbVarCar  Si es Cartera
      Retorno     :

      Autor : German Alexis Duque
      Fecha : 13-08-2012

      Historia de Modificaciones
      Fecha ID Entrega

      17-07-2013  hlopez.SAO212472
      Se adiciona el atributo Clasificaci?n Contable del Contrato.

      08-04-2013   sgomez.SAO205719
      Se modifica <Provisi?n LISIM> por impacto en <Hechos Econ?micos>
      (adici?n de atributo <?tem>).

      16-08-2012  gduqueSAO188626
      Se adiciona los campos MVPRNUFA,MVPRCALE,MVPRTITR,MVPRTIUO,MVPRTIBR,
      MVPRNIBT,MVPRNIBR,MVPRNICA,MVPRCUPO,MVPRVABA.
      Se elimina los campos MVPRTIPR,MVPRESPR,MVPRORDE,MVPRCONT

      13-08-2012    gduqueSAO188355
      creacion
  */
  PROCEDURE InsMovDesProvision(inuTipDocu IN ic_tipodoco.tidccodi%TYPE,
                               isbTyPrEx  IN VARCHAR2,
                               isbVarCar  IN VARCHAR2) IS
  BEGIN
    pkErrors.Push('IC_BCLisimProvGen.InsMovDesProvision');

    INSERT INTO ic_movimien
      (movicons, -- Consecutivo
       movitido, -- codigo tipo documento
       movinudo, -- numero de documento
       movitimo, -- tipo de movimiento
       movifeco, -- fecha contabilizacion
       movisign, -- signo movimiento
       movivalo, -- valor movimiento
       movicicl, -- ciclo
       moviserv, -- tipo producto
       moviempr, -- empresa
       movicate, -- categoria
       movisuca, -- subcategoria
       moviconc, -- concepto
       movicaca, -- causa cargo
       movibanc, -- banco
       movisuba, -- sucursal
       movitdsr, -- tipo documento recaudo
       movititb, -- tipo transaccion
       movibatr, -- banco transaccion
       movicuba, -- numero cuenta
       movinutr, -- numero documento
       movifetr, -- fecha transaccion
       movisusc, -- contrato
       moviceco, -- centro de costos
       moviterc, -- tercero
       moviusua, -- usuario
       moviterm, -- terminal
       movifopa, -- forma de pago
       movicldp, -- clase de documento de pago
       movitoim, -- total impuesto
       moviimp1, -- valor impuesto 1
       moviimp2, -- valor impuesto 2
       moviimp3, -- valor impuesto 3
       movisipr, -- empresa prestadora del servicio
       movisire, -- empresa recaudadora
       movitidi, -- tipo de direcci?n
       movifeap, -- fecha de aplicaci?n del pago
       movifeve, -- fecha de vencimiento de la cuenta de cobro
       movivatr, -- valor total retirados
       movivtir, -- valor total impuesto retirados
       movivir1, -- valor impuesto retirados 1
       movivir2, -- valor impuesto retirados 2
       movivir3, -- valor impuesto retirados 3
       movinips, -- nit del prestador del servicio
       movitica, -- tipo cartera ( c  corriente, d  dif?cil cobro )
       moviubg1, -- ubicaci?n geogr?fica 1
       moviubg2, -- ubicaci?n geogr?fica 2
       moviancb, -- a?o de cargo b?sico
       movimecb, -- mes de cargo b?sico
       movisivr, -- signo del valor de productos retirados.
       movisifa, -- empresa propietaria de la factura
       movisici, -- empresa propietaria del ciclo de facturaci?n
       movitihe, -- tipo hecho economico
       moviproy, -- codigo del proyecto
       moviclit, -- clasificador del item
       moviunid, -- unidades
       moviubg3, -- ubicaci?n geogr?fica 3
       moviubg4, -- ubicaci?n geogr?fica 4
       moviubg5, -- ubicaci?n geogr?fica 5
       movidipr, -- dias provisi?n
       movinaca, -- Naturaleza de Cartera
       movitiuo, -- tipo de unidad operativa (I:interna, E:externa)
       movititr, -- tipo de trabajo
       movicale, -- Causal de Legalizacion
       movinufa, -- Numero de Factura
       moviitem, -- ?tem
       moviclcc -- Clasificacion Contable del Contrato
       )
      SELECT --+ index(tmp_ic_moviprov, IX_TMP_IC_MOVIPROV01)
       SQ_IC_MOVIMIEN_175553.nextval, -- Consecutivo
       mvprtido, -- codigo tipo documento
       mvprnudo, -- numero de documento
       mvprtimo, -- tipo de mvprmiento
       mvprfeco, -- fecha contabilizacion
       mvprsign, -- signo movimiento
       mvprvalo, -- valor movimiento
       mvprcicl, -- ciclo
       mvprserv, -- tipo producto
       mvprempr, -- empresa
       mvprcate, -- categoria
       mvprsuca, -- subcategoria
       mvprconc, -- concepto
       mvprcaca, -- causa cargo
       mvprbanc, -- banco
       mvprsuba, -- sucursal
       mvprtdsr, -- tipo documento recaudo
       mvprtitb, -- tipo transaccion
       mvprbatr, -- banco transaccion
       mvprcuba, -- numero cuenta
       mvprnutr, -- numero documento
       mvprfetr, -- fecha transaccion
       mvprsusc, -- contrato
       mvprceco, -- centro de costos
       mvprterc, -- tercero
       mvprusua, -- usuario
       mvprterm, -- terminal
       mvprfopa, -- forma de pago
       mvprcldp, -- clase de documento de pago
       mvprtoim, -- total impuesto
       mvprimp1, -- valor impuesto 1
       mvprimp2, -- valor impuesto 2
       mvprimp3, -- valor impuesto 3
       mvprsipr, -- empresa prestadora del servicio
       mvprsire, -- empresa recaudadora
       mvprtidi, -- tipo de direcci?n
       mvprfeap, -- fecha de aplicaci?n del pago
       mvprfeve, -- fecha de vencimiento de la cuenta de cobro
       mvprvatr, -- valor total retirados
       mvprvtir, -- valor total impuesto retirados
       mvprvir1, -- valor impuesto retirados 1
       mvprvir2, -- valor impuesto retirados 2
       mvprvir3, -- valor impuesto retirados 3
       mvprnips, -- nit del prestador del servicio
       mvprtica, -- tipo cartera ( c  corriente, d  dif?cil cobro )
       mvprubg1, -- ubicaci?n geogr?fica 1
       mvprubg2, -- ubicaci?n geogr?fica 2
       mvprancb, -- a?o de cargo b?sico
       mvprmecb, -- mes de cargo b?sico
       mvprsivr, -- signo del valor de productos retirados.
       mvprsifa, -- empresa propietaria de la factura
       mvprsici, -- empresa propietaria del ciclo de facturaci?n
       mvprtihe, -- tipo hecho economico
       decode(isbVarCar, 'S', mvprcons, mvprproy), -- c?digo  del proyecto
       mvprclit, -- clasificador del item
       mvprunid, -- unidades
       mvprubg3, -- ubicaci?n geogr?fica 3
       mvprubg4, -- ubicaci?n geogr?fica 4
       mvprubg5, -- ubicaci?n geogr?fica 5
       mvprdipr, -- d?as provisi?n
       mvprnaca, -- naturaleza de cartera
       mvprtiuo, -- tipo de unidad operativa (I:interna, E:externa)
       mvprtitr, -- tipo de trabajo
       mvprcale, -- Causal de Legalizacion
       mvprnufa, -- Numero de Factura
       mvpritem, -- ?tem
       mvprclcc -- Clasificacion Contable del Contrato
        FROM tmp_ic_moviprov
      /*+ IC_BCProcessProvision.InsMovDesProvision */
       WHERE mvprtido = inuTipDocu
         AND instr(',' || isbTyPrEx || ',', ',' || mvprserv || ',', 1, 1) != 0;

    pkErrors.Pop;
  EXCEPTION
    WHEN LOGIN_DENIED THEN
      pkErrors.Pop;
      RAISE LOGIN_DENIED;
    WHEN pkConstante.exERROR_LEVEL2 THEN
      pkErrors.Pop;
      RAISE pkConstante.exERROR_LEVEL2;
    WHEN OTHERS THEN
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           IC_BCLisimProvGen.sbMensajeError);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2,
                              IC_BCLisimProvGen.sbMensajeError);
  END InsMovDesProvision;

  /*
      Propiedad intelectual de Open International Systems. (c).

      Procedimiento :   fnuDaysOnDefByProduct
      Descripci?n     :   Obtiene Edad mora por producto

      Par?metros    :
          idtFecha          Fecha del proceso

      Retorno     :
          nuCuenta        N?mero de registros.

      Autor     :   Claudia Liliana Rodr?guez
      Fecha     :   16-08-2012

      Historia de Modificaciones
      Fecha     IDEntrega

      02-04-2014  aesguerra.3551
      Se modifica para traer la edad de mora a partir de ic_cartcoco

      11-10-2013  sgomez.SAO219973
      Se modifica para acceder a ?ndice por producto (IX_CUENCOBR03) en vez de
      utilizar ?ndice por producto y fecha pago.

      16-08-2012  gduqueSAO188626
      Creaci?n.
  */

  FUNCTION fnuDaysOnDefByProduct(idtfecha    IN ic_cartcoco.caccfege%TYPE,
                                 inuProducto IN servsusc.sesunuse%TYPE)
    RETURN NUMBER IS

    ------------------------------------------------------------------------
    -- Variables
    ------------------------------------------------------------------------

    -- Edad Deuda
    nuEdadDeuda NUMBER := 0;

    ------------------------------------------------------------------------
    -- Cursores
    ------------------------------------------------------------------------
    -- Cuenta registros a procesar en Cartera por Concepto
    CURSOR cuEdadDeuda(idtFecha IN ic_cartcoco.caccfege%TYPE, inuProducto IN ic_cartcoco.caccnuse%TYPE) IS
      SELECT MIN(caccfege) - trunc(MIN(caccfeve))
        FROM ic_cartcoco
       WHERE trunc(caccfege) = trunc(idtFecha)
         AND caccnuse = inuProducto;

  BEGIN

    pkErrors.Push('IC_BCLisimProvGen.fnuDaysOnDefByProduct');

    IF cuEdadDeuda%ISOPEN THEN
      CLOSE cuEdadDeuda;
    END IF;

    OPEN cuEdadDeuda(idtfecha, inuProducto);
    FETCH cuEdadDeuda
      INTO nuEdadDeuda;
    CLOSE cuEdadDeuda;

    IF nuEdadDeuda <= 0 OR nuEdadDeuda IS NULL THEN
      nuEdadDeuda := 0;
    END IF;

    pkErrors.Pop;

    RETURN nuEdadDeuda;

  EXCEPTION
    WHEN LOGIN_DENIED OR ex.CONTROLLED_ERROR THEN
      pkErrors.Pop;
      IF (cuEdadDeuda%ISOPEN) THEN
        CLOSE cuEdadDeuda;
      END IF;
      RAISE LOGIN_DENIED;
    WHEN pkConstante.exERROR_LEVEL2 THEN
      pkErrors.Pop;
      IF (cuEdadDeuda%ISOPEN) THEN
        CLOSE cuEdadDeuda;
      END IF;
      RAISE pkConstante.exERROR_LEVEL2;
    WHEN OTHERS THEN
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           IC_BCLisimProvGen.sbMensajeError);
      pkErrors.Pop;
      IF (cuEdadDeuda%ISOPEN) THEN
        CLOSE cuEdadDeuda;
      END IF;
      raise_application_error(pkConstante.nuERROR_LEVEL2,
                              IC_BCLisimProvGen.sbMensajeError);
  END;

  /*
  Propiedad intelectual de Open International Systems. (c).

  Procedure   :  frfGetPortfolioCharges
  Descripcion   :  M?todo para obtener los cargos de las cuentas de cobro con
                 saldos pendientes.

  Parametros     Descripcion

  Autor       :  German Alexis Duque
  Fecha       :  17-08-2012

  Par?metros    :
      inuCucocodi       Cuenta de cobro

  Retorno     :
      orfCharges        CURSOR con los cargos de las cuentas de cobro con
                        saldos pendientes

  Historia de Modificaciones
  Fecha           Autor
  Modificacion

  17-08-2012  gduqueSAO188626
  Creaci?n.
  */
  FUNCTION frfGetPortfolioCharges(inuCucocodi IN cuencobr.cucocodi%TYPE)
    RETURN pkConstante.tyRefCursor IS

    -- CURSOR para obtener los cargos
    rfPortCharges pkConstante.tyRefCursor;

  BEGIN
    pkErrors.Push('IC_BCLisimProvGen.frfGetPortfolioCharges');

    -- Se verifica el estado del CURSOR
    IF (rfPortCharges%ISOPEN) THEN
      CLOSE rfPortCharges;
    END IF;

    -- Se abre el CURSOR
    OPEN rfPortCharges FOR
      SELECT --+ index(cargos IX_CARG_CUCO_CONC)
       pkConceptValuesMgr.fsbKey(NULL,
                                 NULL,
                                 NULL,
                                 NULL,
                                 NULL,
                                 cargconc,
                                 NULL,
                                 NULL,
                                 NULL,
                                 NULL,
                                 NULL,
                                 1,
                                 0) sbkey,
       cargconc,
       cargnuse,
       cargvalo,
       cargsign,
       cargfecr,
       cargunid,
       cargdoso,
       cargcodo
        FROM cargos /*+ IC_BCLisimProvGen.frfGetPortfolioCharges */
       WHERE cargvalo > pkBillConst.CERO
         AND cargsign IN
             (pkBillConst.DEBITO, pkBillConst.CREDITO, pkBillConst.PAGO,
              pkBillConst.APLSALDFAV, pkBillConst.SALDOFAVOR)
         AND cargcuco = inuCucocodi
       ORDER BY decode(cargsign,
                       pkBillConst.DEBITO,
                       1,
                       pkBillConst.CREDITO,
                       2,
                       pkBillConst.APLSALDFAV,
                       3,
                       pkBillConst.PAGO,
                       4,
                       5);

    -- Retorna el CURSOR
    RETURN rfPortCharges;

    pkErrors.Pop;
  EXCEPTION
    WHEN LOGIN_DENIED THEN
      pkErrors.Pop;
      RAISE LOGIN_DENIED;
    WHEN pkConstante.exERROR_LEVEL2 THEN
      pkErrors.Pop;
      RAISE pkConstante.exERROR_LEVEL2;
    WHEN OTHERS THEN
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           IC_BCLisimProvGen.sbMensajeError);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2,
                              IC_BCLisimProvGen.sbMensajeError);
  END frfGetPortfolioCharges;

  /**********************************************************************
      Propiedad intelectual de OPEN International Systems
      Nombre              fnuGetUsedQuotaByProdDate

      Autor           Andr?s Felipe Esguerra Restrepo

      Fecha               28-may-2014

      Descripci?n         Obtiene el cupo usado de brilla para un producto en una fecha espec?fica

      ***Parametros***
      Nombre              Descripci?n
      inuProductId        Producto
      idtProvisionDate    Fecha de c?lculo

      ***Historia de Modificaciones***
      Fecha Modificaci?n              Autor
      28-05-2014                      aesguerra.3551
      Creaci?n
  ***********************************************************************/
  FUNCTION fnuGetUsedQuotaByProdDate(inuProductId     IN servsusc.sesunuse%TYPE,
                                     idtProvisionDate IN DATE) RETURN NUMBER IS

    CURSOR cuUsedQuota(inuProdId servsusc.sesunuse%TYPE, idtProvDate DATE) IS
      SELECT SUM(caccsape)
        FROM ic_cartcoco
       WHERE caccnuse = inuProdId
         AND caccfege = idtProvDate
         AND caccconc IN (SELECT concept_id FROM ld_article);

    nuUsedQuota NUMBER := 0;

  BEGIN

    ut_trace.trace('Inicio IC_BCLisimProvGen.fnuGetUsedQuotaByProdDate', 1);

    IF cuUsedQuota%ISOPEN THEN
      CLOSE cuUsedQuota;
    END IF;

    OPEN cuUsedQuota(inuProductId, idtProvisionDate);
    FETCH cuUsedQuota
      INTO nuUsedQuota;
    CLOSE cuUsedQuota;

    nuUsedQuota := nvl(nuUsedQuota, 0);

    ut_trace.trace('Fin IC_BCLisimProvGen.fnuGetUsedQuotaByProdDate', 1);

    RETURN nuUsedQuota;

  END fnuGetUsedQuotaByProdDate;

  /**********************************************************************
      Propiedad intelectual del Grupo Promigas
      Nombre              fnuGetAccoutsBalance

      Autor               Jose Lizardo Castro

      Fecha               22-09-2014

      Descripci?n         Obtiene cuentas de cobro con saldo

      ***Parametros***
      Nombre              Descripci?n
      inuProductId        Producto

      ***Historia de Modificaciones***
      Fecha Modificaci?n              Autor

      Creacion
      22-09-2014                     Jose Lizardo Castro
  ***********************************************************************/
  FUNCTION fnuGetAccoutsBalance(inuProductId IN servsusc.sesunuse%TYPE)
    RETURN NUMBER IS

    CURSOR cuBalance(inuProdId servsusc.sesunuse%TYPE) IS
      SELECT SUM(cant)
        FROM (SELECT COUNT(cucocodi) cant
                FROM cuencobr
               WHERE cucosacu > 0
                 AND cuconuse = inuProdId
                    -- Inicio CA 100-9314
                 AND fnuAplicaEntrega(csbBSS_FAC_LFG_10031316) = 0 -- Entrega no aplicada
              UNION
              SELECT los.nro_ctas_con_saldo cant
                FROM ldc_osf_sesucier los
               WHERE los.producto = inuProdId
                 AND nuano = to_number(to_char(ic_bolisimprovgen.dtProcessDate,
                                               'yyyy'))
                 AND numes =
                     to_number(to_char(ic_bolisimprovgen.dtProcessDate, 'mm'))
                 AND fnuAplicaEntrega(csbBSS_FAC_LFG_10031316) = 1); -- Entrega aplicada
    -- Fin CA 100-9314

    nuBalance NUMBER := 0;

  BEGIN

    ut_trace.trace('Inicio IC_BCLisimProvGen.fnuGetAccoutsBalance', 1);

    IF cuBalance%ISOPEN THEN
      CLOSE cuBalance;
    END IF;

    OPEN cuBalance(inuProductId);
    FETCH cuBalance
      INTO nuBalance;
    CLOSE cuBalance;

    nuBalance := nvl(nuBalance, 0);

    ut_trace.trace('Fin IC_BCLisimProvGen.fnuGetAccoutsBalance', 1);

    RETURN nuBalance;

  END fnuGetAccoutsBalance;

END IC_BCLisimProvGen;
/
GRANT EXECUTE on IC_BCLISIMPROVGEN to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on IC_BCLISIMPROVGEN to REXEOPEN;
GRANT EXECUTE on IC_BCLISIMPROVGEN to RSELSYS;
/
