CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKFACTKIOSCO AS

/************************************************************************
PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

       PAQUETE : LDCI_PKFACTKIOSCO
         AUTOR : Hector Fabio Dominguez
         FECHA : 29/01/2013
     RICEF : I045

DESCRIPCION : Paquete de Impresion Duplciado para Kioscos,tiene como funcion principal la
               consulta de informacion de los contratos y la consulta de datos para impresion


Historia de Modificaciones

Autor        Fecha       Descripcion.
hectorfdv    05-03-2014  Ajuste en el calculo del saldo anteror TQ 3034
hectorfdv    31-03-2014  Ajuste para cuando el retorno de la api de saldos sea nulo TQ 3034
hectorfdv    29-04-2014  Ajuste de retorno en la funcion fnuConsultComponentCostoGen para evitar retorno nulo TQ 3292

************************************************************************/

FUNCTION FNUCONSULTAVALORANTFACT (nuSusccodi         IN  suscripc.susccodi%type)RETURN NUMBER;
FUNCTION FNUCONSULTASADOACT   (nuSusccodi         IN  suscripc.susccodi%type)RETURN NUMBER;
FUNCTION FNUCONSULTASADOANT   (nuSusccodi         IN  suscripc.susccodi%type)RETURN NUMBER;
FUNCTION fsbOrdenSuspContrato (nuSusccodi         IN  suscripc.susccodi%TYPE)RETURN VARCHAR2;
FUNCTION fsbProcFactura (nuSusccodi in suscripc.susccodi%type)  RETURN VARCHAR2;
FUNCTION FSBCONSULTAFECHREV(inuNuse IN NUMBER) RETURN VARCHAR2;

PROCEDURE PROCONSULTASUSCRIPC (inuSusccodi         IN  suscripc.susccodi%type,
                               isbIdentificacion   IN  VARCHAR2,
                               isbTelefono         IN  VARCHAR2,
                               nuServicio          IN  NUMBER,
                               CUSUSCRIPCIONES    OUT  SYS_REFCURSOR,
                               onuErrorCode       OUT  NUMBER,
                               osbErrorMessage    OUT  VARCHAR2);

  FUNCTION fsbValidaContrato (nuSusccodi in suscripc.susccodi%type)
  RETURN VARCHAR2;

  FUNCTION fsbFormatoFactContrato (nuSusccodi in suscripc.susccodi%type)
  RETURN VARCHAR2;

  FUNCTION fsbValidaIdentificacion(nuIdentification in ge_subscriber.identification%type)
  RETURN VARCHAR2;

  PROCEDURE proCnltaDupliFact(inuSuscCodi         IN   SUSCRIPC.SUSCCODI%TYPE,
                                  orDocuments           OUT  SYS_REFCURSOR,
                                  onuErrorCode        out  NUMBER,
                                  osbErrorMessage     out  VARCHAR2);

PROCEDURE PROGENERAFACT (inuSusccodi          IN      suscripc.susccodi%type,
                         inuSaldoGen                                       IN     NUMBER, -- NUMBER(13,2)   nuevo
                         isbTipoSaldo                                      IN     VARCHAR2,-- nuevo,
                         CUDATOSBASIC                                  OUT   SYS_REFCURSOR,
                         CUFACTDETA                                      OUT  SYS_REFCURSOR,
                         CURANGOS           OUT  SYS_REFCURSOR,
                         CUHISTORICO        OUT  SYS_REFCURSOR,
                         CULECTURAS     OUT  SYS_REFCURSOR,
                         CUCONSUMOS     OUT  SYS_REFCURSOR,
                         CUCOMPONENTES     OUT  SYS_REFCURSOR,
                         osbSeguroLiberty    OUT VARCHAR2,--Campo Nuevo,
                         osbOrdenSusp        OUT VARCHAR2,-- Campo Nuevo
                         osbProcFact       OUT VARCHAR2,-- Campo Nuevo
                         onuErrorCode       OUT  NUMBER,
                         osbErrorMessage    OUT  VARCHAR2);
FUNCTION fnuObtenerInteresMora
    (
        inuCupon             in CUPON.CUPONUME%type,
        inuFactura         in NUMBER,
        onuErrorCode      out number,
        osbErrorMsg        OUT VARCHAR2
    )
    RETURN ta_vigetaco.vitcporc%type;
FUNCTION fnugetgeo_loca_father_id(iNuGeo IN NUMBER) RETURN NUMBER;
FUNCTION fsbgetdescription(iNuGeo IN NUMBER) RETURN VARCHAR2;

FUNCTION fnuConsultComponentCosto(inuConcept  IN  concepto.conccodi%type,
                                  inuCompType IN  lectelme.leemtcon%type,
                                  inuFOT      IN  number,
                                  nufactura   IN  factura.factcodi%type, --factura
                                  nuSuscripc  IN  servsusc.SESUSUSC%type) RETURN ta_vigetaco.vitcvalo%type;

FUNCTION fnuConsultComponentCostoGen(inuConcept  IN  concepto.conccodi%type,
                                  inuCompType IN  lectelme.leemtcon%type,
                                  inuFOT      IN  number,
                                  nufactura   IN  factura.factcodi%type, --factura
                                  nuSuscripc  IN  servsusc.SESUSUSC%type) RETURN ta_vigetaco.vitcvalo%type;

FUNCTION fsbGetDesviacion(inuFactura IN NUMBER)     return varchar2;

END LDCI_PKFACTKIOSCO;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKFACTKIOSCO AS


    /**************************************************************************
    Propiedad Intelectual de PETI

    Funcion     :  fnuGetDesviacion
    Descripcion :  Obtiene la desviacion de consumos.

    Autor       : Sergio Mejia - Optima Consulting
    Fecha       : 05-03-2014

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    05-03-2014          smejia              Creacion.
    07-03-2014          smejia              Aranda 3065. Se redondea el campo consumo_promedio
                                            que se encuntra en el decode, validando si este campo
                                            es 0 o nulo.
    25-04-2014          hectorfdv           Se ajusta la funcion para calcular la desviacion
    **************************************************************************/
     FUNCTION fsbGetDesviacion(inuFactura IN NUMBER)
     return varchar2
     IS
         sbDesviacion varchar2(50);
         sbFactcodi ge_boInstanceControl.stysbValue;
    BEGIN

     UT_Trace.Trace('Inicia Funcion LDC_BOFORMATOFACTURA.fsbGetDesviacion',15);

     sbFactcodi :=inuFactura; --obtenervalorinstancia('FACTURA','FACTCODI');

        SELECT to_char(decode(round(consumo_promedio), 0, 0, null, 0, ((round(consumo_actual) - round(consumo_promedio))/round(consumo_promedio))*100),'FM999,999,990')||'%' desviacion
        INTO sbDesviacion
        from (
        select  ((open.LDC_BOFORMATOFACTURA.fnuGetConsumoAtras(max(factpefa),max(factcodi),5)+
                open.LDC_BOFORMATOFACTURA.fnuGetConsumoAtras(max(factpefa),max(factcodi),4)+
                open.LDC_BOFORMATOFACTURA.fnuGetConsumoAtras(max(factpefa),max(factcodi),3)+
                open.LDC_BOFORMATOFACTURA.fnuGetConsumoAtras(max(factpefa),max(factcodi),2)+
                open.LDC_BOFORMATOFACTURA.fnuGetConsumoAtras(max(factpefa),max(factcodi),1)+
                open.LDC_BOFORMATOFACTURA.fnuGetConsumoAtras(max(factpefa),max(factcodi),0))/6)  consumo_promedio,
                nvl(round(sum(decode(sesucate,1, cosscoca, 2, cosscoca, 3, decode(cossfcco, null,0,cosscoca),LDC_BOFORMATOFACTURA.fnuGetConsumoIndustriaNR(factcodi))),2),0) consumo_actual
        FROM factura f inner join servsusc s on (sesususc = factsusc) LEFT OUTER JOIN conssesu c
        ON (c.cosssesu = s.sesunuse
        and c.cosspefa = f.factpefa
        AND cossmecc=4) left outer join cm_facocoss on (cossfcco=fccocons)
        WHERE  factcodi = sbFactcodi
        );

        UT_Trace.Trace('Finaliza Funcion LDC_BOFORMATOFACTURA.fsbGetDesviacion',15);

        return sbDesviacion;

    EXCEPTION
        when no_data_found then
            RETURN to_char(0,'FM999,999,990');
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fsbGetDesviacion;

/*****************************************************************
    Propiedad intelectual de Gases de occidente

    Function  :    FSBCONSULTAFECHREV
    Descripcion :  Calcula la fecha de la proxima
                   revision, si no es una fecha entonces
                   retorna el mensaje

    Parametros  :  Servicio

    Retorno     :onubReturn

    Autor    :  Hector Fabio Dominguez
    Fecha    :  08-01-2014



    *****************************************************************/

FUNCTION FSBCONSULTAFECHREV (inuNuse IN  NUMBER)RETURN VARCHAR2
IS
sbReturn VARCHAR2(1000);
BEGIN
sbReturn:=to_char(to_date(open.LDC_BOFORMATOFACTURA.fnuGetFechaProxRevision(inuNuse), 'MON-yyyy'), 'MON-yyyy','NLS_DATE_LANGUAGE = SPANISH');

RETURN sbReturn;
EXCEPTION
WHEN OTHERS THEN
  RETURN  open.LDC_BOFORMATOFACTURA.fnuGetFechaProxRevision(inuNuse) ;
END FSBCONSULTAFECHREV;

/*****************************************************************
    Propiedad intelectual de Gases de occidente

    Function  :    FNUCONSULTAVALORFACT
    Descripcion :  Obtiene el valor facturado

    Parametros  :  Contrato

    Retorno     :onubReturn

    Autor    :  Hector Fabio Dominguez
    Fecha    :  08-01-2014



    *****************************************************************/

FUNCTION FNUCONSULTAVALORANTFACT (nuSusccodi         IN  suscripc.susccodi%type)RETURN NUMBER
IS
  nuCodUltFact      NUMBER;
  nuSaldUltFact     NUMBER;
  onuReturnvalue    NUMBER:=0;
  nuSaldoAnterior   NUMBER;
  dtFechaVenc       DATE;


  /*
   * Consulta la ultima
   * factura para y extrae las cuentas
   * de cobro
   *

    CURSOR cuConsultaUltFact IS
    SELECT SUM (CUCOSACU),CUCOFACT
    FROM CUENCOBR
    WHERE CUCOFACT =(    SELECT MAX(factcodi)
                         FROM factura factu
                         WHERE factu.factsusc=nuSusccodi AND FACTPROG=6)
    GROUP BY CUCOFACT;
*/



   /*
    * Descripcion: Se calcula cual es el ultimo periodo de las facturas con saldo
    *              Se obtiene las facturas de ese periodo y se suman los saldos pendientes
    * fecha: 03/03/2014
    *    TQ: 3034
    */
