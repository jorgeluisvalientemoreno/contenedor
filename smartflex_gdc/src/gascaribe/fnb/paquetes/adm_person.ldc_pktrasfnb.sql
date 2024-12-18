CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_PKTRASFNB is

/**************************************************************************
    Autor       : F Castro
    Fecha       : 2017-03-31
    Descripcion : Generamos informacion de Cartera a un corte especifico

    Parametros Entrada
      nuano A?o
      numes Mes

    Valor de salida
      sbmen  mensaje
      error  codigo del error

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION

***************************************************************************/

/*CURSOR cuInsurDebtExpValue(inuNuse in diferido.difenuse%type, inuCuenta cuencobr.cucocodi%type) IS
            SELECT sum(cargvalo)valor
              FROM cargos
             WHERE cargconc IN
                   (SELECT TO_NUMBER(COLUMN_VALUE)
                      FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(nuInsuranceConcept || '|' ||
                                                              DALD_PARAMETER.fsbGetValue_Chain('CONCEPTOS_MORA_FNB',0),'|')))
               AND cargsign = sbDBSign
               AND cargnuse = inuNuse
               AND cargcuco = inuCuenta;


 LD_BONONBANKFINANCING.getblockUnblocQuoteData
               */


-----------------------
  -- Tablas en Memoria
  -- --------------------
  TYPE rcCargo IS RECORD(
    cuco NUMBER(10),
    conc NUMBER(4),
    valo NUMBER(13, 2));

  TYPE tbCargo IS TABLE OF rcCargo INDEX BY pls_integer; -- indexado concepto
  tCargo tbCargo;

  TYPE rcPagos IS RECORD(
    conc NUMBER(4),
    valo NUMBER(13, 2));

  TYPE tbPagos IS TABLE OF rcPagos INDEX BY pls_integer; -- indexado concepto
  tPagos tbPagos;

  TYPE rcDife IS RECORD(
    poli NUMBER(10),
    dfan NUMBER(10),
    dfnu NUMBER(10),
    sden varchar2(1));

  TYPE tbDife IS TABLE OF rcDife INDEX BY varchar2(15); -- indexado por producto y concepto
  tDife tbDife;

-- Variables
nuindice      pls_integer;
nuindiceP     pls_integer;
sbidxdif      varchar2(15);
nuSuscripcion suscripc.susccodi%type; -- := 617177;
nuServsusc    servsusc.sesunuse%type; -- := 617177;
nuServicio    servsusc.sesuserv%type;
nuConcepto    cargos.cargconc%type; -- := 30;
nuCausal      cargos.cargcaca%type; -- := 2;
nuValor       cargos.cargvalo%type; -- := 999;
sbSigno       cargos.cargsign%type;
sbObserv      notas.notaobse%type := 'TC-CC';
nuTipo        number;
nucuentaori cuencobr.cucocodi%type;
nucuentades cuencobr.cucocodi%type;


nuDepa     cuencobr.cucodepa%type;
nuLoca     cuencobr.cucoloca%type;
nuPrograma cargos.cargprog%type := 2014; -- programa de ajustes
nunotacons notas.notacons%type; -- := 70; -- tipo documento para ND



PROCEDURE prBloqCupoFNB (inusesuori in servsusc.sesunuse%type,
                          inusesudes in servsusc.sesunuse%type);

function fsbEvaluateBloqCupoTrasl (inusesu in servsusc.sesunuse%type) return varchar2;

function fsbGetBloqueoCupo (inususc          in    servsusc.sesususc%type,
                            onucausal_id     out   ld_quota_block.causal_id%type,
                            odtregister_date out   ld_quota_block.register_date%type) return varchar2;

PROCEDURE prDesBloqCupoFNB (inususc in servsusc.sesususc%type) ;

PROCEDURE prCreOrdenesporTrFnb (inuProductId  or_order_activity.product_Id%type,
                                inuActivity  or_order_activity.activity_id%type,
                                isbComment    mo_packages.comment_%type);

PROCEDURE prLegOrdenesporTrFnb (inuorden  or_order.order_id%type,
                                sbobse    varchar2);

/*PROCEDURE prTrasladoSeguros (inususcori  servsusc.sesususc%type,
                             inunuseori  servsusc.sesunuse%type,
                             inususcdes  servsusc.sesususc%type,
                             inunusedes  servsusc.sesunuse%type);*/

 PROCEDURE prTrasladoSeguros;

  PROCEDURE Generate
(
	onuErrorCode       out	number,
	osbErrorMessage    out	varchar2
);

PROCEDURE DetPagos (nucuco in cuencobr.cucocodi%type,
                    dtfeve in cuencobr.cucofeve%type) ;

FUNCTION GetPagoConcepto (nuconc in cargos.cargconc%type) return number;

FUNCTION fnuPolizaPend(inunuse diferido.difenuse%type, inudife diferido.difecodi%type) return varchar2;

  PROCEDURE GenProcess;

  PROCEDURE ProcessSubsServices;

  PROCEDURE AddCharge

  (inuConcepto in cargos.cargconc%type,
   isbSigno    in cargos.cargsign%type,
   isbDocSop   in cargos.cargdoso%type,
   inuCausal   in cargos.cargcaca%type,
   inuVlrCargo in cargos.cargvalo%type,
   inuConsDocu in cargos.cargcodo%type,
   isbTipoProc in cargos.cargtipr%type);

  PROCEDURE GenerateCharge(inuConcepto in cargos.cargconc%type,
                           isbSigno    in cargos.cargsign%type,
                           isbDocSop   in cargos.cargdoso%type,
                           inuCausal   in cargos.cargcaca%type,
                           inuVlrCargo in cargos.cargvalo%type,
                           inuConsDocu in cargos.cargcodo%type,
                           isbTipoProc in cargos.cargtipr%type);

  PROCEDURE ProcessCharges;

  PROCEDURE UpdateAccoRec;

  PROCEDURE ProcessGeneratedAcco;

  PROCEDURE AsignaNumeracionFiscal;

  PROCEDURE GenerateAccount;

  PROCEDURE GenerateAccountStatus;

  PROCEDURE UpdateCharges;

  PROCEDURE AdjustAccount;

  PROCEDURE UpdAccoBillValues;

  FUNCTION fnuGetAccountNumber RETURN number;

  FUNCTION fnuGetAccountStNumber RETURN number;

  PROCEDURE AddAccount;

  PROCEDURE AddAccountStatus;

  FUNCTION ValInputData(osbError out varchar2) return number;

  PROCEDURE ValSubsService(inuServsusc in servsusc.sesunuse%type);

  PROCEDURE ValSubscriber(inuSuscripcion in suscripc.susccodi%type);

  PROCEDURE ValSupportDoc(isbDocumento in cargos.cargdoso%type);

  PROCEDURE ValSubsNServ
    (
	inuSubscription in suscripc.susccodi%type,
	inuServNum      in servsusc.sesunuse%type
    );

  FUNCTION ValConcepto
    (
	inuConcepto concepto.conccodi%type
    ) return number;

  FUNCTION ValCausal
     (
	inuCausal causcarg.cacacodi%type
    ) return number;

  FUNCTION ValPlanFina
     (
	inuPlan plandife.PLDICODI%type
    ) return number;



  FUNCTION fboGetIsNumber
    (
	isbValor varchar2
    ) return boolean;

  FUNCTION ValContProdServ
    (
	inuSubscription in suscripc.susccodi%type,
	inuServNum      in servsusc.sesunuse%type,
  inuserv         in servsusc.sesuserv%type
    ) return number ;

  PROCEDURE ValGenerationDate(idtFechaGene in date);
  FUNCTION fnuGetAdjustValue RETURN number;

  PROCEDURE CalcAdjustValue(inuFactor      in timoempr.tmemfaaj%type,
                            inuValorCta    in cuencobr.cucovato%type,
                            onuValorAjuste out cargos.cargvalo%type,
                            osbSignoAjuste out cargos.cargsign%type);

PROCEDURE GetOverChargePercent(inuPlandife         in plandife.pldicodi%type,
                                   onuPercenOverCharge out number);

PROCEDURE ValInterestConcept(inuConc in concepto.conccodi%type);



PROCEDURE GetExtraPayTotal(inuExtraPayNumber in number,
                             onuExtraPayValue  out number);

PROCEDURE GenerateBillingNote;

Function ConsCartera return pkConstante.tyRefCursor;

end LDC_PKTRASFNB;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_PKTRASFNB is
  /**************************************************************************
    Autor       : F Castro
    Fecha       : 2017-03-31
    Descripcion : Se genera informacion de Cartera a un corte especifico (Caso SS 100-28174)

    Parametros Entrada
      nuano A?o
      numes Mes

    Valor de salida
      sbmen  mensaje
      error  codigo del error

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION

***************************************************************************/


nucuantosreg  number := -2;

    -- Tabla de Estados de cuenta
    TYPE tytbCargfact IS TABLE OF cuencobr.cucofact%type INDEX BY binary_integer;
    tbCargfact  tytbCargfact;

    -- Tabla de cuentas de cobro
    TYPE tytbCargcuco IS TABLE OF cargos.cargcuco%type INDEX BY binary_integer;
    tbCargcuco  tytbCargcuco;

    -- Tabla de fechas contables
    TYPE tytbCargfeco IS TABLE OF pkbccargos.stycargfeco INDEX BY binary_integer;
    tbCargfeco  tytbCargfeco;

    -- Tabla de fechas de creaci?n del cargo
    TYPE tytbCargfecr IS TABLE OF pkbccargos.stycargfeco INDEX BY binary_integer;
    tbCargdate  tytbCargfecr;

    -- Tabla de documentos de soporte
    TYPE tytbCargdoso IS TABLE OF cargos.cargdoso%type INDEX BY binary_integer;
    tbCargdoso  tytbCargdoso;

    -- Tabla de documentos de soporte
    TYPE tytbCargtipr IS TABLE OF cargos.cargtipr%type INDEX BY binary_integer;
    tbCargtipr  tytbCargtipr;

    -- Tabla de rowids de los cargos
    TYPE tytbRowid IS TABLE OF rowid INDEX BY binary_integer;
    tbRowid  tytbRowid;

    --------------------------------
    -- Movimientos de Pagos       --
    --------------------------------
    TYPE tyrcCargos IS RECORD
    (
       sbRowid      rowid,
       cargconc     cargos.cargconc%type,
       cargcaca     cargos.cargcaca%type,
       cargsign     cargos.cargsign%type,
       cargdoso     cargos.cargdoso%type,
       cargvalo     cargos.cargvalo%type,
       cargfecr     cargos.cargfecr%type,
       cargnuse     cargos.cargnuse%type,
       cargpeco     cargos.cargpeco%type
    );

    TYPE tytbCargos IS TABLE OF tyrcCargos INDEX BY BINARY_INTEGER;

    TYPE tyrcMaxPericosePorConcepto IS RECORD
    (
       rcPeriodoConsumo pericose%rowtype,
       dtFechaUltLiq    feullico.felifeul%type,
       sbTipoCobro      concepto.concticc%type
    );

    TYPE tytbMaxPericoseConcepto IS TABLE OF tyrcMaxPericosePorConcepto INDEX BY BINARY_INTEGER;

    ------------------
    -- Constantes
    ------------------
    -- Esta constante se debe modificar cada vez que se entregue el
    -- paquete con un SAO
    csbVersion          CONSTANT VARCHAR2(250) := 'SAO258199';

    -- Nombre del programa ejecutor Generate Invoice
    csbPROGRAMA      constant varchar2(4) := 'ANDM';

    -- Tipo Documento Numeracion Fiscal
    nuTipDocNumFiscal  number := 66;

    -- Maximo numero de registros Hash para Parametros o cadenas
    cnuHASH_MAX_RECORDS constant number := 100000 ;

    -- Constante de error de no Aplicaci?n para el API OS_generateInvoice
    cnuERRORNOAPLI number := 500;

    cnuNivelTrace constant number(2) := 5;
    -----------------------
    -- Variables
    -----------------------
    sbErrMsg    varchar2(2000);    -- Mensajes de Error

    grcEstadoCta factura%rowtype; -- Global de la factura generada

    -- Concepto de ajuste
    nuConcAjuste  concepto.conccodi%type;
    -- Concepto de pago
    nuConcPago    concepto.conccodi%type;
    -- Verifica si se genero la cuenta
    boCuentaGenerada  boolean;
    -- Verifica si se genero estado de cuenta
    boAccountStGenerado  boolean;
    -- Record del periodo de facturacion current
    rcPerifactCurr  perifact%rowtype;
    -- Record de la suscripcion current
    rcSuscCurr    suscripc%rowtype;
    -- Record del servicio suscrito current
    rcSeSuCurr    servsusc%rowtype;
    -- Numero del estado de cuenta current
    nuEstadoCuenta  factura.factcodi%type;
    -- Numero de la cuenta de cobro current
    nuCuenta    cuencobr.cucocodi%type;
    -- Numero del Diferido Creado
    nuDiferido   diferido.difecodi%type;
    -- Numero de la Nota Creada
    nuNota   notas.notanume%type;
    -- Fecha de generacion de las cuentas
    dtFechaGene     date;
    -- Programa
    sbApplication    varchar2 (10);
    -- Fecha contable del periodo contable current
    dtFechaContable   date;

    dtFechaCurrent   date;
    sbTerminal     factura.factterm%type ;

    -- Saldo pendiente de la factura
    nuSaldoFac  pkbcfactura.styfactspfa;

    -- Valores facturados cuenta por servicio
    nuVlrFactCta        cuencobr.cucovafa%type;
    nuVlrIvaFactCta     cuencobr.cucoimfa%type;

    -- Valores facturados de la factura
    nuVlrFactFac        pkbcfactura.styfactvafa;
    nuVlrIvaFactFac     pkbcfactura.styfactivfa;

    gnuCouponPayment pagos.pagocupo%type;    -- Cupon de Pago

    -- Variables de valores de cartera actualizados despues de realizar
    -- una actualizacion
    nuCart_ValorCta      cuencobr.cucovato%type;  -- Valor cuenta
    nuCart_AbonoCta      cuencobr.cucovaab%type;  -- Abonos cuenta
    nuCart_SaldoCta      cuencobr.cucosacu%type;  -- Saldo cuenta

    -- Tipo de documento
    gnuTipoDocumento    ge_document_type.document_type_id%type;

     nugNumServ servsusc.sesunuse%type; -- Numero servicio
      dtgProceso     diferido.difefein%type; -- Fecha proceso
       nugPorcMora plandife.pldiprmo%type;
   /*  nugCiclo    ciclo.ciclcodi%type; -- Codigo Ciclo Facturacion
  nugAno      perifact.pefaano%type; -- Ano periodo current
  nugMes      perifact.pefames%type; -- Mes periodo current
  nugPeriodo  perifact.pefacodi%type; -- Periodo current*/
  nugTasaInte diferido.difetain%type; -- Codigo Tasa Interes
  cnuBadOverChargePercent constant number(6) := 120782;


  sbgUser     varchar2(50); -- Nombre usuario
  sbgTerminal varchar2(50); -- Terminal
  gnuPersonId ge_person.person_id%type; -- Id de la persona
  nuIdxDife number; -- Indice de tabla de diferidos

  tbgDeferred      mo_tytbdeferred;
  tbgExtraPayments mo_tytbextrapayments;
  tbgCharges       mo_tytbCharges;
  tbgQuotaSimulate mo_tytbQuotaSimulate;
    tbExtraPayment cc_bcfinancing.tytbExtraPayment;
  nugSubscription suscripc.susccodi%type;

  nugFinanCode diferido.difecofi%type;

   nugMetodo      diferido.difemeca%type; -- Metodo Cuota
  nugPlan        diferido.difepldi%type; -- Plan del Diferido
    nugFactor        diferido.difefagr%type; -- Factor Gradiente