CURSOR cuConsultaUltFact IS
SELECT GCC.SALDO,(SELECT max(factcodi) FROM factura fact2 WHERE factsusc=nuSusccodi AND (SELECT SUM(CUCOSACU) FROM CUENCOBR CCBR WHERE CUCOFACT=fact2.factcodi)>0) FACTURA
FROM(
SELECT SUM (CUCOSACU) SALDO
    FROM CUENCOBR cc
    WHERE cc.CUCOFACT IN (SELECT factu.factcodi
                          FROM factura factu
                          WHERE factu.factsusc = nuSusccodi AND (SELECT SUM(CUCOSACU) FROM CUENCOBR CCBR WHERE CCBR.CUCOFACT=factu.factcodi)>0 AND
                                factu.FACTPEFA = (SELECT MAX(factusub.FACTPEFA) FROM FACTURA factusub WHERE factusub.factsusc=nuSusccodi AND (SELECT SUM(CUCOSACU) FROM CUENCOBR CCBR WHERE CUCOFACT=factusub.factcodi)>0)))GCC ;


    /*
     * Consulta la fecha de vencimiento
     * primera cuenta de cobro
     * de la factura
     */

      CURSOR cuConsultaFechVenc(iNuCodFact NUMBER) IS
      SELECT CUCOFEVE
      FROM   CUENCOBR
      WHERE  CUCOFACT = iNuCodFact AND
             ROWNUM<=1;




BEGIN

/*
 * Se consulta
 * la ultima factura generada
 */

  OPEN cuConsultaUltFact;
  FETCH cuConsultaUltFact INTO nuSaldUltFact,nuCodUltFact;
  CLOSE cuConsultaUltFact;

  IF nuSaldUltFact IS NULL THEN
    nuSaldUltFact:=0;
  END IF;
  /*
   * Se consulta a fecha de vencimiento de la primera cuenta de cobro
   */

  OPEN cuConsultaFechVenc(nuCodUltFact);
  FETCH cuConsultaFechVenc INTO dtFechaVenc;
  CLOSE cuConsultaFechVenc;

 /*
  * Se debe restar el saldo facturado al anterior
  * siempre y cuando el saldo anterior sea superior o igual al facturado
  * en caso contrario quiere decir que el saldo anterior no esta incluido
  *
  */
 nuSaldoAnterior:=LDCI_PKFACTKIOSCO.FNUCONSULTASADOANT(nuSusccodi);

  /*
   * Si la fecha de vencimiento
   * es menor a hoy, quiere decir
   * que se debe realizar la resta
   * del valor facturado
   * al saldo anterior
   * de lo contrario no, ya que el valor facturado
   * no se calculo dentro del saldo pendiente
   */

  IF dtFechaVenc<SYSDATE THEN
     onuReturnvalue:=nuSaldoAnterior-nuSaldUltFact;
  ELSE
     onuReturnvalue:=nuSaldoAnterior;
  END IF;


/*
 * TQ 3278
 * FECHA: 31-03-2014
 * Ajuste para cuando el retorno de la api
 * sea nulo
 */
  IF onuReturnvalue IS NULL THEN
    onuReturnvalue:=0;
  END IF;

  RETURN onuReturnvalue;

EXCEPTION
WHEN OTHERS THEN
RETURN 0;
END FNUCONSULTAVALORANTFACT;



 /*****************************************************************
    Propiedad intelectual de Gases de occidente

    Function  :  fsbgetdescription
    Descripcion :  Obtiene descripcion del barrio

    Parametros  :  Descripcion

    Retorno     :osbReturn

    Autor    :  Hector Fabio Dominguez
    Fecha    :  10-11-2013


    *****************************************************************/

FUNCTION fsbgetdescription(iNuGeo IN NUMBER) RETURN VARCHAR2
IS
osbReturn VARCHAR2(800);
BEGIN
osbReturn:=open.dage_geogra_location.fsbgetdescription(iNuGeo);
RETURN osbReturn;
EXCEPTION
WHEN OTHERS THEN
RETURN ' ';

END fsbgetdescription;

 /*****************************************************************
    Propiedad intelectual de Gases de occidente

    Function  :  fnugetgeo_loca_father_id
    Descripcion :  Obtiene el id del geograp padre

    Parametros  :  Descripcion
        inuConcept         Concepto
        inuCompType        Tipo de Consumo
        inuFOT             Forma de Obtener Tarifa

    Retorno     :
      nuTariffValid      Vigencia de Tarifa

    Autor    :  Hector Fabio Dominguez
    Fecha    :  10-11-2013


    *****************************************************************/


FUNCTION fnugetgeo_loca_father_id(iNuGeo IN NUMBER) RETURN NUMBER
IS
oNuReturn NUMBER;
BEGIN
oNuReturn:=open.dage_geogra_location.fnugetgeo_loca_father_id(iNuGeo);

EXCEPTION
WHEN OTHERS THEN
RETURN -1;

END fnugetgeo_loca_father_id;


    /*****************************************************************
    Propiedad intelectual de Gases de occidente

    Function    :  fnuConsultComponentCosto
    Descripcion :  Consulta componentes de costo

    Parametros  :  Descripcion
        inuConcept         Concepto
        inuCompType        Tipo de Consumo
        inuFOT             Forma de Obtener Tarifa
        nufactura          Numero de factura
        nuSuscripc         Contrato

    Retorno     :
      nuTariffValue      Valor

    Autor    :  Hector Fabio Dominguez
    Fecha    :  06-09-2013

	hectorfdv    29-04-2014  Ajuste de retorno en la funcion fnuConsultComponentCostoGen para evitar retorno nulo TQ 3292

    *****************************************************************/

FUNCTION fnuConsultComponentCostoGen(inuConcept  IN  concepto.conccodi%type,
                                  inuCompType IN  lectelme.leemtcon%type,
                                  inuFOT      IN  number,
                                  nufactura   IN  factura.factcodi%type, --factura
                                  nuSuscripc  IN  servsusc.SESUSUSC%type) RETURN  ta_vigetaco.vitcvalo%type
IS

        nuVitcons                   ta_vigetaco.vitccons%type;
        nuVitcvalo                  ta_vigetaco.vitcvalo%type;
        sbFactcodi                  ge_boInstanceControl.stysbValue;

        nuEsIndustriaNoRegulada     number; -- 1 si es es una industria no regulada
        -- parametro de identificadores de categoria de industria no regulada
        sbParameter   ld_parameter.value_chain%type:= dald_parameter.fsbGetValue_Chain('CATEG_IDUSTRIA_NO_REG');

    BEGIN
        --Obtiene el identificador de la factura de la instancia
        sbFactcodi := nufactura;

        -- Verifica si el cliente es industria no regulada
        BEGIN

            SELECT 1
            INTO nuEsIndustriaNoRegulada
            FROM factura,servsusc, (SELECT column_value
                                    from table (ldc_boutilities.splitStrings(sbParameter,'|')))
            WHERE factcodi = sbFactcodi
            AND sesususc = factsusc
            AND sesucate = column_value
            AND rownum = 1;

        EXCEPTION
           when no_data_found then
              nuEsIndustriaNoRegulada := 0;
        END;

        IF nuEsIndustriaNoRegulada = 1 then
            -- Si es industria no regulada
            BEGIN
                SELECT round(Total/cargunid,2)
                INTO nuVitcvalo
                FROM (
                select decode(cargsign,'CR', cargvalo*-1, 'PA', cargvalo*-1, 'AS', cargvalo*-1,'DB',cargvalo,cargvalo*-1) Total
                       ,cargunid
                from factura f,cuencobr cc, cargos cg, concepto c
                where cg.cargconc = c.conccodi
                  and f.factcodi = cc.cucofact
                  and cc.cucocodi = cg.cargcuco
                  and (substr(nvl(cargdoso,' '),1,3) IN ('CO-','CB-') OR (cargconc in (137,196,37) and (substr(nvl(cargdoso,' '),1,3) not IN ('ID-','DF-'))) )
                  and c.concticl in (1,2)  -- consumo
                  AND cargconc = inuConcept
                  and factcodi  =  sbFactcodi);

             EXCEPTION
                 when no_data_found then
                    nuVitcvalo := 0;
              END;


        else
            -- Si la categoria es residencia, constructora, industria regulada
            BEGIN
                nuVitcons := open.LDCI_PKFACTKIOSCO.fnuConsultComponentCosto(inuConcept,inuCompType,inuFOT,nufactura,nuSuscripc);
            EXCEPTION
                when ex.CONTROLLED_ERROR then
                  return 0;
                when others then
                  return 0;
            END;

            if nuVitcons IS not null then
                SELECT  vitcvalo
                INTO    nuVitcvalo
                FROM    ta_vigetaco
                WHERE   vitccons = nuVitcons;
            END if;
        END if;
        --tiquete 3292
		--fecha  29-04-2014
        --hectorfdv se realiza cambio en el retorno con nvl  para evitar retornar valores nulos
		return nvl(nuVitcvalo,0);

    EXCEPTION
        when no_data_found then
            nuVitcvalo := 0;
            RETURN nuVitcvalo;
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;


END fnuConsultComponentCostoGen;


   /*****************************************************************
    Propiedad intelectual de Gases de occidente

    Function    :  fnuConsultComponentCostoGeneric
    Descripcion :  Consulta componentes de costo

    Parametros  :  Descripcion
        inuConcept         Concepto
        inuCompType        Tipo de Consumo
        inuFOT             Forma de Obtener Tarifa
        nufactura          Numero de factura
        nuSuscripc         Contrato

    Retorno     :
      nuTariffValue      Valor

    Autor    :  Hector Fabio Dominguez
    Fecha    :  06-09-2013


    *****************************************************************/

FUNCTION fnuConsultComponentCosto(inuConcept  IN  concepto.conccodi%type,
                                  inuCompType IN  lectelme.leemtcon%type,
                                  inuFOT      IN  number,
                                  nufactura   IN  factura.factcodi%type, --factura
                                  nuSuscripc  IN  servsusc.SESUSUSC%type) RETURN ta_vigetaco.vitcvalo%type
IS

------------------------------------------------------------------
        -- VARIABLES ENCAPSULADOS
        ------------------------------------------------------------------
        -- Periodo de Consumo Actual
        nuCompPeriodCurr    pericose.pecscons%type;

        -- Periodo de Consumo Anterior
        nuCompPeriodPrev    pericose.pecscons%type;

        -- Fecha de Lectura Inicial
        dtInitialReadDate   lectelme.leemfele%type;

        -- Fecha de Lectura Final
        dtLastReadDate  lectelme.leemfele%type;

        -- Registro del Producto
        rcProduct   servsusc%rowtype;

        -- Registro de Factura
        rcBill  factura%rowtype;

        -- C�digo de Tarifa
        nuTariffConc    ta_tariconc.tacocons%type;

        -- Vigencia de Tarifa
        nuTariffValid   ta_vigetaco.vitccons%type := null;

        -- Valor de la Tarifa
        nuTariffValue   ta_vigetaco.vitcvalo%type;

        -- Porcentaje de la Tarifa
        nuTariffPerc    ta_vigetaco.vitcporc%type;


        -- Identificador del producto
        nuproductid servsusc.SESUNUSE%type;

        osbErrorMsg VARCHAR2(2000);

        /*
         * Cursor para consultar el producto
         */
        CURSOR cuProducto IS
        SELECT *
        FROM servsusc
        WHERE SESUSUSC=nuSuscripc AND SESUSERV=7014;

        /*
         * Cursor para consultar la factura
         */
        CURSOR cuFactura IS
        SELECT *
        FROM FACTURA
        WHERE FACTCODI=nufactura;




BEGIN

      /*
       * Consulamos el producto
       */
      OPEN cuProducto;
      FETCH cuProducto INTO rcProduct;
      CLOSE cuProducto;

      /*
       * Consultamos la factura
       */

      OPEN cuFactura;
      FETCH cuFactura INTO rcBill;
      CLOSE cuFactura;


        ut_trace.trace ('BEGIN FA_BOPrintCostCompRules.fnuGetCostCompValid',1);
        pkErrors.Push('FA_BOPrintCostCompRules.fnuGetCostCompValid');

        -- Obtener Informaci�n desde la Instancia
        ut_trace.trace('rcBill.factpefa: ' || rcBill.factpefa,1);

            -- Obtener el periodo de consumo actual
            pkBCPericose.GetConsPerByBillPer(
                                                rcProduct.sesucico,
                                                rcBill.factpefa,
                                                nuCompPeriodCurr
                                            );

            -- Obtener el periodo de consumo anterior
            pkBOPericose.GetPrevConsPeriod(
                                                nuCompPeriodCurr,
                                                nuCompPeriodPrev
                                          );

            -- Obtener la fecha de lectura inicial
            CI_BCLectelme.GetLastReadingDate(
                                                nuCompPeriodPrev,
                                                rcProduct.sesunuse,
                                                inuCompType,
                                                dtInitialReadDate
                                            );

            -- Obtener la fecha de lectura final
            CI_BCLectelme.GetLastReadingDate(
                                                nuCompPeriodCurr,
                                                rcProduct.sesunuse,
                                                inuCompType,
                                                dtLastReadDate
                                            );

            -- Obtener la Tarifa para el Concepto
            TA_BOTarifas.LiqTarifa(
                                      rcProduct.sesuserv,
                                      inuConcept,
                                      rcProduct.sesunuse,
                                      rcBill.factsusc,
                                      dtInitialReadDate,
                                      dtLastReadDate,
                                      rcProduct.sesufevi,
                                      null,
                                      null,
                                      inuFOT,
                                      false,
                                      nuTariffConc,
                                      nuTariffValid,
                                      nuTariffValue,
                                      nuTariffPerc
                                  );

        ut_trace.trace ('END FA_BOPrintCostCompRules.fnuGetCostCompValid',1);
        ut_trace.trace ('nuTariffValid: ' || nuTariffValid,2);

        -- Retorna el c�digo de la vigencia de tarifa
        RETURN nuTariffValue;
EXCEPTION
WHEN OTHERS THEN
         pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, osbErrorMsg );
        DBMS_OUTPUT.PUT_LINE(' Error generando la informacion a imprimir en la factura: '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE||' error '||SQLERRM  );
        RETURN 0;
END fnuConsultComponentCosto;

    /*****************************************************************
    Propiedad intelectual de Gases de occidente

    Function  :  fnuObtenerInteresMora
    Descripcion :  Obtiene la vigencia de tarifa para el componente
                   de costo.

    Parametros  :  Descripcion
        inuConcept         Concepto
        inuCompType        Tipo de Consumo
        inuFOT             Forma de Obtener Tarifa

    Retorno     :
      nuTariffValid      Vigencia de Tarifa

    Autor    :  Hector Fabio Dominguez
    Fecha    :  06-09-2013


    *****************************************************************/
   FUNCTION fnuObtenerInteresMora
    (
        inuCupon             in CUPON.CUPONUME%type,
        inuFactura         in NUMBER,
        onuErrorCode      out number,
        osbErrorMsg        OUT VARCHAR2
    )
    RETURN ta_vigetaco.vitcporc%type
    IS


        -- Porcentaje de la Tarifa
        nuTariffPerc    ta_vigetaco.vitcporc%type;

        -- Parametro: identificador del concepto de interes de mora
        nuParConcInt    number;

        -- Identificador de la factura
        nuFactcodi      factura.factcodi%type;

        CURSOR cuTarifa(inuConcepto concepto.conccodi%type, inuFactura factura.factcodi%type) IS
        SELECT vitcporc
        FROM factura, perifact, ta_conftaco, ta_tariconc, ta_vigetaco
        WHERE factpefa = pefacodi
        AND tacocotc = cotccons
        AND vitctaco = tacocons
        AND pefaffmo between cotcfein AND cotcfefi
        AND pefaffmo between vitcfein AND vitcfefi
        AND cotcconc = inuConcepto
        AND factcodi = inuFactura
        AND rownum = 1;

    BEGIN
    --{
        ut_trace.trace ('BEGIN LDC_BOFORMATOFACTURA.fnuGetTasaInteresMora',1);
        pkErrors.Push('BEGIN LDC_BOFORMATOFACTURA.fnuGetTasaInteresMora');

        -- Obtiene el identificador de la factura de la instancia
        nuFactcodi := inuFactura;

        nuParConcInt := to_number(DALD_PARAMETER.fsbGetValue_Chain('LDC_ID_CONCEPTOS_INTERES_MORA',NULL));

        OPEN cuTarifa(nuParConcInt, nuFactcodi);
        fetch cuTarifa INTO nuTariffPerc;
        close cuTarifa;

        pkErrors.Pop;
        ut_trace.trace ('END LDC_BOFORMATOFACTURA.fnuGetTasaInteresMora',1);
        ut_trace.trace ('nuTariffPerc: ' || nuTariffPerc,2);

        -- Retorna el c�digo de la vigencia de tarifa
        RETURN ( (nvl(nuTariffPerc,0)));

    EXCEPTION
        WHEN OTHERS THEN
          pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, osbErrorMsg );
          --DBMS_OUTPUT.PUT_LINE(' Error generando la informacion a imprimir en la factura: '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE||' error '||SQLERRM  );
          onuErrorCode:=-666;
          osbErrorMsg:=' Error generando la informacion a imprimir en la factura: '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE||' error '||SQLERRM;
           RETURN null;
    --}
    END fnuObtenerInteresMora;

 /************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

        FUNCTION : prcCierraCursores
         AUTOR   : Hector Fabio Dominguez
         FECHA   : 10/09/2013
         RICEF   : I045
     DESCRIPCION : Esta funcion se encarga de cerrar los cursores

 Historia de Modificaciones

 Autor                Fecha             Descripcion.
 HECTORFDV    10/09/2013  Creacion del paquete
************************************************************************/

PROCEDURE prcCierraCursores (CUDATOSBASIC              IN     OUT    SYS_REFCURSOR,
                                                           CUFACTDETA                  IN     OUT    SYS_REFCURSOR,
                                                           CURANGOS                     IN     OUT    SYS_REFCURSOR,
                                                           CUHISTORICO                IN     OUT    SYS_REFCURSOR,
                                                           CULECTURAS                   IN    OUT    SYS_REFCURSOR,
                                                           CUCONSUMOS               IN    OUT    SYS_REFCURSOR,
                                                           CUCOMPONENTES               IN    OUT    SYS_REFCURSOR)
AS

BEGIN
    IF NOT CUDATOSBASIC%ISOPEN THEN
        OPEN CUDATOSBASIC FOR SELECT * FROM dual where 1=2;
    END IF;
    IF NOT CUFACTDETA%ISOPEN THEN
        OPEN CUFACTDETA FOR SELECT * FROM dual where 1=2;
    END IF;
    IF NOT CURANGOS%ISOPEN THEN
        OPEN CURANGOS FOR SELECT * FROM dual where 1=2;
    END IF;
    IF NOT CUHISTORICO%ISOPEN THEN
        OPEN CUHISTORICO FOR SELECT * FROM dual where 1=2;
    END IF;

    IF NOT CULECTURAS%ISOPEN THEN
        OPEN CULECTURAS FOR SELECT * FROM dual where 1=2;
    END IF;

    IF NOT CUCONSUMOS%ISOPEN THEN
        OPEN CUCONSUMOS FOR SELECT * FROM dual where 1=2;
    END IF;

    IF NOT CUCOMPONENTES%ISOPEN THEN
        OPEN CUCOMPONENTES FOR SELECT * FROM dual where 1=2;
    END IF;

END;

 /************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

        FUNCTION : fsbOrdenSuspContrato
         AUTOR   : Hector Fabio Dominguez
         FECHA   : 16/05/2013
         RICEF   : I045
     DESCRIPCION : Funcion encargada de indicar si el usuario tiene una
                   orden de suspencion en proceso

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    16/05/2013  Creacion del paquete
************************************************************************/
FUNCTION fsbOrdenSuspContrato (nuSusccodi in suscripc.susccodi%type)
  RETURN VARCHAR2
      IS
         Nuexiste Number;
         nuResExiste VARCHAR2(2000);
      BEGIN
      Nuresexiste := 'N';
      nuExiste:=-1;
         BEGIN
             Select  Order_Id     INTO   nuExiste
             From OR_ORDER_ACTIVITY  oa
              Where TASK_TYPE_ID In(10058,10061,10064,10122,10169,12521,12523,12524,12526,12528) And
              SUBSCRIPTION_ID = nuSusccodi and (select ORDER_STATUS_ID from or_order where Order_Id=oa.Order_Id )<>8 AND ROWNUM<=1;
         EXCEPTION
         WHEN ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
         END;

         IF (nuExiste <> -1) then
           --DBMS_OUTPUT.PUT_LINE('El contrato Si existe');
           nuResExiste := nuExiste;
         ELSE
           --DBMS_OUTPUT.PUT_LINE('El contrato No existe');
           nuResExiste := 'N';
         END IF;

      RETURN nuResExiste;

      EXCEPTION
      WHEN ex.CONTROLLED_ERROR then
      RETURN nuResExiste;
         raise ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         RETURN nuResExiste;
         Errors.setError;
         Raise Ex.Controlled_Error;
   END fsbOrdenSuspContrato;


   /************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

        FUNCTION : fsbProcFactura
         AUTOR   : Hector Fabio Dominguez
         FECHA   : 16/05/2013
         RICEF   :
     DESCRIPCION : Funcion encargada de validar si un contrato se encuentra en
                   proceso de facturacion

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    16/05/2013  Creacion del paquete
************************************************************************/
FUNCTION fsbProcFactura (nuSusccodi in suscripc.susccodi%type)
  RETURN VARCHAR2
     IS
         nuExiste number;
         nuResExiste varchar(2);
      BEGIN
      nuResExiste := '-1';
         BEGIN
         Select count(1) into nuExiste
          From Procejec
          Where
          Prejprog = 'FGCA' AND
          Prejespr <> 'E'   And
          PREJCOPE =(SELECT PEFACODI FROM PERIFACT WHERE pefaactu ='S' AND PEFACICL=(SELECT SUSCCICL FROM SUSCRIPC WHERE SUSCCODI=nuSusccodi) AND ROWNUM=1);
         EXCEPTION
         WHEN ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
         END;

         IF (nuExiste = 1) then
           --DBMS_OUTPUT.PUT_LINE('El contrato Si existe');
           nuResExiste := 'S';
         ELSE
           --DBMS_OUTPUT.PUT_LINE('El contrato No existe');
           nuResExiste := 'N';
         END IF;

      RETURN nuResExiste;

      EXCEPTION
      WHEN ex.CONTROLLED_ERROR then
      RETURN nuResExiste;
         raise ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         RETURN nuResExiste;
         Errors.setError;
         raise ex.CONTROLLED_ERROR;
   END fsbProcFactura;