nugSpread      diferido.difespre%type; -- valor del Spread
  nugPorcInteres diferido.difeinte%type; -- Interes Efectivo
   nugPorIntNominal diferido.difeinte%type; -- Interes Nominal
     nugNumCuotaExt cuotextr.cuexnume%type; -- Numero de Cuota extras
  nuIdxExtr number; -- Indice de tabla Cuotras Extras
  nugVlrFinIva diferido.difevatd%type;

   -- Acumuladores de cuotas extras por numero de cuota
  type tytbAcumExtraPay IS table of number index BY binary_integer;
  tbgAcumExtraPay tytbAcumExtraPay;

--------------------------------------------------------------------------------------------------------------
 PROCEDURE prBloqCupoFNB (inusesuori in servsusc.sesunuse%type,
                          inusesudes in servsusc.sesunuse%type) is

   nuCausTras      number      :=  dald_parameter.fnuGetNumeric_Value('CAUSAL_TRASL_DEUD');
   nuSeq           number;
   nususcori       servsusc.sesususc%type;
   nususcdes       servsusc.sesususc%type;

   cursor cuSusc (nusesu servsusc.sesunuse%type) is
     select sesususc
       from servsusc
      where sesunuse = nusesu;

   cursor cuSESSION is
			select MACHINE, PROGRAM, OSUSER, USERNAME
				from V$SESSION
			where sid=(select sys_context('USERENV','SID') from dual);
   reSESSION			cuSESSION%rowtype;

   nuusuariox number;

    BEGIN
      -- halla secuencia
      nuSeq := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('SEQ_LD_QUOTA_BLOCK');
      -- halla contrato origen
      open cususc(inusesuori);
      fetch cususc into nususcori;
      if cususc%notfound then
        nususcori := -1;
      end if;
      close cususc;
      -- halla contrato destino
      open cususc(inusesudes);
      fetch cususc into nususcdes;
      if cususc%notfound then
        nususcdes := -1;
      end if;
      close cususc;
       -- halla usuario y maquina
       open cuSESSION;
       fetch cuSESSION into reSESSION;
       close cuSESSION;

       select sys_context('USERENV','SID') INTO nuusuariox from dual;

      insert into ld_quota_block
            values (nuSeq, 'Y', nususcori, nuCausTras, sysdate, 'POR TRASLADO AL CONTRATO ' || nususcdes,
                    reSESSION.Username, reSESSION.Machine );


    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;

        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END prBloqCupoFNB;

--------------------------------------------------------------------------------------------------------------
 PROCEDURE prDesBloqCupoFNB (inususc in servsusc.sesususc%type) is

   nuCausTras      number      :=  dald_parameter.fnuGetNumeric_Value('CAUSAL_TRASL_DEUD');
   nuSeq           number;


   cursor cuSESSION is
			select MACHINE, PROGRAM, OSUSER, USERNAME
				from V$SESSION
			where sid=(select sys_context('USERENV','SID') from dual);
   reSESSION			cuSESSION%rowtype;
   nuusuariox NUMBER;

    BEGIN
      -- halla secuencia
      nuSeq := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('SEQ_LD_QUOTA_BLOCK');
       -- halla usuario y maquina
       open cuSESSION;
       fetch cuSESSION into reSESSION;
       close cuSESSION;

       select sys_context('USERENV','SID') INTO nuusuariox from dual;

       insert into ld_quota_block
            values (nuSeq, 'N', inususc, nuCausTras, sysdate, 'POR CUMPLIR TIEMPO DE BLOQUEO POR TRASLADO ',
                    reSESSION.Username, reSESSION.Machine );


    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;

        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END prDesBloqCupoFNB;

---------------------------------------------------------------------------------
function fsbEvaluateBloqCupoTrasl (inusesu in servsusc.sesunuse%type) return varchar2 is

 sbBloqParam     varchar2(1) :=  DALD_PARAMETER.fsbGetValue_Chain('BLOQ_CUPO_FNB_TRASL_DEUDA');
 numesbloq       number      :=  dald_parameter.fnuGetNumeric_Value('MESES_BLOQ_CUPO_FNB_TRASL_DEUD');
 nuCausTras      number      :=  dald_parameter.fnuGetNumeric_Value('CAUSAL_TRASL_DEUD');

 sbblock         ld_quota_block.block%type;
 nucausal_id     ld_quota_block.causal_id%type;
 dtregister_date ld_quota_block.register_date%type;

 sbBloquear varchar2(1);

 cursor cuBloqueoCupo is
   SELECT q2.block, q2.causal_id, q2.register_date
     FROM ld_quota_block q2
    WHERE q2.quota_block_id = (select max(q.quota_block_id)
                                 from ld_quota_block q
                                where q.subscription_id = (select sesususc
                                                             from servsusc
                                                            where sesunuse=inusesu));


begin
  if sbBloqParam = 'S' then
    open cuBloqueoCupo;
    fetch cuBloqueoCupo into sbblock, nucausal_id, dtregister_date;
    if cuBloqueoCupo%notfound then
      sbblock  := null;
    end if;
    close cuBloqueoCupo;

    if nvl(sbblock,'N') = 'N' then
       sbBloquear :=  'Y';

    else

      if nucausal_id !=  nuCausTras then
         sbBloquear :=  'Y';

      else
        if trunc(dtregister_date) < trunc(sysdate) then
          sbBloquear :=  'Y';
        else
          sbBloquear :=  'N';
        end if;
      end if;
    end if;
  else
    sbBloquear :=  'N';

  end if;

  return (sbBloquear);

exception when others then
   return ('E');
end fsbEvaluateBloqCupoTrasl;

---------------------------------------------------------------------------------
function fsbGetBloqueoCupo (inususc          in    servsusc.sesususc%type,
                            onucausal_id     out   ld_quota_block.causal_id%type,
                            odtregister_date out   ld_quota_block.register_date%type) return varchar2 is


 sbblock         ld_quota_block.block%type;


 cursor cuBloqueoCupo is
   SELECT q2.block, q2.causal_id, q2.register_date
     FROM ld_quota_block q2
    WHERE q2.quota_block_id = (select max(q.quota_block_id)
                                 from ld_quota_block q
                                where q.subscription_id = inususc);


begin
    open cuBloqueoCupo;
    fetch cuBloqueoCupo into sbblock, onucausal_id, odtregister_date;
    if cuBloqueoCupo%notfound then
      sbblock  := 'N';
    end if;
    close cuBloqueoCupo;

  return (sbblock);

exception when others then
   return ('N');
end fsbGetBloqueoCupo;

----------------------------------------------------------------------------------------------------
PROCEDURE prCreOrdenesporTrFnb (inuProductId  or_order_activity.product_Id%type,
                                inuActivity  or_order_activity.activity_id%type,
                                isbComment    mo_packages.comment_%type) IS

nuError    number;
sbMessage  varchar2(2000);
nuUnitOper number;
nuCausal   number;

nuSubscriber               ge_subscriber.subscriber_id%type;
nuSuscription              suscripc.susccodi%type;
nuAddressId                or_order_activity.address_id%type;

nuOrderId                   or_order.order_id%type;
nuOrderActivityId           or_order_activity.activity_id%type;

rcOrder   daor_order.styor_order;

CURSOR cuAddress is
     SELECT  p.subscription_id, s.suscclie, p.address_id
         FROM pr_product p, suscripc s, servsusc ss
        where product_id = sesunuse
          and susccodi = sesususc
          and p.product_id = inuProductId;


  BEGIN
    open cuAddress;
      fetch cuAddress into nuSuscription, nuSubscriber, nuAddressId;
      if cuAddress%notfound then
        nuSuscription := 0;
      end if;
      close cuAddress;

    if nuSuscription != 0 then
      or_boorderactivities.CreateActivity(inuActivity, -- inuItemsId
                                          null, --inuPackageId
                                          null, --inuMotiveId
                                          null, --inuComponentId
                                          null, --inuInstanceId
                                          nuAddressId, --inuAddressId
                                          null, --inuElementId
                                          nuSubscriber, --inuSubscriberId
                                          nuSuscription, --inuSubscriptionId
                                          inuProductId, --inuProductId
                                          null, --inuOperSectorId
                                          null, --inuOperUnitId
                                          null, --idtExecEstimDate
                                          null, --inuProcessId
                                          isbComment, --isbComment
                                          null, --iblProcessOrder
                                          null, --inuPriorityId
                                          nuOrderId, --ionuOrderId
                                          nuOrderActivityId, --ionuOrderActivityId
                                          null, --inuOrderTemplateId
                                          null, --isbCompensate
                                          null, --inuConsecutive
                                          null, --inuRouteId
                                          null, --inuRouteConsecutive
                                          null, --inuLegalizeTryTimes
                                          null, --isbTagName
                                          null, --iblIsActToGroup
                                          null, --inuRefValue
                                          null --inuActionId
                                          );
      rcOrder := Daor_Order.Frcgetrecord(nuOrderId);
      -- actualiza sector y fechas basicas de la orden
      OR_boProcessOrder.updBasicData(rcOrder,
                                     rcOrder.operating_sector_id,
                                     null);
   end if;
  EXCEPTION
   /* when ex.CONTROLLED_ERROR then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
   */
    when others then
    /*  Errors.setError;
      raise ex.CONTROLLED_ERROR;
    */
    dbms_output.put_line('error: ' || sqlerrm );
  end prCreOrdenesporTrFnb;
----------------------------------------------------------------------------------------------------
PROCEDURE prLegOrdenesporTrFnb (inuorden  or_order.order_id%type,
                                sbobse    varchar2) IS  -- 'POR TRASLADO A '

    nuError    number;
    sbMessage  varchar2(2000);
    nuUnitOper number;
    nuCausal   number;
    rcOrder    daor_order.styor_order;

  BEGIN

     nuUnitOper := to_number(DALD_PARAMETER.fnuGetNumeric_Value('TRANSFER_QUOTA_AUTHORIZA'));
     nuCausal := to_number(DALD_PARAMETER.fnuGetNumeric_Value('COD_OT_CUMPLIDA'));

     -- COD_UNIT_ADM_FNB


    /*Se asigna la orden a la unidad operativa administrativa FNB*/

    rcOrder := Daor_Order.Frcgetrecord(inuorden);

    if rcOrder.order_status_id = 0 then

      OR_boProcessOrder.updBasicData(rcOrder,
                                     rcOrder.operating_sector_id,
                                     null);

      or_boprocessorder.assign(rcOrder,
                               nuUnitOper,
                               sysdate, --dtArrangedHour,
                               false, --true,
                               TRUE);

      if nuUnitOper is null then

        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                         'La unidad operativa no permite asignar' ||
                                         nuUnitOper || ' ' || inuorden);
      end if;
    end if;

    /* Se legaliza la orden */
    os_legalizeorderallactivities(inuorden,
                                  nucausal, --or_boconstants.cnuSuccesCausal,
                                  LD_BOUtilFlow.fnuGetPersonToLegal(nuUnitOper), --ge_bopersonal.fnugetpersonid,
                                  sysdate,
                                  sysdate,
                                  sbobse,
                                  null,
                                  nuError,
                                  sbMessage);

    if (nuError <> 0) then
      gw_boerrors.checkerror(nuError, sbMessage);

    end if;

  EXCEPTION
   /* when ex.CONTROLLED_ERROR then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
   */
    when others then
    /*  Errors.setError;
      raise ex.CONTROLLED_ERROR;
    */
    dbms_output.put_line('error: ' || sqlerrm );
  end prLegOrdenesporTrFnb;