/************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

        FUNCTION : fsbProcFactura
         AUTOR   : Hector Fabio Dominguez
         FECHA   : 16/05/2013
         RICEF   :
     DESCRIPCION : Funcion de utilidad para obtener el numero de filas
           que contiene un cursor

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    16/05/2013  Creacion del paquete
************************************************************************/
FUNCTION countSyfRefCursor( icRef  IN  sys_refcursor) RETURN NUMBER
IS


          cSql    number;
          cnt     integer;
          cRef sys_refcursor;
  begin
        cRef:=icRef;
          -- convert it to a DBMS_SQL cursor
          cSql := DBMS_SQL.to_cursor_number( cRef );

           -- now loop through it
           cnt := 0;
           loop
                   exit when DBMS_SQL.fetch_rows( cSql ) = 0;
                   cnt := cnt + 1;
           end loop;

           DBMS_SQL.close_cursor( cSql );

           --dbms_output.put_line( cnt||' row(s)' );
           RETURN cnt;
END countSyfRefCursor;

 /************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

        FUNCTION : FNUCONSULTASADOANT
         AUTOR   : Hector Fabio Dominguez
         FECHA   : 16/05/2013
         RICEF   : I045
     DESCRIPCION : Proceso encargado de retornar la informacion del saldo anterior

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    16/05/2013  Creacion del paquete
************************************************************************/

FUNCTION FNUCONSULTASADOANT(nuSusccodi         IN  suscripc.susccodi%type)
RETURN NUMBER
IS

  nuIdentificacion   NUMBER;
  nuTelefono         NUMBER;
  onuSaldoPend       NUMBER;
  onuSaldoAnterior   NUMBER;
  onuPeriodoCant     NUMBER;
  sbMunicipio        VARCHAR2(500);
  sbDireccion        VARCHAR2(500);
  sbCategoria        VARCHAR2(500);
  onuErrorCode       NUMBER;
  osbErrorMessage    VARCHAR2(1000);
  ONUDEFERREDBALANCE NUMBER;

BEGIN
  /*
   * Se llama al api que retorna el saldo anterior
   *
   */
   OS_GETSUBSCRIPBALANCE(   nuSusccodi,
                            NULL,
                            onuSaldoPend,
                            ONUDEFERREDBALANCE,
                            onuSaldoAnterior,
                            onuPeriodoCant,
                            onuErrorCode,
                            osbErrorMessage);

/*
 * TQ 3278
 * FECHA: 31-03-2014
 * Ajuste para cuando el retorno de la api
 * sea nulo
 */
  IF onuSaldoAnterior IS NULL THEN
  onuSaldoAnterior:=0;
  END IF;

  return onuSaldoAnterior;

EXCEPTION
      WHEN ex.CONTROLLED_ERROR then
         ROLLBACK;
         Errors.geterror (onuErrorCode, osbErrorMessage);
      WHEN OTHERS THEN
        osbErrorMessage := 'Error consultando saldo anterior: '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
        pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
        Errors.seterror;
        Errors.geterror (onuErrorCode, osbErrorMessage);

END FNUCONSULTASADOANT;

 /************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

        FUNCTION : FNUCONSULTASADOACT
         AUTOR   : Hector Fabio Dominguez
         FECHA   : 16/05/2013
         RICEF   : I045
     DESCRIPCION : Proceso encargado de retornar la informacion del saldo actual

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    16/05/2013  Creacion del paquete
************************************************************************/



FUNCTION FNUCONSULTASADOACT(nuSusccodi         IN  suscripc.susccodi%type)
RETURN NUMBER
IS

nuIdentificacion   NUMBER;
nuTelefono         NUMBER;
onuSaldoPend       NUMBER;
onuSaldoAnterior   NUMBER;
onuPeriodoCant     NUMBER;
sbMunicipio        VARCHAR2(500);
sbDireccion        VARCHAR2(500);
sbCategoria        VARCHAR2(500);
onuErrorCode       NUMBER;
osbErrorMessage    VARCHAR2(1000);
ONUDEFERREDBALANCE NUMBER;
BEGIN
  /*
   * Se consulta el api que retorna el
   * saldo actual
   *
   */
   OS_GETSUBSCRIPBALANCE(   nuSusccodi,
                            NULL,
                            onuSaldoPend,
                            ONUDEFERREDBALANCE,
                            onuSaldoAnterior,
                            onuPeriodoCant,
                            onuErrorCode,
                            osbErrorMessage);


/*
 * TQ 3278
 * FECHA: 31-03-2014
 * Ajuste para cuando el retorno de la api
 * sea nulo
 */

 IF onuSaldoPend IS NULL THEN
  onuSaldoPend:=0;
  END IF;

  return onuSaldoPend;

  EXCEPTION
        WHEN ex.CONTROLLED_ERROR then
           ROLLBACK;
           Errors.geterror (onuErrorCode, osbErrorMessage);
        WHEN OTHERS THEN
          osbErrorMessage := 'Error consultando saldo actual: '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
          pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
          Errors.seterror;
          Errors.geterror (onuErrorCode, osbErrorMessage);
END FNUCONSULTASADOACT;






 /************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

       PROCEDURE : PROCONSULTASUSCRIPC
         AUTOR   : Hector Fabio Dominguez
         FECHA   : 16/05/2013
         RICEF   : I042
     DESCRIPCION : Proceso encargado de consultar la informacion que se
                   encuentran disponible para obtener duplicado

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    16/05/2013  Creacion del paquete
************************************************************************/


PROCEDURE PROCONSULTASUSCRIPC (inuSusccodi         IN  suscripc.susccodi%type,
                               isbIdentificacion   IN  VARCHAR2,
                               isbTelefono         IN  VARCHAR2,
                               nuServicio          IN  NUMBER,
                               CUSUSCRIPCIONES     OUT  SYS_REFCURSOR,
                               onuErrorCode        OUT  NUMBER,
                               osbErrorMessage     OUT  VARCHAR2)
AS

  ONUDEFERREDBALANCE NUMBER;
  nuCantReg NUMBER;
  CUSUSCRIPCIONESAUX SYS_REFCURSOR;
  BEGIN


--consultando los datos basicos (headers) de la factura

IF inuSusccodi <>-1 THEN

  OPEN CUSUSCRIPCIONES FOR
            Select Addr.Geograp_Location_Id AS nuLocalidad,
                    (
                         Select Description
                         From Ge_Geogra_Location
                         Where Geograp_Location_Id =    (Select Geo_Loca_Father_Id
                                                               From  Ge_Geogra_Location
                                                               Where Geograp_Location_Id= Addr.Geograp_Location_Id )
                     ) As  sbDepartamento,
                     (  Select Description
                         From Ge_Geogra_Location
                         Where Geograp_Location_Id =Addr.Geograp_Location_Id)As sbNombreLocalidad,
                     --Dage_Geogra_Location.Fsbgetdisplay_Description(Addr.Geograp_Location_Id) As sbNombreLocalidad,
                     (
                         Select Description
                         From Ge_Geogra_Location
                         Where Geograp_Location_Id =Addr.NEIGHBORTHOOD_ID

                     ) As  SbBarrio,
                    /*Serv.SESUSERV,*/Sus.Susccodi as nuSuscripc,
                           Ldci_Pkfactkiosco.FNUCONSULTAVALORANTFACT(Sus.Susccodi) As nuSaldAnterior,
                           Ldci_Pkfactkiosco.Fnuconsultasadoact(Sus.Susccodi) As nuSaldActual,
                           Gesus.Subscriber_Name As sbNombreSuscripc,
                           Gesus.Subs_Last_Name As sbApellidoSuscripc,
                           Gesus.Identification As sbIdentificacion,
                           (SELECT address from ab_address where address_id=Sus.Susciddi) As sbDireccion,
                           --Ldci_Pkbssreca.Fsbgenaddress(Sus.Susciddi) As sbDireccion,
                           'GAS '||Cate.Catedesc As sbCategoria ,
                           Serv.Sesunuse As nuServicio,
                           gesus.PHONE as sbTelefono


                    From Suscripc Sus, Ab_Address Addr, Categori Cate,Servsusc Serv,GE_SUBSCRIBER gesus
                    Where Sus.Susccodi=inuSusccodi            And
                          Addr.Address_Id=Sus.Susciddi       And
                          Cate.Catecodi=Serv.Sesucate        And
                          Serv.Sesususc=Sus.Susccodi         And
                          Gesus.Subscriber_Id = Sus.SUSCCLIE And
                          Serv.Sesuserv = nuServicio;

ELSIF isbIdentificacion IS NOT NULL THEN
  OPEN CUSUSCRIPCIONES FOR
     Select Addr.Geograp_Location_Id AS nuLocalidad,
                    (
                         Select Description
                         From Ge_Geogra_Location
                         Where Geograp_Location_Id =    (Select Geo_Loca_Father_Id
                                                               From  Ge_Geogra_Location
                                                               Where Geograp_Location_Id= Addr.Geograp_Location_Id )
                     ) As  sbDepartamento,
                     (  Select Description
                         From Ge_Geogra_Location
                         Where Geograp_Location_Id =Addr.Geograp_Location_Id)As sbNombreLocalidad,
                     --Dage_Geogra_Location.Fsbgetdisplay_Description(Addr.Geograp_Location_Id) As sbNombreLocalidad,
                     (
                         Select Description
                         From Ge_Geogra_Location
                         Where Geograp_Location_Id =Addr.NEIGHBORTHOOD_ID

                     ) As  SbBarrio,
                    /*Serv.SESUSERV,*/Sus.Susccodi as nuSuscripc,
                           Ldci_Pkfactkiosco.FNUCONSULTAVALORANTFACT(Sus.Susccodi) As nuSaldAnterior,
                           Ldci_Pkfactkiosco.Fnuconsultasadoact(Sus.Susccodi) As nuSaldActual,
                           Gesus.Subscriber_Name As sbNombreSuscripc,
                           Gesus.Subs_Last_Name As sbApellidoSuscripc,
                           Gesus.Identification As sbIdentificacion,
                           (SELECT address from ab_address where address_id=Sus.Susciddi) As sbDireccion,
                           --Ldci_Pkbssreca.Fsbgenaddress(Sus.Susciddi) As sbDireccion,
                           'GAS '||Cate.Catedesc As sbCategoria ,
                           Serv.Sesunuse As nuServicio,
                           gesus.PHONE as sbTelefono


                    From Suscripc Sus, Ab_Address Addr, Categori Cate,Servsusc Serv,Ge_Subscriber Gesus
                    Where Sus.SUSCCLIE in (select SUBSCRIBER_ID from GE_SUBSCRIBER  where IDENTIFICATION =isbIdentificacion )                    And
                          Addr.Address_Id=Sus.Susciddi       And
                          Cate.Catecodi=Serv.Sesucate        And
                          Serv.Sesususc=Sus.Susccodi         And
                          Gesus.Subscriber_Id = Sus.SUSCCLIE And
                          Serv.Sesuserv = nuServicio;

ELSIF isbTelefono IS NOT NULL THEN
  OPEN CUSUSCRIPCIONES FOR

  Select Addr.Geograp_Location_Id AS nuLocalidad,
                    (
                         Select Description
                         From Ge_Geogra_Location
                         Where Geograp_Location_Id =    (Select Geo_Loca_Father_Id
                                                               From  Ge_Geogra_Location
                                                               Where Geograp_Location_Id= Addr.Geograp_Location_Id )
                     ) As  sbDepartamento,
                     (  Select Description
                         From Ge_Geogra_Location
                         Where Geograp_Location_Id =Addr.Geograp_Location_Id)As sbNombreLocalidad,
                     --Dage_Geogra_Location.Fsbgetdisplay_Description(Addr.Geograp_Location_Id) As sbNombreLocalidad,
                     (
                         Select Description
                         From Ge_Geogra_Location
                         Where Geograp_Location_Id =Addr.NEIGHBORTHOOD_ID

                     ) As  SbBarrio,
                    /*Serv.SESUSERV,*/Sus.Susccodi as nuSuscripc,
                           Ldci_Pkfactkiosco.FNUCONSULTAVALORANTFACT(Sus.Susccodi) As nuSaldAnterior,
                           Ldci_Pkfactkiosco.Fnuconsultasadoact(Sus.Susccodi) As nuSaldActual,
                           Gesus.Subscriber_Name As sbNombreSuscripc,
                           Gesus.Subs_Last_Name As sbApellidoSuscripc,
                           Gesus.Identification As sbIdentificacion,
                           (SELECT address from ab_address where address_id=Sus.Susciddi) As sbDireccion,
                           --Ldci_Pkbssreca.Fsbgenaddress(Sus.Susciddi) As sbDireccion,
                           'GAS '||Cate.Catedesc As sbCategoria ,
                           Serv.Sesunuse As nuServicio,
                           gesus.PHONE as sbTelefono

                    From Suscripc Sus, Ab_Address Addr, Categori Cate,Servsusc Serv,Ge_Subscriber Gesus
                    Where Sus.SUSCCLIE in (select SUBSCRIBER_ID from GE_SUBSCRIBER  where PHONE =isbTelefono )                    And
                          Addr.Address_Id=Sus.Susciddi       And
                          Cate.Catecodi=Serv.Sesucate        And
                          Serv.Sesususc=Sus.Susccodi         And
                          Gesus.Subscriber_Id = Sus.SUSCCLIE And
                          Serv.Sesuserv = nuServicio;
END IF;

    IF NOT CUSUSCRIPCIONES%ISOPEN THEN

        OPEN CUSUSCRIPCIONES FOR SELECT * FROM dual where 1=2;


    END IF;


onuErrorCode:=0;
osbErrorMessage:='Consulta exitosa ';

COMMIT;

EXCEPTION


      WHEN ex.CONTROLLED_ERROR then
         ROLLBACK;
         Errors.geterror (onuErrorCode, osbErrorMessage);
      WHEN OTHERS THEN
        ROLLBACK;
        osbErrorMessage := 'Error consultando las facturas: '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
        pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
        Errors.seterror;
        Errors.geterror (onuErrorCode, osbErrorMessage);

END PROCONSULTASUSCRIPC;

 /************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

       PROCEDURE : PROGENERAFACT
         AUTOR   : Hector Fabio Dominguez
         FECHA   : 16/05/2013
         RICEF   : I045
     DESCRIPCION : Proceso encargado de consultar la informacion que se
                   que se va a colocar en el pdf de la factura

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    16/05/2013  Creacion del paquete
 HECTORFDV   24/01/2013   Se modifica el proceso de obtenci�n de cargos
                          para que incluya los intereses de financiaci�n
                          cuando solo se liquiden solo intereses.
 HECTORFDV    10/02/2014  Ajuste en fechas limites de pago y calculo de saldo anterior
 HECTORFDV    14/02/2014  Ajuste consumos e historicos 2794
 HECTORFDV    30/02/2014  formateo del total a pagar, dias de consumo
************************************************************************/


PROCEDURE PROGENERAFACT (inuSusccodi           IN      suscripc.susccodi%type,
                          inuSaldoGen          IN     NUMBER, -- NUMBER(13,2)   nuevo
                          isbTipoSaldo          IN     VARCHAR2,-- nuevo,
                          CUDATOSBASIC        OUT   SYS_REFCURSOR,
                          CUFACTDETA             OUT  SYS_REFCURSOR,
                          CURANGOS               OUT  SYS_REFCURSOR,
                          CUHISTORICO           OUT  SYS_REFCURSOR,
                          CULECTURAS             OUT  SYS_REFCURSOR,
                          CUCONSUMOS          OUT  SYS_REFCURSOR,
                          CUCOMPONENTES   OUT  SYS_REFCURSOR,
                          osbSeguroLiberty    OUT VARCHAR2,--Campo Nuevo,
                          osbOrdenSusp         OUT VARCHAR2,-- Campo Nuevo
                          osbProcFact              OUT VARCHAR2,-- Campo Nuevo
                          onuErrorCode           OUT  NUMBER,
                          osbErrorMessage    OUT  VARCHAR2)
AS
    ONUDEFERREDBALANCE NUMBER;
    nuFactura NUMBER;
    ISBXMLREFERENCE CLOB; -- para envio de parametros en la generacion de cupon
    INUREFTYPE NUMBER;
    ONUCUPONUME     NUMBER;
     --nuFactura NUMBER;
    ONUTOTALVALUE   NUMBER;
   nuInteresMora ta_vigetaco.vitcporc%type;

   /*
   * Descripcion: Declaracion de variable de
                  control para la fecha limite de pago
   * Tiquete:  2733
   * fecha:    10-02-2014
   * autor:    hectorfdv
   */
   sbInmediata VARCHAR2(500);


    ERROR_GENERA EXCEPTION;
    ERROR_MORA EXCEPTION;

    BEGIN
    onuErrorCode:=0;
    osbSeguroLiberty:='N';
    osbOrdenSusp:='N';
    onuErrorCode:=0;
   /*
   * Descripcion: Inicialziamos la variable de
                  control para la fecha limite de pago
   * Tiquete:  2733
   * fecha:    10-02-2014
   * autor:    hectorfdv
   */
    sbInmediata:='';
    Inureftype      := 2;

                /*
                  *  Se coloca el manejo de excepciones
                  *  ya que el api no esta controlando
                  * en su interior las excepciones
                  */

                BEGIN

                  ISBXMLREFERENCE := '<?xml version="1.0" encoding="utf-8" ?><Suscripcion><Id_Suscripcion>'||inuSusccodi||'</Id_Suscripcion><Valor_a_Pagar>'||inuSaldoGen||'</Valor_a_Pagar></Suscripcion >';
                  OS_COUPONGENERATION( INUREFTYPE => INUREFTYPE, ISBXMLREFERENCE => ISBXMLREFERENCE, ONUCUPONUME => ONUCUPONUME, ONUTOTALVALUE => ONUTOTALVALUE, ONUERRORCODE => ONUERRORCODE, OSBERRORMESSAGE => OSBERRORMESSAGE );

                EXCEPTION
                    WHEN OTHERS THEN
                        RAISE  ERROR_GENERA;
                END;

               IF onuErrorCode <> 0 THEN
                  RAISE  ERROR_GENERA;
               END IF;

            /*
             * Select que se encarga de
             * retornar la factura
             */

            SELECT max(factcodi) into nuFactura
            FROM factura
            WHERE factsusc=inuSusccodi AND FACTPROG=6;
             /*
            SELECT MAX(FACTCODI) into nuFactura
            FROM FACTURA
            WHERE FACTCODI = (SELECT CUPODOCU FROM CUPON WHERE CUPONUME=ONUCUPONUME);
            */

              /*
                * Consulta la tasa de interes
                * por mora
                *
                */

              nuInteresMora := fnuObtenerInteresMora(ONUCUPONUME,nuFactura,onuErrorCode,osbErrorMessage);

                IF onuErrorCode <> 0 THEN
                 osbErrorMessage:=' La tasa de interes de mora no se logro consultar';
                 onuErrorCode:=0;

                 -- Se coloca en comentario por la misma razon de que es un campo informativo
                  /*
                   * RAISE  ERROR_MORA;
                   */
               END IF;

/*
 * Descripcion: valida si debemos colocar inmediato en
 * la fecha limite de pago
 * Tiquete:  2733
 * fecha:    10-02-2014
 * autor:    hectorfdv
 */

 /*
 * Descripcion: Se calcula la suma de las cuentas vencidas, si es superior a cero
 *              Entonces es pago inmediato
 * Tiquete:  2756
 * fecha:    10-02-2014
 * autor:    hectorfdv
 */

IF open.LDCI_PKFACTKIOSCO.FNUCONSULTASADOANT(inuSusccodi)> 0 THEN
  sbInmediata:='INMEDIATO';
ELSE
  sbInmediata:='-1';
END IF;

    --consultando los datos basicos (headers) de la factura

      OPEN CUDATOSBASIC FOR