----------------------------------------------------------------------------------------------------
PROCEDURE prTrasladoSeguros  IS

    nuError      number;
    sbMessage    varchar2(2000);
    nuUnitOper   number;
    nuCausal     number;
    rcOrder      daor_order.styor_order;
    nucant       number;
    nuwidx  number;
      nuwpoli number;
      nuwdfan number;
      nuwdfnu  number;
    ----------------

    inususcori  ge_boInstanceControl.stysbValue;
    inunuseori  ge_boInstanceControl.stysbValue;
    inususcdes  ge_boInstanceControl.stysbValue;
    inunusedes   ge_boInstanceControl.stysbValue;


   ----------------

    nudifecodi   diferido.difecodi%type;
    nudifecofi   diferido.difecofi%type;
    nudifenucu   diferido.difenucu%type;
    sbdifenudo   diferido.difenudo%type;
    sbmodidoso   movidife.modidoso%type;
    procesado    varchar2(1);

    sbProg       varchar2(4) := 'FTCS';
    sbUser       varchar2(200);
    sbTerm       varchar2(200);
    nuPerson     number;
    nuCausTras   number      :=  dald_parameter.fnuGetNumeric_Value('CAUSCAR_TRANSF_CARTERA');
    nuCausCanc   number      :=  dald_parameter.fnuGetNumeric_Value('CAUSCAR_CANC_DIFERIDO');
    nuccante     cuencobr.cucocodi%type;
    nuRegs       number;
    nuFeesInvoiced number;
    nuFeesPaid    number;
    nuSeqPolicyTr number;
    nudifepoliza  diferido.difecodi%type;

    nuErrorCode      NUMBER;
    sbErrorMessage   VARCHAR2(4000);
    sbLineLog        varchar2(1000) :=null;

    cursor cuProductos (nuprodori servsusc.sesunuse%type, nuproddes servsusc.sesunuse%type) is
      select count(1)
        from servsusc
       where sesunuse in (nuprodori, nuproddes)
         and sesuserv =7053;

    cursor cuDiferidos is
     select *
       from diferido
      where difenuse=inunuseori
        and difesape > 0;

    cursor cuCuentas is
     select cucocodi,cucovato,cucovaab,cucosacu,cucofeve
       from cuencobr
      where cuconuse=inunuseori
        and cucosacu > 0
      order by cucocodi;

    cursor cuPolizas is
     select p.policy_id, p.deferred_policy_id, fnuPolizaPend(inunuseori,p.deferred_policy_id) saldoen
      from ld_policy  p , diferido d
     where p.product_id = inunuseori
       and p.deferred_policy_id = d.difecodi
       and p.state_policy in (1,5);

    cursor cupoliza (nupoliza ld_policy.policy_id%type) is
     select *
      from ld_policy
     where policy_id=nupoliza;

    rgp ld_policy%rowtype;

  cursor cuCargos (nucuco cuencobr.cucocodi%type) is
   select cargcuco,cargconc,sum(decode(cargsign,'DB',cargvalo,-cargvalo)) cargvalo
     from cargos
    where cargcuco=nucuco
      and cargsign not in ('PA','SA','AS')
  group by cargcuco,cargconc;

  BEGIN
      /*obtener los valores ingresados en la aplicacion PB */
    inususcori := ge_boInstanceControl.fsbGetFieldValue('SUSCRIPC','SUSCCODI');

    inunuseori := ge_boInstanceControl.fsbGetFieldValue('SERVSUSC', 'SESUNUSE');

    inususcdes := ge_boInstanceControl.fsbGetFieldValue('SERVSUSC', 'SESUSUSC');

    inunusedes := ge_boInstanceControl.fsbGetFieldValue('CONSSESU', 'COSSSESU');

    procesado := 'N';

    -- valida que los productos sean de seguro brilla
    open cuProductos (inunuseori, inunusedes);
    fetch cuProductos into nucant;
    if cuProductos%notfound then
      nucant := 0;
    end if;
    close cuProductos;

    if nvl(nucant,0) != 2 then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Al menos uno de los productos no es de Seguros Brilla');
      return;
    end if;

    -- guarda en tabla en memoria los diferidos de las polizas activas o renovadas con saldo
    tdife.delete;
    for rg in cuPolizas loop
      if rg.saldoen in ('D','C') then
       sbidxdif := rg.deferred_policy_id;
       tdife(sbidxdif).poli := rg.policy_id;
       tdife(sbidxdif).dfan := rg.deferred_policy_id;
       tdife(sbidxdif).dfnu := null;
       tdife(sbidxdif).sden := rg.saldoen;
      end if;
    end loop;

    -- cancela diferidos en ori y crea en des
    for rg in cuDiferidos loop
      procesado := 'S';
      -- Obtiene proximo numero de diferido y de financiacion
      pkDeferredMgr.GetNewDefNumber(nudifecodi);
      pkDeferredMgr.nuGetNextFincCode(nudifecofi);

      nudifenucu := rg.difenucu - rg.difecupa;
      sbdifenudo := 'TC'||rg.difecodi;


      -- Obtiene usuario funcionario y terminal
      sbUser       := pkGeneralServices.fsbGetUserName;
      sbTerm       := pkGeneralServices.fsbGetTerminal;
     -- nuPerson     := GE_BOPersonal.fnuGetPersonId;

      select funccodi into nuPerson from FUNCIONA where funcusba=sbUser;


      sbmodidoso := 'DF-'||nudifecodi;
      -- crea nuevo diferido en contrato destino
      insert into diferido (difecodi,    difesusc,     difeconc,    difevatd,    difevacu,
                            difecupa,    difenucu,     difesape,    difenudo,    difeinte,
                            difeinac,    difeusua,     difeterm,    difesign,    difenuse,
                            difemeca,    difecoin,     difeprog,    difepldi,    difefein,
                            difefumo,    difespre,     difetain,    difefagr,    difecofi,
                            difetire,    difefunc,     difelure,    difeenre)
                    values (nudifecodi,  inususcdes,   rg.difeconc, rg.difesape, rg.difevacu,
                            0,           nudifenucu,   rg.difesape, sbdifenudo,  rg.difeinte,
                            rg.difeinac, sbUser,       sbTerm,      rg.difesign, inunusedes,
                            rg.difemeca, rg.difecoin,  sbProg,      rg.difepldi, sysdate,
                            sysdate,     rg.difespre,  rg.difetain, rg.difefagr, nudifecofi,
                            rg.difetire, nuPerson,     rg.difelure, rg.difeenre);

      insert into movidife (modidife,   modisusc,    modisign,   modifech,   modifeca,
                            modicuap,   modivacu,    modidoso,   modicaca,   modiusua,
                            moditerm,   modiprog,    modinuse,   modidiin,   modipoin,
                            modivain,   modicodo)
                    values (nudifecodi, inususcdes, 'DB',        sysdate,    sysdate,
                            0,          rg.difesape, sbmodidoso, nuCausTras, sbUser,
                            sbTerm,     sbProg,      inunusedes, 0,          0,
                            0,          null);

       -- cancela diferido en contrato anterior
       update diferido
          set difecupa = rg.difenucu,
              difesape = 0,
              difefumo = sysdate
        where difecodi = rg.difecodi;

        sbmodidoso := 'Ca-'||rg.difecodi;
        insert into movidife (modidife,   modisusc,    modisign,   modifech,   modifeca,
                            modicuap,     modivacu,    modidoso,   modicaca,   modiusua,
                            moditerm,     modiprog,    modinuse,   modidiin,   modipoin,
                            modivain,     modicodo)
                    values (rg.difecodi,  inususcori,  'CR',        sysdate,    sysdate,
                            rg.difenucu,  rg.difesape, sbmodidoso, nuCausCanc, sbUser,
                            sbTerm,     sbProg,      inunuseori, 0,          0,
                            0,          null);

       -- guarda el nuevo diferido de la poliza
       sbidxdif := rg.difecodi;
       if tdife.exists(sbidxdif) then
         tdife(sbidxdif).dfnu := nudifecodi;
       end if;

    end loop;

    -- cancela cuentas con saldo en ori y crea en des
    FOR rg in cucuentas LOOP
     procesado := 'S';
     tcargo.delete;
     tpagos.delete;
     -- si cta pagada parcialmente halla los pagos aplicados a cada concepto
     if rg.cucovaab != 0 then
       LDC_PKTRASFNB.detpagos(rg.cucocodi,rg.cucofeve);
     end if;
     nucuentaori := rg.cucocodi;
     for rgc in cucargos(rg.cucocodi) loop
      if rgc.cargvalo != 0 then
       nuindice := rgc.cargconc;
       tcargo(nuindice).cuco := rg.cucocodi;
       tcargo(nuindice).conc := rgc.cargconc;
       tcargo(nuindice).valo := rgc.cargvalo - GetPagoConcepto(rgc.cargconc);
      end if;
     end loop;

     if tcargo.count > 0 then
       nuTipo := 1;
       nuSuscripcion := inususcdes;
       nuServsusc    := inunusedes;
       Generate (nuErrorCode,sbErrorMessage);

       if nuErrorCode != 0 then
          sbLineLog := nuErrorCode || ' - ' || sbErrorMessage;
          rollback;
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, sbLineLog);
       else
         nuTipo := 2;
         nuSuscripcion := inususcori;
         nuServsusc    := inunuseori;
         nucuentades := nuCuenta;
         Generate (nuErrorCode,sbErrorMessage);

         if nuErrorCode != 0 then
            sbLineLog := nuErrorCode || ' - ' || sbErrorMessage;
            rollback;
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, sbLineLog);
         end if;
       end if;
     end if;
    END LOOP;

   -- crea poliza_trasl y actualiza ld_policy
    nuRegs   := tdife.count;
    sbidxdif := tdife.first;

   IF procesado = 'S' THEN
    FOR i IN 1 .. nuRegs LOOP
      nuFeesInvoiced := LD_BCSecureManagement.FnuGetFessInvoiced(tdife(sbidxdif).poli);
      nuFeesPaid     := LD_BCSecureManagement.FnuGetFessPaid(tdife(sbidxdif).poli);
      if tdife(sbidxdif).sden = 'D' then
        nudifepoliza := tdife(sbidxdif).dfnu;
      else
        nudifepoliza := tdife(sbidxdif).dfan;
      end if;

      open cupoliza(tdife(sbidxdif).poli);
      fetch cupoliza into rgp;
      close cupoliza;

      nuSeqPolicyTr := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('SEQ_LDC_POLICY_TRASL');

      insert into ldc_policy_trasl  VALUES
      (nuSeqPolicyTr,        rgp.policy_id,          rgp.state_policy,    rgp.launch_policy,
      rgp.contratist_code,   rgp.product_line_id,    rgp.dt_in_policy,    rgp.dt_en_policy,
      rgp.value_policy,      rgp.prem_policy ,       rgp.name_insured,    rgp.suscription_id,
      rgp.product_id,        rgp.identification_id,  rgp.period_policy,   rgp.year_policy,
      rgp.month_policy,      rgp.deferred_policy_id, rgp.dtcreate_policy, rgp.share_policy,
      rgp.dtret_policy,      rgp.valueacr_policy,    rgp.report_policy,   rgp.dt_report_policy,
      rgp.dt_insured_policy, rgp.per_report_policy,  rgp.policy_type_id,  rgp.id_report_policy,
      rgp.cancel_causal_id,  rgp.fees_to_return,
      'Poliza se traslado al Contrato ' || inususcdes || '. ' || rgp.comments,
      rgp.policy_exq,
      rgp.number_acta,       rgp.geograp_location_id, rgp.validity_policy_type_id,
      rgp.policy_number,     rgp.collective_number,   rgp.base_value,      rgp.porc_base_val,
      nuFeesInvoiced ,       nuFeesPaid);

      update ld_policy
         set suscription_id     = inususcdes,
             product_id         = inunusedes,
             deferred_policy_id = nudifepoliza,
             comments           = 'Poliza viene trasladada del Contrato ' || inususcori || '. ' || comments
       where policy_id = tdife(sbidxdif).poli;

      sbidxdif := tdife.next(sbidxdif);
    END LOOP;
   END IF;

   tcargo.delete;
   tdife.delete;

   commit;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      rollback;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

    when others then
      rollback;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;


  end prTrasladoSeguros;

--********************************************************************************************


PROCEDURE DetPagos (nucuco in cuencobr.cucocodi%type,
                    dtfeve in cuencobr.cucofeve%type) IS

 cursor cuCargos is
  select cargcodo
     from open.cargos
    where cargcuco=nucuco
      and cargsign = 'PA';

cursor cuPagos (nucupo resureca.rerecupo%type) is
select rereconc, sum(rerevalo) rerevalo
  from open.resureca
 where rerecupo=nucupo
   and rerefeve=dtfeve
 group by rereconc;

BEGIN
 for rg in cuCargos loop
   for rgp in cuPagos(rg.cargcodo) loop
     nuindiceP := rgp.rereconc;
     if tPagos.exists(nuindiceP) then
       tPagos(nuindiceP).valo := tPagos(nuindiceP).valo + nvl(rgp.rerevalo,0);
     else
       tPagos(nuindiceP).conc := rgp.rereconc;
       tPagos(nuindiceP).valo := nvl(rgp.rerevalo,0);
     end if;
   end loop;
 end loop;

EXCEPTION
    when LOGIN_DENIED then
  pkErrors.Pop;
  raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
  pkErrors.Pop;
  raise pkConstante.exERROR_LEVEL2;

    when others then
  pkErrors.NotifyError ( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
  pkErrors.Pop;
  raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );

--}
END DetPagos;

--********************************************************************************************


FUNCTION GetPagoConcepto (nuconc in cargos.cargconc%type) return number IS

BEGIN
  if tPagos.exists(nuconc) then
    return(tPagos(nuconc).valo);
  else
    return (0);
  end if;
EXCEPTION WHEN OTHERS THEN
    return (0);
END GetPagoConcepto;

--********************************************************************************************


FUNCTION fnuPolizaPend(inunuse diferido.difenuse%type, inudife diferido.difecodi%type) return varchar2 IS

sbdaldoen varchar2(1);
nudife    number;
nucuco    number;

cursor cudiferido is
 select count(1)
   from diferido
  where difecodi=inudife
    and difesape>0;

cursor cucuentas is
select count(1)
  from cuencobr , cargos
  where cucocodi=Cargcuco
    and cuconuse= inunuse
    and cucosacu>0
    and cargdoso like 'DF-'||inudife
    and cargsign='DB'
    and cargprog=5;

BEGIN
  open cudiferido;
  fetch cudiferido into nudife;
  if cudiferido%notfound then
    nudife := 0;
  end if;
  close cudiferido;

  if nvl(nudife,0) > 0 then
    sbdaldoen := 'D';
  else
    open cucuentas;
    fetch cucuentas into nucuco;
    if cucuentas%notfound then
      nucuco := 0;
    end if;
    close cucuentas;
    if nvl(nucuco,0) > 0 then
      sbdaldoen := 'C';
    else
      sbdaldoen := 'N';
    end if;
  end if;
  return sbdaldoen;
EXCEPTION WHEN OTHERS THEN
    return ('N');
END fnuPolizaPend;

--********************************************************************************************