SELECT  fc.factcodi account_number, --2
            a.subscriber_name||' '||a.subs_last_name client_name, --3
            ca.address_parsed client_address, --4
            s.sesusuca subcategory,  --5
            s.sesucate codcategory, --6
            open.pktblcategori.fsbgetdescription(s.sesucate) category, --6
            b.susccicl billing_cycle,--7
            to_char(to_date(pf.pefames,'mm'), 'MONTH','NLS_DATE_LANGUAGE = SPANISH') billing_month, --8
            b.susccodi suscripcion,--9
            'R: '||ab.route_id||'   C: '||(select consecutive from ab_premise where ca.estate_number = premise_id) route, --10
            to_char(pc.pecsfeci, 'dd mm yyyy') date_initial_per,--11
            to_char(pc.pecsfecf, 'dd mm yyyy') date_end_per,--12
            case when (open.LDC_BOFORMATOFACTURA.fsbPagoInmediato(s.sesunuse)=1) then 'INMEDIATO'
            when (sbInmediata='INMEDIATO') then 'INMEDIATO'
            else to_char(cc.cucofeve, 'dd/MON/yyyy','NLS_DATE_LANGUAGE = SPANISH') end date_limited_per,--13
            to_char((select round(cupovalo) FROM cupon WHERE cuponume = ONUCUPONUME),'FM999999999990') Total_pay, --14
            to_char(nuInteresMora/*open.LDC_BOFORMATOFACTURA.fnuGetTasaInteresMora()*/,'FM999999990.0000') interest_mora, -- 15
            replace(open.LDC_BOFORMATOFACTURA.fsbPorcSuboContri(fc.factcodi),'%') Percen_sc, -- 16
            open.LDC_BOFORMATOFACTURA.fnuGetIndiceCalidad(s.sesunuse, pf.pefafimo, pf.pefaffmo) time_desc, --17
            decode(ca.geograp_location_id, null, null, open.dage_geogra_location.fnugetgeo_loca_father_id(ca.geograp_location_id)) state, --18
            ca.geograp_location_id city,--19
            Dage_Geogra_Location.Fsbgetdisplay_Description(ca.geograp_location_id) cityDesc,
            to_char((select  round(sum(case when conctico=1 then decode(CARGSIGN,'CR',CARGVALO*-1,'PA',CARGVALO*-1,'AS',
                CARGVALO*-1,'DB',CARGVALO,CARGVALO*-1) else 0 end))
            from open.cuencobr, open.cargos,open.concepto
            where cargconc=conccodi
            and cargcuco=cucocodi
            AND cucofact = fc.factcodi),'FM999999990') t_servicios_publicos, --20
            0 t_bienes,                                     --21
            to_char((select  round(sum(case when conctico=3 then decode(CARGSIGN,'CR',CARGVALO*-1,'PA',CARGVALO*-1,'AS',
                CARGVALO*-1,'DB',CARGVALO,CARGVALO*-1) else 0 end))
            from open.cuencobr,open.cargos,open.concepto
            where cargconc=conccodi
            and cargcuco=cucocodi
            AND cucofact = fc.factcodi),'FM999999999990') t_servicios, --22
            decode(ca.neighborthood_id, null, null, open.dage_geogra_location.fsbgetdescription(ca.neighborthood_id)) neighborthood, --23
            to_char(round(open.LDCI_PKFACTKIOSCO.FNUCONSULTAVALORANTFACT(fc.factsusc)),'FM999999999990') Saldo_Anterior, --24
            (select em.emsscoem from open.elmesesu em where em.emsssesu=s.sesunuse and emssfein = (select max(emssfein)
            from open.elmesesu em where em.emsssesu=s.sesunuse)) meter, --25
            (case when (a.ident_type_id =110 OR a.ident_type_id=1) then identification end) Client_Nit, -- 26
            b.suscclie suscriptor,
            (round(pc.pecsfecf) - trunc(pc.pecsfeci)) days_cons,
            to_char(cc_boBssSubscriptionData.fnuClaimbalance(b.susccodi),'FM999,999,990') favor_balance,
            to_char(cc_boBssSubscriptionData.fnufavorbalance(b.susccodi),'FM999,999,990') claim_balance,
            open.ldci_pkfactkiosco.fsbGetDesviacion(nuFactura) desviacion
     FROM open.factura fc, open.cuencobr cc,
        open.suscripc b, open.servsusc s, open.ge_subscriber a,open.perifact pf,
        open.pericose pc, open.ab_address ca, open.ab_segments ab
      where fc.factcodi= nuFactura
      AND fc.factsusc= inuSusccodi
      AND s.sesuserv = 7014
      AND fc.factcodi  = cc.cucofact
      AND fc.factsusc=b.susccodi
      AND b.susccodi = s.sesususc
      AND a.subscriber_id = b.suscclie
      AND pf.pefacodi = fc.factpefa
      ANd pc.pecscons = open.LDC_BOFORMATOFACTURA.fnuObtPerConsumo(pf.pefacicl, pf.pefacodi)
      AND b.susciddi = ca.address_id --(+)
      AND pf.pefacodi = fc.factpefa
      AND ca.segment_id = ab.segments_id
      and rownum=1;

    --Consultando cargos de la factura


  OPEN CUFACTDETA FOR
        select concepto_desc, to_char(Saldo_Anterior, 'FM999999990.00') Saldo_Anterior,to_char(Abono_Capital, 'FM999999990.00') Abono_Capital,to_char(Intereses, 'FM999999990.00') Intereses
        , NVL(to_char(Abono_Capital+Intereses+Total, 'FM999999999990.00'),0) Total,
        to_char(Saldo_posterior_pago, 'FM999999990.00') Saldo_posterior_pago,Cuotas_pendientes,to_char(interes_financiacion,'990.0000') interes_financiacion, tipo_concepto
        from (
                      SELECT   concepto_desc,
                               tipo_concepto,
                               cod_financia,
                               Saldo_Anterior,
                               Abono_Capital,
                               Intereses,
                               Iva,
                               Total,
                               Saldo_posterior_pago,
                               Cuotas_pendientes,
                               interes_financiacion
                         FROM (
                        select c.concorim   orden,
                               c.concdefa   concepto_desc,
                               c.conctico   tipo_concepto,
                               0            cod_financia,
                               0            Saldo_Anterior,
                               0            Abono_Capital,
                               0            Intereses,
                               (case when cargconc=137 then cargvalo else 0 end) Iva,
                               decode(cargsign,'CR', cargvalo*-1, 'PA', cargvalo*-1, 'AS', cargvalo*-1,'DB',cargvalo,cargvalo*-1) Total,
                               0            Saldo_posterior_pago,
                               0            Cuotas_pendientes,
                               0            interes_financiacion
                        from factura f,cuencobr cc, cargos cg, concepto c
                        where cg.cargconc = c.conccodi
                          and f.factcodi = cc.cucofact
                          and cc.cucocodi = cg.cargcuco
                          and (substr(nvl(cargdoso,' '),1,3) IN ('CO-','CB-') OR (cargconc in (137,196,37) and (substr(nvl(cargdoso,' '),1,3) not IN ('ID-','DF-'))) )
                          and c.concticl in (1,2)  -- consumo
                          and factcodi  =  nuFactura)

                        WHERE Total <> 0

                        union all

                        select  concepto_desc,tipo_concepto, 0 cod_financia,
                        sum(Saldo_Anterior) Saldo_Anterior , 0 Abono_Capital,
                        sum(Intereses) Intereses, sum(Iva) Iva, sum( Total),
                        sum(Saldo_posterior_pago) Saldo_posterior_pago, sum(Cuotas_pendientes) Cuotas_pendientes,
                        sum(interes_financiacion) interes_financiacion
                        from(
                            select  concorim    orden,
                                    concdefa    concepto_desc,
                                    conctico    tipo_concepto,
                                    nvl((   select difesape
                                            from diferido
                                            where difecodi = Nrodiferido
                                         )+cargvalo,0) Saldo_Anterior,
                                    cargvalo    Abono_Capital,
                                    Intereses   Intereses,
                                    (case when cargconc=137 then cargvalo else 0 end) Iva,
                                    cargvalo Total,
                                    nvl((select difesape
                                        from diferido
                                        where difecodi = Nrodiferido),0) Saldo_posterior_pago,
                                    nvl((select (difenucu-difecupa)
                                    from diferido where difecodi = Nrodiferido),0) Cuotas_pendientes,
                                    nvl((select difeinte
                                    from diferido where difecodi = Nrodiferido),0) interes_financiacion
                            FROM ( select   c.concorim, c.conccodi, c.concdefa, c.conctico, cg.cargsign, cg.cargdoso, cg.cargconc,
                                            decode(substr(nvl(cg.cargdoso,' '),1,3),'DF-',substr(nvl(cg.cargdoso,' '),4)) Nrodiferido,
                                            decode(cargsign,'CR', cargvalo*-1, 'PA', cargvalo*-1, 'AS', cargvalo*-1,'DB',cargvalo,cargvalo*-1) cargvalo,
                                            (   select
                                                        nvl (sum(cargvalo), 0)
                                                from factura qf,cuencobr qcc, cargos qcg, concepto co
                                                where qf.factcodi = qcc.cucofact
                                                and qcc.cucocodi = qcg.cargcuco
                                                and co.conccodi = qcg.cargconc
                                                and qcg.cargdoso = 'ID-'||decode(substr(nvl(cg.cargdoso,' '),1,3),'DF-',substr(nvl(cg.cargdoso,' '),4))
                                                and qf.factcodi = f.factcodi
                                              ) Intereses
                                           ,0 Por_IVA
                                    from factura f,cuencobr cc, cargos cg, concepto c
                                    where cg.cargconc = c.conccodi
                                      and f.factcodi = cc.cucofact
                                      and cc.cucocodi = cg.cargcuco
                                      and (c.concticl <> 4 or cg.cargcaca not in (15,53))
                                      AND cargconc not in (137,196,37)
                                      and (substr(nvl(cargdoso,' '),1,3) NOT IN ('CO-','DF-','ID-','CB-') )
                                      AND cargsign <> 'SA'
                                      and f.factcodi   = nuFactura

                                    )
                         )
                     group by concepto_desc,tipo_concepto
                     HAVING sum(Abono_Capital)+sum(Intereses)+sum(Total) <>0

                     UNION ALL


                     SELECT   concepto_desc, tipo_concepto, cod_financia, sum(Saldo_Anterior) Saldo_Anterior,
                              sum(Abono_Capital) Abono_Capital, sum(Intereses) Intereses, sum(Iva) Iva, sum(Total) Total,
                              sum(Saldo_posterior_pago) Saldo_posterior_pago, max(Cuotas_pendientes) Cuotas_pendientes,
                              max(interes_financiacion) interes_financiacion
                     FROM (
                     select     concorim    orden,
                                concdefa    concepto_desc,
                                conctico    tipo_concepto,
                                (select difecofi
                                from diferido where difecodi = Nrodiferido) cod_financia,
                               decode(sesuserv,7053,0,nvl((   select difesape
                                        from diferido
                                        where difecodi = Nrodiferido
                                     )+cargvalo,0))   Saldo_Anterior,
                                decode(sesuserv,7053,0,cargvalo)    Abono_Capital,
                                decode(sesuserv,7053,0,nvl(Intereses,0))   Intereses,
                                (case when cargconc=173 then cargvalo else 0 end) Iva,
                                decode(sesuserv,7053,cargvalo,0) Total,
                                decode(sesuserv,7053,0,(nvl((select difesape
                                        from diferido
                                        where difecodi = Nrodiferido),0)))  Saldo_posterior_pago,
                                decode(sesuserv,7053,0,(nvl((select (difenucu-difecupa)
                                from diferido where difecodi = Nrodiferido),0))) Cuotas_pendientes,

                                decode(sesuserv,7053,0,((power( 1 + nvl( (select difeinte
                                                    from diferido
                                                    where difecodi = Nrodiferido),0)/100,
                                     (1/12) ) -1) *100))
                                interes_financiacion

                        FROM ( select   cargcuco,c.concorim, c.conccodi, c.concdefa, c.conctico, cg.cargsign, cg.cargdoso, cg.cargconc,
                                        decode(substr(nvl(cg.cargdoso,' '),1,3),'DF-',substr(nvl(cg.cargdoso,' '),4)) Nrodiferido,
                                        decode(substr(nvl(cargdoso,' '),1,3),'DF-',cargvalo,0) cargvalo,
                                        --decode(cargsign,'CR', cargvalo*-1, 'PA', cargvalo*-1, 'AS', cargvalo*-1,'DB',cargvalo,cargvalo*-1) cargvalo,
                                        (select cargvalo
                                         from cargos abz where cg.cargcuco = abz.cargcuco
                                                                and substr(nvl(abz.cargdoso,' '),4,length(abz.cargdoso)) = substr(nvl(cg.cargdoso,' '),4,length(cg.cargdoso))
                                                                and substr(nvl(cargdoso,' '),1,3) IN ('ID-')
                                                                 ) Intereses
                                        --decode(substr(nvl(cargdoso,' '),1,3),'ID-',cargvalo,0) Intereses
                                       ,0 Por_IVA
                                       , sesuserv
                                from factura f,cuencobr cc, cargos cg, concepto c, servsusc s
                                where cg.cargconc = c.conccodi
                                  and f.factcodi = cc.cucofact
                                  and cc.cucocodi = cg.cargcuco
                                  --and c.concticl <> 4
                                  and (substr(nvl(cargdoso,' '),1,3) IN ('DF-') )
                                  AND cargsign <> 'SA'
                                  AND s.sesunuse = cargnuse
                                  and f.factcodi   = nuFactura

                                ))
                       group by concepto_desc,tipo_concepto,cod_financia
                       HAVING sum(Abono_Capital)+sum(Intereses)+sum(Total) <>0

                        UNION ALL


                       SELECT   concepto_desc, tipo_concepto, cod_financia, sum(Saldo_Anterior) Saldo_Anterior,
                              sum(Abono_Capital) Abono_Capital, sum(Intereses) Intereses, sum(Iva) Iva, sum(Total) Total,
                              sum(Saldo_posterior_pago) Saldo_posterior_pago, max(Cuotas_pendientes) Cuotas_pendientes,
                              max(interes_financiacion) interes_financiacion
                        FROM (
                         select     concorim    orden,
                                    concdefa    concepto_desc,
                                    conctico    tipo_concepto,
                                    (select difecofi
                                    from diferido where difecodi = Nrodiferido) cod_financia,
                                    nvl((   select difesape
                                            from diferido
                                            where difecodi = Nrodiferido
                                         )+cargvalo,0)   Saldo_Anterior,
                                    cargvalo    Abono_Capital,
                                    nvl(Intereses,0)   Intereses,
                                    (case when cargconc=173 then cargvalo else 0 end) Iva,
                                    0 Total,
                                    (nvl((select difesape
                                            from diferido
                                            where difecodi = Nrodiferido),0))  Saldo_posterior_pago,
                                    (nvl((select (difenucu-difecupa)
                                    from diferido where difecodi = Nrodiferido),0)) Cuotas_pendientes,

                                    ((power( 1 + nvl( (select difeinte
                                                        from diferido
                                                        where difecodi = Nrodiferido),0)/100,
                                         (1/12) ) -1) *100)
                                    interes_financiacion
                                    ,nrodiferido

                            FROM ( select   cargcuco,c.concorim, c.conccodi, c.concdefa, c.conctico, cg.cargsign, cg.cargdoso, cg.cargconc,
                                            decode(substr(nvl(cg.cargdoso,' '),1,3),'ID-',substr(nvl(cg.cargdoso,' '),4)) Nrodiferido,
                                            decode(substr(nvl(cargdoso,' '),1,3),'ID-',cargvalo,0) cargvalo,
                                            --decode(cargsign,'CR', cargvalo*-1, 'PA', cargvalo*-1, 'AS', cargvalo*-1,'DB',cargvalo,cargvalo*-1) cargvalo,
                                            0 Intereses
                                            --decode(substr(nvl(cargdoso,' '),1,3),'ID-',cargvalo,0) Intereses
                                           ,0 Por_IVA
                                    from factura f,cuencobr cc, cargos cg, concepto c
                                    where cg.cargconc = c.conccodi
                                      and f.factcodi = cc.cucofact
                                      and cc.cucocodi = cg.cargcuco
                                      --and c.concticl <> 4
                                      and (substr(nvl(cargdoso,' '),1,3) IN ('ID-') )
                                      AND cargsign <> 'SA'
                                      and f.factcodi   = nuFactura

                                    ) a
                                WHERE not exists (
                                SELECT 1 FROM (
                                SELECT cargcuco, cargconc, decode(substr(nvl(cg.cargdoso,' '),1,3),'DF-',substr(nvl(cg.cargdoso,' '),4)) Nrodiferido
                                from factura f,cuencobr cc, cargos cg, concepto c
                                where cg.cargconc = c.conccodi
                                      and f.factcodi = cc.cucofact
                                      and cc.cucocodi = cg.cargcuco
                                      --and c.concticl <> 4
                                      and (substr(nvl(cargdoso,' '),1,3) IN ('DF-') )
                                      AND cargsign <> 'SA'
                                      and f.factcodi   = nuFactura ) b

                                 WHERE a.cargcuco = b.cargcuco
                                 AND a.Nrodiferido = b.Nrodiferido
                                )
                                )
                           group by concepto_desc,tipo_concepto,cod_financia
                           HAVING sum(Abono_Capital)+sum(Intereses)+sum(Total) <>0


        )
        union all
        select 'SALDO ANTERIOR' concepto_desc,
            '0.00' Saldo_Anterior,
            '0.00' Abono_Capital,
            '0.00' Intereses,
            to_char(open.LDCI_PKFACTKIOSCO.FNUCONSULTAVALORANTFACT(inuSusccodi), 'FM999999990.00') Total,

            '0.00' Saldo_posterior_pago,
            0 Cuotas_pendientes,
            to_char(0,'990.0000') interes_financiacion,
            0 tipo_concepto
        FROM DUAL
        WHERE open.LDCI_PKFACTKIOSCO.FNUCONSULTAVALORANTFACT(inuSusccodi) <> 0

        UNION ALL
        SELECT     'IVA' concepto_desc,
                 '0.00' Saldo_Anterior,
                 '0.00' Abono_Capital,
                 '0.00' Intereses,
                 to_char(sum(Total), 'FM999999990.00') Total,
                 '0.00' Saldo_posterior_pago,
                 0 Cuotas_pendientes,
                 to_char(0,'990.0000') interes_financiacion,
                 0 tipo_concepto
         FROM (
        select c.concorim   orden,
               c.concdefa   concepto_desc,
               c.conctico   tipo_concepto,
               0            cod_financia,
               0            Saldo_Anterior,
               0            Abono_Capital,
               0            Intereses,
               (case when cargconc=137 then cargvalo else 0 end) Iva,
               decode(cargsign,'CR', cargvalo*-1, 'PA', cargvalo*-1, 'AS', cargvalo*-1,'DB',cargvalo,cargvalo*-1) Total,
               0            Saldo_posterior_pago,
               0            Cuotas_pendientes,
               0            interes_financiacion
        from factura f,cuencobr cc, cargos cg, concepto c
        where cg.cargconc = c.conccodi
          and f.factcodi = cc.cucofact
          and cc.cucocodi = cg.cargcuco
          and c.concticl = 4
          AND cg.cargcaca in (15,53)
          and factcodi  =  nuFactura)
        HAVING sum(Total) <> 0;

    --consulta de rangos de consumo

    OPEN CURANGOS FOR

    SELECT
    case
    when rang.ralilisr< 1000 then
        rang.raliliir||' - '||rang.ralilisr
    else rang.raliliir||' - O MAS' end rango,
    rang.ralivalo valor
        FROM rangliqu rang, (SELECT cargconc, factpefa, factcodi, cuconuse, pefacicl, pefacodi
                        FROM factura, cuencobr, cargos, perifact
                        WHERE factcodi = nuFactura
                        AND factsusc = inuSusccodi
                        AND pefacodi = factpefa
                        AND factcodi=cucofact
                        AND cucocodi=cargcuco
                        AND cargconc = (select pamenume FROM parametr WHERE pamecodi = 'CONSUMO')
                        AND rownum=1 ) cons
        WHERE cons.cargconc = rang.raliconc
        AND cons.factpefa = rang.ralipefa
        AND cons.cuconuse = rang.ralisesu
        AND rang.ralipeco = LDC_BOFORMATOFACTURA.fnuObtPerConsumo(cons.pefacicl, cons.pefacodi)
AND rownum < 3
union all
select '0' rango, 0 valor from dual;

    --consulta historicos de consumo

    OPEN CUHISTORICO FOR
        select  open.LDC_BOFORMATOFACTURA.fnuObtNCuentaSaldo(sesunuse) n_cuentas_saldo,
        TO_CHAR(ADD_MONTHS(sysdate, - 5),'MON','NLS_DATE_LANGUAGE = SPANISH') mes_6,
        open.LDC_BOFORMATOFACTURA.fnuGetConsumoAtras(factpefa,factcodi,5) consumo_6,
        TO_CHAR(ADD_MONTHS(sysdate, - 4),'MON','NLS_DATE_LANGUAGE = SPANISH') mes_5,
        open.LDC_BOFORMATOFACTURA.fnuGetConsumoAtras(factpefa,factcodi,4) consumo_5,
        TO_CHAR(ADD_MONTHS(sysdate, - 3),'MON','NLS_DATE_LANGUAGE = SPANISH') mes_4,
        open.LDC_BOFORMATOFACTURA.fnuGetConsumoAtras(factpefa,factcodi,3) consumo_4,
        TO_CHAR(ADD_MONTHS(sysdate, - 2),'MON','NLS_DATE_LANGUAGE = SPANISH') mes_3,
        open.LDC_BOFORMATOFACTURA.fnuGetConsumoAtras(factpefa,factcodi,2) consumo_3,
        TO_CHAR(ADD_MONTHS(sysdate, - 1),'MON','NLS_DATE_LANGUAGE = SPANISH') mes_2,
        open.LDC_BOFORMATOFACTURA.fnuGetConsumoAtras(factpefa,factcodi,1) consumo_2,
        TO_CHAR(sysdate,'MON','NLS_DATE_LANGUAGE = SPANISH') mes_1,
        open.LDC_BOFORMATOFACTURA.fnuGetConsumoAtras(factpefa,factcodi,0) consumo_1,
        to_char(factfege, 'dd/MON/yyyy','NLS_DATE_LANGUAGE = SPANISH') fecha_facturacion,
        ONUCUPONUME cupon_referencia,
        case when (open.LDC_BOFORMATOFACTURA.fsbPagoInmediato(sesunuse)=1) then 'INMEDIATO'
        when (sbInmediata='INMEDIATO') then 'INMEDIATO'
        else to_char(pefaffpa, 'dd/MON/yyyy','NLS_DATE_LANGUAGE = SPANISH') end fecha_pag_recargo,
        '(415)'||'7707183670022'||'(8020)'||lpad(ONUCUPONUME,10,'0')||
        '(3900)'||lpad(inuSaldoGen,10,'0')||'(96)'||to_char(cucofeve, 'yyyymmdd') codigo_barras,
        to_char(round(open.LDC_BOFORMATOFACTURA.fnuValorPosterior(factcodi)),'FM999999990') Sal_Pos_Pago,
        to_char(round(open.pktblsuscripc.fnugetsuscsafa(factsusc)),'FM999999990') Saldo_Favor,
        decode(LDC_BOFORMATOFACTURA.fnuMostrarFechaSuspension(sesususc), 1, to_char(pefaffpa, 'dd/MON/yyyy','NLS_DATE_LANGUAGE = SPANISH'), null) fecha_susp_corte,
        --open.LDC_BOFORMATOFACTURA.fnuGetFechaProxRevision(sesunuse) fecha_prox_revi
        LDCI_PKFACTKIOSCO.FSBCONSULTAFECHREV(sesunuse) fecha_prox_revi
from open.factura, open.servsusc, open.perifact ,open.cuencobr
where      factsusc= inuSusccodi
and      factcodi = nuFactura
and sesususc=factsusc
and cucofact=factcodi
and factpefa=pefacodi
and rownum=1;
--consultas las lecturas
    OPEN CULECTURAS FOR
select round(sum(leac),2) lectura_actual , round(sum(lean),2)  lectura_anterior,
       num_medidor,causal_no_lec
from (
select nvl(leemleto,0) leac, nvl(leemlean,0) lean,
    (select emsscoem from open.elmesesu where emsssesu=leemsesu and rownum=1) num_medidor,
    (select obledesc from open.obselect where oblecodi = leemobsc and oblecanl='S' and rownum=1) causal_no_lec
from open.factura, open.servsusc,  open.lectelme
where factcodi = nuFactura
and factsusc= inuSusccodi
and sesususc=factsusc
and sesuserv=7014 -- Servicio de GAS
and leemsesu=sesunuse
and leempefa=factpefa
)group by num_medidor,causal_no_lec;
--consulta los consumos
  OPEN CUCONSUMOS FOR

/*
 * hectorfdv
 * TQ: 3071
 * 03-04-2014
 * Se actualiza el calculo del consumo promedio
 * para evitar el envio de codigo de factura nula
 * cuando no se registra consumo
 *
 */


select  round(consumo_promedio,0) consumo_promedio, round(consumo_actual,0) consumo_actual, to_char(factor_correccion,'FM999999990.0000') factor_correccion, poder_calorifico,
        nvl(round(((consumo_actual*poder_calorifico)/3.6),2),0) Equivalencia_Kwh,
        nvl(round(((consumo_actual*consumo_promedio)/3.6),2),0) Equi_Consumo_Pro