PROCEDURE Generate
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Generate
    Descripcion    : Procedimiento que genera todo el proceso para cada producto leido
                     en el archivo plano
    Autor          : F.Castro
    Fecha          : 02/04/2016 ERS 200-206

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================

    ******************************************************************/
  (onuErrorCode out number, osbErrorMessage out varchar2) IS

    nures       number;
    sbError     varchar2(2000);
    onuSaldoFac cargos.cargvalo%type;

    /* ***************************************************************** */
    /* ********           Procedimientos Encapsulados           ******** */
    /* ***************************************************************** */

    /*
        Procedure  :  ClearMemory
      Descripcion  :  Limpia memoria cache
                        Clear Memory
    */

    PROCEDURE ClearMemory IS

    BEGIN
      --{
      pkErrors.Push('pkGenerateInvoice.ClearMemory');

      -- Limpia la memoria cache que usa el package

      pktblParafact.ClearMemory;
      pktblSistema.ClearMemory;
      pktblConsecut.ClearMemory;
      pktblCuencobr.ClearMemory;
      pktblFactura.ClearMemory;
      pktblSuscripc.ClearMemory;
      pktblServsusc.ClearMemory;
      pktblConcepto.ClearMemory;
      pktblParametr.ClearMemory;
      pktblMensaje.ClearMemory;
      pktblPerifact.ClearMemory;

      pkErrors.Pop;
      --}
    END ClearMemory;

    /* -------------------------------------------------------------- */

    /*
        Procedure  :  Initialize
        Descripcion  :  Inicializa variables del package
                        Initialize
    */

    PROCEDURE Initialize IS
    BEGIN
      --{
      pkErrors.Push('pkGenerateInvoice.Initialize');

      -- Fija la Aplicacion en una variable global del paquete
      sbApplication := csbPROGRAMA;
      pkErrors.SetApplication(sbApplication);

      -- Fecha de Generacion de la Cuenta
      dtFechaGene := sysdate;

      dtFechaCurrent := sysdate;
      sbTerminal     := pkGeneralServices.fsbGetTerminal;

      -- Asigna el Cupon de Pago
      -----  gnuCouponPayment := inuCouponPayment;

      -- Fecha Contable
      dtFechaContable := pkGeneralServices.fdtGetSystemDate;

      -- Clase de Documento que entra como parametro
      gnuTipoDocumento := nuTipDocNumFiscal; -- tipo de documento de Notas Debito

      -- Inicializa Codigos de Documentos
      nuEstadoCuenta := NULL;
      nuCuenta       := NULL;

      -- Inicializa Saldo Pendiente de la Factura
      nuSaldoFac := NULL;

      -- Valores Facturados en la Cuenta de Cobro
      nuVlrFactCta    := 0;
      nuVlrIvaFactCta := 0;

      -- Valores facturados en el Estado de Cuenta
      nuVlrFactFac    := 0;
      nuVlrIvaFactFac := 0;

      -- Inicializa tabla de memoria de parametros
      pkBillFuncParameters.InitMemTable;

      -- Habilita manejo de cache para parametros
      pkGrlParamExtendedMgr.SetCacheOn;

      -- Inicializa parametros de salida
      nuSaldoFac := NULL;

      -- Por defecto no se ha generado Estado de Cuenta ni Cuenta de Cobro

      boAccountStGenerado := FALSE;
      boCuentaGenerada    := FALSE;

      -- Inicializa variables de Error
      pkErrors.GetErrorVar(onuErrorCode,
                           osbErrorMessage,
                           pkConstante.INITIALIZE);

      -- Obtiene el record de la suscripcion
      rcSuscCurr := pktblSuscripc.frcGetRecord(nuSuscripcion);

      -- Obtiene record de periodo de facturacion current
      rcPeriFactCurr := pkBillingPeriodMgr.frcGetAccCurrentPeriod(rcSuscCurr.susccicl);

      pkErrors.Pop;
      --}
    END Initialize;

    /* ***************************************************************** */

  BEGIN
    --{
    pkErrors.Push('pkGenerateInvoice.Generate');

    -- Savepoint del proceso principal
    savepoint svGenerate;

    -- Inicializa variables
    Initialize;

    -- Limpia memoria
    ClearMemory;

    /*sbProgram       :=  'LDC_ANDM';*/

    -- Valida los parametros necesarios para el proceso
    ---------------------------------------------------------- GetParameters;

    -- Valida los datos de entrada
    nuRes := ValInputData(sbError);

    -- Ejecuta el proceso de generacion de Factura
    GenProcess;

    -- Asigna saldo de la Factura
    onuSaldoFac := nuSaldoFac;

    /*COMMIT;*/

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
      --   PK_FC_GRABALOG.pro_fc_grabalog('PRUNOTAS','GENERATE: ' || SQLERRM);
      -- Error de Aplicacion
      pkErrors.Pop;
      pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);
      rollback to savepoint svGenerate;

    when others then
      --  PK_FC_GRABALOG.pro_fc_grabalog('PRUNOTAS','GENERATE: ' || SQLERRM);
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);
      rollback to savepoint svGenerate;
      --}
  END Generate;

  --********************************************************************************************

  PROCEDURE GenProcess

   IS

  BEGIN
    --{
    pkErrors.Push('pkGenerateInvoice.GenProcess');

    -- Inicializa las tablas de memoria en el actualiza cartera,
    -- destruye el cache
    pkUpdAccoReceiv.ClearMemTables;

    -- Por defecto, no se ha generado estado de cuenta
    boAccountStGenerado := FALSE;

    -- Elimina tabla de hash para que sea borrada por cada suscripcion
    pkExtendedHash.SetInitVar(TRUE);

    -- Procesa los servicios suscritos
    ProcessSubsServices;

    -- Aqui se realiza la numeracion fiscal
    if (boAccountStGenerado) then
      AsignaNumeracionFiscal;
    END if;

    pkErrors.Pop;
  EXCEPTION
    when LOGIN_DENIED then
      --    PK_FC_GRABALOG.pro_fc_grabalog('PRUNOTAS','GENPROCESS: ' || SQLERRM);
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      --   PK_FC_GRABALOG.pro_fc_grabalog('PRUNOTAS','GENPROCESS: ' || SQLERRM);
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      --  PK_FC_GRABALOG.pro_fc_grabalog('PRUNOTAS','GENPROCESS: ' || SQLERRM);
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);

    --}
  END GenProcess;

  --*****************************************************************************************

  PROCEDURE ProcessSubsServices is

    nuRegs   number;
    nuccobse cuencobr.cucocodi%type;

  BEGIN
    --{

    pkErrors.Push('pkGenerateInvoice.ProcessSubsServices');

    -- Busca informacion del servicio suscrito
    rcSeSuCurr := pktblServsusc.frcGetRecord(nuServsusc);

    nuDepa := nvl(pkBCSubscription.fnuGetContractState(rcSuscCurr.susccodi),
                  pkConstante.NULLNUM);
    nuLoca := nvl(pkBCSubscription.fnuGetContractTown(rcSuscCurr.susccodi),
                  pkConstante.NULLNUM);

    -- Liquida el impuesto de cargos a la -1
    -------------- pkBOLiquidateTax.LiqTaxValue(rcSeSuCurr,rcPeriFactCurr,isbDocumento);

  if nuTipo = 1 then
    nuccobse := nucuentaori;
    -- Genera Estado de cuenta y Cuenta
    if (not (boAccountStGenerado)) then
      GenerateAccountStatus;
    end if;

    -- Genera cuenta si no se ha generado antes
    if (not (boCuentaGenerada)) then
      GenerateAccount;
    end if;
  else
    nuccobse := nucuentades;
    nuCuenta := nucuentaori;
  end if;

    -- recorre tabla con los productos y conceptos a procesar
    nuRegs   := tcargo.count;
    nuindice := tcargo.first;

    FOR i IN 1 .. nuRegs LOOP

      -- asigna a las variables de paquete
      nuConcepto    := tcargo(nuindice).conc;
      nuCausal      := 23;
      nuValor       := abs(tcargo(nuindice).valo);
      if tcargo(nuindice).valo > 0 then
        if nuTipo = 1 then
         sbSigno := 'DB';
        else
          sbSigno := 'CR';
        end if;
      else
        if nuTipo = 1 then
         sbSigno := 'CR';
        else
          sbSigno := 'DB';
        end if;
      end if;

      -- Se crea la Nota DB
      GenerateBillingNote;


        -- Actualiza el cargdoso del cargo credito con el numero del diferido
      update cargos
         set cargdoso = 'TC-CC'||nuccobse
       where cargcuco=nuCuenta
         and cargconc=nuconcepto
         and cargsign=sbSigno
         and cargvalo=nuValor
         and trunc(cargfecr) = trunc(sysdate);


      nuindice := tcargo.next(nuindice);

    END LOOP;

    -- Procesa los cargos del servicio suscrito
    ProcessCharges; --  (isbDocumento, iblAllCharges);


    -- Verifica si se genero nueva cuenta

    /*if (boCuentaGenerada) then
      --{
      -- Actualiza cartera
      UpdateAccoRec;


      -- Procesa la cuenta generada
      ProcessGeneratedAcco;

      --}
    end if;*/

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
      --}
  END ProcessSubsServices;

--********************************************************************************************


PROCEDURE AddCharge

  (    inuConcepto  in  cargos.cargconc%type,
       isbSigno    in  cargos.cargsign%type,
       isbDocSop  in  cargos.cargdoso%type,
       inuCausal  in  cargos.cargcaca%type,
       inuVlrCargo in cargos.cargvalo%type,
       inuConsDocu in  cargos.cargcodo%type,
       isbTipoProc  in  cargos.cargtipr%type
  )


  IS
    BEGIN
    --{

  pkErrors.Push('pkGenerateInvoice.AddCharge');

  -- Adiciona el Cargo
  GenerateCharge
      (
       inuConcepto,
       isbSigno,
       isbDocSop,
       inuCausal,
       inuVlrCargo,
       inuConsDocu,
       isbTipoProc
      );

  -- Actualiza cartera
  pkUpdAccoReceiv.UpdAccoRec
      (
    pkBillConst.cnuSUMA_CARGO,
    nuCuenta,
    rcSuscCurr.susccodi,
    rcSeSuCurr.sesunuse,
    inuConcepto,
    isbSigno,
    abs(inuVlrCargo),
    pkBillConst.cnuNO_UPDATE_DB
      );

  UpdateAccoRec ;

  -- Actualiza el acumulado de los valores facturados

  if (isbSigno = pkBillConst.DEBITO) then
  --{

      -- Cargo debito
      nuVlrFactCta    := nuVlrFactCta + abs(inuVlrCargo) ;
      nuVlrFactFac    := nuVlrFactFac + abs(inuVlrCargo) ;

  --}
  else
  --{
      -- Cargo credito
      nuVlrFactCta    := nuVlrFactCta - abs(inuVlrCargo) ;
      nuVlrFactFac    := nuVlrFactFac - abs(inuVlrCargo) ;
  --}
  end if;

  pkErrors.Pop;

    EXCEPTION
         when LOGIN_DENIED then
          pkErrors.Pop;
          raise LOGIN_DENIED;

         when pkConstante.exERROR_LEVEL2 then
          pkErrors.Pop;
          raise pkConstante.exERROR_LEVEL2;

      when others then
          pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
          pkErrors.Pop;
          raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    --}
    END AddCharge;


--********************************************************************************************

PROCEDURE GenerateCharge
   (   inuConcepto  in  cargos.cargconc%type,
       isbSigno    in  cargos.cargsign%type,
       isbDocSop  in  cargos.cargdoso%type,
       inuCausal  in  cargos.cargcaca%type,
       inuVlrCargo in cargos.cargvalo%type,
       inuConsDocu in  cargos.cargcodo%type,
       isbTipoProc  in  cargos.cargtipr%type
  )
  IS

    -- Record del cargo
    rcCargo  cargos%rowtype ;

    ------------------------------------------------------------------------
    -- Procedimientos Encapsulados
    ------------------------------------------------------------------------

    PROCEDURE FillRecord IS

      rcCargoNull  cargos%rowtype;

    BEGIN
    --{

  pkErrors.Push ('pkGenerateInvoice.GenChrg.FillRecord');

    rcCargo := rcCargoNull ;

  rcCargo.cargcuco := nuCuenta;
  rcCargo.cargnuse := rcSeSuCurr.sesunuse ;
  rcCargo.cargpefa := rcPerifactCurr.pefacodi ;
  rcCargo.cargconc := inuConcepto ;
  rcCargo.cargcaca := inuCausal;
  rcCargo.cargsign := isbSigno ;
  rcCargo.cargvalo := inuVlrCargo ;
  rcCargo.cargdoso := isbDocSop; -- isbDocumento ;  DEBE SER DF-NRODIFERIDO o ND-NRONOTA?
  rcCargo.cargtipr := isbTipoProc; -- pkBillConst.AUTOMATICO;
  rcCargo.cargfecr := dtFechaCurrent ;
  rcCargo.cargcodo := inuConsDocu; --  DEBE SER  numero de la nota
  rcCargo.cargunid := null ;
  rcCargo.cargcoll := null ;
  rcCargo.cargprog := nuPrograma; -- 2014 = AJUSTES DE FACTURACION --   ge_bcProcesos.frcprograma(sbApplication).proccons;
  rcCargo.cargusua := sa_bosystem.getSystemUserID ;

  pkErrors.Pop;

    EXCEPTION
        when LOGIN_DENIED OR ex.CONTROLLED_ERROR then
            pkErrors.Pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise pkConstante.exERROR_LEVEL2;

        when OTHERS then
        	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        	pkErrors.Pop;
        	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    --}
    END FillRecord ;

    ------------------------------------------------------------------------

BEGIN
--{

    pkErrors.Push ('pkGenerateInvoice.GenerateCharge');

    -- Prepara record del Cargo
    FillRecord ;

    -- Adiciona el Cargo
    pktblCargos.InsRecord (rcCargo);

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED OR ex.CONTROLLED_ERROR then
        pkErrors.Pop;
        raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;

    when OTHERS then
        	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        	pkErrors.Pop;
        	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
--}
END GenerateCharge;

--********************************************************************************************