from (
select  ((open.LDC_BOFORMATOFACTURA.fnuGetConsumoAtras(max(factpefa),max(factcodi),5)+
        open.LDC_BOFORMATOFACTURA.fnuGetConsumoAtras(max(factpefa),max(factcodi),4)+
        open.LDC_BOFORMATOFACTURA.fnuGetConsumoAtras(max(factpefa),max(factcodi),3)+
        open.LDC_BOFORMATOFACTURA.fnuGetConsumoAtras(max(factpefa),max(factcodi),2)+
        open.LDC_BOFORMATOFACTURA.fnuGetConsumoAtras(max(factpefa),max(factcodi),1)+
        open.LDC_BOFORMATOFACTURA.fnuGetConsumoAtras(max(factpefa),max(factcodi),0))/6)  consumo_promedio,
        nvl(round(sum(decode(sesucate,1, cosscoca, 2, cosscoca, 3, decode(cossfcco, null,0,cosscoca),open.LDC_BOFORMATOFACTURA.fnuGetConsumoIndustriaNR(factcodi))),2),0) consumo_actual,
        max(fccofaco) factor_correccion,
        max(fccofapc) poder_calorifico, null Equivalencia_Kwh
FROM factura f inner join servsusc s on (sesususc = factsusc) LEFT OUTER JOIN conssesu c
ON (c.cosssesu = s.sesunuse
and c.cosspefa = f.factpefa
AND cossmecc=4) left outer join cm_facocoss on (cossfcco=fccocons)
WHERE  factcodi =nuFactura);

--consulta los componentes de costo

 /*
 * hectorfdv
 * TQ: 3071
 * 03-04-2014
 * Se modifica el calculo de los componentes, para que permita la consulta de los conponentes
 * cuando se trate de factura para industrias
 *
 */
OPEN CUCOMPONENTES FOR

SELECT LDCI_PKFACTKIOSCO.fnuConsultComponentCostoGen(TO_NUMBER(LDCI.CASEVALO),1,6,nuFactura,inuSusccodi) AS VALOR,
       LDCI.CASEDESC AS DESCRIPCION,
       TO_NUMBER(LDCI.CASEVALO) AS CONCEPTO,
       C.CONCDESC AS CONCEPTODESC
FROM LDCI_CARASEWE LDCI, CONCEPTO C
WHERE LDCI.CASEDESE='WS_KIOSCO' AND
TO_NUMBER(LDCI.CASEVALO) = C.CONCCODI;


    prcCierraCursores (CUDATOSBASIC , CUFACTDETA, CURANGOS,CUHISTORICO,CULECTURAS,CUCONSUMOS,CUCOMPONENTES);

    /*
     * se consulta si tiene una orden de suspencion en
     * proceso
     */
    osbOrdenSusp:=fsbOrdenSuspContrato(inuSusccodi);

   /*
    * Se Consulta si el contrato se encuentra en proceso
    * de facturacion
    */

   osbProcFact:=LDCI_PKFACTKIOSCO.fsbProcFactura(inuSusccodi);

  /*
   * Se confirma la creacion del cupon, y demas transacciones de los apis
   */

COMMIT;
onuErrorCode:=0;
EXCEPTION
      WHEN ERROR_GENERA THEN
        ROLLBACK;

        pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
        Errors.seterror;
        Errors.geterror (onuErrorCode, osbErrorMessage);
        prcCierraCursores (CUDATOSBASIC , CUFACTDETA, CURANGOS,CUHISTORICO,CULECTURAS,CUCONSUMOS,CUCOMPONENTES);
        osbErrorMessage := 'Error Generando el cupon: '||osbErrorMessage||' '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;

       WHEN ERROR_MORA THEN
        ROLLBACK;

        pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
        Errors.seterror;
        Errors.geterror (onuErrorCode, osbErrorMessage);
        prcCierraCursores (CUDATOSBASIC , CUFACTDETA, CURANGOS,CUHISTORICO,CULECTURAS,CUCONSUMOS,CUCOMPONENTES);
        osbErrorMessage := 'Error consultando el interes de mora: '||osbErrorMessage||' '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE||osbErrorMessage;

      WHEN ex.CONTROLLED_ERROR then
         ROLLBACK;
         Errors.geterror (onuErrorCode, osbErrorMessage);
         osbErrorMessage := 'Error: '||osbErrorMessage||' '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;

      WHEN OTHERS THEN
       ROLLBACK;
        pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
        Errors.seterror;
        Errors.geterror (onuErrorCode, osbErrorMessage);
        prcCierraCursores (CUDATOSBASIC , CUFACTDETA, CURANGOS,CUHISTORICO,CULECTURAS,CUCONSUMOS,CUCOMPONENTES);
        osbErrorMessage := ' Error generando la informacion a imprimir en la factura: '||osbErrorMessage||' '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;

END PROGENERAFACT;




 /************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

       PROCEDURE : fsbValidaContrato
         AUTOR   : Hector Fabio Dominguez
         FECHA   : 16/05/2013
         RICEF   : I045
     DESCRIPCION : Proceso encargado de validar si un contrato
           existe o no existe

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    16/05/2013  Creacion del paquete
************************************************************************/

  FUNCTION fsbValidaContrato (nuSusccodi in suscripc.susccodi%type)
  RETURN VARCHAR2
      IS
         nuExiste number;
         nuResExiste varchar(2);
      BEGIN
      nuResExiste := '-1';
         BEGIN
            SELECT count(1)
            INTO   nuExiste
            FROM   suscripc
            WHERE  susccodi = nuSusccodi
            AND  susccodi > 0 ; --Se excluye el  codigo -1  comodin
         EXCEPTION
         WHEN ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
         END;

         IF (nuExiste = 1) then
           --DBMS_OUTPUT.PUT_LINE('El contrato Si existe');
           nuResExiste := '1';
         ELSE
           --DBMS_OUTPUT.PUT_LINE('El contrato No existe');
           nuResExiste := '0';
         END IF;

      RETURN nuResExiste;

      EXCEPTION
      WHEN ex.CONTROLLED_ERROR then
      RETURN nuResExiste;
         raise ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         RETURN nuResExiste;
         Errors.setError;
         raise ex.CONTROLLED_ERROR;
   END fsbValidaContrato;
 /************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

       PROCEDURE : fsbValidaIdentificacion
         AUTOR   : Hector Fabio Dominguez
         FECHA   : 30/07/2012
         RICEF   : I045
     DESCRIPCION : Validar si la identificacion existe

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    16/05/2013  Creacion del paquete
************************************************************************/


  FUNCTION fsbValidaIdentificacion(nuIdentification in ge_subscriber.identification%type)
  RETURN VARCHAR2
      IS
         nuExiste number;
         nuResExiste varchar(2);
      BEGIN
      nuResExiste := '-1';
         BEGIN
            SELECT count(1)
            INTO   nuExiste
            FROM   ge_subscriber
            WHERE  identification = nuIdentification;
         EXCEPTION
         WHEN ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
         END;

         IF (nuExiste = 1) then
           --DBMS_OUTPUT.PUT_LINE('El contrato Si existe');
           nuResExiste := '1';
         ELSE
           --DBMS_OUTPUT.PUT_LINE('El contrato No existe');
           nuResExiste := '0';
         END IF;

      RETURN nuResExiste;

      EXCEPTION
      WHEN ex.CONTROLLED_ERROR then
      RETURN nuResExiste;
         raise ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         RETURN nuResExiste;
         Errors.setError;
         raise ex.CONTROLLED_ERROR;
   END fsbValidaIdentificacion;

 /************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

       PROCEDURE : fsbFormatoFactContrato
         AUTOR   : Hector Fabio Dominguez
         FECHA   : 30/07/2012
         RICEF   : I045
     DESCRIPCION : Consulta el formato de una factura

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    16/05/2013  Creacion del paquete
************************************************************************/
  FUNCTION fsbFormatoFactContrato (nuSusccodi in suscripc.susccodi%type)
  RETURN VARCHAR2
      IS
         nuExiste NUMBER :=0;
         sbFormato varchar2(100) :='';
         nuResExiste NUMBER;
      BEGIN
      nuResExiste := -1;
         BEGIN
            select count(1)
            INTO nuExiste
            from ed_formato edfo,
              ed_confexme edco,
              suscripc suscri
            where suscri.susccodi =nuSusccodi
              and edco.coemcodi = suscri.susccemf
              and edfo.FORMIDEN  =edco.COEMPADA;


            select edfo.FORMDESC
            INTO sbFormato
            from ed_formato edfo,
              ed_confexme edco,
              suscripc suscri
            where suscri.susccodi =nuSusccodi
              and edco.coemcodi = suscri.susccemf
              and edfo.FORMIDEN  =edco.COEMPADA;

         EXCEPTION
         WHEN ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
         END;

         IF (nuExiste = 1) then
           --DBMS_OUTPUT.PUT_LINE('El contrato Si existe');
           sbFormato := sbFormato;
         ELSE
           --DBMS_OUTPUT.PUT_LINE('El contrato No existe');
           nuResExiste := '0';
         END IF;

      RETURN sbFormato;

      EXCEPTION
      WHEN ex.CONTROLLED_ERROR then
      RETURN nuResExiste;
         raise ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         RETURN nuResExiste;
         Errors.setError;
         raise ex.CONTROLLED_ERROR;
   END fsbFormatoFactContrato;


   /*
    * Procedimiendo encargado de
    * retornar la informacion de la factura
    * de la tabla ed_document, este procedimiento
    * no serÿ¿ÿ¿ÿ¿ÿ¿ÿ¿ÿ¿ÿ¿ÿ¡ utilizado para Kiosco
    */

   /************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

       PROCEDURE : proCnltaDupliFact
         AUTOR   : Hector Fabio Dominguez
         FECHA   : 30/07/2012
         RICEF   : I045
     DESCRIPCION : Consulta el duplicado de la factura

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    16/05/2013  Creacion del paquete
************************************************************************/
  PROCEDURE proCnltaDupliFact(inuSuscCodi         in   SUSCRIPC.SUSCCODI%TYPE,
                                  orDocuments           OUT  SYS_REFCURSOR,
                                  onuErrorCode        out  NUMBER,
                                  osbErrorMessage     out  VARCHAR2) IS
BEGIN

onuErrorCode:=0;
OPEN orDocuments for
SELECT do.*
  FROM  ed_document do, factura fa
  WHERE
    do.docupefa  = fa.factpefa
    AND do.docucodi = fa.factcodi
    AND fa.factsusc = Decode(inuSuscCodi,-1,fa.factsusc,inuSuscCodi)
    AND  fa.factcodi = (SELECT max(factcodi) FROM  factura fa1 WHERE fa1.factsusc = Decode(inuSuscCodi,-1,fa.factsusc,inuSuscCodi) )
    AND fa.factprog  IN(6,123);

      EXCEPTION
      WHEN ex.CONTROLLED_ERROR then
      onuErrorCode:=-1;

      WHEN OTHERS THEN
         onuErrorCode:=-1;
         raise ex.CONTROLLED_ERROR;
END;
END LDCI_PKFACTKIOSCO;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_PKFACTKIOSCO', 'ADM_PERSON'); 
END;
/

GRANT EXECUTE on ADM_PERSON.LDCI_PKFACTKIOSCO to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKFACTKIOSCO to INTEGRADESA;
/