PROCEDURE ProcessCharges
    /*(
    	isbDocumento	in	 cargos.cargdoso%type,
    	iblAllCharges   in   boolean
    )*/
    IS
    -- Tabla de cargos a liquidar
    tbCargos                tytbCargos;
    rcCargos                tyrcCargos;
    tbMaxPericoseConcepto   tytbMaxPericoseConcepto;

    nuIdxCargos  number;

    -- Registro del servicio
    rcServicio      servicio%rowtype;

    -- Fecha de retiro del producto
    dtFechRetProd   servsusc.sesufere%type;



    -- Definicion del cursor para la seleccion de todos los cargos de
    -- la cuenta generada
    CURSOR cuAllCargos (inuNumServ	servsusc.sesunuse%type)
    IS
    SELECT --+ index (cargos ix_carg_nuse_cuco_conc) -- pkGenerateInvoice.ProcessCharges
           rowid, cargconc, cargcaca, cargsign,
	   cargdoso, cargvalo, cargfecr,cargnuse, cargpeco
    FROM   cargos
    WHERE  cargcuco+0 = nuCuenta
    AND    cargnuse = inuNumServ;

    -- Indice arreglos de cargos procesados
    nuIdx	number;

    -----------------------------------------------------------------------
    -- PROCEDIMIENTOS ENCAPSULADOS
    -----------------------------------------------------------------------
    PROCEDURE CleanChargeArrays IS
    BEGIN
    --{

	pkErrors.Push ('pkGenerateInvoice.CleanChargeArrays');

	tbCargfact.DELETE;
	tbCargcuco.DELETE;
	tbCargfeco.DELETE;
	tbCargdate.DELETE;
	tbCargtipr.DELETE;
	tbRowid.DELETE;
	tbCargos.DELETE;
	tbMaxPericoseConcepto.DELETE;

	pkErrors.Pop;

    --}
    END CleanChargeArrays;

    -- Procedimiento para inicialiar datos del proceso.
    PROCEDURE Initialize IS
    BEGIN
        -- Obtiene el tipo de producto que se est? liquidando para
        -- realizar obtenci?n del periodo de consumo de acuerdo
        -- al tipo de cobro (anticipado o vencido)
        rcServicio := pktblservicio.frcGetRecord(rcSeSuCurr.sesuserv);

		-- Se obtiene fecha de retiro del producto
		dtFechRetProd := pktblServsusc.fdtGetRetireDate( rcSeSuCurr.sesunuse );
    END Initialize;



    PROCEDURE CalcularFechaUltLiqConcepto
    (
       inuConcepto concepto.conccodi%type,
       inuCargPeco cargos.cargpeco%type
    )
    IS
        -- Fecha ?ltima liquidaci?n
        dtFechaUltLiq   feullico.felifeul%type  := null;

        -- Tipo de cobro generado por el concepto
        sbTipoCobro     concepto.concticc%type;

        -- Datos del proceso
        nuPeriodoConsumoActual pericose.pecscons%type;

        rcPeriodoConsumoActual pericose%rowtype;

        rcPeriodoConsumoCargo  pericose%rowtype;
    BEGIN
        if tbMaxPericoseConcepto.EXISTS(inuConcepto) then
           -- Si el periodo de consumo del cargo es nulo, se respeta el
           -- que se exite en la colecci?n.
           if inuCargPeco IS null then
             return;
           END if;

           sbTipoCobro := tbMaxPericoseConcepto(inuConcepto).sbTipoCobro;
           rcPeriodoConsumoActual := tbMaxPericoseConcepto(inuConcepto).rcPeriodoConsumo;
        else
            -- Se obtiene el tipo de cobro del concepto
        	sbTipoCobro := pktblConcepto.fsbObtTipoCobro( inuConcepto );

            -- Obtiene el periodo de consumo current
        	pkBCPericose.GetCacheConsPerByBillPer
    		(
    		    rcSeSuCurr.sesucico,
    		    rcPerifactCurr.pefacodi,
    		    nuPeriodoConsumoActual,
    		    rcservicio.servtico, -- Tipo Cobro del Servicio (Anticipado/Vencido)
                sbTipoCobro          -- Tipo Cobro del Concepto (Consumo/Abono)
    		);

            -- Se obtiene el registro del periodo de consumo
    		rcPeriodoConsumoActual := pktblPericose.frcGetRecord (nuPeriodoConsumoActual);
        END if;

        -- Si periodo de consumo del cargo no es nulo, se debe comparar contra el
        -- actual. Debe quedar seteado como periodo actual el mas viejo.
        if inuCargPeco IS not null then
           rcPeriodoConsumoCargo := pktblPericose.frcGetRecord (inuCargPeco);

           -- Evaluar que perido de consumo es mayor, si el actual o del de cargo
           -- Se debe actualizar feullico con el mayor.
           -- Se evalua el tipo de cobro del concepto
           IF sbTipoCobro = 'C' THEN
                -- Concepto de tipo Consumo
                -- Si la fecha de consumo final del periodo del cargo es mayor a la
                -- del periodo actual, se cambia el periodo de consumo actual por
                -- el del cargo.
        		IF (rcPeriodoConsumoCargo.pecsfecf > rcPeriodoConsumoActual.pecsfecf)THEN
                    rcPeriodoConsumoActual := rcPeriodoConsumoCargo;
                END if;
           ELSE
                -- Concepto de tipo Consumo
                -- Si la fecha de cargo b?sico final del periodo del cargo es mayor a la
                -- del periodo actual, se cambia el periodo de consumo actual por
                -- el del cargo.
        		IF (rcPeriodoConsumoCargo.pecsfeaf > rcPeriodoConsumoActual.pecsfeaf)THEN
                    rcPeriodoConsumoActual := rcPeriodoConsumoCargo;
                END if;
           end if;
        END if;

        -- Se actualiza o inserta los datos a la colecci?n en memoria.
        tbMaxPericoseConcepto(inuConcepto).rcPeriodoConsumo := rcPeriodoConsumoActual;
        tbMaxPericoseConcepto(inuConcepto).sbTipoCobro := sbTipoCobro;

        -- Se debe verificar la fecha final del periodo actual, con la fecha
        -- de retiro del producto. Si la fecha de retiro es menor, se debe
        -- actualizar feullico con esta.

        -- Se evalua el tipo de cobro del concepto
        IF sbTipoCobro = 'C' THEN
            -- Concepto de tipo Consumo
            -- Si el producto se retiro en el periodo se establece esta
            -- fecha como la fecha de ?ltima liquidaci?n
    		IF ( dtFechRetProd < rcPeriodoConsumoActual.pecsfecf )THEN
                tbMaxPericoseConcepto(inuConcepto).dtFechaUltLiq := dtFechRetProd;
            ELSE
                -- de lo contrario se establece la fecha final del periodo
                tbMaxPericoseConcepto(inuConcepto).dtFechaUltLiq := rcPeriodoConsumoActual.pecsfecf;
            end if;
    	ELSE
            -- Concepto de tipo Abono
    		-- Si el producto se retiro en el periodo se establece esta fecha
    		-- como la fecha de ?ltima liquidaci?n
    		IF dtFechRetProd < rcPeriodoConsumoActual.pecsfeaf THEN
                tbMaxPericoseConcepto(inuConcepto).dtFechaUltLiq := dtFechRetProd;
            ELSE
                -- de lo contrario se establece la fecha final del periodo
                tbMaxPericoseConcepto(inuConcepto).dtFechaUltLiq := rcPeriodoConsumoActual.pecsfeaf;
            end if;
        end if;

        EXCEPTION
    	when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
    	    pkErrors.Pop;
    	    raise;

    	when others then
    	    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    	    pkErrors.Pop;
    	    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    --}
    END CalcularFechaUltLiqConcepto;


    PROCEDURE ActFechaUltFactConceptos
    IS
        nuConcepto concepto.conccodi%type;
        -- Registro Fecha ultima liquidacion
        rcFeullico      feullico%rowtype;
    BEGIN
        ut_trace.trace('Actualizando ultima fecha facturaci?n conceptos.', 5);

        nuConcepto :=  tbMaxPericoseConcepto.first;

        loop
            EXIT WHEN ( nuConcepto IS NULL );

            ut_trace.trace('[Concepto] = '|| nuConcepto ||
            ' - [Fecha Ult Fact] = '|| tbMaxPericoseConcepto(nuConcepto).dtFechaUltLiq, 5);

            -- Arma registro fecha ultima Facturacion
            rcFeullico.felisesu := rcSeSuCurr.sesunuse;
            rcFeullico.feliconc := nuConcepto;
            rcFeullico.felifeul := tbMaxPericoseConcepto(nuConcepto).dtFechaUltLiq;

            -- Evalua si existe registro de fecha de ?ltima liquidaci?n
            if ( pktblFeullico.fblExist(rcSeSuCurr.sesunuse, nuConcepto) ) THEN
                -- Se actualiza registro
                pktblFeullico.UpRecord( rcFeullico );
            else
                -- Se inserta registro por ser la primera vez que se actualiza
                -- fecha de ?ltima liquidaci?n
                pktblFeullico.InsRecord( rcFeullico );
            end if;

            nuConcepto := tbMaxPericoseConcepto.NEXT(nuConcepto);
        END loop;
    END ActFechaUltFactConceptos;
    -----------------------------------------------------------------------
BEGIN
--{
    pkErrors.Push ('pkGenerateInvoice.ProcessCharges');


    -- Inicializa flag
    --boCuentaGenerada := FALSE;
    -- Inicializa valor facturado de la cuenta en cero
    nuVlrFactCta := 0;
    -- Inicializa valor impuesto facturado de la cuenta en cero
    nuVlrIvaFactCta := 0;

    nuIdx := 1;

    -- Limpia tablas de cargos
    CleanChargeArrays;

    -- Inicializa variables del proceso.
    Initialize;

    -- Verifica si se deben procesar todos los cargos o solo los asociados a
    -- al documento de soporte.
  --  if iblAllCharges then
        ut_trace.trace('Procesando todos los cargos asociados al producto: '||
        rcSeSuCurr.sesunuse, 5);
        OPEN cuAllCargos(rcSeSuCurr.sesunuse);
        FETCH cuAllCargos bulk collect INTO tbCargos;
        CLOSE cuAllCargos;
   /* else
        ut_trace.trace('Procesando los cargos asociados al documento: '||
        isbDocumento ||' y al producto '|| rcSeSuCurr.sesunuse, 5);
        OPEN cuCargos(rcSeSuCurr.sesunuse, isbDocumento);
        FETCH cuCargos bulk collect INTO tbCargos;
        CLOSE cuCargos;
    END if;*/

    if(tbCargos.count > 0)then
        -- Valida que el producto pertenezca al contrato
        ValSubsNServ(rcSuscCurr.susccodi,rcSeSuCurr.sesunuse);
    END if;

    ut_trace.trace('Periodo de facturacion actual: '|| rcPerifactCurr.pefacodi, 5);


    -- Recorrer tabla de cargos.
    nuIdxCargos :=  tbCargos.first;

    loop
       EXIT WHEN ( nuIdxCargos IS NULL );
            rcCargos := tbCargos(nuIdxCargos);

            ut_trace.trace('Procesando cargo: [Concepto]='|| rcCargos.cargconc ||
            ' - [Valor] = '|| rcCargos.cargvalo, 5);

        	-- Genera Estado de cuenta cuando se trata del primer servicio suscrito
        	/*if ( not (boAccountStGenerado)) then
        	    GenerateAccountStatus;
        	end if;

        	-- Genera cuenta si no se ha generado antes
        	if ( not (boCuentaGenerada)) then
        	   GenerateAccount;
        	end if;*/

        	-- Actualiza Cartera
        	pkUpdAccoReceiv.UpdAccoRec
    	    (
        		pkBillConst.cnuSUMA_CARGO,
        		nuCuenta,
        	  pktblservsusc.fnuGetSuscription(rcCargos.cargnuse),--	rcCargos.cargsusc,
        		rcCargos.cargnuse,
        		rcCargos.cargconc,
        		rcCargos.cargsign,
        		rcCargos.cargvalo,
        		pkBillConst.cnuNO_UPDATE_DB
    	    );


        	-- Almacena informacion del cargo procesado
        	tbCargfact (nuIdx) := nuEstadoCuenta;
        	tbCargcuco (nuIdx) := nuCuenta;
        	tbCargfeco (nuIdx) := dtFechaContable;
        	tbCargtipr (nuIdx) := pkBillConst.AUTOMATICO;

            /*Se asigna la fecha de generaci?n de la factura a la
            fecha de creaci?n del cargo*/
            ut_trace.trace('rcCargos.cargfecr'||rcCargos.cargfecr,5);
            ut_trace.trace('grcEstadoCta.factfege '||grcEstadoCta.factfege,5);

            IF (rcCargos.cargfecr > grcEstadoCta.factfege) THEN

                tbCargdate (nuIdx) := grcEstadoCta.factfege;

                ut_trace.trace('Actualiz? fecha con la fecha de generaci?n de factura '||grcEstadoCta.factfege,5);

            else
                tbCargdate (nuIdx) := rcCargos.cargfecr;

            END IF;

            tbRowid    (nuIdx) := rcCargos.sbrowid;

        	nuIdx := nuIdx + 1;

        	CalcularFechaUltLiqConcepto
            (
               rcCargos.cargconc,
               rcCargos.cargpeco
            );

            nuIdxCargos := tbCargos.NEXT(nuIdxCargos);
    END loop;

    -- Actualiza los Cargos
    if (nuIdx > 1) then
    	-- Actualiza el Cargo current
    	UpdateCharges;

    	-- Actualiza fecha de ultima facturaci?n del concepto.
    	ActFechaUltFactConceptos;
    end if;

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
    	pkErrors.Pop;
        /*IF (cuCargos%isOpen) THEN
           CLOSE cuCargos;
        END IF;*/
        IF (cuAllCargos%isOpen) THEN
           CLOSE cuAllCargos;
        END IF;
    	raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
    	pkErrors.Pop;
       /* IF (cuCargos%isOpen) THEN
           CLOSE cuCargos;
        END IF;*/
        IF (cuAllCargos%isOpen) THEN
           CLOSE cuAllCargos;
        END IF;
    	raise pkConstante.exERROR_LEVEL2;

    when others then
    	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    	pkErrors.Pop;
        /*IF (cuCargos%isOpen) THEN
           CLOSE cuCargos;
        END IF;*/
        IF (cuAllCargos%isOpen) THEN
           CLOSE cuAllCargos;
        END IF;
    	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
--}
END ProcessCharges;



--********************************************************************************************


PROCEDURE UpdateAccoRec IS
BEGIN
--{

    pkErrors.Push ('pkGenerateInvoice.UpdateAccoRec');

    -- Actualiza la cartera
    pkUpdAccoReceiv.UpdateData ;

    -- Obtiene valores de la cuenta de cobro
    pkUpdAccoReceiv.GetAccountData
	(
	    nuCuenta,
	    nuCart_ValorCta,
	    nuCart_AbonoCta,
	    nuCart_SaldoCta
	);

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
	pkErrors.Pop;
	raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
	pkErrors.Pop;
	raise pkConstante.exERROR_LEVEL2;

    when OTHERS then
	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
	pkErrors.Pop;
	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );

--}
END UpdateAccoRec;


--********************************************************************************************

PROCEDURE ProcessGeneratedAcco IS

    sbSignoAjuste	cargos.cargsign%type;	-- Signo del ajuste

BEGIN
--{

    pkErrors.Push ('pkGenerateInvoice.ProcessGeneratedAcco');

    -- Genera Ajuste de la cuenta
    AdjustAccount ;

    -- Genera posible saldo a favor
    pkAccountMgr.GenPositiveBal
	(
	    nuCuenta
	) ;

    -- Aplica saldo a favor
    pkAccountMgr.ApplyPositiveBalServ
	(
	    rcSeSuCurr.sesunuse,
	    nuCuenta,
	    pkBillConst.POST_FACTURACION,--pkBillConst.MANUAL,
	    dtFechaGene
	) ;

    -- Actualiza acumulados de facturacion por cuenta
    UpdAccoBillValues ;

    -- Obtiene saldo pendiente de la factura
    nuSaldoFac := pkBCAccountStatus.fnuGetBalance(nuEstadoCuenta);


    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
    	pkErrors.Pop;
    	raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
    	pkErrors.Pop;
    	raise pkConstante.exERROR_LEVEL2;

    when others then
    	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    	pkErrors.Pop;
    	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
--}
END ProcessGeneratedAcco;

--********************************************************************************************
PROCEDURE AsignaNumeracionFiscal
    IS

        ------------------------------------------------------------------------
        -- Variables
        ------------------------------------------------------------------------

        -- Tipo de comprobante
        nuTipoComprobante   tipocomp.ticocodi%type;

    BEGIN

        pkErrors.Push
        (
            'pkGenerateInvoice.AsignaNumeracionFiscal'
        );

     	-- Se asigna el tipo de documento
      	grcEstadoCta.factcons := gnuTipoDocumento;

        -- Se obtiene el n?mero fiscal
        pkConsecutiveMgr.GetFiscalNumber
        (
            pkConsecutiveMgr.gcsbTOKENFACTURA,
            grcEstadoCta.factcodi            ,
            null                             ,
            grcEstadoCta.factcons            ,
            rcSuscCurr.suscclie              ,
            rcSuscCurr.suscsist              ,
            grcEstadoCta.factnufi            ,
            grcEstadoCta.factpref            ,
            grcEstadoCta.factconf            ,
            nuTipoComprobante
        );

        -- Se actualiza la factura
        pktblFactura.UpFiscalNumber
        (
        	grcEstadoCta.factcodi,
        	grcEstadoCta.factnufi,
        	grcEstadoCta.factcons,
            grcEstadoCta.factconf,
            grcEstadoCta.factpref
        );

        -- Se limpia el registro global de factura
        grcEstadoCta := null;

        pkErrors.Pop;

    EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise LOGIN_DENIED;
        when OTHERS then
            pkErrors.NotifyError
            (
                pkErrors.fsbLastObject,
                sqlerrm               ,
                sbErrMsg
            );
            pkErrors.Pop;
            raise pkConstante.exERROR_LEVEL2;
    END AsignaNumeracionFiscal;
--********************************************************************************************

--********************************************************************************************


FUNCTION ValInputData
          (osbError out varchar2) return number IS
BEGIN
--{

    pkErrors.Push ('pkGenerateInvoice.ValInputData');

    -- Valida la suscripcion
    ValSubscriber (nuSuscripcion);

    -- Valida el servicio suscrito
    ValSubsService (nuServsusc);

    -- Valida que el producto pertenezca al contrato
    ValSubsNServ(nuSuscripcion,nuServsusc);

    -- Valida la fecha de generacion
    ValGenerationDate(dtFechaGene);

    return (1);

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
  pkErrors.Pop;
  raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
  pkErrors.Pop;
  raise pkConstante.exERROR_LEVEL2;

    when others then
  pkErrors.NotifyError ( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
  pkErrors.Pop;
  raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );

--}
END ValInputData;

--********************************************************************************************

PROCEDURE ValSubsService
    (
  inuServsusc  in  servsusc.sesunuse%type
    )
    IS

    ----------------------------------------------------------------------------
    -- VerifyProdProcessSecurity -- Valida estados del corte Producto
    ----------------------------------------------------------------------------
    PROCEDURE VerifyProdProcessSecurity
    (
        inuSesu    servsusc.sesunuse%type
    )
    IS
        sbProc   procrest.prreproc%type;
    BEGIN

        pkErrors.Push('pkAccountMgr.VerifyProdProcessSecurity');

        sbProc := pkErrors.fsbGetApplication;

        -- Se valida si el producto tiene restricci?n de pago por corte
        pkBOProcessSecurity.ValidateProductSecurity (
                                                           inuSesu,
                                                           sbProc
                                                       );
        pkErrors.Pop;

    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise pkConstante.exERROR_LEVEL2;

        when others then
            pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
            pkErrors.Pop;
            raise pkConstante.exERROR_LEVEL2;
    END VerifyProdProcessSecurity;

BEGIN
--{

    pkErrors.Push ('pkGenerateInvoice.ValSubsService');

    -- Realiza la validacion basica del servicio suscrito
    pkServNumberMgr.ValBasicData (inuServsusc);

    VerifyProdProcessSecurity (inuServsusc);

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
  pkErrors.Pop;
  raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
  pkErrors.Pop;
  raise pkConstante.exERROR_LEVEL2;

    when others then
  pkErrors.NotifyError ( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
  pkErrors.Pop;
  raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );

--}
END ValSubsService;
--********************************************************************************************

PROCEDURE ValSubscriber
    (
  inuSuscripcion  in  suscripc.susccodi%type
    )
    IS

BEGIN
--{

    pkErrors.Push ('pkGenerateInvoice.ValSubscriber');

    -- Realiza la validacion basica de la suscripcion
    pkSubscriberMgr.ValBasicData (inuSuscripcion);

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
  pkErrors.Pop;
  raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
  pkErrors.Pop;
  raise pkConstante.exERROR_LEVEL2;

    when others then
  pkErrors.NotifyError ( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
  pkErrors.Pop;
  raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );

--}
END ValSubscriber;


--********************************************************************************************

PROCEDURE ValSupportDoc
    (
  isbDocumento  in  cargos.cargdoso%type
    )
    IS

   -- Error en el documento soporte
    cnuERROR_DOCSOP  constant number := 11517;

BEGIN
--{

    pkErrors.Push ('pkGenerateInvoice.ValSupportDoc');

    if ( isbDocumento is null ) then

  pkErrors.SetErrorCode
      (
    pkConstante.csbDIVISION,
    pkConstante.csbMOD_BIL,
    cnuERROR_DOCSOP
      );

  raise LOGIN_DENIED;

    end if;

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
  pkErrors.Pop;
  raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
  pkErrors.Pop;
  raise pkConstante.exERROR_LEVEL2;

    when others then
  pkErrors.NotifyError ( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
  pkErrors.Pop;
  raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );

--}
END ValSupportDoc;

--********************************************************************************************
PROCEDURE ValSubsNServ
    (
  inuSubscription in suscripc.susccodi%type,
  inuServNum      in servsusc.sesunuse%type
    )
    IS


BEGIN
--{

    pkErrors.Push ('pkGenerateInvoice.ValSubsNServ');

    pkServNumberMgr.ValSubscription(inuSubscription,inuServNum);

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
  pkErrors.Pop;
  raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
  pkErrors.Pop;
  raise pkConstante.exERROR_LEVEL2;

    when others then
  pkErrors.NotifyError ( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
  pkErrors.Pop;
  raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );

--}
END ValSubsNServ;
--********************************************************************************************

FUNCTION ValContProdServ
    (
  inuSubscription in suscripc.susccodi%type,
  inuServNum      in servsusc.sesunuse%type,
  inuserv         in servsusc.sesuserv%type
    ) return number is

sbExiste varchar2(1);
nuRes    number(1);

cursor cuservsusc is
 select 'x'
   from servsusc
  where sesususc = inuSubscription
    and sesunuse = inuServNum
    and sesuserv = inuserv;

BEGIN
 open cuservsusc;
 fetch cuservsusc into sbExiste;
 if cuservsusc%notfound then
   nuRes := 1;
 else
   nuRes := 0;
 end if;
 close cuservsusc;

 return (nures);

EXCEPTION
    when others then
      return -1;
END ValContProdServ;


--********************************************************************************************

FUNCTION ValConcepto
    (
  inuConcepto concepto.conccodi%type
    ) return number is

sbExiste varchar2(1);
nuRes    number(1);

cursor cuConcepto is
 select 'x'
   from concepto
  where conccodi = inuConcepto;

BEGIN
 open cuConcepto;
 fetch cuConcepto into sbExiste;
 if cuConcepto%notfound then
   nuRes := 1;
 else
   nuRes := 0;
 end if;
 close cuConcepto;

 return (nures);

EXCEPTION
    when others then
      return -1;
END ValConcepto;


--********************************************************************************************

FUNCTION ValCausal
     (
  inuCausal causcarg.cacacodi%type
    ) return number is

sbExiste varchar2(1);
nuRes    number(1);

cursor cuCausal is
 select 'x'
   from causcarg
  where cacacodi = inuCausal;

BEGIN
 open cuCausal;
 fetch cuCausal into sbExiste;
 if cuCausal%notfound then
   nuRes := 1;
 else
   nuRes := 0;
 end if;
 close cuCausal;

 return (nures);

EXCEPTION
    when others then
      return -1;
END ValCausal;

--********************************************************************************************

FUNCTION ValPlanFina
     (
  inuPlan plandife.PLDICODI%type
    ) return number is

sbExiste varchar2(1);
nuRes    number(1);

cursor cuPlan is
 select 'x'
   from plandife
  where PLDICODI = inuPlan;

BEGIN
 open cuPlan;
 fetch cuPlan into sbExiste;
 if cuPlan%notfound then
   nuRes := 1;
 else
   nuRes := 0;
 end if;
 close cuPlan;

 return (nures);

EXCEPTION
    when others then
      return -1;
END ValPlanFina;
--********************************************************************************************

FUNCTION fboGetIsNumber
    (
  isbValor varchar2
    ) return boolean is

blResult boolean := TRUE;
nuRes    number;


BEGIN
 begin
   nuRes := to_number(isbValor);
 exception when others then
   blResult := FALSE;
 end;

 return (blResult);

EXCEPTION
    when others then
      return (FALSE);
END fboGetIsNumber;


--********************************************************************************************



PROCEDURE ValGenerationDate
    (
  idtFechaGene  in  date
    )
    IS

  -- Fecha fuera de rango de fechas de movimientos del periodo de
  -- facturacion current
    cnuDATE_OUT_OF_RANGE  constant number := 10116;

BEGIN

    pkErrors.Push('pkGenerateInvoice.ValGenerationDate');

    pkGeneralServices.ValDateY2K ( idtFechaGene );

    -- Valida que la fecha de generacion de cuentas se encuentre entre las
    -- fechas de movimientos del periodo
    if ( trunc(idtFechaGene) < trunc(rcPerifactCurr.pefafimo) or
   trunc(idtFechaGene) > trunc(rcPerifactCurr.pefaffmo) )
    then
  pkErrors.SetErrorCode ( pkConstante.csbDIVISION,
        pkConstante.csbMOD_BIL,
        cnuDATE_OUT_OF_RANGE );
  raise LOGIN_DENIED;
    end if;

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
  pkErrors.Pop;
  raise LOGIN_DENIED;
    when pkConstante.exERROR_LEVEL2 then
  pkErrors.Pop;
  raise pkConstante.exERROR_LEVEL2;
    when others then
  pkErrors.NotifyError ( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
  pkErrors.Pop;
  raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
END ValGenerationDate;



--********************************************************************************************


PROCEDURE GenerateAccount IS

BEGIN
--{

    pkErrors.Push ('pkGenerateInvoice.GenerateAccount');

    -- Define cuenta para el servicio suscrito
    nuCuenta := fnuGetAccountNumber ;

    AddAccount ;

    -- Se pudo generar la cuenta
    boCuentaGenerada := TRUE;

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
  pkErrors.Pop;
  boCuentaGenerada := FALSE;
  raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
  boCuentaGenerada := FALSE;
  pkErrors.Pop;
  raise pkConstante.exERROR_LEVEL2;

    when others then
  boCuentaGenerada := FALSE;
  pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
  pkErrors.Pop;
  raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );

--}
END GenerateAccount;


--********************************************************************************************

PROCEDURE GenerateAccountStatus IS

BEGIN
--{

    pkErrors.Push ('pkGenerateInvoice.GenerateAccountStatus');

    -- Define estado de cuenta para la suscripcion
    nuEstadoCuenta := fnuGetAccountStNumber ;

    -- Adiciona el registro del nuevo estado de cuenta
    AddAccountStatus ;

    -- Genero estado de cuenta
    boAccountStGenerado := TRUE;

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
  pkErrors.Pop;
  boAccountStGenerado := FALSE;
  raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
  pkErrors.Pop;
  boAccountStGenerado := FALSE;
  raise pkConstante.exERROR_LEVEL2;

    when others then
  pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
  boAccountStGenerado := FALSE;
  pkErrors.Pop;
  raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );

--}
END GenerateAccountStatus;

--********************************************************************************************

PROCEDURE UpdateCharges IS

    -- Colecciones temporales para almacenar la informacion de los cargos que se
    -- estan actualizando
    tbCargnuse          pktblCargos.tyCargnuse;
    tbCargconc          pktblCargos.tyCargconc;
    tbCargvalo          pktblCargos.tyCargvalo;
    tbCargvabl          pktblCargos.tyCargvabl;
    tbCargsign          pktblCargos.tyCargsign;
    tbCargcaca          pktblCargos.tyCargcaca;
    tbCargdoso          pktblCargos.tyCargdoso;
    tbCargfecr          pktblCargos.tyCargfecr;

    tbCargnuseNull      pktblCargos.tyCargnuse;
    tbCargconcNull      pktblCargos.tyCargconc;
    tbCargvaloNull      pktblCargos.tyCargvalo;
    tbCargvablNull      pktblCargos.tyCargvabl;
    tbCargsignNull      pktblCargos.tyCargsign;
    tbCargcacaNull      pktblCargos.tyCargcaca;
    tbCargdosoNull      pktblCargos.tyCargdoso;
    tbCargfecrNull      pktblCargos.tyCargfecr;

    PROCEDURE ClearArrays IS
    BEGIN
    --{

        tbCargnuse := tbCargnuseNull;
        tbCargconc := tbCargconcNull;
        tbCargvalo := tbCargvaloNull;
        tbCargvabl := tbCargvablNull;
        tbCargcaca  := tbCargcacaNull;
        tbCargsign := tbCargsignNull;
        tbCargdoso := tbCargdosoNull;
        tbCargfecr := tbCargfecrNull;

        tbCargnuse.DELETE;
        tbCargconc.DELETE;
        tbCargvalo.DELETE;
        tbCargvabl.DELETE;
        tbCargcaca.DELETE;
        tbCargsign.DELETE;
        tbCargdoso.DELETE;
        tbCargfecr.DELETE;

    --}
    END ClearArrays ;

BEGIN
--{

    pkErrors.Push ('pkGenerateInvoice.UpdateCharges');

    -- Limpia colecciones temporales
    ClearArrays ;

    -- Realiza la actualizacion del cargo
    FORALL nuIndex in tbCargfact.FIRST .. tbCargfact.LAST
    UPDATE cargos
    SET  --cargfact = tbCargfact (nuIndex),
	   cargcuco = tbCargcuco (nuIndex),
	   cargfecr = tbCargdate (nuIndex),
	   --cargfeco = tbCargfeco (nuIndex),
	   cargtipr = tbCargtipr (nuIndex)
    WHERE  rowid    = tbRowid    (nuIndex)
    RETURNING cargnuse, cargconc, cargvalo, cargvabl, cargsign, cargcaca, cargdoso, cargfecr
         BULK COLLECT INTO tbcargnuse, tbCargconc, tbCargvalo, tbcargvabl, tbCargsign, tbCargcaca, tbCargdoso, tbcargfecr;

    -- Acumula valores facturados

    for nuIdx in tbCargvalo.FIRST .. tbCargvalo.LAST loop
    --{
        -- Evalua si se trata de una cuota de capital de diferido o
        -- una cuota extra para no acumularla como valor facturado
        -- Se evalua ademas que la causa de cargo de los cargos no sea la obtenida
        -- del parametro de causa de cargo por traslado de diferido.
        if ( substr( tbCargdoso( nuIdx ), 1, 3 ) = pkBillConst.csbTOKEN_DIFERIDO or
             substr( tbCargdoso( nuIdx ), 1, 3 ) = pkBillConst.csbTOKEN_CUOTA_EXTRA or
             FA_BOChargeCauses.fboIsDefTransChCause(tbCargcaca( nuIdx ))
        )
        then
            goto PROXIMO ;
        end if;

        -- Acumula valores facturados
        if (tbCargsign (nuIdx) = pkBillConst.DEBITO) then
        --{
            -- Se acumula el valor facturado de la cuenta de cobro y la factura
            nuVlrFactCta := nuVlrFactCta + tbCargvalo( nuIdx );
            nuVlrFactFac := nuVlrFactFac + tbCargvalo( nuIdx );

            -- Se obtiene la informacion del concepto para determinar si se trata
            -- de un concepto de impuesto
            if ( pkConceptMgr.fblIsTaxesConcept( tbCargconc( nuIdx ) ) ) then
            --{
                -- Se acumula el valor del IVA facturado para la cuenta de cobro
                nuVlrIvaFactCta := nuVlrIvaFactCta + tbCargvalo( nuIdx );

                -- Se acumula el valor del IVA facturado para la factura
                nuVlrIvaFactFac := nuVlrIvaFactFac + tbCargvalo( nuIdx );
            --}
            else
                -- Se acumula el valor del IVA facturado para la cuenta de cobro
                nuVlrIvaFactCta := nuVlrIvaFactCta + FA_BOIVAModeMgr.fnuGetValueIVA(
                                                    tbCargnuse(nuIdx),
                                                    tbCargconc(nuIdx),
                                                    nvl(tbCargvabl(nuIdx),  tbCargvalo(nuIdx)),
                                                    tbCargfecr(nuIdx));

                -- Se acumula el valor del IVA facturado para la factura
                nuVlrIvaFactFac := nuVlrIvaFactFac + FA_BOIVAModeMgr.fnuGetValueIVA(
                                                    tbCargnuse(nuIdx),
                                                    tbCargconc(nuIdx),
                                                    nvl(tbCargvabl(nuIdx),  tbCargvalo(nuIdx)),
                                                    tbCargfecr(nuIdx));
            end if;
        --}
        else
        --{
            -- Se acumula el valor facturado de la cuenta de cobro y la factura
            nuVlrFactCta := nuVlrFactCta - tbCargvalo( nuIdx );
            nuVlrFactFac := nuVlrFactFac - tbCargvalo( nuIdx );

            -- Se obtiene la informacion del concepto para determinar si se trata
            -- de un concepto de impuesto
            if ( pkConceptMgr.fblIsTaxesConcept( tbCargconc( nuIdx ) ) ) then
            --{
                -- Se acumula el valor del IVA facturado para la cuenta de cobro
                nuVlrIvaFactCta := nuVlrIvaFactCta - tbCargvalo( nuIdx );

                -- Se acumula el valor del IVA facturado para la factura
                nuVlrIvaFactFac := nuVlrIvaFactFac - tbCargvalo( nuIdx );
            else
                -- Se acumula el valor del IVA facturado para la cuenta de cobro
                nuVlrIvaFactCta := nuVlrIvaFactCta - FA_BOIVAModeMgr.fnuGetValueIVA(
                                                    tbCargnuse(nuIdx),
                                                    tbCargconc(nuIdx),
                                                    nvl(tbCargvabl(nuIdx),  tbCargvalo(nuIdx)),
                                                    tbCargfecr(nuIdx));

                -- Se acumula el valor del IVA facturado para la factura
                nuVlrIvaFactFac := nuVlrIvaFactFac - FA_BOIVAModeMgr.fnuGetValueIVA(
                                                    tbCargnuse(nuIdx),
                                                    tbCargconc(nuIdx),
                                                    nvl(tbCargvabl(nuIdx),  tbCargvalo(nuIdx)),
                                                    tbCargfecr(nuIdx));
            --}
            end if;
        --}
        end if;

        << PROXIMO >>
        null ;
    --}
    end loop ;

    -- Limpia colecciones temporales
    ClearArrays ;

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
    	pkErrors.Pop;
    	raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
    	pkErrors.Pop;
    	raise pkConstante.exERROR_LEVEL2;

    when others then
    	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    	pkErrors.Pop;
    	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );

--}
END UpdateCharges;


--********************************************************************************************

PROCEDURE AdjustAccount IS

    nuValorCta		cuencobr.cucovato%type;	-- Valor total cuenta
    nuVlrAjustes	number;			-- Suma ajustes previos Cta
    sbSignoAjuste	cargos.cargsign%type;	-- Signo ajuste
    nuVlrAjuste		cargos.cargvalo%type;	-- Valor ajuste
    sbSignCanc		cargos.cargsign%type;	-- Signo de cancelacion ajuste

    -- Evaluacion si se deben o no ajustar las cuentas de acuerdo a la
    -- configuracion realizada en los parametros de facturacion
    boAjustarCuentas	boolean;
    -- Factor de ajuste de cuenta
    nuFactorAjusteCta	timoempr.tmemfaaj%type;

    -----------------------------------------------------------------------
    -- Procedimientos Encapsulados
    -----------------------------------------------------------------------
    -- --------------------------------------------------------------------
    -- 	Evalua si el valor necesita o no ajuste
    -- --------------------------------------------------------------------
    FUNCTION fblNeedAdjust
    (
        inuValorCta	in	cuencobr.cucovato%type
    )
    RETURN boolean IS

        nuValor		cuencobr.cucovato%type;	-- Valor absoluto cuenta
        nuVlrAAjustar	cuencobr.cucovato%type;	-- Valor a ajustar

    BEGIN
    --{
        pkErrors.Push ('pkGenerateInvoice.fblNeedAdjust');

        nuValor := inuValorCta;

        -- Valida el valor de la cuenta

        if ( nuValor = 0.00 or nuValor is null ) then
        	pkErrors.Pop;
        	return (FALSE);
        end if;

        -- Obtiene residuo del valor de la cuenta vs el factor de ajuste
        nuVlrAAjustar := mod (abs (nuValor), nuFactorAjusteCta);

        -- En caso de que no haya valor desajustado, retorna

        if ( nuVlrAAjustar = 0.00 ) then
        	pkErrors.Pop;
        	return (FALSE);
        end if;

        pkErrors.Pop;
        return (TRUE);

    EXCEPTION
        when LOGIN_DENIED then
        	pkErrors.Pop;
        	raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
        	pkErrors.Pop;
        	raise pkConstante.exERROR_LEVEL2;

        when others then
        	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        	pkErrors.Pop;
        	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    --}
    END fblNeedAdjust;
    -- --------------------------------------------------------------------
    --  Adiciona cargo de ajuste
    -- --------------------------------------------------------------------
    PROCEDURE AddCharge
	(
	    inuVlrCargo	in	cargos.cargvalo%type,
	    isbSigno	in	cargos.cargsign%type,
	    isbDocSop	in	cargos.cargdoso%type
	)
	IS
    BEGIN
    --{

	pkErrors.Push('pkGenerateInvoice.AddCharge');

	-- Adiciona el Cargo
	GenerateCharge
	    (
		nuConcAjuste,
    isbSigno,
    isbDocSop,
    FA_BOChargeCauses.fnuGenericChCause(pkConstante.NULLNUM), -- causal original en pkGenInvoice
		abs(inuVlrCargo),
    0, -- consdocu (cargcodo)
    pkBillConst.AUTOMATICO -- tipoproc
	    );

	-- Actualiza cartera
	pkUpdAccoReceiv.UpdAccoRec
	    (
		pkBillConst.cnuSUMA_CARGO,
		nuCuenta,
		rcSuscCurr.susccodi,
		rcSeSuCurr.sesunuse,
		nuConcAjuste,
		isbSigno,
		abs(inuVlrCargo),
		pkBillConst.cnuNO_UPDATE_DB
	    );

	UpdateAccoRec ;

	-- Actualiza el acumulado de los valores facturados

	if (isbSigno = pkBillConst.DEBITO) then
	--{

	    -- Cargo debito
	    nuVlrFactCta    := nuVlrFactCta + abs(inuVlrCargo) ;
	    nuVlrFactFac    := nuVlrFactFac + abs(inuVlrCargo) ;

	--}
	else
	--{
	    -- Cargo credito
	    nuVlrFactCta    := nuVlrFactCta - abs(inuVlrCargo) ;
	    nuVlrFactFac    := nuVlrFactFac - abs(inuVlrCargo) ;
	--}
	end if;

	pkErrors.Pop;

    EXCEPTION
   	    when LOGIN_DENIED then
    	    pkErrors.Pop;
    	    raise LOGIN_DENIED;

       	when pkConstante.exERROR_LEVEL2 then
    	    pkErrors.Pop;
    	    raise pkConstante.exERROR_LEVEL2;

    	when others then
    	    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    	    pkErrors.Pop;
    	    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    --}
    END AddCharge;

    ------------------------------------------------------------------------

BEGIN
--{
    pkErrors.Push ('pkGenerateInvoice.AdjustAccount');

    -- Obtiene validacion ajuste a la cuenta
    FA_BOPoliticaRedondeo.ObtienePoliticaAjuste (
                                                    rcSeSuCurr.sesususc,
                                                    boAjustarCuentas,
                                                    nuFactorAjusteCta
                                                );

    -- Evalua si se debe realizar ajuste, de acuerdo a los parametros

    if (not boAjustarCuentas) then
    	pkErrors.Pop;
    	return;
    end if;

    -- Obtiene el valor de la cuenta actualizado
    nuValorCta := nuCart_ValorCta ;

    -- Evalua si necesita ajuste

    if (not fblNeedAdjust (nuValorCta)) then
    	pkErrors.Pop;
    	return;
    end if;

    -- Obtiene el valor de los ajustes realizados a la cuenta
    nuVlrAjustes := fnuGetAdjustValue ;

    -- Evalua si debe cancelar ajustes previos

    if (nuVlrAjustes != 0.00) then
    --{
    	-- Obtiene signo de cancelacion de cargo ajuste
    	sbSignCanc := pkChargeMgr.fsbGetCancelSign (nuVlrAjustes);

    	-- Crea cargo de cancelacion
    	AddCharge
	    (
    		nuVlrAjustes,
    		sbSignCanc,
    		pkBillConst.csbDOC_CANC_AJUSTE
	    );
    --}
    end if;

    -- Obtiene el valor de la cuenta actualizado
    nuValorCta := nuCart_ValorCta ;

    -- Calcula el valor y signo del nuevo ajuste
    CalcAdjustValue
	(
        nuFactorAjusteCta,
	    nuValorCta,
	    nuVlrAjuste,
	    sbSignoAjuste
	);

    -- Evalua si se debe adicionar cargo

    if ( nuVlrAjuste = 0.00 ) then
    	pkErrors.Pop;
    	return;
    end if;

    -- Crea cargo con el nuevo ajuste
    AddCharge
	(
	    nuVlrAjuste,
	    sbSignoAjuste,
	    pkBillConst.csbDOC_AJUSTE
	);

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
    	pkErrors.Pop;
    	raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
    	pkErrors.Pop;
    	raise pkConstante.exERROR_LEVEL2;

    when others then
    	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    	pkErrors.Pop;
    	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
--}
END AdjustAccount;


--********************************************************************************************

FUNCTION fnuGetAccountNumber RETURN number IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    -- Numero de cuenta
    nuCta		cuencobr.cucocodi%type;

BEGIN
--{

    pkErrors.Push ('pkGenerateInvoice.fnuGetAccountNumber');

    -- Obtiene el numero de la cuenta del consecutivo
    pkAccountMgr.GetNewAccountNum (nuCta);

    pkErrors.Pop;

    -- Cerramos el bloque autonomo
    pkgeneralservices.CommitTransaction;

    return (nuCta);

EXCEPTION
    when LOGIN_DENIED then
	pkErrors.Pop;
	raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
	pkErrors.Pop;
	raise pkConstante.exERROR_LEVEL2;

    when others then
	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
	pkErrors.Pop;
	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );

--}
END fnuGetAccountNumber;


--********************************************************************************************

FUNCTION fnuGetAccountStNumber RETURN number IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    nuEstadoCta	factura.factcodi%type;	-- Numero estado de cuenta

BEGIN
--{

    pkErrors.Push ('pkGenerateInvoice.fnuGetAccountStNumber');

    -- Obtiene el numero del estado de cuenta del consecutivo
    pkAccountStatusMgr.GetNewAccoStatusNum (nuEstadoCta);

    pkErrors.Pop;

    -- Cerramos el bloque autonomo
    pkgeneralservices.CommitTransaction;

    return (nuEstadoCta);

EXCEPTION
    when LOGIN_DENIED then
	pkErrors.Pop;
	raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
	pkErrors.Pop;
	raise pkConstante.exERROR_LEVEL2;

    when others then
	pkErrors.NotifyError ( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
	pkErrors.Pop;
	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );

--}
END fnuGetAccountStNumber;


--********************************************************************************************

PROCEDURE AddAccount IS

    rcCuenta	cuencobr%rowtype;	-- Record de cuenta de cobro

    ----------------------------------------------------------------------
    -- METODOS ENCAPSULADOS
    ----------------------------------------------------------------------

    PROCEDURE FillRecord IS

    	rcCuenCobrNull	cuencobr%rowtype;	-- Record Nulo Cuenta
    BEGIN
    --{

	pkErrors.Push ('pkGenerateInvoice.AddAccount.FillRecord');

	rcCuenta := rcCuenCobrNull;

	-- Se prepara el registro de la Cuenta de Cobro
	-- Ya se tiene current la cuenta de cobro
	rcCuenta.cucocodi := nuCuenta;
	rcCuenta.cucogrim := 99 ;
	rcCuenta.cucovaap := pkBillConst.CERO;
	rcCuenta.cucovare := pkBillConst.CERO;
  rcCuenta.cucodepa := nuDepa;
	rcCuenta.cucoloca := nuLoca;
	rcCuenta.cucocate := rcSeSuCurr.sesucate;
	rcCuenta.cucosuca := rcSeSuCurr.sesusuca;
	rcCuenta.cucoplsu := rcSeSuCurr.sesuplfa;
 	rcCuenta.cucovato := pkBillConst.CERO;
 	rcCuenta.cucovaab := pkBillConst.CERO;
 	rcCuenta.cucovafa := pkBillConst.CERO;
 	rcCuenta.cucoimfa := pkBillConst.CERO;
	rcCuenta.cucofepa := null;
	rcCuenta.cucosacu := pkBillConst.CERO;
	rcCuenta.cucovrap := pkBillConst.CERO;
	rcCuenta.cuconuse := rcSeSuCurr.sesunuse;
	rcCuenta.cucofact := nuEstadoCuenta;
	rcCuenta.cucofaag := nuEstadoCuenta;
 	rcCuenta.cucofeve := pkSubsDateLineMgr.fdtGetDateLine
				(
				    rcSeSuCurr.sesususc,
				    rcPerifactCurr.pefaano,
				    rcPerifactCurr.pefames,
				    rcPerifactCurr.pefafepa
				);

    -- Se obtiene la direcci?n de instalaci?n del producto
	rcCuenta.cucodiin := pr_bcproduct.fnuGetAddressId(
                                                        rcSeSuCurr.sesunuse
                                                     );
	rcCuenta.cucosist := rcSeSuCurr.sesusist;

	pkErrors.Pop;

    EXCEPTION
	when LOGIN_DENIED then
	    pkErrors.Pop;
	    raise LOGIN_DENIED;

	when others then
	    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
	    pkErrors.Pop;
	    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );


    --}
    END FillRecord;

    ----------------------------------------------------------------------

BEGIN
--{

    pkErrors.Push ('pkGenerateInvoice.AddAccount');

    -- Se prepara el registro de la Cuenta de Cobro
    FillRecord ;

    -- Se adiciona el registro a la tabla Cuencobr
    pktblCuencobr.InsRecord (rcCuenta);

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
	pkErrors.Pop;
	raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
	pkErrors.Pop;
	raise pkConstante.exERROR_LEVEL2;

    when others then
	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
	pkErrors.Pop;
	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );

--}
END AddAccount;


--********************************************************************************************

PROCEDURE AddAccountStatus IS

    rcEstadoCta	factura%rowtype := NULL;	-- Record de Estado de cuenta

    ----------------------------------------------------------------------
    -- METODOS ENCAPSULADOS
    ----------------------------------------------------------------------

    PROCEDURE FillNewRecord IS

    	rcEstadoCtaNull	factura%rowtype := NULL; -- Record Nulo Estado Cuenta

    BEGIN
    --{
    	pkErrors.Push ('pkGenerateInvoice.AddAccountStatus.FillNewRecord');

    	rcEstadoCta := rcEstadoCtaNull;

    	-- Se prepara el registro del Estado de Cuenta
    	-- Estado de cuenta current
    	rcEstadoCta.factcodi := nuEstadoCuenta;

    	-- Suscripcion current
    	rcEstadoCta.factsusc := rcSuscCurr.susccodi;
    	rcEstadoCta.factvaap := pkBillConst.CERO;
     	rcEstadoCta.factpefa := rcPerifactCurr.pefacodi;

     	-- Dejar current sysdate en esta variable
    	rcEstadoCta.factfege := dtFechaGene;
    	rcEstadoCta.factterm := sbTerminal;
    	rcEstadoCta.factusua := sa_bosystem.getSystemUserID;

    	--  Asigna el valor del campo departamento y localidad
        rcEstadoCta.factdepa := nuDepa;
        rcEstadoCta.factloca := nuLoca;
        -- Se obtiene la direcci?n de cobro
        rcEstadoCta.factdico := rcSuscCurr.susciddi;

    	rcEstadoCta.factprog := nuPrograma;

        -- La numeracion fiscal pasa a ser asignada despues de aceptar
        -- y ser creada la factura y todo su proceso
    	pkErrors.Pop;


    EXCEPTION
        when LOGIN_DENIED OR ex.CONTROLLED_ERROR then
            pkErrors.Pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise pkConstante.exERROR_LEVEL2;

        when OTHERS then
        	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        	pkErrors.Pop;
        	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    --}
    END FillNewRecord;

    ----------------------------------------------------------------------

BEGIN
--{

    pkErrors.Push ('pkGenerateInvoice.AddAccountStatus');

    -- Se prepara el registro del Estado de cuenta
    FillNewRecord ;

    -- guarda informacion de la factura generada
    grcEstadoCta := rcEstadoCta;

    -- Se adiciona el registro a la tabla Factura
    pktblFactura.InsRecord (rcEstadoCta);

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;

    when others then
        pkErrors.NotifyError (pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.Pop;
        raise_application_error (pkConstante.nuERROR_LEVEL2, sbErrMsg);
--}
END AddAccountStatus;


--********************************************************************************************
FUNCTION fnuGetAdjustValue RETURN number IS

    nuVlrAjustes	number;			-- Valor de los ajustes

	-- Documento de soporte para ajuste de cuenta
    csbAJUSTE           constant varchar2(15) := 'AJUSTE';

	-- Documento de soporte para cancelacion de ajuste de cuenta
    csbCANCAJUSTE       constant varchar2(15) := 'CANC.AJUSTE';

    -- Cursor para sumar los ajuste de la cuenta
    CURSOR cuAjuste (nuCuenta	cargos.cargcuco%type,
		             nuConcepto	cargos.cargconc%type)
    IS
    SELECT nvl (sum (decode (upper (cargsign), pkBillConst.DEBITO,
					       cargvalo,
					       pkBillConst.CREDITO,
					       -cargvalo, 0 ) ), 0 )
    FROM   cargos
    WHERE  cargcuco = nuCuenta
    AND    cargconc = nuConcepto
    AND    cargdoso || '' in (csbAJUSTE, csbCANCAJUSTE);

BEGIN
--{
    pkErrors.Push ('pkGenerateInvoice.fnuGetAdjustValue');

    -- Obtiene el valor de los ajustes de la cuenta
    open cuAjuste (nuCuenta, nuConcAjuste);

    fetch cuAjuste into nuVlrAjustes;
    close cuAjuste;

    pkErrors.Pop;
    return (nuVlrAjustes);

EXCEPTION
    when LOGIN_DENIED then
    	pkErrors.Pop;
    	raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
    	pkErrors.Pop;
    	raise pkConstante.exERROR_LEVEL2;

    when others then
    	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    	pkErrors.Pop;
    	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
--}
END fnuGetAdjustValue;


--********************************************************************************************

PROCEDURE CalcAdjustValue
    (
    inuFactor   in  timoempr.tmemfaaj%type,
    inuValorCta	in	cuencobr.cucovato%type,
	onuValorAjuste	out	cargos.cargvalo%type,
	osbSignoAjuste	out	cargos.cargsign%type
    )
    IS

    nuValor		cuencobr.cucovato%type;	-- Valor absoluto cuenta
    nuVlrAAjustar	number;			-- Valor que se va a ajustar

BEGIN
--{

    pkErrors.Push ('pkGenerateInvoice.CalcAdjustValue');

    onuValorAjuste := pkBillConst.CERO;
    osbSignoAjuste := null;
    nuValor        := inuValorCta;

    -- Valida el valor de la cuenta

    if ( nuValor = 0.00 or nuValor is null ) then
    	pkErrors.Pop;
    	return;
    end if;

    -- Evalua si el valor de la cuenta es negativo

    if ( nuValor < 0.00 ) then
    	nuValor := abs (nuValor);
    end if;

    -- Obtiene residuo del valor de la cuenta vs el factor de ajuste
    nuVlrAAjustar := mod (nuValor, inuFactor);

    -- En caso de que no haya valor desajustado, retorna

    if ( nuVlrAAjustar = 0.00 ) then
    	pkErrors.Pop;
    	return;
    end if;

    -- Evalua si el ajuste es por encima o por debajo, comparando contra
    -- la mitad del factor de ajuste

    if ( (inuFactor - nuVlrAAjustar) > (inuFactor / 2) ) then
    	onuValorAjuste := nuVlrAAjustar;
    	osbSignoAjuste := pkBillConst.CREDITO;
    else
    	onuValorAjuste := inuFactor - nuVlrAAjustar;
    	osbSignoAjuste := pkBillConst.DEBITO;
    end if;

    -- Verifica si el Valor Total de la Cuenta es Negativo
    -- para invertir el Signo del cargo de Ajuste

    if (inuValorCta < 0.00) then
    --{
    	if (osbSignoAjuste = pkBillConst.DEBITO) then
    	    osbSignoAjuste := pkBillConst.CREDITO;
    	else
    	    osbSignoAjuste := pkBillConst.DEBITO;
    	end if;
    --}
    end if;

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
    	pkErrors.Pop;
    	raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
    	pkErrors.Pop;
    	raise pkConstante.exERROR_LEVEL2;

    when others then
    	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    	pkErrors.Pop;
    	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
--}
END CalcAdjustValue;


--********************************************************************************************

PROCEDURE UpdAccoBillValues IS

BEGIN
--{

    pkErrors.Push ('pkGenerateBill.UpdAccoBillValues');

    pktblCuencobr.UpBilledValues
        (
            nuCuenta,
            nuVlrFactCta,
            nuVlrIvaFactCta
        );

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;

    when others then
        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
        pkErrors.Pop;
        raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );

--}
END UpdAccoBillValues;


--********************************************************************************************
PROCEDURE GetOverChargePercent(inuPlandife         in plandife.pldicodi%type,
                                   onuPercenOverCharge out number) IS
    BEGIN
      onuPercenOverCharge := pktblPlandife.fnuPercOverCharge(inuPlandife,
                                                             pkConstante.NOCACHE);
      onuPercenOverCharge := nvl(onuPercenOverCharge, 0);

      if onuPercenOverCharge not between 0 AND 100 then
        -- El porcentaje de mora configurado en el plan de financiacion (%s1) no es correcto
        errors.setError(cnuBadOverChargePercent, inuPlandife);
        raise ex.controlled_error;
      END if;
    EXCEPTION
      WHEN LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR
           ex.CONTROLLED_ERROR then
        raise;
      when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    END;
--*******************************************************************************************
PROCEDURE ValInterestConcept(inuConc in concepto.conccodi%type) IS

  BEGIN
    --{

    ut_trace.trace('cc_bofinancing.ValInterestConcept', cnuNivelTrace + 1);

    -- Valida si el codigo del concepto es nulo

    pkConceptMgr.ValidateNull(inuConc);

    -- Valida si el concepto existe en BD

    pktblConcepto.AccKey(inuConc);

  EXCEPTION
    WHEN LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
      raise;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ValInterestConcept;

--*******************************************************************************************
PROCEDURE GetExtraPayTotal(inuExtraPayNumber in number,
                             onuExtraPayValue  out number) IS
    nuIndex number;
  BEGIN
    ut_trace.trace('cc_bofinancing.GetExtraPayTotal (' ||
                   inuExtraPayNumber || ')',
                   cnuNivelTrace);

    onuExtraPayValue := 0;

    if (nvl(tbExtraPayment.count, 0) = 0) then
      return;
    END if;

    nuIndex := tbExtraPayment.FIRST;

    loop
      exit when nuIndex is null;

      if (tbExtraPayment(nuIndex).ExtraPayNumber = inuExtraPayNumber) then
        onuExtraPayValue := onuExtraPayValue + tbExtraPayment(nuIndex)
                           .extraPayValue;
      END IF;

      nuIndex := tbExtraPayment.next(nuIndex);
    END loop;

  EXCEPTION
    WHEN LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
      raise;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END;
--*******************************************************************************************

PROCEDURE GenerateBillingNote IS

    nunotanume notas.notanume%type;
    sbToken    VARCHAR2(10);

  BEGIN

    pkErrors.Push('pkGenerateInvoice.GenerateBillNote');

    -- determina signo
    if sbSigno = 'DB' then
      sbToken := pkBillConst.csbTOKEN_NOTA_DEBITO;
      nunotacons := 70;
    else
      sbToken := pkBillConst.csbTOKEN_NOTA_CREDITO;
      nunotacons := 71;
    end if;

    FA_BOBillingNotes.SetUpdateDataBaseFlag;
    pkerrors.setapplication(cc_boconstants.csbCUSTOMERCARE);
    pkBillingNoteMgr.CreateBillingNote(nuServsusc,
                                       nuCuenta,
                                       nunotacons,
                                       UT_Date.fdtSysdate,
                                       sbObserv,
                                       sbToken,
                                       nunotanume -- consecutivo nota generada
                                       );

    --  Se Aplica la nota
    FA_BOBillingNotes.DetailRegister(nunotanume, -- tbBillNote(to_char(rcAccount.cucofact)),
                                     nuServsusc,
                                     nuSuscripcion,
                                     nuCuenta, -- rcAccount.cucocodi,
                                     nuConcepto,
                                     nuCausal,
                                     nuValor,
                                     null, --valor base
                                     sbToken || nunotanume, --documento soporte
                                     sbSigno, --signo
                                     pkConstante.SI, --ajusta cuenta
                                     null, --documento nota
                                     pkconstante.SI, --saldo a favor
                                     FALSE); --registra en aprobacion

    -- Se asigna numero de nota a variable de paquete
    nuNota := nunotanume;

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
  END GenerateBillingNote;

--------------------------------------------------------------------------------------------
  Function ConsCartera return pkConstante.tyRefCursor is

    rfcursor           pkConstante.tyRefCursor;
    nuProductoOri      ge_boInstanceControl.stysbValue;

    nuMaxRein number;

  begin

    ut_trace.trace('Inicio Ldci_ResetIntMensCajaGris.ConsMensCGEncolados', 10);

    /*obtener los valores ingresados en la aplicacion PB */
    nuProductoOri := ge_boInstanceControl.fsbGetFieldValue('SERVSUSC', 'SESUNUSE');



      if (nuProductoOri is null) then
      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                      'Producto no debe ser nulo');
      raise ex.CONTROLLED_ERROR;
    end if;


    OPEN rfcursor FOR
      select difesusc contrato, difenuse producto, 'Diferido' tipo, difecodi numero, difesape saldo
        from diferido where difenuse=nuProductoOri
      union
      select sesususc contrato, cuconuse producto, 'Cuenta'   tipo, cucocodi numero, cucosacu saldo
        from cuencobr, servsusc
       where cuconuse=sesunuse
         and cucosacu>0
         and sesunuse=nuProductoOri;

    ut_trace.trace('Fin Ldci_ResetIntMensCajaGris.ConsMensCGEncolados', 10);

    return rfcursor;

  exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  end ConsCartera;


end LDC_PKTRASFNB;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKTRASFNB', 'ADM_PERSON'); 
END;
/
