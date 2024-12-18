CREATE OR REPLACE PACKAGE adm_person.LDC_BCCOMMERCIALSEGMENTFNB is
    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BCCOMMERCIALSEGMENTFNB
    Descripcion    : Paquete con la logica de negocio para manejar el proceso
                     de segmentación comercial de Brilla.
    Autor          : KCienfuegos
    Fecha          : 22/09/2014

    Historia de Modificaciones
    Fecha         Autor               Modificacion
    -------------------------------------------------
    19/06/2024    PAcosta             OSF-2845: Cambio de esquema ADM_PERSON  
    30-03-2015    KCienfuegos.RNP198  Se modifica método <<fsbRolloverSusc>>
    25-03-2015    KCienfuegos.RNP198  Se modifica método <<fsbGasapplSusc>>
                                                       <<fsbFuturSusc>>
    10-02-2015    KCienfuegos.RNP198  Se modifica el método <<fsbNormalSusc>>
    22-09-2014    KCienfuegos.RNP198  Creación
    16/07/2015    heiberb             Cambio 7805 Creación de metodos <<fsbNewFNBSuscRe>>, <<fsbFuturSuscM>>, <<fsbFuturSuscL>>
                                      y ajuste del metodo <<fsbNormalSusc>>, <<fsbRolloverSusc>>, <<fsbNoQuotaSusc>>.
    ******************************************************************/

    /*Variables globales*/
    nuAssignedQuotaSusc       ld_quota_by_subsc.quota_value%type := 0;
    nuSuscription             suscripc.susccodi%type;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbNormalSusc
    Descripcion    : Valida si el usuario pertenece a la segmentación comercial Normal.

    Autor          : KCienfuegos.RNP198
    Fecha          : 22/09/2014

    Parametros                   Descripcion
    ============             ===================
    inuContrato:              Id del contrato

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22/09/2014       KCienfuegos.RNP198    Creación.
    ******************************************************************/
    FUNCTION fsbNormalSusc(inuContrato  in suscripc.susccodi%type)
      RETURN VARCHAR2;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbIrresoluteSusc
    Descripcion    : Valida si el usuario pertenece a la segmentación comercial Indeciso.

    Autor          : KCienfuegos.RNP198
    Fecha          : 22/09/2014

    Parametros                   Descripcion
    ============             ===================
    inuContrato:              Id del contrato
    inuMeses:                 Número de meses

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22/09/2014       KCienfuegos.RNP198    Creación.
    ******************************************************************/
    FUNCTION fsbIrresoluteSusc(inuContrato  in suscripc.susccodi%type,
                               inuMeses      in number)
      RETURN VARCHAR2;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbNewFNBSusc
    Descripcion    : Valida si el usuario pertenece a la segmentación comercial Nuevo.

    Autor          : KCienfuegos.RNP198
    Fecha          : 22/09/2014

    Parametros                   Descripcion
    ============             ===================
    inuContrato:              Id del contrato
    inuMeses:                 Número de meses

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22/09/2014       KCienfuegos.RNP198    Creación.
    ******************************************************************/
    FUNCTION fsbNewFNBSusc(inuContrato  in suscripc.susccodi%type,
                           inuMeses      in number)
      RETURN VARCHAR2;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbRolloverSusc
    Descripcion    : Valida si el usuario pertenece a la segmentación comercial Rollover.

    Autor          : KCienfuegos.RNP198
    Fecha          : 22/09/2014

    Parametros                   Descripcion
    ============             ===================
    inuContrato:              Id del contrato
    inuCantDiferidos:         Cant. diferidos que deben estar saldados

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22/09/2014       KCienfuegos.RNP198    Creación.
    ******************************************************************/
    FUNCTION fsbRolloverSusc(inuContrato  in suscripc.susccodi%type,
                             inuCantDiferidos      in number)
      RETURN VARCHAR2;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbGasapplSusc
    Descripcion    : Valida si el usuario pertenece a la segmentación comercial Gasodoméstico.

    Autor          : KCienfuegos.RNP198
    Fecha          : 22/09/2014

    Parametros                   Descripcion
    ============             ===================
    inuContrato:              Id del contrato
    isbExclusPolicy:           Políticas que se pueden incumplir

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22/09/2014       KCienfuegos.RNP198    Creación.
    ******************************************************************/
    FUNCTION fsbGasapplSusc(inuSubscriptionId in suscripc.susccodi%type,
                            isbExclusPolicy   in ld_parameter.value_chain%type)
      RETURN VARCHAR2;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbFuturSusc
    Descripcion    : Valida si el usuario pertenece a la segmentación comercial Futuro.

    Autor          : KCienfuegos.RNP198
    Fecha          : 24/09/2014

    Parametros                   Descripcion
    ============             ===================
    inuContrato:              Id del contrato
    isbExclusPolicy:           Pólizas a excluir

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    24/09/2014       KCienfuegos.RNP198    Creación.
    ******************************************************************/
    FUNCTION fsbFuturSusc(inuSubscriptionId in suscripc.susccodi%type,
                          inuMeses   in number)
      return VARCHAR2;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbNoQuotaSusc
    Descripcion    : Valida si el usuario pertenece a la segmentación comercial Sin Cupo.

    Autor          : KCienfuegos.RNP198
    Fecha          : 24/09/2014

    Parametros                   Descripcion
    ============             ===================
    inuContrato:              Id del contrato
    isbExclusPolicy:           Pólizas a excluir

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    24/09/2014       KCienfuegos.RNP198    Creación.
    ******************************************************************/
    FUNCTION fsbNoQuotaSusc(inuSubscriptionId in suscripc.susccodi%type)
      return VARCHAR2;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : frcGetSegmentSuscRec
    Descripcion    : Obtiene el registro de segmentación actual del contrato.

    Autor          : KCienfuegos.RNP198
    Fecha          : 24/09/2014

    Parametros              Descripcion
    ============         ===================
    inuSubscription       Id del coNtrato


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    24/09/2014      KCienfuegos.RNP198  Creación
    ******************************************************************/
    FUNCTION frcGetSegmentSuscRec(inuSubscription suscripc.susccodi%type)
      return daldc_segment_susc.styldc_segment_susc;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fnuGetSegmentbySusc
    Descripcion    : Obtiene el Id de la segmentación del contrato.

    Autor          : KCienfuegos.RNP198
    Fecha          : 24/09/2014

    Parametros              Descripcion
    ============         ===================
    inuSubscription       Id del contrato


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    24/09/2014      KCienfuegos.RNP198  Creación
    ******************************************************************/
    FUNCTION fnuGetSegmentbySusc(inuSubscription suscripc.susccodi%type)
      return NUMBER;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbGetSegmentbySusc
    Descripcion    : Obtiene la sigla de la segmentación del contrato.

    Autor          : KCienfuegos.RNP198
    Fecha          : 24/09/2014

    Parametros              Descripcion
    ============         ===================
    inuSubscription       Id del contrato


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    24/09/2014      KCienfuegos.RNP198  Creación
    ******************************************************************/
    FUNCTION fsbGetSegmentbySusc(inuSubscription suscripc.susccodi%type)
      return VARCHAR2;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : proGetAcronNameSegmbySusc
    Descripcion    : Obtiene la sigla y nombre de la segmentación del contrato.

    Autor          : KCienfuegos.RNP198
    Fecha          : 25/09/2014

    Parametros              Descripcion
    ============         ===================
    inuSubscription       Id del contrato
    onuSegmentId          Id de la segmentación
    osbSegment            Descripción de la segmentación

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    25/09/2014      KCienfuegos.RNP198  Creación
    ******************************************************************/
    PROCEDURE proGetAcronNameSegmbySusc (inuSubscription in suscripc.susccodi%type,
                                         onuSegmentId    out ldc_segment_susc.segment_id%type,
                                         osbSegment      out varchar2);

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbGetAcronNameSegmbySusc
    Descripcion    : Obtiene la sigla y nombre de la segmentación del contrato.

    Autor          : KCienfuegos.RNP198
    Fecha          : 25/09/2014

    Parametros              Descripcion
    ============         ===================
    inuSubscription       Id del contrato
    onuSegmentId          Id de la segmentación
    osbSegment            Descripción de la segmentación

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    25/09/2014      KCienfuegos.RNP198  Creación
    ******************************************************************/
    FUNCTION fsbGetAcronNameSegmbySusc (inuSubscription in suscripc.susccodi%type)
      RETURN VARCHAR2;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fnuGetQuotaSusc
    Descripcion    : Obtiene el cupo actual del contrato

    Autor          : KCienfuegos.RNP198
    Fecha          : 26/09/2014

    Parametros              Descripcion
    ============         ===================
    inuSubscription       Id del contrato


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    26/09/2014      KCienfuegos.RNP198  Creación
    ******************************************************************/
    FUNCTION fnuGetQuotaSusc(inuSubscription suscripc.susccodi%type)
      return NUMBER;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fnuGetAssigQuota
    Descripcion    : Obtiene el cupo asignado al contrato.

    Autor          : KCienfuegos.RNP198
    Fecha          : 31/10/2014

    Parametros              Descripcion
    ============         ===================
    inuSubscription       Id del contrato


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    31/10/2014      KCienfuegos.RNP198  Creación
    ******************************************************************/
    FUNCTION fnuGetAssigQuota(inuSubscription suscripc.susccodi%type)
      return NUMBER;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fblHasCashSales
    Descripcion    : Valida si tuvo ventas de contado.

    Autor          : KCienfuegos.RNP198
    Fecha          : 31/10/2014

    Parametros              Descripcion
    ============         ===================
    inuSubscription       Id del contrato


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    31/10/2014      KCienfuegos.RNP198  Creación.
    ******************************************************************/
    FUNCTION fblHasCashSales(inuSubscription suscripc.susccodi%type)
      return BOOLEAN;

    /*****************************************************************
    Propiedad intelectual de PETI(c).

    Unidad         : fnugetGasProduct
    Descripcion    : funcion que obtiene el identificador del producto GAS.
    Fecha          : 18/03/2015

    Parametros              Descripcion
    ============         ===================
    inuSubscription      Contrato
    onuProductId         Código de producto gas
    onuAddressId         Dirección

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
    Procedure getGasProductData(inuSubscription in suscripc.susccodi%type,
                                onuProductId out pr_product.product_id%type,
                                onuAddressId out pr_product.address_id%type);

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbNewFNBSuscRe
    Descripcion    : Valida si el usuario pertenece a la segmentación comercial Nuevo Regular.

    Autor          : heiberb
    Fecha          : 16/07/2015

    Parametros                   Descripcion
    ============             ===================
    inuContrato:              Id del contrato
    inuMeses:                 Número de meses

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    16/07/2015       heiberb               Cambio 7805 creacion del muedo metodo
    ******************************************************************/
    FUNCTION fsbNewFNBSuscRe(inuContrato  in suscripc.susccodi%type,
                             inuMeses      in number)
    RETURN VARCHAR2;

/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbFuturSuscM
    Descripcion    : Valida si el usuario pertenece a la segmentación comercial Futuro Mediano.

    Autor          : heiberb
    Fecha          : 16-07-2015

    Parametros                   Descripcion
    ============             ===================
    inuContrato:              Id del contrato
    isbExclusPolicy:           Pólizas a excluir

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    16/07/2015       heiberb               Cambio 7805 creacion del muedo metodo
    ******************************************************************/
    FUNCTION fsbFuturSuscM(inuSubscriptionId in suscripc.susccodi%type,
                           inuMeses   in number)
    return VARCHAR2;

/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbFuturSuscL
    Descripcion    : Valida si el usuario pertenece a la segmentación comercial Futuro Lejano.

    Autor          : heiberb
    Fecha          : 16-07-2015

    Parametros                   Descripcion
    ============             ===================
    inuContrato:              Id del contrato
    isbExclusPolicy:           Pólizas a excluir

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    16/07/2015       heiberb               Cambio 7805 creacion del muedo metodo
    ******************************************************************/
    FUNCTION fsbFuturSuscL(inuSubscriptionId in suscripc.susccodi%type,
                           inuMeses   in number)
    return VARCHAR2;

END LDC_BCCOMMERCIALSEGMENTFNB;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_BCCOMMERCIALSEGMENTFNB is
  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : LDC_BCCOMMERCIALSEGMENTFNB
  Descripcion    : Paquete con la lógica de negocio para manejar el proceso
                   de segmentación comercial de Brilla.
  Autor          : KCienfuegos
  Fecha          : 22/09/2014

  Historia de Modificaciones
  Fecha         Autor               Modificacion
  -------------------------------------------------
  30-03-2015    KCienfuegos.RNP198  Se modifica método <<fsbRolloverSusc>>
  25-03-2015    KCienfuegos.RNP198  Se modifica método <<fsbGasapplSusc>>
                                                       <<fsbFuturSusc>>
  10-02-2015    KCienfuegos.RNP198  Se modifica el método <<fsbNormalSusc>>
  22-09-2014    KCienfuegos.RNP198  Creación.
  16/07/2015    heiberb             Cambio 7805 Creación de metodos <<fsbNewFNBSuscRe>>, <<fsbFuturSuscM>>, <<fsbFuturSuscL>>
                                    y ajuste del metodo <<fsbNormalSusc>>, <<fsbRolloverSusc>>, <<fsbNoQuotaSusc>>.
  ******************************************************************/


  -- Private type declarations
  --type <TypeName> is <Datatype>;

  -- Private constant declarations
     cnucero             constant NUMBER := LD_BOCONSTANS.cnuCero;
     cnuone              constant NUMBER := LD_BOCONSTANS.cnuonenumber;
     cnuConcSegVid       constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('COD_CON_SEG');
     cnuSegmentNorm      constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_NORMAL');
     cnuSegmentIndec     constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_INDECISO');
     cnuSegmentNueva     constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_NUEVO');
     cnuSegmentGas       constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_GASODOMESTICO');
     cnuSegmentFutu      constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_FUTURO');
     cnuSegmentRoll      constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_ROLLOVER');
     cnuSegmentNoQuot    constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_SINCUPO');
     csbPolRedVal        constant ld_parameter.value_chain%type := dald_parameter.fsbGetValue_Chain('COD_POLITICA_RED',0);

--<<
--   16/07/2015    heiberb             Cambio 7805 creacion de las variables para los nuevos segmentos
-->>
     cnuSegmentNuevaR     constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_NUEVORE');
     cnuSegmentFutuM     constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_FUTUROM');
     cnuSegmentFutuL     constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_FUTUROL');
     cnuSegmentNormD     constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_NORMALD');
     cnuSegmentRollD     constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_ROLLOVERD');
     cnuSegmentNormN     constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_NORMALN');
     cnuSegmentRollN     constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_ROLLOVERN');

     csbNoFlag           constant VARCHAR2(1) := ld_boconstans.csbNOFlag;

  -- Private variable declarations
  -- <VariableName> <Datatype>;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbNormalSusc
    Descripcion    : Valida si el usuario pertenece a la segmentación comercial Normal.
                     Segmentación Normal: aquellos clientes que en la actualidad,
                     todos los diferidos a evaluar, se encuentren activos, es decir, se están
                     facturando (Saldo pendiente del diferido + saldo en corriente)>0.

    Autor          : KCienfuegos.RNP198
    Fecha          : 22/09/2014

    Parametros                   Descripcion
    ============             ===================
    inuContrato:              Id del contrato

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    10/02/2015       KCienfuegos.RNP198    Se modifica ya que de acuerdo a la nueva directriz, la segmentación
                                           Normal, incluye a aquellos usuarios que tienen diferidos activos y diferidos
                                           cancelados al mismo tiempo.
    22/09/2014       KCienfuegos.RNP198    Creación.
    16/07/2015       heiberb               Cambio 7805 Ajuste para determinar si es usuario normal a partir de la cantidad de ventas
                                           y de igual manera si es Normal D cuando el pago tiene mas de N meses
    ******************************************************************/
    FUNCTION fsbNormalSusc(inuContrato  in suscripc.susccodi%type)
      RETURN VARCHAR2 IS

      sbresult        ldc_condit_commerc_segm.acronym%type;
      nuValor         number := cnucero;
      blHasDef        boolean := false;
      blHasValue      boolean := false;
      nuDiferidos     number := cnucero;
      nuCantiDifer    number := 0; --cantida de diferidos con saldo
      nuCanSellEfect  number := 0; --Cantidad de ventas efectivas
      nuCantMigr      number := 0; --Cantidad de ventas efectivas migradas
      daFechaPago     date; --fecha del ultimo pago del diferido.
      nuMeses         number := 0; --tiempo establecido para el segmento nuevo nuevo
      nuTotalSell     number := 0; -- variable para el total de las ventas
      nuTimeNormalN   number := 0; --variable para el tiempo establecido en Normal N
      nuCantSell    number := 0; --variable para la cant ventas configuradas en segmento Normal
      nuCantDife     number := cnucero; --variable para la cantidad de diferidos

      /*Cursor para obtener todos los diferidos FNB del contrato que no hayan sido cancelados*/
      CURSOR cu_alldeferreds IS
       SELECT Count(difecofi) venta
         FROM (SELECT Count(difecofi) difecofi, Trunc(difefein) difefein
                 FROM diferido d, servsusc s
                WHERE difesusc = inuContrato
                  AND difenuse = sesunuse
                  AND instr(DALD_PARAMETER.fsbGetValue_Chain('COD_SERVFINBRPRO'),
                            sesuserv) > 0
                  AND difesusc = sesususc
                  AND difecodi NOT IN
                      (SELECT modidife
                         FROM movidife
                        WHERE modidife = difecodi
                          AND modicaca =
                              (dald_parameter.fnuGetNumeric_Value('CANCEL_DIFE')))
                  AND SubStr(DIFENUDO, 0, 2) <> 'RF'
                GROUP BY Trunc(difefein));

       /*Cursor para obtener el # de diferidos configurados para segmentación Rollover*/
      cursor cuDifeSegmentRoll is
        select sc.parameter
          from ldc_condit_commerc_segm sc
         where sc.cond_commer_segm_id= cnuSegmentRoll
           and sc.active = 'Y';

       /*Cursor para obtener el time configurados para segmentación Normal N*/
      cursor cuGetSegmentNorN is
        select sc.time
          from ldc_condit_commerc_segm sc
         where sc.cond_commer_segm_id= cnuSegmentNormN
           and sc.active = 'Y';

       /*Cursor para obtener el parametro # de diferidos configurado para segmentación Normal*/
      cursor cuGetParaNor is
        select sc.parameter
          from ldc_condit_commerc_segm sc
         where sc.cond_commer_segm_id= cnuSegmentNorm
           and sc.active = 'Y';

       /*Cursor para obtener saldo en corriente*/
       CURSOR cu_CurrentDebt(nuDeferred diferido.difecodi%type) is
           SELECT /*+
                  ordered
                  use_nl(servsusc cuencobr cargos)
                  index_rs_asc(servsusc IX_SERVSUSC12)
                  index_rs_asc(cuencobr IX_CUENCOBR03)
                  index_rs_asc(cargos IX_CARGOS02)*/
               nvl(SUM(cargvalo),0)
              FROM servsusc, cuencobr, cargos
             WHERE sesususc = inuContrato
               AND instr(DALD_PARAMETER.fsbGetValue_Chain('COD_SERVFINBRPRO'),
                         sesuserv) > 0
               AND sesunuse = cuconuse
               AND nvl(cucosacu, 0) > 0
               AND cucocodi = cargcuco
               AND cargdoso = 'DF-'||nuDeferred
               AND cargsign = 'DB';

        /*16/07/2015  heiberb Cambio 7805 Cursor para obtener el total de las ventas efectivas*/
          CURSOR cu_Get_Data_Sell  is
          select count(*) solicitud from (
         SELECT

          --inicia pestaña de datos básicos
          distinct(m.package_id) solicitud, -- � Código de la solicitud ok
          decode(ov.state,'PA', 'Aprobación', 'EP', 'En Proceso A/D', 'AN', 'Anulado',
          decode(oa.status, 'F','Entregado', 'Registrado'))  EstEnt,--ESTADO DE LA ENTREGA OK
           decode(r.digital_prom_note_cons, null, 'Impreso', 'Digital') TipoPagare
          --Acaba pestaña de datos detalle
          FROM ld_non_ban_fi_item i,
          ld_non_ba_fi_requ  r,
          mo_packages        m,
          ld_article         a,
              OR_order_activity  oa,
          ld_item_work_order ov
          /*+ Ubicación: LD_BOQueryFNB.frfGetSaleFNBInfo */
          WHERE i.non_ba_fi_requ_id in (select unique mp.package_id
  from mo_motive mo, mo_packages mp
 where mo.product_type_id in (SELECT TO_NUMBER(COLUMN_VALUE) valor
                                FROM TABLE
                                (open.LDC_BOUTILITIES.SPLITSTRINGS((select trim(replace(value_chain, '|', ',')) from ld_parameter where parameter_id = 'COD_SERVFINBRPRO'),',') )
                             )
   and mo.subscription_id = inuContrato
   and mo.package_id = mp.package_id
   and mp.package_type_id = (select NUMERIC_VALUE from ld_parameter where parameter_id = 'TIPO_SOL_VENTA_FNB')
   and mp.motive_status_id = (select NUMERIC_VALUE from ld_parameter where parameter_id = 'ID_ESTADO_PKG_ATENDTIDO'))
          AND i.non_ba_fi_requ_id = r.non_ba_fi_requ_id
          AND m.package_id = r.non_ba_fi_requ_id
          AND a.article_id = i.article_id
          AND oa.motive_id(+) = i.non_ban_fi_item_id
          AND ov.order_activity_id = oa.order_activity_id
          AND oa.activity_id = (select NUMERIC_VALUE from ld_parameter where parameter_id = 'ACTIVITY_TYPE_FNB'))
          where EstEnt = 'Entregado'; --parametro entregado

        /*16/07/2015  heiberb Cambio 7805 Cursor para buscar cantidad de ventas migradas de ese contrato*/
        CURSOR cu_Cant_ven_MGR is
         select count(*)
           from LDC_SCORHIST hst
          where hst.suscriptor = inuContrato;

         /* 16/07/2015  heiberb Cambio 7805 Cursor para validar diferidos con saldo*/
         CURSOR cu_Dif_Saldo is
            SELECT count(*)
              FROM diferido d, servsusc s
             WHERE difesusc = inuContrato
               AND difenuse = sesunuse
               AND instr (DALD_PARAMETER.fsbGetValue_Chain('COD_SERVFINBRPRO'),sesuserv)>0
               AND difesusc = sesususc
               and difesape > 0;

         /* 16/07/2015  heiberb Cambio 7805 Cursor para validar corriente con saldo*/
       CURSOR cu_CurrentDebito is
           SELECT /*+
                  ordered
                  use_nl(servsusc cuencobr cargos)
                  index_rs_asc(servsusc IX_SERVSUSC12)
                  index_rs_asc(cuencobr IX_CUENCOBR03)
                  index_rs_asc(cargos IX_CARGOS02)*/
               nvl(SUM(cargvalo),0)
              FROM servsusc, cuencobr, cargos, concepto
             WHERE sesususc = inuContrato
               AND instr(DALD_PARAMETER.fsbGetValue_Chain('COD_SERVFINBRPRO'),
                         sesuserv) > 0
               AND sesunuse = cuconuse
               AND nvl(cucosacu, 0) > 0
               AND cucocodi = cargcuco
               AND cargdoso like '%DF-%'
               AND cargsign = 'DB'
               and cargconc = conccodi
               and concclco = (select NUMERIC_VALUE from ld_parameter where parameter_id = 'CLASIF_BRILLA'); --parametro brilla;

         /*16/07/2015  heiberb Cambio 7805 Cursor para obtener la fecha del pago*/
         CURSOR cu_fecha_pago is
         SELECT * FROM (
         select cucofepa from (
         SELECT cucocodi, cucofepa
                      FROM servsusc, cuencobr, cargos, concepto
                     WHERE instr(DALD_PARAMETER.fsbGetValue_Chain('COD_SERVFINBRPRO'),
                                 sesuserv) > 0
                       AND sesunuse = cuconuse
                       and sesususc = inucontrato
                       AND nvl(cucosacu, 0) = 0
                       AND cucocodi = cargcuco
                       AND cargdoso like '%DF-%'
                       AND cargsign = 'DB'
                       and cargconc = conccodi
                       and concclco = (select NUMERIC_VALUE from ld_parameter where parameter_id = 'CLASIF_BRILLA') --clasificador Brilla
                     order by cucofepa DESC nulls last) where rownum = 1
         UNION ALL
         (SELECT cucofepa FROM (
                  SELECT NON_BA_FI_REQU_ID, STATUS_CHANGE_DATE cucofepa FROM LD_NON_BA_FI_REQU ld, mo_motive mt, mo_packages mo
                  WHERE payment = VALUE_TOTAL
                   AND ld.non_ba_fi_requ_id = mt.package_id
                   AND mo.package_id = mt.package_id
                   AND mo.package_type_id = (select NUMERIC_VALUE from ld_parameter where parameter_id = 'TIPO_SOL_VENTA_FNB')
                   AND mo.motive_status_id = (select NUMERIC_VALUE from ld_parameter where parameter_id = 'ID_ESTADO_PKG_ATENDTIDO')
                   and mt.subscription_id = inucontrato
                   ORDER BY STATUS_CHANGE_DATE DESC)
                   WHERE ROWNUM = 1)) WHERE cucofepa IS NOT NULL
                   AND ROWNUM = 1;

    BEGIN

      ut_trace.trace('Inicia ldc_bccommercialsegmentfnb.fsbNormalSusc',1);

      if not ldc_bocommercialsegmentfnb.blFlagRollOver then

        open cu_Get_Data_Sell;
        fetch cu_Get_Data_Sell into nuCanSellEfect;
        close cu_Get_Data_Sell;

        open cu_Cant_ven_MGR;
        fetch cu_Cant_ven_MGR into nuCantMigr;
        close cu_Cant_ven_MGR;

        open cuDifeSegmentRoll;
        fetch cuDifeSegmentRoll into nuDiferidos;
        close cuDifeSegmentRoll;

        open cuGetSegmentNorN;
        fetch cuGetSegmentNorN into nuTimeNormalN;
        close cuGetSegmentNorN;

        open cuGetParaNor;
        fetch cuGetParaNor into nuCantSell;
        close cuGetParaNor;



        nuTotalSell := nuCanSellEfect + nuCantMigr;

        IF (nuTotalSell > cnucero) THEN --registros de ventas

          if (nuTotalSell > nuCantSell) then
            sbResult := fsbRolloverSusc(inuContrato, nudiferidos);
          end if;

         if (sbResult is null) then


          IF (DALD_PARAMETER.fsbGetValue_Chain('EVALUDEUDA') = 'S') then

              open cu_Dif_Saldo; --obtiene la cantidad de diferidos con saldo
              fetch cu_Dif_Saldo into nuCantiDifer;
              close cu_Dif_Saldo;

                if (nuCantiDifer > cnucero) then
                 blHasDef := true; --no ha terminado de pagar el diferido
                 else
                 blHasDef := false; -- no tiene diferidos con saldo
                end if;

             /*Se evalúa que haya deuda en corriente*/
                open cu_CurrentDebito;
                fetch cu_CurrentDebito into nuValor;
                close cu_CurrentDebito;

                --si hay valor en corriente
                if nuValor > cnucero then
                  blHasValue := true;

                else
                  blHasValue := false;

                end if;


              if not blHasDef and not blHasValue then --identifica que no tiene dedua ni en diferido ni en corriente

                open cu_fecha_pago;--trae fecha termnina pago ultimo diferido pago
                fetch cu_fecha_pago into daFechaPago;
                close cu_fecha_pago;

                if daFechaPago is not null then
              --validacion para las fechas para determinar el semento Actual o Actual regular
                      if (trunc(add_months(daFechaPago, nvl(nuTimeNormalN,0))) >= ut_date.fdtsysdate) then

                      sbResult := cnuSegmentNormN;

                      else

                      sbResult := cnuSegmentNormD;

                      END IF;

                ELSE

                  sbResult := cnuSegmentNormD;--debe ser normal ya que tiene venta y no tiene deuda DALD_PARAMETER.fsbGetValue_Chain('SEGNOFECHPA'); --si no encuentra fecha pago asigna segmento parametrizado--validar con parametro

                end if;

            --  ELSE


              else

              sbResult := cnuSegmentNorm;

              end if;
          else

                open cu_fecha_pago;--trae fecha termnina pago ultimo diferido pago
                fetch cu_fecha_pago into daFechaPago;
                close cu_fecha_pago;

                if daFechaPago is not null then
              --validacion para las fechas para determinar el semento Actual o Actual regular
                      if (trunc(add_months(daFechaPago, nvl(nuTimeNormalN,0))) >= ut_date.fdtsysdate) then

                      sbResult := cnuSegmentNormN;

                      else

                      sbResult := cnuSegmentNormD;

                      END IF;

                ELSE

                  sbResult := cnuSegmentNorm; --debe ser normal ya que no le han facturado para pago pero tiene venta--DALD_PARAMETER.fsbGetValue_Chain('SEGNOFECHPA'); --si no encuentra fecha pago asigna segmento parametrizado--validar con parametro

                end if;

          end if;

         end if;


        else --no hay ventas migradas y se validan los diferidos.

          open cu_alldeferreds;
          fetch cu_alldeferreds into nuCantDife;
          close cu_alldeferreds;

          if (nuCantDife > nuCantSell) then
              sbResult := fsbRolloverSusc(inuContrato, nudiferidos);
          end if;

          if (sbResult is null) then


          IF (DALD_PARAMETER.fsbGetValue_Chain('EVALUDEUDA') = 'S') then

              open cu_Dif_Saldo; --obtiene la cantidad de diferidos con saldo
              fetch cu_Dif_Saldo into nuCantiDifer;
              close cu_Dif_Saldo;

                if (nuCantiDifer > cnucero) then
                 blHasDef := true; --no ha terminado de pagar el diferido
                 else
                 blHasDef := false; -- no tiene diferidos con saldo
                end if;

             /*Se evalúa que haya deuda en corriente*/
                open cu_CurrentDebito;
                fetch cu_CurrentDebito into nuValor;
                close cu_CurrentDebito;

                --si hay valor en corriente
                if nuValor > cnucero then
                  blHasValue := true;

                else
                  blHasValue := false;

                end if;


              if not blHasDef and not blHasValue then --identifica que no tiene dedua ni en diferido ni en corriente

                open cu_fecha_pago;--trae fecha termnina pago ultimo diferido pago
                fetch cu_fecha_pago into daFechaPago;
                close cu_fecha_pago;

                if daFechaPago is not null then
              --validacion para las fechas para determinar el semento Actual o Actual regular
                      if (trunc(add_months(daFechaPago, nvl(nuTimeNormalN,0))) >= ut_date.fdtsysdate) then

                      sbResult := cnuSegmentNormN;

                      else

                      sbResult := cnuSegmentNormD;

                      END IF;

                ELSE

                  if nuCantDife > cnucero then

                  sbResult := cnuSegmentNormD;--se deja normal N ya que tiene diferido sin deuda  pero no hay pago DALD_PARAMETER.fsbGetValue_Chain('SEGNOFECHPA'); --si no encuentra fecha pago asigna segmento parametrizado--validar con parametro

                  else

                  sbResult := null;

                  end if;

                end if;

            --  ELSE


              else

              sbResult := cnuSegmentNorm;

              end if;
          else

                open cu_fecha_pago;--trae fecha termnina pago ultimo diferido pago
                fetch cu_fecha_pago into daFechaPago;
                close cu_fecha_pago;

                if daFechaPago is not null then
              --validacion para las fechas para determinar el semento Actual o Actual regular
                      if (trunc(add_months(daFechaPago, nvl(nuTimeNormalN,0))) >= ut_date.fdtsysdate) then

                      sbResult := cnuSegmentNormN;

                      else

                      sbResult := cnuSegmentNormD;

                      END IF;

                ELSE

                  if nuCantDife > cnucero then

                  sbResult := cnuSegmentNormD;--se deja normal N ya que tiene diferido sin deuda  pero no hay pago DALD_PARAMETER.fsbGetValue_Chain('SEGNOFECHPA'); --si no encuentra fecha pago asigna segmento parametrizado--validar con parametro

                  else

                  sbResult := null;

                  end if;

                end if;

          end if;

         end if;

        /*de buscar diferidos y agruparlos por fechas.*/

        end if;


      /*       open cuDifeSegmentRoll;
             fetch cuDifeSegmentRoll into nuDiferidos;
             close cuDifeSegmentRoll;

             if nuDiferidos is not null then
                sbResult := fsbRolloverSusc(inuContrato, nuDiferidos);
             end if;

      end if;

      if sbResult is null then
        if nvl(nuAssignedQuotaSusc,0) > cnucero then
          \*Se recorren todos los diferidos FNB del contrato*\
          for i in cu_alldeferreds loop
            blHasDef := true;

            \*Se evalúa que el diferido tenga saldo pendiente*\
            if (i.difesape > cnucero) then
               blHasValue := true;
               exit;
              --continue;
            else
              \*Se evalúa que haya deuda en corriente*\
              open cu_CurrentDebt(i.difecodi);
              fetch cu_CurrentDebt into nuValor;
              close cu_CurrentDebt;

              \*Si no existe deuda en corriente, se sale del loop*\
              if nuValor > cnucero then
                blHasValue := true;
                exit;
                --exit;
              else
                blHasValue := false;
                continue;
              end if;

            end if;
          end loop;

          \*Evalúa si tuvo algún diferido FNB*\
          if blHasDef then

            \*Valida que todos los diferidos hayan tenido saldo pendiente (incluyendo saldo en corriente)*\
            if blHasValue then
                sbresult := cnuSegmentNorm;
            else
              sbresult := null;
            end if;

          else
             sbresult := null;
          end if;

        end if;*/
        end if;

      ut_trace.trace('ldc_bccommercialsegmentfnb.fsbNormalSusc - Resultado '||nvl(sbResult,'Ninguno'),1);

      return sbresult;

    EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
        RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        Errors.setError;
        RAISE ex.CONTROLLED_ERROR;

    END fsbNormalSusc;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbIrresoluteSusc
    Descripcion    : Valida si el usuario pertenece a la segmentación comercial Indeciso.
                     Segmentación Indeciso: Clientes que han tenido el cupo asignado hace
                     más de N meses (parámetro) y no lo han utilizado, es decir, nunca han
                     tenido un diferido asociado a los tipo de productos establecidos en el
                     parámetro COD_SERVFINBRPRO.

    Autor          : KCienfuegos.RNP198
    Fecha          : 22/09/2014

    Parametros                   Descripcion
    ============             ===================
    inuContrato:              Id del contrato
    inuMeses:                 Número de meses

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22/09/2014       KCienfuegos.RNP198    Creación.
    04-08-2015       HeiberB Cambio 7805   Modificacion de la validacion donde se evalua que tenga cupo
                                           y que no lo haya utilizado.
    ******************************************************************/
    FUNCTION fsbIrresoluteSusc(inuContrato  in suscripc.susccodi%type,
                               inuMeses      in number)
      RETURN VARCHAR2 IS

      nuquantdefer              number := cnucero;
      numonths                 number := cnucero;
      dtassigned_date          ld_quota_historic.register_date%type;
      sbresult                 ldc_condit_commerc_segm.acronym%type;
      nuRes                    number;

      /*Cursor para obtener el número de diferidos de Brilla*/
      cursor cuQuantDeferrFNB(inususc in suscripc.susccodi%type) is
        select count(*)
          from diferido d, servsusc s
         where difesusc = sesususc
           and  instr (DALD_PARAMETER.fsbGetValue_Chain('COD_SERVFINBRPRO'),sesuserv)>0
           and difesusc = inususc
           and difenuse = sesunuse
           and difeconc not in (select conccore FROM concepto WHERE conccodi in (select conccoin FROM concepto))
           and difecodi not in(select difecodi
                                 from ld_item_work_order iw, Or_Order_Activity oa
                                where oa.order_activity_id = iw.order_activity_id
                                  and oa.activity_id =Dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB')
                                  and difecodi is not null
                                  and iw.state in('AN')
                                  and OA.SUBSCRIPTION_ID = inususc)
           AND difeconc <> dald_parameter.fnuGetNumeric_Value('COD_CON_SEG');

      /*Cursor para obtener el registro de las asignaciones de cupo*/
       cursor culd_quota_historic(inususc in suscripc.susccodi%type) is
        select register_date, assigned_quote, qh.result
          from ld_quota_historic qh
         where qh.subscription_id = inususc
         order by qh.register_date desc;

    BEGIN

      ut_trace.trace('Inicia ldc_bccommercialsegmentfnb.fsbIrresoluteSusc',1);

      if nvl(nuAssignedQuotaSusc, 0) > cnucero then

        /*Se obtiene la cantidad de diferidos Brilla*/
       /* open cuquantdeferrfnb(inucontrato);
        fetch cuquantdeferrfnb into nuquantdefer;
        close cuquantdeferrfnb;*/

       nuRes := ld_bononbankfinancing.fnugetusedquote(inucontrato);

       if nuRes = cnucero then
       sbresult := cnuSegmentIndec;
       end if;

        if nvl(nuquantdefer,cnucero) = cnucero then

          /*Valida si ha tenido ventas de contado*/
          if not fblHasCashSales(inucontrato) then

            /*Obtiene la fecha de asignación de cupo*/
            for i in culd_quota_historic(inucontrato) loop
              if (nvl(i.assigned_quote,cnucero) = cnucero or i.result = csbNoFlag)  then
               exit;
              else
               dtassigned_date := i.register_date;
              end if;
            end loop;

            /*Calcula el número de meses entre la fecha de asignación y la fecha actual*/
            numonths :=  months_between(ut_date.fdtsysdate, nvl(dtassigned_date,ut_date.fdtsysdate));

            if numonths >= inuMeses then
              sbresult := cnuSegmentIndec;
            else
              sbresult := null;
            end if;

          else
             sbresult := null;
          end if;

        else
             sbresult := null;
        end if;

      end if;

      ut_trace.trace('ldc_bccommercialsegmentfnb.fsbIrresoluteSusc - Resultado '||nvl(sbResult,'Ninguno'),1);

      return sbresult;

    EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
        RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        Errors.setError;
        RAISE ex.CONTROLLED_ERROR;

    END fsbIrresoluteSusc;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbNewFNBSusc
    Descripcion    : Valida si el usuario pertenece a la segmentación comercial Nuevo.
                     Segmentación nuevo: Clientes que tienen cupo Brilla hace N meses
                     (parámetro) o menos tiempo y no lo han utilizado, es decir, nunca
                     han tenido un diferido asociado a los tipos de productos establecidos
                     en el parámetro COD_SERVFINBRPRO.

    Autor          : KCienfuegos.RNP198
    Fecha          : 22/09/2014

    Parametros                   Descripcion
    ============             ===================
    inuContrato:              Id del contrato
    inuMeses:                 Número de meses

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    22/09/2014       KCienfuegos.RNP198    Creación.
    ******************************************************************/
    FUNCTION fsbNewFNBSusc(inuContrato  in suscripc.susccodi%type,
                           inuMeses      in number)
      RETURN VARCHAR2 IS

      nuquantdefer              number := cnucero;
      numonths                 number := cnucero;
      dtassigned_date          ld_quota_historic.register_date%type;
      sbresult                 ldc_condit_commerc_segm.acronym%type;

      /*Cursor para obtener el número de diferidos de Brilla*/
      cursor cuquantdeferrfnb(inususc in suscripc.susccodi%type) is
        select count(*)
          from diferido d, servsusc s
         where difesusc = sesususc
           and  instr (DALD_PARAMETER.fsbGetValue_Chain('COD_SERVFINBRPRO'),sesuserv)>0
           and difesusc = inususc
           and difenuse = sesunuse
           and difeconc not in (select conccore from concepto where conccodi in (select conccoin from concepto))
           and difecodi not in (select difecodi
                                 from ld_item_work_order iw, Or_Order_Activity oa
                                where oa.order_activity_id = iw.order_activity_id
                                  and oa.activity_id =Dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB')
                                  and difecodi is not null
                                  and iw.state in('AN')
                                  and oa.subscription_id = inususc)
           and difeconc <>  cnuconcsegvid;

      /*Cursor para obtener el registro de las asignaciones de cupo*/
      cursor culd_quota_historic(inususc in suscripc.susccodi%type) is
        select register_date, assigned_quote, qh.result
          from ld_quota_historic qh
         where qh.subscription_id = inususc
         order by qh.register_date desc;

    BEGIN

      ut_trace.trace('Inicia ldc_bccommercialsegmentfnb.fsbNewFNBSusc',1);

      if nvl(nuAssignedQuotaSusc,cnucero) > cnucero then

        /*Se obtiene la cantidad de diferidos Brilla*/
        open cuquantdeferrfnb(inucontrato);
        fetch cuquantdeferrfnb into nuquantdefer;
        close cuquantdeferrfnb;

        if nvl(nuquantdefer,cnucero) = cnucero then

          /*Valida si ha tenido ventas de contado*/
          if not fblHasCashSales(inucontrato) then

            /*Obtiene la fecha de asignación de cupo*/
            for i in culd_quota_historic(inucontrato) loop
              if (nvl(i.assigned_quote,cnucero) = cnucero or i.result = csbNoFlag) then
               exit;
              else
               dtassigned_date := i.register_date;
              end if;
            end loop;

            /*Calcula el número de meses entre la fecha de asignación y la fecha actual*/
            numonths :=  months_between(ut_date.fdtsysdate, nvl(dtassigned_date,ut_date.fdtsysdate));

            /*Hace N meses o menos con el cupo y no lo ha utilizado*/
            if numonths <= inuMeses then
              sbresult := cnuSegmentNueva;
            else
              sbresult := null;
            end if;

          end if;

        else
             sbresult := null;
        end if;

      end if;

      ut_trace.trace('ldc_bccommercialsegmentfnb.fsbNewFNBSusc - Resultado '||nvl(sbResult,'Ninguno'),1);

      return sbresult;

    EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
        RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        Errors.setError;
        RAISE ex.CONTROLLED_ERROR;
    END fsbNewFNBSusc;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbRolloverSusc
    Descripcion    : Valida si el usuario pertenece a la segmentación comercial Rollover.
                     Segmentación Rollover: Clientes que han terminado de pagar al menos un
                     diferido o todos, que se encuentren asociados a los productos Brilla y
                     Promigas.

    Autor          : KCienfuegos.RNP198
    Fecha          : 22/09/2014

    Parametros                   Descripcion
    ============             ===================
    inuContrato:              Id del contrato
    inuCantDiferidos:         Cant. diferidos que deben estar saldados

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    30/03/2015       KCienfuegos.RNP198    Se modifica para que la validación de la venta de contado
                                           teniendo en cuenta las ventas anuladas.
    22/09/2014       KCienfuegos.RNP198    Creación.
    16/07/2015       heiberb               Cambio 7805 Ajuste para determinar si es usuario RollOver a partir de la cantidad de ventas
                                           y de igual manera si es RollOver D cuando el pago tiene mas de N meses
    ******************************************************************/
    FUNCTION fsbRolloverSusc(inuContrato       in suscripc.susccodi%type,
                             inuCantDiferidos   in number)
      RETURN VARCHAR2 IS

      nuincump                 number := cnucero;
      sbresult                 ldc_condit_commerc_segm.acronym%type;
      blHasDeferr              boolean := false;
      nuValor                  number := cnucero;
      blHasDef        boolean := false;
      blHasValue      boolean := false;
      nuDiferidos     number := cnucero;
      nuCantiDifer    number := 0; --cantida de diferidos con saldo
      nuCanSellEfect  number := 0; --Cantidad de ventas efectivas
      nuCantMigr      number := 0; --Cantidad de ventas efectivas migradas
      daFechaPago     date; --fecha del ultimo pago del diferido.
      nuMeses         number := 0; --tiempo establecido para el segmento nuevo nuevo
      nuTotalSell     number := 0; -- variable para el total de las ventas
      nuCantSell      number := 0; --variable para la cant ventas configuradas en segmento RollOver
      nuCantDife     number := cnucero; --variable para la cantidad de diferidos

      /*Cursor para obtener todos los diferidos FNB un contrato*/
      CURSOR cuAllDeferreds(inususc in suscripc.susccodi%type) is
        SELECT difecodi, difenuse, difesape
          FROM diferido d, servsusc s
         WHERE difesusc = sesususc
           AND instr (DALD_PARAMETER.fsbGetValue_Chain('COD_SERVFINBRPRO'),sesuserv)>cnucero
           AND difesusc = inususc
           AND difenuse = sesunuse
           AND difeconc not in (select conccore FROM concepto WHERE conccodi in (select conccoin FROM concepto))
           AND difeconc <>  cnuConcSegVid
           AND difecodi not in (select difecodi
                                 from ld_item_work_order iw, Or_Order_Activity oa
                                where oa.order_activity_id = iw.order_activity_id
                                  and oa.activity_id =Dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB')
                                  and difecodi is not null
                                  and iw.state in('AN')
                                  and oa.subscription_id = inususc);

      /*Cursor para determinar si hay deuda corriente*/
      CURSOR cu_CurrDebt(nuProducto in servsusc.sesunuse%type,
                         nuDifecodi in diferido.difecodi%type) IS
        SELECT nvl(SUM(c.cargvalo),0)
          FROM cargos c, cuencobr cu
         WHERE c.cargcuco = cu.cucocodi
           AND c.cargnuse = nuProducto
           AND cargdoso = 'DF-' || nuDifecodi
           AND nvl(cucosacu, 0) > cnucero
           AND cargsign = 'DB';

      /*Cursor para obtener ventas de contado*/
      /*CURSOR CUVTASCONTADO(inuSusc in suscripc.susccodi%type) IS
         SELECT COUNT(*)
          FROM or_order_activity oa, mo_packages mp, ld_non_ba_fi_requ nb
         WHERE oa.activity_id = Dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB')
           AND oa.package_id = mp.package_id
           AND mp.package_type_id = dald_parameter.fnuGetNumeric_Value('COD_PACK_FNB')
           AND nb.non_ba_fi_requ_id = mp.package_id
           AND oa.subscription_id = inuSusc
           AND oa.status = 'F'
           AND nb.payment = nb.value_total
           AND rownum=1;*/
/*Cursor para obtener el # de time configurados para segmentación Rollover*/
      cursor cuDifeSegmentRollN is
        select sc.time
          from ldc_condit_commerc_segm sc
         where sc.cond_commer_segm_id= cnuSegmentRollN
           and sc.active = 'Y';

       /*Cursor para obtener el parametro # de diferidos configurado para segmentación RollOver*/
      cursor cuGetParaRol is
        select sc.parameter
          from ldc_condit_commerc_segm sc
         where sc.cond_commer_segm_id= cnuSegmentRoll
           and sc.active = 'Y';

      /*Cursor para obtener todos los diferidos FNB del contrato que no hayan sido cancelados*/
      CURSOR cu_alldeferreds IS
       SELECT Count(difecofi) venta
         FROM (SELECT Count(difecofi) difecofi, Trunc(difefein) difefein
                 FROM diferido d, servsusc s
                WHERE difesusc = inuContrato
                  AND difenuse = sesunuse
                  AND instr(DALD_PARAMETER.fsbGetValue_Chain('COD_SERVFINBRPRO'),
                            sesuserv) > 0
                  AND difesusc = sesususc
                  AND difecodi NOT IN
                      (SELECT modidife
                         FROM movidife
                        WHERE modidife = difecodi
                          AND modicaca =
                              (dald_parameter.fnuGetNumeric_Value('CANCEL_DIFE')))
                  AND SubStr(DIFENUDO, 0, 2) <> 'RF'
                GROUP BY Trunc(difefein));

       /*Cursor para obtener saldo en corriente*/
       CURSOR cu_CurrentDebt(nuDeferred diferido.difecodi%type) is
           SELECT /*+
                  ordered
                  use_nl(servsusc cuencobr cargos)
                  index_rs_asc(servsusc IX_SERVSUSC12)
                  index_rs_asc(cuencobr IX_CUENCOBR03)
                  index_rs_asc(cargos IX_CARGOS02)*/
               nvl(SUM(cargvalo),0)
              FROM servsusc, cuencobr, cargos
             WHERE sesususc = inuContrato
               AND instr(DALD_PARAMETER.fsbGetValue_Chain('COD_SERVFINBRPRO'),
                         sesuserv) > 0
               AND sesunuse = cuconuse
               AND nvl(cucosacu, 0) > 0
               AND cucocodi = cargcuco
               AND cargdoso = 'DF-'||nuDeferred
               AND cargsign = 'DB';

        /*16/07/2015 heiberb Cambio 7805 Cursor para obtener el detalle de las ventas*/
          CURSOR cu_Get_Data_Sell  is
          select count(*) solicitud from (
        SELECT

          --inicia pestaña de datos básicos
          distinct(m.package_id) solicitud, -- � Código de la solicitud ok
          decode(ov.state,'PA', 'Aprobación', 'EP', 'En Proceso A/D', 'AN', 'Anulado',
          decode(oa.status, 'F','Entregado', 'Registrado'))  EstEnt,--ESTADO DE LA ENTREGA OK
           decode(r.digital_prom_note_cons, null, 'Impreso', 'Digital') TipoPagare
          --Acaba pestaña de datos detalle
          FROM ld_non_ban_fi_item i,
          ld_non_ba_fi_requ  r,
          mo_packages        m,
          ld_article         a,
              OR_order_activity  oa,
          ld_item_work_order ov
          /*+ Ubicación: LD_BOQueryFNB.frfGetSaleFNBInfo */
          WHERE i.non_ba_fi_requ_id in (select unique mp.package_id
  from mo_motive mo, mo_packages mp
 where mo.product_type_id in (SELECT TO_NUMBER(COLUMN_VALUE) valor
                                FROM TABLE
                                (open.LDC_BOUTILITIES.SPLITSTRINGS((select trim(replace(value_chain, '|', ',')) from ld_parameter where parameter_id = 'COD_SERVFINBRPRO'),',') )
                             )
   and mo.subscription_id = inuContrato
   and mo.package_id = mp.package_id
   and mp.package_type_id = (select NUMERIC_VALUE from ld_parameter where parameter_id = 'TIPO_SOL_VENTA_FNB')
   and mp.motive_status_id = (select NUMERIC_VALUE from ld_parameter where parameter_id = 'ID_ESTADO_PKG_ATENDTIDO'))
          AND i.non_ba_fi_requ_id = r.non_ba_fi_requ_id
          AND m.package_id = r.non_ba_fi_requ_id
          AND a.article_id = i.article_id
          AND oa.motive_id(+) = i.non_ban_fi_item_id
          AND ov.order_activity_id = oa.order_activity_id
          AND oa.activity_id = (select NUMERIC_VALUE from ld_parameter where parameter_id = 'ACTIVITY_TYPE_FNB'))
          where EstEnt = 'Entregado'; --parametro entregado

        /*16/07/2015 heiberb Cambio 7805 Cursor para buscar cantidad de ventas migradas de ese contrato*/
        CURSOR cu_Cant_ven_MGR is
         select count(*)
           from LDC_SCORHIST hst
          where hst.suscriptor = inuContrato;

         /* 16/07/2015 heiberb Cambio 7805 Cursor para validar diferidos con saldo*/
         CURSOR cu_Dif_Saldo is
            SELECT count(*)
              FROM diferido d, servsusc s
             WHERE difesusc = inuContrato
               AND difenuse = sesunuse
               AND instr (DALD_PARAMETER.fsbGetValue_Chain('COD_SERVFINBRPRO'),sesuserv)>0
               AND difesusc = sesususc
               and difesape > 0;

         /*16/07/2015 heiberb Cambio 7805 Cursor para validar corriente con saldo*/
       CURSOR cu_CurrentDebito is
           SELECT /*+
                  ordered
                  use_nl(servsusc cuencobr cargos)
                  index_rs_asc(servsusc IX_SERVSUSC12)
                  index_rs_asc(cuencobr IX_CUENCOBR03)
                  index_rs_asc(cargos IX_CARGOS02)*/
               nvl(SUM(cargvalo),0)
              FROM servsusc, cuencobr, cargos, concepto
             WHERE sesususc = inuContrato
               AND instr(DALD_PARAMETER.fsbGetValue_Chain('COD_SERVFINBRPRO'),
                         sesuserv) > 0
               AND sesunuse = cuconuse
               AND nvl(cucosacu, 0) > 0
               AND cucocodi = cargcuco
               AND cargdoso like '%DF-%'
               AND cargsign = 'DB'
               and cargconc = conccodi
               and concclco = (select NUMERIC_VALUE from ld_parameter where parameter_id = 'CLASIF_BRILLA'); --parametro brilla;

               CURSOR cu_fecha_pago is
                SELECT * FROM (
         select cucofepa from (
         SELECT cucocodi, cucofepa
                      FROM servsusc, cuencobr, cargos, concepto
                     WHERE instr(DALD_PARAMETER.fsbGetValue_Chain('COD_SERVFINBRPRO'),
                                 sesuserv) > 0
                       AND sesunuse = cuconuse
                       and sesususc = inucontrato
                       AND nvl(cucosacu, 0) = 0
                       AND cucocodi = cargcuco
                       AND cargdoso like '%DF-%'
                       AND cargsign = 'DB'
                       and cargconc = conccodi
                       and concclco = (select NUMERIC_VALUE from ld_parameter where parameter_id = 'CLASIF_BRILLA') --clasificador Brilla
                     order by cucofepa DESC nulls last) where rownum = 1
         UNION ALL
         (SELECT cucofepa FROM (
                  SELECT NON_BA_FI_REQU_ID, STATUS_CHANGE_DATE cucofepa FROM LD_NON_BA_FI_REQU ld, mo_motive mt, mo_packages mo
                  WHERE payment = VALUE_TOTAL
                   AND ld.non_ba_fi_requ_id = mt.package_id
                   AND mo.package_id = mt.package_id
                   AND mo.package_type_id = (select NUMERIC_VALUE from ld_parameter where parameter_id = 'TIPO_SOL_VENTA_FNB')
                   AND mo.motive_status_id = (select NUMERIC_VALUE from ld_parameter where parameter_id = 'ID_ESTADO_PKG_ATENDTIDO')
                   and mt.subscription_id = inucontrato
                   ORDER BY STATUS_CHANGE_DATE DESC)
                   WHERE ROWNUM = 1)) WHERE cucofepa IS NOT NULL
                   AND ROWNUM = 1;

    BEGIN

      ut_trace.trace('Inicia ldc_bccommercialsegmentfnb.fsbRolloverSusc',1);

        open cu_Get_Data_Sell;
        fetch cu_Get_Data_Sell into nuCanSellEfect;
        close cu_Get_Data_Sell;

        open cu_Cant_ven_MGR;
        fetch cu_Cant_ven_MGR into nuCantMigr;
        close cu_Cant_ven_MGR;

        open cuDifeSegmentRollN;
        fetch cuDifeSegmentRollN into nuMeses;
        close cuDifeSegmentRollN;

        open cuGetParaRol;
        fetch cuGetParaRol into nuCantSell;
        close cuGetParaRol;

        nuTotalSell := nuCanSellEfect + nuCantMigr;

        IF (nuTotalSell >= nuCantSell) THEN --registros de ventas si es mayor a las ventas paranetrizadas

          IF (DALD_PARAMETER.fsbGetValue_Chain('EVALUDEUDAR') = 'S') then --valida si evaluda cartera dif + corr

              open cu_Dif_Saldo; --obtiene la cantidad de diferidos con saldo
              fetch cu_Dif_Saldo into nuCantiDifer;
              close cu_Dif_Saldo;

                if (nuCantiDifer > cnucero) then
                 blHasDef := true; --no ha terminado de pagar el diferido
                 else
                 blHasDef := false; -- no tiene diferidos con saldo
                end if;

             /*Se evalúa que haya deuda en corriente*/
                open cu_CurrentDebito;
                fetch cu_CurrentDebito into nuValor;
                close cu_CurrentDebito;

                --si hay valor en corriente
                if nuValor > cnucero then
                  blHasValue := true;

                else
                  blHasValue := false;

                end if;

              if not blHasDef and not blHasValue then --identifica que no tiene dedua ni en diferido ni en corriente

                open cu_fecha_pago;--trae fecha termnina pago ultimo diferido pago
                fetch cu_fecha_pago into daFechaPago;
                close cu_fecha_pago;

                if daFechaPago is not null then
              --validacion para las fechas para determinar el semento Actual o Actual regular
                      if (trunc(add_months(daFechaPago, nvl(nuMeses,0))) >= ut_date.fdtsysdate) then

                      sbResult := cnuSegmentRollN;

                      else

                      sbResult := cnuSegmentRollD;

                      END IF;

                ELSE

                  sbResult := cnuSegmentRollD;-- se toma como n por no habre pago DALD_PARAMETER.fsbGetValue_Chain('SEGNOFECHPAR'); --si no encuentra fecha pago asigna segmento parametrizado--validar con parametro;

                end if;

              else

               sbResult := cnuSegmentRoll; --tiene deuda asi que es rollover

              end if;
          else

                open cu_fecha_pago;--trae fecha termnina pago ultimo diferido pago
                fetch cu_fecha_pago into daFechaPago;
                close cu_fecha_pago;

              if daFechaPago is not null then
                --validacion para las fechas para determinar el semento Actual o Actual regular
                        if (trunc(add_months(daFechaPago, nvl(nuMeses,0))) >= ut_date.fdtsysdate) then

                        sbResult := cnuSegmentRollN;

                        else

                        sbResult := cnuSegmentRollD;

                        END IF;

                ELSE

                    sbResult := cnuSegmentRollD;--rollover N no registra pago pero tiene deuda--DALD_PARAMETER.fsbGetValue_Chain('SEGNOFECHPAR'); --si no encuentra fecha pago asigna segmento parametrizado

                end if;
          end if;

        else --no hay ventas y se validan los diferidos

          open cu_alldeferreds;
          fetch cu_alldeferreds into nuCantDife;
          close cu_alldeferreds;

          if (nuCantDife >= nuCantSell) then

            IF (DALD_PARAMETER.fsbGetValue_Chain('EVALUDEUDAR') = 'S') then --valida si evaluda cartera dif + corr

              open cu_Dif_Saldo; --obtiene la cantidad de diferidos con saldo
              fetch cu_Dif_Saldo into nuCantiDifer;
              close cu_Dif_Saldo;

                if (nuCantiDifer > cnucero) then
                 blHasDef := true; --no ha terminado de pagar el diferido
                 else
                 blHasDef := false; -- no tiene diferidos con saldo
                end if;

             /*Se evalúa que haya deuda en corriente*/
                open cu_CurrentDebito;
                fetch cu_CurrentDebito into nuValor;
                close cu_CurrentDebito;

                --si hay valor en corriente
                if nuValor > cnucero then
                  blHasValue := true;

                else
                  blHasValue := false;

                end if;

              if not blHasDef and not blHasValue then --identifica que no tiene dedua ni en diferido ni en corriente

                open cu_fecha_pago;--trae fecha termnina pago ultimo diferido pago
                fetch cu_fecha_pago into daFechaPago;
                close cu_fecha_pago;

                if daFechaPago is not null then
              --validacion para las fechas para determinar el semento Actual o Actual regular
                      if (trunc(add_months(daFechaPago, nvl(nuMeses,0))) >= ut_date.fdtsysdate) then

                      sbResult := cnuSegmentRollN;

                      else

                      sbResult := cnuSegmentRollD;

                      END IF;

                ELSE

                  sbResult := cnuSegmentRollD;--rollover N ya que tiene diferidos pero no hay pago DALD_PARAMETER.fsbGetValue_Chain('SEGNOFECHPAR'); --si no encuentra fecha pago asigna segmento parametrizado--validar con parametro;

                end if;

              else

               sbResult := cnuSegmentRoll; --aun tiene cartera

              end if;
          else

                open cu_fecha_pago;--trae fecha termnina pago ultimo diferido pago
                fetch cu_fecha_pago into daFechaPago;
                close cu_fecha_pago;

              if daFechaPago is not null then
                --validacion para las fechas para determinar el semento Actual o Actual regular
                        if (trunc(add_months(daFechaPago, nvl(nuMeses,0))) >= ut_date.fdtsysdate) then

                        sbResult := cnuSegmentRollN;

                        else

                        sbResult := cnuSegmentRollD;

                        END IF;

                ELSE

                    sbResult := cnuSegmentRollD;--no evalua deduda y no tiene pago pero si tuvo diferido DALD_PARAMETER.fsbGetValue_Chain('SEGNOFECHPAR'); --si no encuentra fecha pago asigna segmento parametrizado

                end if;
            end if;


        end if;
        end if;

/*      \*Obtiene todos los diferidos FNB del contrato*\
      for i in cuAllDeferreds(inucontrato) loop

        blHasDeferr := true;

        \*Si todos los diferidos deben estar saldados*\
        if inuCantDiferidos = -1 then
          if i.difesape > cnucero then
            nuincump := cnuone;
            exit;
          else
            \*Valida deuda corriente por cada diferido*\
            open  cu_currdebt (i.difenuse, i.difecodi);
            fetch cu_currdebt into nuValor;
            close cu_currdebt;

            if nuValor > cnucero then
              nuincump := cnuone;
              exit;
            end if;
            continue;

          end if;

        \*Si sólo un diferido debe estar saldado*\
        elsif inucantdiferidos = cnuone then
           if i.difesape > cnucero then
              nuincump := cnuone;
              continue;
           else
             \*Valida deuda corriente por cada diferido*\
             open  cu_currdebt (i.difenuse, i.difecodi);
             fetch cu_currdebt into nuValor;
             close cu_currdebt;

             if nuValor = cnucero then
               nuincump := 0;
               exit;
             else
               nuincump := cnuone;
             end if;

           end if;
        else
          nuincump := cnuone;
        end if;

      end loop;

    \*Si algún diferido no cumplió con la regla*\
    if nuincump > cnucero then

      if inucantdiferidos = 1 then
        \*Valida si por lo menos hubo una venta de contado*\
        if fblHasCashSales(inucontrato) then
          sbresult := cnuSegmentRoll;
        else
          sbresult := null;
        end if;

      else
        sbresult := null;
      end if;

     else
       if blHasDeferr then
          sbresult := cnuSegmentRoll;
       else

         if fblHasCashSales(inucontrato)then
           sbresult := cnuSegmentRoll;
         else
           sbresult := null;
         end if;

       end if;
     end if;*/

    /*Indica que ya evaluó la segmentación Rollover*/
    ldc_bocommercialsegmentfnb.blFlagRollOver := true;

    ut_trace.trace('ldc_bccommercialsegmentfnb.fsbRolloverSusc - Resultado '||nvl(sbResult,'Ninguno'),1);

    return sbresult;

    EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
        RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        Errors.setError;
        RAISE ex.CONTROLLED_ERROR;
    END fsbRolloverSusc;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbGasapplSusc
    Descripcion    : Valida si el usuario pertenece a la segmentación comercial Gasodoméstico.
                     Segmentación Gasodoméstico: Clientes que tienen un cupo Brilla 0, por
                     incumplir las políticas que se configuren en LDCSC (Política 24 y 26).

    Autor          : KCienfuegos.RNP198
    Fecha          : 22/09/2014

    Parametros                   Descripcion
    ============             ===================
    inuContrato:              Id del contrato
    isbExclusPolicy:           Pólizas a excluir

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    25/03/2015       KCienfuegos.RNP198    Se valida si tiene cupo bloqueado.
    22/09/2014       KCienfuegos.RNP198    Creación.
    ******************************************************************/
    FUNCTION fsbGasapplSusc(inuSubscriptionId in suscripc.susccodi%type,
                            isbExclusPolicy   in ld_parameter.value_chain%type)
      return VARCHAR2 IS

      nuIndex            number;
      sbResult           ldc_condit_commerc_segm.acronym%type;
      otbPolicyHistoric  dald_policy_historic.tytbLD_policy_historic;
      nuQuotaHistoricId  ld_quota_historic.quota_historic_id%type;
      nuDiferidos        number;
      tbBlockQuota       dald_quota_block.tytbBlock;
      blLockQuota        boolean := false;

      /*Cursor para obtener el último histórico de cupo*/
      cursor cu_ld_quota_historic (inuContrato suscripc.susccodi%type) is
        select quota_historic_id
          from (select qh.quota_historic_id
                  from ld_quota_historic qh, ld_policy_historic p
                 where qh.subscription_id = inuContrato
                   and p.quota_historic_id = qh.quota_historic_id
                 order by qh.quota_historic_id desc)
         where rownum = 1;

      /*Cursor para obtener el # de diferidos configurados para segmentación Rollover*/
      cursor cuDifeSegmentRoll is
        select sc.parameter
          from ldc_condit_commerc_segm sc
         where sc.cond_commer_segm_id= cnuSegmentRoll
           and sc.active = 'Y';

    BEGIN
      ut_trace.trace('Inicio ldc_bccommercialsegmentfnb.fsbGasapplSusc',1);

      if nuAssignedQuotaSusc = cnucero then

            /*Obtiene el último histórico de cupo*/
            open cu_ld_quota_historic(inuSubscriptionId);
            fetch cu_ld_quota_historic into nuQuotaHistoricId;
            close cu_ld_quota_historic;

            if nuQuotaHistoricId is null then
              sbResult := null;

            else

               if not ldc_bocommercialsegmentfnb.blFlagRollOver then

                 open cuDifeSegmentRoll;
                 fetch cuDifeSegmentRoll into nuDiferidos;
                 close cuDifeSegmentRoll;

                 if nuDiferidos is not null then
                    sbResult := fsbRolloverSusc(inuSubscriptionId, nudiferidos);
                 end if;

               end if;

               /*Valida si fue clasificado con segmentación Rollover*/
               if sbResult is null then
                 /*Obtiene los bloqueos de cupo*/
                 tbBlockQuota := LD_BCNONBANKFINANCING.FtbGetQuota_Block(inuSubscriptionId);

                 /* Trae el registro de bloqueo y desbloqueo mas reciente a partir del contrato*/
                 if tbBlockQuota.count > 0 then

                     if (tbBlockQuota(tbBlockQuota.first) = 'Y') then
                       blLockQuota := true;
                     end if;

                 end if;

                  dald_policy_historic.getRecords('QUOTA_HISTORIC_ID = '||nuQuotaHistoricId,otbPolicyHistoric);

                  if otbPolicyHistoric.count > cnucero and not blLockQuota then
                    nuIndex := otbPolicyHistoric.first;

                    while nuIndex is not null loop

                      /*Valida si incumple la política*/
                      if otbPolicyHistoric(nuIndex).result = csbNoFlag then

                         /*Valida si la política que se incumple es una de las configuradas en el parámetro*/
                         if  instr (isbExclusPolicy,otbPolicyHistoric(nuIndex).quota_assign_policy_id)>0 then
                           sbResult := cnuSegmentGas;
                         else
                           sbResult := null;
                           exit;
                         end if;

                      end if;

                      nuIndex := otbPolicyHistoric.next(nuIndex);
                    end loop;

                  end if;
               end if;

             end if;

      end if;

      ut_trace.trace('ldc_bccommercialsegmentfnb.fsbGasapplSusc - Resultado '||nvl(sbResult,'Ninguno'),1);

      return sbResult;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    END fsbGasapplSusc;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbFuturSusc
    Descripcion    : Valida si el usuario pertenece a la segmentación comercial Futuro.
                     Segmentación Futuro: Clientes que no poseen cupo Brilla por incumplir algunas
                     de las políticas de asignación de cupo (diferentes a las políticas para marcación
                     de gasodoméstico), sin embargo, máximo en N meses(parámetro) tendrá cupo.

    Autor          : KCienfuegos.RNP198
    Fecha          : 24/09/2014

    Parametros                   Descripcion
    ============             ===================
    inuContrato:              Id del contrato
    isbExclusPolicy:           Pólizas a excluir

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    25/03/2015       KCienfuegos.RNP198    Se valida si tiene cupo bloqueado.
    19/03/2014       KCienfuegos.RNP198    Se modifica para que las políticas que no tengan valor configurado
                                           en FIDCC, se les coloque 0 por defecto. Adicionalmente, si es la política de
                                           saldo de red (valor), también se le coloque 0 al parámetro.
    24/09/2014       KCienfuegos.RNP198    Creación.
    ******************************************************************/
    FUNCTION fsbFuturSusc(inuSubscriptionId in suscripc.susccodi%type,
                          inuMeses   in number)
      return VARCHAR2 IS

      nuDiferidos        number;
      nuContPolFut       number := 0;
      blValidateFut      boolean := false;
      nuCreditConf       number;
      dtLastExp          date;
      sbParentLocation   varchar2(1000);
      sbResult           ldc_condit_commerc_segm.acronym%type;
      nuQuotaHistoricId  ld_quota_historic.quota_historic_id%type;
      sbParameter        ldc_condit_commerc_segm.parameter%type;
      dtBreach_Date      ld_policy_historic.breach_date%type;
      dtRecov_Date       ld_policy_historic.breach_date%type;
      nuQuotaValue       ld_quota_by_subsc.quota_value%type;
      nuGasAddressId     ab_address.address_id%type;
      nuProduct          pr_product.product_id%type;
      rcServsusc         servsusc%rowtype;
      nuGeogLoca         ge_geogra_location.geograp_location_id%type;
      rcSubscription     suscripc%rowtype;
      nuNeighborthoodId  ab_address.neighborthood_id%type;
      nuCategory         servsusc.Sesucate%type;
      nuSubcategory      servsusc.Sesusuca%type;
      tbCreditQuota      dald_credit_quota.tytbLD_credit_quota;
      nuParameter        ld_policy_by_cred_quot.parameter_value%type;
      nuLastPolicyId     ld_policy_historic.quota_assign_policy_id%type;
      tbBlockQuota       dald_quota_block.tytbBlock;
      blLockQuota        boolean := false;

      /*Cursor para obtener el último histórico de cupo*/
      cursor cu_ld_quota_historic (inuContrato suscripc.susccodi%type) is
        select quota_historic_id, assigned_quote
          from (select qh.quota_historic_id, qh.assigned_quote
                  from ld_quota_historic qh, ld_policy_historic p
                 where qh.subscription_id = inuContrato
                   and qh.quota_historic_id = p.quota_historic_id
                 order by qh.quota_historic_id desc)
         where rownum = 1;

      /*Cursor para obtener parámetro de segmentación Gas*/
      cursor cu_ParamSegmGas is
        select s.parameter
          from ldc_condit_commerc_segm s
         where s.cond_commer_segm_id = cnuSegmentGas
           and rownum    = cnuone
           and s.active = 'Y';

      /*Obtiene las políticas incumplidas*/
      cursor cu_BrokenPolicies is
        select *
          from ld_policy_historic ld
         where ld.quota_historic_id = nuQuotaHistoricId
          and ld.result = csbNoFlag;

      /*Cursor para obtener el # de diferidos configurados para segmentación Rollover*/
      cursor cuDifeSegmentRoll is
        select sc.parameter
          from ldc_condit_commerc_segm sc
         where sc.cond_commer_segm_id= cnuSegmentRoll
           and sc.active = 'Y';

      /*Cursor para obtener el parámetro configurado en FIDCC para la política evaluada*/
      cursor cuParamPolicy(nuAssignPolici number, nuConfCred number) is
       select parameter_value
         from ld_policy_by_cred_quot p
        where p.credit_quota_id = nuConfCred
          and active = 'Y'
          and p.quota_assign_policy_id = nuAssignPolici;

    BEGIN
      ut_trace.trace('Inicio ldc_bccommercialsegmentfnb.fsbFuturSusc',1);

      /*Obtiene el último histórico de cupo*/
      open cu_ld_quota_historic(inuSubscriptionId);
      fetch cu_ld_quota_historic into nuQuotaHistoricId, nuQuotaValue;
      close cu_ld_quota_historic;

      /*Obtiene el valor del parámetro configurado para segmentación Gasodoméstico*/
      open cu_ParamSegmGas;
      fetch cu_ParamSegmGas into sbParameter;
      close cu_ParamSegmGas;

      sbParameter := nvl(sbParameter,-1);

      if (nuQuotaHistoricId is null or nvl(nuQuotaValue,cnucero) <> cnucero) then
        sbResult := null;
      else
        if (not ldc_bocommercialsegmentfnb.blFlagRollOver) then

           open cuDifeSegmentRoll;
           fetch cuDifeSegmentRoll into nuDiferidos;
           close cuDifeSegmentRoll;

           if (nuDiferidos is not null) then
              sbResult := fsbRolloverSusc(inuSubscriptionId, nudiferidos);
           end if;

        end if;

        if (sbResult is null) then
          getGasProductData(inuSubscriptionId, nuProduct, nuGasAddressId);

          if (nuProduct is not null) then
            /*Obtiene el record de los datos del servicio gas*/
             rcServsusc := pktblservsusc.frcGetRecord(nuProduct);

             /*Obtiene la subcategoria del producto gas*/
             nuSubcategory := rcServsusc.Sesusuca;

             /*Obtiene la categoria del producto gas*/
             nuCategory := rcServsusc.Sesucate;

             /*Obtiene la ubicacion geografica del producto gas*/
             nuGeogLoca := daab_address.fnuGetGeograp_Location_Id(nuGasAddressId);

             /*Obtiene los datos del suscritor*/
             rcSubscription := pktblsuscripc.frcgetrecord(inuSubscriptionId);

             /*Se obtienen los datos de la dirección del contrato*/
             nuNeighborthoodId := daab_address.fnugetneighborthood_id(rcSubscription.susciddi);

             if (nuNeighborthoodId IS null or nuNeighborthoodId = LD_BOConstans.cnuallrows) then

                /*Obtiene ubicación geográfica padre*/
                ge_bogeogra_location.GetGeograpParents(nuGeogLoca, sbParentLocation);
             else
                /*Obtiene ubicación geográfica padre*/
                ge_bogeogra_location.GetGeograpParents(nuNeighborthoodId, sbParentLocation);
             end if;

             /*Obtiene la configuración que aplica al contrato*/
             tbCreditQuota := LD_BCNONBANKFINANCING.ftbGetCreditQuote(nuCategory,
                                                                      nuSubcategory,
                                                                      sbParentLocation);

             if (tbCreditQuota.count > 0) then
               nuCreditConf := tbCreditQuota(tbCreditQuota.first).credit_quota_id;
             end if;

          end if;

          /*Obtiene los bloqueos de cupo*/
          tbBlockQuota := LD_BCNONBANKFINANCING.FtbGetQuota_Block(inuSubscriptionId);

          /* Trae el registro de bloqueo y desbloqueo mas reciente a partir del contrato*/
          if tbBlockQuota.count > 0 then

             if (tbBlockQuota(tbBlockQuota.first) = 'Y') then
               blLockQuota := true;
             end if;

          end if;

        /*Si no está bloqueado el cupo, evalúa la conf*/
        if  not blLockQuota then
          /*Obtiene las políticas incumplidas*/
          for p in cu_BrokenPolicies loop

               blValidateFut := true;

               /*Obtiene la fecha de incumplimiento*/
               dtBreach_Date := nvl(p.breach_date,ut_date.fdtsysdate);

               if (instr (sbParameter,p.quota_assign_policy_id)=0) then
                 nuContPolFut := nuContPolFut + 1;
               end if;

               /*Obtiene el parámetro configurado en FIDCC para la política incumplida*/
               open cuParamPolicy(p.quota_assign_policy_id,nuCreditConf);
               fetch cuParamPolicy into nuParameter;
               close cuParamPolicy;

               nuParameter := nvl(nuParameter,cnucero);

               if (instr(csbPolRedVal,p.quota_assign_policy_id)>0) then
                   nuParameter := cnucero;
               end if;

               dtRecov_Date := add_months(dtBreach_Date, nuParameter);
               ut_trace.trace('Fecha de vencimiento de política'||dtRecov_Date,1);

               if (dtLastExp is null) then
                 dtLastExp := dtRecov_Date;
                 nuLastPolicyId := p.quota_assign_policy_id;
               else
                 if (dtLastExp < dtRecov_Date) then
                   ut_trace.trace('Fecha de vencimiento '||dtRecov_Date,1);
                   dtLastExp := dtRecov_Date;
                   nuLastPolicyId := p.quota_assign_policy_id;
                 end if;

               end if;

          end loop;

            if (blValidateFut) then
              ut_trace.trace('Se evalúa la fecha de vencimiento con el período de evaluación futuro',1);

               if nuContPolFut > 0 then
                /*Valida si la fecha de incumplimiento vence en los N meses*/
                 if (trunc(add_months(ut_date.fdtsysdate,nvl(inuMeses,0))) >= trunc(nvl(dtLastExp,ut_date.fdtsysdate))) then
                    sbResult := cnuSegmentFutu;
                 else
                    sbResult := null;
                 end if;
               else
                 sbResult := null;

               end if;

             end if;

           end if;

         end if;

      end if;

      /*Indica que ya evaluó la segmentación Futuro*/
      ldc_bocommercialsegmentfnb.blFlagFuture := true;

      ut_trace.trace('ldc_bccommercialsegmentfnb.fsbFuturSusc - Resultado '||nvl(sbResult,'Ninguno'),1);

      return sbResult;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    END fsbFuturSusc;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbNoQuotaSusc
    Descripcion    : Valida si el usuario pertenece a la segmentación comercial Sin Cupo.

    Autor          : KCienfuegos.RNP198
    Fecha          : 24/09/2014

    Parametros                   Descripcion
    ============             ===================
    inuContrato:              Id del contrato
    isbExclusPolicy:           Pólizas a excluir

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    20/03/2015       KCienfuegos.RNP198    Se modifica para quitar la validación del resultado del cupo, ya que
                                           excluiría los usuario con bloqueo de cupo.
    24/09/2014       KCienfuegos.RNP198    Creación.
    ******************************************************************/
    FUNCTION fsbNoQuotaSusc(inuSubscriptionId in suscripc.susccodi%type)
      return VARCHAR2 IS

      sbResult           ldc_condit_commerc_segm.acronym%type;
      nuTime             number;
      nuTimeM             number;
      nuTimeL             number;

      /*Cursor para obtener el tiempo configurado para segmentación comercial*/
      cursor cuSegmentFutur is
        select sc.time
          from ldc_condit_commerc_segm sc
         where sc.cond_commer_segm_id= cnuSegmentFutu
           and sc.active = 'Y';

     /*Cursor para obtener el tiempo configurado para segmentación futuro mediano*/
      cursor cuSegmentFuturM is
        select sc.time
          from ldc_condit_commerc_segm sc
         where sc.cond_commer_segm_id= cnuSegmentFutuM
           and sc.active = 'Y';

      /*Cursor para obtener el tiempo configurado para segmentación futuro lejano*/
      cursor cuSegmentFuturL is
        select sc.time
          from ldc_condit_commerc_segm sc
         where sc.cond_commer_segm_id= cnuSegmentFutuL
           and sc.active = 'Y';

    BEGIN
     ut_trace.trace('Inicio ldc_bccommercialsegmentfnb.fsbNoQuotaSusc',1);

      if nvl(nuAssignedQuotaSusc,cnucero) = cnucero then
        if ldc_bocommercialsegmentfnb.blFlagFuture then
         sbResult := cnuSegmentNoQuot;
        else
          open cuSegmentFutur;
          fetch cuSegmentFutur into nuTime;
          close cuSegmentFutur;

          open cuSegmentFuturM;
          fetch cuSegmentFuturM into nuTimeM;
          close cuSegmentFuturM;

          open cuSegmentFuturL;
          fetch cuSegmentFuturL into nuTimeL;
          close cuSegmentFuturL;

          if nuTime is not null then
            sbResult := fsbFuturSusc(inuSubscriptionId, nutime);

            if sbResult is null then
              sbResult := fsbFuturSuscM(inuSubscriptionId, nutimeM);
            end if;

            if sbResult is null then
              sbResult := fsbFuturSuscL(inuSubscriptionId, nutimeL);
            end if;

          end if;

          if sbResult is null then
            sbResult := cnuSegmentNoQuot;
          end if;

        end if;
      end if;

      return sbResult;

      ut_trace.trace('Fin ldc_bccommercialsegmentfnb.fsbNoQuotaSusc',1);

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    END fsbNoQuotaSusc;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : frcGetSegmentSuscRec
    Descripcion    : Obtiene el registro de segmentación actual del contrato.

    Autor          : KCienfuegos.RNP198
    Fecha          : 24/09/2014

    Parametros              Descripcion
    ============         ===================
    inuSubscription       Id del contrato


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    24/09/2014      KCienfuegos.RNP198  Creación
    ******************************************************************/
    FUNCTION frcGetSegmentSuscRec(inuSubscription suscripc.susccodi%type)
      return daldc_segment_susc.styldc_segment_susc IS

      cursor cuSegmentRecord
      is
        select ldc_segment_susc .*, rowid
          from ldc_segment_susc
         where ldc_segment_susc.subscription_id = inuSubscription;

      rcSegmentSubsc daldc_segment_susc.styldc_segment_susc;

    BEGIN

      open cuSegmentRecord;
      fetch cuSegmentRecord
        into rcSegmentSubsc;
      close cuSegmentRecord;

      return rcSegmentSubsc;


    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    END frcGetSegmentSuscRec;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fnuGetSegmentbySusc
    Descripcion    : Obtiene el Id de la segmentación del contrato.

    Autor          : KCienfuegos.RNP198
    Fecha          : 24/09/2014

    Parametros              Descripcion
    ============         ===================
    inuSubscription       Id del contrato


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    24/09/2014      KCienfuegos.RNP198  Creación
    ******************************************************************/
    FUNCTION fnuGetSegmentbySusc(inuSubscription suscripc.susccodi%type)
      return NUMBER IS

      cursor cuSegmentId
      is
        select s.segment_id
          from ldc_segment_susc s
         where s.subscription_id = inuSubscription;

      nuSegment     ldc_segment_susc.segment_id%type;

    BEGIN

      open cuSegmentId;
      fetch cuSegmentId into nuSegment;
      close cuSegmentId;


      return nuSegment;


    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    END fnuGetSegmentbySusc;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbGetSegmentbySusc
    Descripcion    : Obtiene la sigla de la segmentación del contrato.

    Autor          : KCienfuegos.RNP198
    Fecha          : 24/09/2014

    Parametros              Descripcion
    ============         ===================
    inuSubscription       Id del contrato


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    24/09/2014      KCienfuegos.RNP198  Creación
    ******************************************************************/
    FUNCTION fsbGetSegmentbySusc(inuSubscription suscripc.susccodi%type)
      return VARCHAR2 IS

      cursor cuAcronymSegment
      is
        select nvl(cs.acronym,'N/A')
          from ldc_segment_susc s, ldc_condit_commerc_segm cs
         where s.subscription_id = inuSubscription
           and s.segment_id = cs.cond_commer_segm_id;

      sbSegment     ldc_condit_commerc_segm.acronym%type;

    BEGIN

      open cuAcronymSegment;
      fetch cuAcronymSegment into sbSegment;
      close cuAcronymSegment;

      sbSegment := nvl(sbSegment,'N/A');

      return sbSegment;


    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    END fsbGetSegmentbySusc;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : proGetAcronNameSegmbySusc
    Descripcion    : Obtiene la sigla y nombre de la segmentación del contrato.

    Autor          : KCienfuegos.RNP198
    Fecha          : 25/09/2014

    Parametros              Descripcion
    ============         ===================
    inuSubscription       Id del contrato
    onuSegmentId          Id de la segmentación
    osbSegment            Descripción de la segmentación

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    25/09/2014      KCienfuegos.RNP198  Creación
    ******************************************************************/
    PROCEDURE proGetAcronNameSegmbySusc (inuSubscription in suscripc.susccodi%type,
                                         onuSegmentId    out ldc_segment_susc.segment_id%type,
                                         osbSegment      out varchar2)IS

      cursor cuAcronymSegment
      is
        select s.segment_id, cs.acronym ||' - '||cs.description
          from ldc_segment_susc s, ldc_condit_commerc_segm cs
         where s.subscription_id = to_number(inuSubscription)
           and s.segment_id = cs.cond_commer_segm_id;

    BEGIN
      ut_trace.trace('Inicio ldc_bccommercialsegmentfnb.proGetAcronNameSegmbySusc',1);

       ut_trace.trace('ldc_bccommercialsegmentfnb.proGetAcronNameSegmbySusc: -->'||inuSubscription,1);

      /*Obtiene la sigla y descripción de la segmentación*/
      open cuAcronymSegment;
      fetch cuAcronymSegment into onuSegmentId, osbSegment;
      close cuAcronymSegment;

      if onuSegmentId is null then
        onuSegmentId := 0;
        osbSegment := DALD_PARAMETER.fsbGetValue_Chain('DESCRIPC_SEGMENT_NO_EXISTE');
      end if;

      ut_trace.trace('Fin ldc_bccommercialsegmentfnb.proGetAcronNameSegmbySusc',1);

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    END proGetAcronNameSegmbySusc;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbGetAcronNameSegmbySusc
    Descripcion    : Obtiene la sigla y nombre de la segmentación del contrato.
                     Utilizado en RUORD.

    Autor          : KCienfuegos.RNP198
    Fecha          : 25/09/2014

    Parametros              Descripcion
    ============         ===================
    inuSubscription       Id del contrato
    onuSegmentId          Id de la segmentación
    osbSegment            Descripción de la segmentación

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    25/09/2014      KCienfuegos.RNP198  Creación
    ******************************************************************/
    FUNCTION fsbGetAcronNameSegmbySusc (inuSubscription in suscripc.susccodi%type)
      RETURN VARCHAR2 IS

      cursor cuAcronymSegment
      is
        select cs.acronym ||' - '||cs.description
          from ldc_segment_susc s, ldc_condit_commerc_segm cs
         where s.subscription_id = to_number(inuSubscription)
           and s.segment_id = cs.cond_commer_segm_id;

      sbSegmentacion        varchar2(100);

    BEGIN
      ut_trace.trace('Inicio ldc_bccommercialsegmentfnb.fsbGetAcronNameSegmbySusc',1);

       ut_trace.trace('ldc_bccommercialsegmentfnb.fsbGetAcronNameSegmbySusc: -->'||inuSubscription,1);

      /*Obtiene la sigla y descripción de la segmentación*/
      open cuAcronymSegment;
      fetch cuAcronymSegment into sbSegmentacion;
      close cuAcronymSegment;

      if sbSegmentacion is null then
        sbSegmentacion := DALD_PARAMETER.fsbGetValue_Chain('DESCRIPC_SEGMENT_NO_EXISTE');
      end if;

      return sbSegmentacion;

      ut_trace.trace('Fin ldc_bccommercialsegmentfnb.fsbGetAcronNameSegmbySusc',1);

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    END fsbGetAcronNameSegmbySusc;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fnuGetQuotaSusc
    Descripcion    : Obtiene el cupo actual del contrato

    Autor          : KCienfuegos.RNP198
    Fecha          : 26/09/2014

    Parametros              Descripcion
    ============         ===================
    inuSubscription       Id del contrato


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    26/09/2014      KCienfuegos.RNP198  Creación
    ******************************************************************/
    FUNCTION fnuGetQuotaSusc(inuSubscription suscripc.susccodi%type)
      return NUMBER IS

      nuAssignedQuota       ld_quota_by_subsc.quota_value%type;
      nuUsedQuota           ld_quota_by_subsc.quota_value%type;
      nuAvailableQuota      ld_quota_by_subsc.quota_value%type;

      cursor cuQuotavalue(inuContrato suscripc.susccodi%type) is
        select qs.quota_value
          from ld_quota_by_subsc qs
         where qs.subscription_id = inuContrato;

    BEGIN

      /*Se obtiene el cupo asignado*/
      open cuQuotavalue(inuSubscription);
      fetch cuQuotavalue into nuAssignedQuota;
      close cuQuotavalue;

      /*Se obtiene el cupo usado*/
      nuUsedQuota := ld_bononbankfinancing.fnuGetUsedQuote(inuSubscription);

      if (nuAssignedQuota >= nuUsedQuota) then
        nuAvailableQuota := nuAssignedQuota - nuUsedQuota;
      else
        nuAvailableQuota := 0;
      end if;

      return nuAvailableQuota;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    END fnuGetQuotaSusc;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fnuGetAssigQuota
    Descripcion    : Obtiene el cupo asignado al contrato.

    Autor          : KCienfuegos.RNP198
    Fecha          : 31/10/2014

    Parametros              Descripcion
    ============         ===================
    inuSubscription       Id del contrato


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    31/10/2014      KCienfuegos.RNP198  Creación
    ******************************************************************/
    FUNCTION fnuGetAssigQuota(inuSubscription suscripc.susccodi%type)
      return NUMBER IS

      nuAssignedQuota       ld_quota_by_subsc.quota_value%type;

      cursor cuQuotavalue(inuContrato suscripc.susccodi%type) is
        select qs.quota_value
          from ld_quota_by_subsc qs
         where qs.subscription_id = inuContrato;

    BEGIN
      ut_trace.trace('Cupo del contrato inuSubscription '||inuSubscription,1);
      /*Se obtiene el cupo asignado*/
      open cuQuotavalue(inuSubscription);
      fetch cuQuotavalue into nuAssignedQuota;
      close cuQuotavalue;

      nuAssignedQuota := nvl(nuAssignedQuota,cnucero);

      return nuAssignedQuota;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    END fnuGetAssigQuota;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fblHasCashSales
    Descripcion    : Valida si tuvo ventas de contado.

    Autor          : KCienfuegos.RNP198
    Fecha          : 31/10/2014

    Parametros              Descripcion
    ============         ===================
    inuSubscription       Id del contrato


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    31/10/2014      KCienfuegos.RNP198  Creación.
    ******************************************************************/
    FUNCTION fblHasCashSales(inuSubscription suscripc.susccodi%type)
      return BOOLEAN IS

      nuContSales      number := cnucero;
      blresult         boolean := false;

      /*Cursor para obtener ventas de contado*/
      CURSOR cuvtascontado(inususc in suscripc.susccodi%type) is
         SELECT COUNT(*)
          FROM or_order_activity oa, mo_packages mp, ld_non_ba_fi_requ nb
         WHERE oa.activity_id = Dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB')
           AND oa.package_id = mp.package_id
           AND mp.package_type_id = dald_parameter.fnuGetNumeric_Value('COD_PACK_FNB')
           AND nb.non_ba_fi_requ_id = mp.package_id
           AND oa.subscription_id = inuSusc
           AND oa.status = 'F'
           AND nb.payment = nb.value_total
           AND EXISTS (SELECT oe.package_id
                             FROM ld_item_work_order iw, Or_Order_Activity oe
                            WHERE oe.order_activity_id = iw.order_activity_id
                              AND oe.package_id = mp.package_id
                              AND oe.activity_id =Dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB')
                              AND difecodi IS NOT NULL
                              AND oe.subscription_id = inuSusc
                              AND iw.state <>('AN'))
           AND ROWNUM=1;

    BEGIN

      /*Valida si ha tenido ventas de contado*/
      open cuvtascontado(inuSubscription);
      fetch cuvtascontado into nuContSales;
      close cuvtascontado;

      if nuContSales >  cnucero then
        blresult := true;
      else
        blresult := false;
      end if;

      return blresult;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    END fblHasCashSales;

    /*****************************************************************
    Propiedad intelectual de PETI(c).

    Unidad         : fnugetGasProduct
    Descripcion    : funcion que obtiene el identificador del producto GAS.
    Fecha          : 18/03/2015

    Parametros              Descripcion
    ============         ===================
    inuSubscription      Contrato
    onuProductId         Código de producto gas
    onuAddressId         Dirección

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
    PROCEDURE getGasProductData(inuSubscription in suscripc.susccodi%type,
                                onuProductId out pr_product.product_id%type,
                                onuAddressId out pr_product.address_id%type)
    IS


      tbGasProduct     dapr_product.tytbPR_product;

    BEGIN
      onuProductId := null;
      onuAddressId := null;

      tbGasProduct := pr_bcproduct.ftbGetProdBySubsNType(inuSubscription, ld_boconstans.cnuGasService);

      if (tbGasProduct.count > 0) then
        onuProductId := tbGasProduct(tbGasProduct.first).product_id;
        onuAddressId := tbGasProduct(tbGasProduct.first).address_id;
      end if;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    END getGasProductData;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbNewFNBSuscRe
    Descripcion    : Valida si el usuario pertenece a la segmentación comercial Nuevo.
                     Segmentación nuevo: Clientes que tienen cupo Brilla hace N meses
                     (parámetro) o menos tiempo y no lo han utilizado, es decir, nunca
                     han tenido un diferido asociado a los tipos de productos establecidos
                     en el parámetro COD_SERVFINBRPRO.

    Autor          : heiberb
    Fecha          : 16/07/2015

    Parametros                   Descripcion
    ============             ===================
    inuContrato:              Id del contrato
    inuMeses:                 Número de meses

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    16/07/2015       heiberb               Cambio 7805 Creación.
    ******************************************************************/
    FUNCTION fsbNewFNBSuscRe(inuContrato  in suscripc.susccodi%type,
                           inuMeses      in number)
      RETURN VARCHAR2 IS

      nuquantdefer              number := cnucero;
      numonths                 number := cnucero;
      dtassigned_date          ld_quota_historic.register_date%type;
      sbresult                 ldc_condit_commerc_segm.acronym%type;
      nuTimeSegNew             LDC_CONDIT_COMMERC_SEGM.TIME%type;

      /*Cursor para obtener el número de diferidos de Brilla*/
      cursor cuquantdeferrfnb(inususc in suscripc.susccodi%type) is
        select count(*)
          from diferido d, servsusc s
         where difesusc = sesususc
           and  instr (DALD_PARAMETER.fsbGetValue_Chain('COD_SERVFINBRPRO'),sesuserv)>0
           and difesusc = inususc
           and difenuse = sesunuse
           and difeconc not in (select conccore from concepto where conccodi in (select conccoin from concepto))
           and difecodi not in (select difecodi
                                 from ld_item_work_order iw, Or_Order_Activity oa
                                where oa.order_activity_id = iw.order_activity_id
                                  and oa.activity_id =Dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB')
                                  and difecodi is not null
                                  and iw.state in('AN')
                                  and oa.subscription_id = inususc)
           and difeconc <>  cnuconcsegvid;

      /*Cursor para obtener el registro de las asignaciones de cupo*/
      cursor culd_quota_historic(inususc in suscripc.susccodi%type) is
        select register_date, assigned_quote, qh.result
          from ld_quota_historic qh
         where qh.subscription_id = inususc
         order by qh.register_date desc;

       cursor cu_Segm_New is
       select sc.time
         from open.LDC_CONDIT_COMMERC_SEGM sc
        where cond_commer_segm_id = dald_parameter.fnuGetNumeric_Value('SEGMENT_NUEVO');

    BEGIN

      ut_trace.trace('Inicia ldc_bccommercialsegmentfnb.fsbNewFNBSusc',1);

      if nvl(nuAssignedQuotaSusc,cnucero) > cnucero then

        /*Se obtiene la cantidad de diferidos Brilla*/
        open cuquantdeferrfnb(inucontrato);
        fetch cuquantdeferrfnb into nuquantdefer;
        close cuquantdeferrfnb;

        open cu_Segm_New;
        fetch cu_Segm_New into nuTimeSegNew;
        close cu_Segm_New;

        if nvl(nuquantdefer,cnucero) = cnucero then

          /*Valida si ha tenido ventas de contado*/
          if not fblHasCashSales(inucontrato) then

            /*Obtiene la fecha de asignación de cupo*/
            for i in culd_quota_historic(inucontrato) loop
              if (nvl(i.assigned_quote,cnucero) = cnucero or i.result = csbNoFlag) then
               exit;
              else
               dtassigned_date := i.register_date;
              end if;
            end loop;

            /*Calcula el número de meses entre la fecha de asignación y la fecha actual*/
            numonths :=  months_between(ut_date.fdtsysdate, nvl(dtassigned_date,ut_date.fdtsysdate));

            /*Hace N meses o menos con el cupo y no lo ha utilizado*/
            if numonths <= inuMeses  and  numonths > nuTimeSegNew then
              sbresult := cnuSegmentNuevaR;
            else
              sbresult := null;
            end if;

          end if;

        else
             sbresult := null;
        end if;

      end if;

      ut_trace.trace('ldc_bccommercialsegmentfnb.fsbNewFNBSuscRe - Resultado '||nvl(sbResult,'Ninguno'),1);

      return sbresult;

    EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
        RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        Errors.setError;
        RAISE ex.CONTROLLED_ERROR;
    END fsbNewFNBSuscRe;


    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbFuturSuscM
    Descripcion    : Valida si el usuario pertenece a la segmentación comercial Futuro.
                     Segmentación Futuro: Clientes que no poseen cupo Brilla por incumplir algunas
                     de las políticas de asignación de cupo (diferentes a las políticas para marcación
                     de gasodoméstico), sin embargo, máximo en N meses(parámetro) tendrá cupo.

    Autor          : heiberb
    Fecha          : 16/07/2015

    Parametros                   Descripcion
    ============             ===================
    inuContrato:              Id del contrato
    isbExclusPolicy:           Pólizas a excluir

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    16/07/2015       heiberb               Cambio 7805 Creación.
    ******************************************************************/
    FUNCTION fsbFuturSuscM(inuSubscriptionId in suscripc.susccodi%type,
                          inuMeses   in number)
      return VARCHAR2 IS

      nuDiferidos        number;
      nuContPolFut       number := 0;
      blValidateFut      boolean := false;
      nuCreditConf       number;
      dtLastExp          date;
      sbParentLocation   varchar2(1000);
      sbResult           ldc_condit_commerc_segm.acronym%type;
      nuQuotaHistoricId  ld_quota_historic.quota_historic_id%type;
      sbParameter        ldc_condit_commerc_segm.parameter%type;
      dtBreach_Date      ld_policy_historic.breach_date%type;
      dtRecov_Date       ld_policy_historic.breach_date%type;
      nuQuotaValue       ld_quota_by_subsc.quota_value%type;
      nuGasAddressId     ab_address.address_id%type;
      nuProduct          pr_product.product_id%type;
      rcServsusc         servsusc%rowtype;
      nuGeogLoca         ge_geogra_location.geograp_location_id%type;
      rcSubscription     suscripc%rowtype;
      nuNeighborthoodId  ab_address.neighborthood_id%type;
      nuCategory         servsusc.Sesucate%type;
      nuSubcategory      servsusc.Sesusuca%type;
      tbCreditQuota      dald_credit_quota.tytbLD_credit_quota;
      nuParameter        ld_policy_by_cred_quot.parameter_value%type;
      nuLastPolicyId     ld_policy_historic.quota_assign_policy_id%type;
      tbBlockQuota       dald_quota_block.tytbBlock;
      blLockQuota        boolean := false;
      nuMesesCerc        number := 0; --variable para obtener el tiempo del segmento futuro cercano

      /*Cursor para obtener el último histórico de cupo*/
      cursor cu_ld_quota_historic (inuContrato suscripc.susccodi%type) is
        select quota_historic_id, assigned_quote
          from (select qh.quota_historic_id, qh.assigned_quote
                  from ld_quota_historic qh, ld_policy_historic p
                 where qh.subscription_id = inuContrato
                   and qh.quota_historic_id = p.quota_historic_id
                 order by qh.quota_historic_id desc)
         where rownum = 1;

      /*Cursor para obtener parámetro de segmentación Gas*/
      cursor cu_ParamSegmGas is
        select s.parameter
          from ldc_condit_commerc_segm s
         where s.cond_commer_segm_id = cnuSegmentGas
           and rownum    = cnuone
           and s.active = 'Y';

      /*Obtiene las políticas incumplidas*/
      cursor cu_BrokenPolicies is
        select *
          from ld_policy_historic ld
         where ld.quota_historic_id = nuQuotaHistoricId
          and ld.result = csbNoFlag;

      /*Cursor para obtener el # de diferidos configurados para segmentación Rollover*/
      cursor cuDifeSegmentRoll is
        select sc.parameter
          from ldc_condit_commerc_segm sc
         where sc.cond_commer_segm_id= cnuSegmentRoll
           and sc.active = 'Y';

      /*Cursor para obtener el parámetro configurado en FIDCC para la política evaluada*/
      cursor cuParamPolicy(nuAssignPolici number, nuConfCred number) is
       select parameter_value
         from ld_policy_by_cred_quot p
        where p.credit_quota_id = nuConfCred
          and active = 'Y'
          and p.quota_assign_policy_id = nuAssignPolici;

       /*Cursor para obtener el tiempo configurado en el segmento futuro cercano*/
       cursor cu_Segm_FutC is
       select sc.time
         from open.LDC_CONDIT_COMMERC_SEGM sc
        where cond_commer_segm_id = dald_parameter.fnuGetNumeric_Value('SEGMENT_FUTURO');


    BEGIN
      ut_trace.trace('Inicio ldc_bccommercialsegmentfnb.fsbFuturSuscL',1);

      /*Obtiene el último histórico de cupo*/
      open cu_ld_quota_historic(inuSubscriptionId);
      fetch cu_ld_quota_historic into nuQuotaHistoricId, nuQuotaValue;
      close cu_ld_quota_historic;

      /*Obtiene el valor del parámetro configurado para segmentación Gasodoméstico*/
      open cu_ParamSegmGas;
      fetch cu_ParamSegmGas into sbParameter;
      close cu_ParamSegmGas;

     /*Obtiene el tiempo del segmento configurado para segmentación futuro (Cercano)*/
      open cu_Segm_FutC;
      fetch cu_Segm_FutC into nuMesesCerc;
      close cu_Segm_FutC;

      sbParameter := nvl(sbParameter,-1);

      if (nuQuotaHistoricId is null or nvl(nuQuotaValue,cnucero) <> cnucero) then
        sbResult := null;
      else
        if (not ldc_bocommercialsegmentfnb.blFlagRollOver) then

           open cuDifeSegmentRoll;
           fetch cuDifeSegmentRoll into nuDiferidos;
           close cuDifeSegmentRoll;

           if (nuDiferidos is not null) then
              sbResult := fsbRolloverSusc(inuSubscriptionId, nudiferidos);
           end if;

        end if;

        if (sbResult is null) then
          getGasProductData(inuSubscriptionId, nuProduct, nuGasAddressId);

          if (nuProduct is not null) then
            /*Obtiene el record de los datos del servicio gas*/
             rcServsusc := pktblservsusc.frcGetRecord(nuProduct);

             /*Obtiene la subcategoria del producto gas*/
             nuSubcategory := rcServsusc.Sesusuca;

             /*Obtiene la categoria del producto gas*/
             nuCategory := rcServsusc.Sesucate;

             /*Obtiene la ubicacion geografica del producto gas*/
             nuGeogLoca := daab_address.fnuGetGeograp_Location_Id(nuGasAddressId);

             /*Obtiene los datos del suscritor*/
             rcSubscription := pktblsuscripc.frcgetrecord(inuSubscriptionId);

             /*Se obtienen los datos de la dirección del contrato*/
             nuNeighborthoodId := daab_address.fnugetneighborthood_id(rcSubscription.susciddi);

             if (nuNeighborthoodId IS null or nuNeighborthoodId = LD_BOConstans.cnuallrows) then

                /*Obtiene ubicación geográfica padre*/
                ge_bogeogra_location.GetGeograpParents(nuGeogLoca, sbParentLocation);
             else
                /*Obtiene ubicación geográfica padre*/
                ge_bogeogra_location.GetGeograpParents(nuNeighborthoodId, sbParentLocation);
             end if;

             /*Obtiene la configuración que aplica al contrato*/
             tbCreditQuota := LD_BCNONBANKFINANCING.ftbGetCreditQuote(nuCategory,
                                                                      nuSubcategory,
                                                                      sbParentLocation);

             if (tbCreditQuota.count > 0) then
               nuCreditConf := tbCreditQuota(tbCreditQuota.first).credit_quota_id;
             end if;

          end if;

          /*Obtiene los bloqueos de cupo*/
          tbBlockQuota := LD_BCNONBANKFINANCING.FtbGetQuota_Block(inuSubscriptionId);

          /* Trae el registro de bloqueo y desbloqueo mas reciente a partir del contrato*/
          if tbBlockQuota.count > 0 then

             if (tbBlockQuota(tbBlockQuota.first) = 'Y') then
               blLockQuota := true;
             end if;

          end if;

        /*Si no está bloqueado el cupo, evalúa la conf*/
        if  not blLockQuota then
          /*Obtiene las políticas incumplidas*/
          for p in cu_BrokenPolicies loop

               blValidateFut := true;

               /*Obtiene la fecha de incumplimiento*/
               dtBreach_Date := nvl(p.breach_date,ut_date.fdtsysdate);

               if (instr (sbParameter,p.quota_assign_policy_id)=0) then
                 nuContPolFut := nuContPolFut + 1;
               end if;

               /*Obtiene el parámetro configurado en FIDCC para la política incumplida*/
               open cuParamPolicy(p.quota_assign_policy_id,nuCreditConf);
               fetch cuParamPolicy into nuParameter;
               close cuParamPolicy;

               nuParameter := nvl(nuParameter,cnucero);

               if (instr(csbPolRedVal,p.quota_assign_policy_id)>0) then
                   nuParameter := cnucero;
               end if;

               dtRecov_Date := add_months(dtBreach_Date, nuParameter);
               ut_trace.trace('Fecha de vencimiento de política'||dtRecov_Date,1);

               if (dtLastExp is null) then
                 dtLastExp := dtRecov_Date;
                 nuLastPolicyId := p.quota_assign_policy_id;
               else
                 if (dtLastExp < dtRecov_Date) then
                   ut_trace.trace('Fecha de vencimiento '||dtRecov_Date,1);
                   dtLastExp := dtRecov_Date;
                   nuLastPolicyId := p.quota_assign_policy_id;
                 end if;

               end if;

          end loop;

            if (blValidateFut) then
              ut_trace.trace('Se evalúa la fecha de vencimiento con el período de evaluación futuro',1);

               if nuContPolFut > 0 then
                /*Valida si la fecha de incumplimiento vence en los N meses*/
                 if (trunc(add_months(ut_date.fdtsysdate,nvl(inuMeses,0))) >= trunc(nvl(dtLastExp,ut_date.fdtsysdate)) and (trunc(nvl(dtLastExp,ut_date.fdtsysdate)) > trunc(add_months(ut_date.fdtsysdate,nvl(nuMesesCerc,0))))) then
                    sbResult := cnuSegmentFutuM;
                 else
                    sbResult := null;
                 end if;
               else
                 sbResult := null;

               end if;

             end if;

           end if;

         end if;

      end if;

      /*Indica que ya evaluó la segmentación Futuro*/
      ldc_bocommercialsegmentfnb.blFlagFuture := true;

      ut_trace.trace('ldc_bccommercialsegmentfnb.fsbFuturSuscM - Resultado '||nvl(sbResult,'Ninguno'),1);

      return sbResult;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    END fsbFuturSuscM;


    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbFuturSuscL
    Descripcion    : Valida si el usuario pertenece a la segmentación comercial Futuro.
                     Segmentación Futuro: Clientes que no poseen cupo Brilla por incumplir algunas
                     de las políticas de asignación de cupo (diferentes a las políticas para marcación
                     de gasodoméstico), sin embargo, máximo en N meses(parámetro) tendrá cupo.

    Autor          : heiberb
    Fecha          : 24/09/2014

    Parametros                   Descripcion
    ============             ===================
    inuContrato:              Id del contrato
    isbExclusPolicy:           Pólizas a excluir

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    16/07/2015       heiberb               Cambio 7805 Creación.
    ******************************************************************/
    FUNCTION fsbFuturSuscL(inuSubscriptionId in suscripc.susccodi%type,
                          inuMeses   in number)
      return VARCHAR2 IS

      nuDiferidos        number;
      nuContPolFut       number := 0;
      blValidateFut      boolean := false;
      nuCreditConf       number;
      dtLastExp          date;
      sbParentLocation   varchar2(1000);
      sbResult           ldc_condit_commerc_segm.acronym%type;
      nuQuotaHistoricId  ld_quota_historic.quota_historic_id%type;
      sbParameter        ldc_condit_commerc_segm.parameter%type;
      dtBreach_Date      ld_policy_historic.breach_date%type;
      dtRecov_Date       ld_policy_historic.breach_date%type;
      nuQuotaValue       ld_quota_by_subsc.quota_value%type;
      nuGasAddressId     ab_address.address_id%type;
      nuProduct          pr_product.product_id%type;
      rcServsusc         servsusc%rowtype;
      nuGeogLoca         ge_geogra_location.geograp_location_id%type;
      rcSubscription     suscripc%rowtype;
      nuNeighborthoodId  ab_address.neighborthood_id%type;
      nuCategory         servsusc.Sesucate%type;
      nuSubcategory      servsusc.Sesusuca%type;
      tbCreditQuota      dald_credit_quota.tytbLD_credit_quota;
      nuParameter        ld_policy_by_cred_quot.parameter_value%type;
      nuLastPolicyId     ld_policy_historic.quota_assign_policy_id%type;
      tbBlockQuota       dald_quota_block.tytbBlock;
      blLockQuota        boolean := false;
      nuMesesCerc        number := 0; --variable para obtener el tiempo del segmento futuro cercano
      nuMesesMedi        number := 0; --variable para obtener el tiempo del segmento futuro mediano

      /*Cursor para obtener el último histórico de cupo*/
      cursor cu_ld_quota_historic (inuContrato suscripc.susccodi%type) is
        select quota_historic_id, assigned_quote
          from (select qh.quota_historic_id, qh.assigned_quote
                  from ld_quota_historic qh, ld_policy_historic p
                 where qh.subscription_id = inuContrato
                   and qh.quota_historic_id = p.quota_historic_id
                 order by qh.quota_historic_id desc)
         where rownum = 1;

      /*Cursor para obtener parámetro de segmentación Gas*/
      cursor cu_ParamSegmGas is
        select s.parameter
          from ldc_condit_commerc_segm s
         where s.cond_commer_segm_id = cnuSegmentGas
           and rownum    = cnuone
           and s.active = 'Y';

      /*Obtiene las políticas incumplidas*/
      cursor cu_BrokenPolicies is
        select *
          from ld_policy_historic ld
         where ld.quota_historic_id = nuQuotaHistoricId
          and ld.result = csbNoFlag;

      /*Cursor para obtener el # de diferidos configurados para segmentación Rollover*/
      cursor cuDifeSegmentRoll is
        select sc.parameter
          from ldc_condit_commerc_segm sc
         where sc.cond_commer_segm_id= cnuSegmentRoll
           and sc.active = 'Y';

      /*Cursor para obtener el parámetro configurado en FIDCC para la política evaluada*/
      cursor cuParamPolicy(nuAssignPolici number, nuConfCred number) is
       select parameter_value
         from ld_policy_by_cred_quot p
        where p.credit_quota_id = nuConfCred
          and active = 'Y'
          and p.quota_assign_policy_id = nuAssignPolici;

       /*Cursor para obtener el tiempo configurado en el segmento futuro Cercano*/
       cursor cu_Segm_FutC is
       select sc.time
         from open.LDC_CONDIT_COMMERC_SEGM sc
        where cond_commer_segm_id = dald_parameter.fnuGetNumeric_Value('SEGMENT_FUTURO');

       /*Cursor para obtener el tiempo configurado en el segmento futuro Mediano*/
       cursor cu_Segm_FutM is
       select sc.time
         from open.LDC_CONDIT_COMMERC_SEGM sc
        where cond_commer_segm_id = dald_parameter.fnuGetNumeric_Value('SEGMENT_FUTUROM');


    BEGIN
      ut_trace.trace('Inicio ldc_bccommercialsegmentfnb.fsbFuturSuscL',1);

      /*Obtiene el último histórico de cupo*/
      open cu_ld_quota_historic(inuSubscriptionId);
      fetch cu_ld_quota_historic into nuQuotaHistoricId, nuQuotaValue;
      close cu_ld_quota_historic;

      /*Obtiene el valor del parámetro configurado para segmentación Gasodoméstico*/
      open cu_ParamSegmGas;
      fetch cu_ParamSegmGas into sbParameter;
      close cu_ParamSegmGas;

     /*Obtiene el tiempo del segmento configurado para segmentación futuro (Cercano)*/
      open cu_Segm_FutC;
      fetch cu_Segm_FutC into nuMesesCerc;
      close cu_Segm_FutC;

     /*Obtiene el tiempo del segmento configurado para segmentación futuro (Cercano)*/
      open cu_Segm_FutM;
      fetch cu_Segm_FutM into nuMesesMedi;
      close cu_Segm_FutM;


      sbParameter := nvl(sbParameter,-1);

      if (nuQuotaHistoricId is null or nvl(nuQuotaValue,cnucero) <> cnucero) then
        sbResult := null;
      else
        if (not ldc_bocommercialsegmentfnb.blFlagRollOver) then

           open cuDifeSegmentRoll;
           fetch cuDifeSegmentRoll into nuDiferidos;
           close cuDifeSegmentRoll;

           if (nuDiferidos is not null) then
              sbResult := fsbRolloverSusc(inuSubscriptionId, nudiferidos);
           end if;

        end if;

        if (sbResult is null) then
          getGasProductData(inuSubscriptionId, nuProduct, nuGasAddressId);

          if (nuProduct is not null) then
            /*Obtiene el record de los datos del servicio gas*/
             rcServsusc := pktblservsusc.frcGetRecord(nuProduct);

             /*Obtiene la subcategoria del producto gas*/
             nuSubcategory := rcServsusc.Sesusuca;

             /*Obtiene la categoria del producto gas*/
             nuCategory := rcServsusc.Sesucate;

             /*Obtiene la ubicacion geografica del producto gas*/
             nuGeogLoca := daab_address.fnuGetGeograp_Location_Id(nuGasAddressId);

             /*Obtiene los datos del suscritor*/
             rcSubscription := pktblsuscripc.frcgetrecord(inuSubscriptionId);

             /*Se obtienen los datos de la dirección del contrato*/
             nuNeighborthoodId := daab_address.fnugetneighborthood_id(rcSubscription.susciddi);

             if (nuNeighborthoodId IS null or nuNeighborthoodId = LD_BOConstans.cnuallrows) then

                /*Obtiene ubicación geográfica padre*/
                ge_bogeogra_location.GetGeograpParents(nuGeogLoca, sbParentLocation);
             else
                /*Obtiene ubicación geográfica padre*/
                ge_bogeogra_location.GetGeograpParents(nuNeighborthoodId, sbParentLocation);
             end if;

             /*Obtiene la configuración que aplica al contrato*/
             tbCreditQuota := LD_BCNONBANKFINANCING.ftbGetCreditQuote(nuCategory,
                                                                      nuSubcategory,
                                                                      sbParentLocation);

             if (tbCreditQuota.count > 0) then
               nuCreditConf := tbCreditQuota(tbCreditQuota.first).credit_quota_id;
             end if;

          end if;

          /*Obtiene los bloqueos de cupo*/
          tbBlockQuota := LD_BCNONBANKFINANCING.FtbGetQuota_Block(inuSubscriptionId);

          /* Trae el registro de bloqueo y desbloqueo mas reciente a partir del contrato*/
          if tbBlockQuota.count > 0 then

             if (tbBlockQuota(tbBlockQuota.first) = 'Y') then
               blLockQuota := true;
             end if;

          end if;

        /*Si no está bloqueado el cupo, evalúa la conf*/
        if  not blLockQuota then
          /*Obtiene las políticas incumplidas*/
          for p in cu_BrokenPolicies loop

               blValidateFut := true;

               /*Obtiene la fecha de incumplimiento*/
               dtBreach_Date := nvl(p.breach_date,ut_date.fdtsysdate);

               if (instr (sbParameter,p.quota_assign_policy_id)=0) then
                 nuContPolFut := nuContPolFut + 1;
               end if;

               /*Obtiene el parámetro configurado en FIDCC para la política incumplida*/
               open cuParamPolicy(p.quota_assign_policy_id,nuCreditConf);
               fetch cuParamPolicy into nuParameter;
               close cuParamPolicy;

               nuParameter := nvl(nuParameter,cnucero);

               if (instr(csbPolRedVal,p.quota_assign_policy_id)>0) then
                   nuParameter := cnucero;
               end if;

               dtRecov_Date := add_months(dtBreach_Date, nuParameter);
               ut_trace.trace('Fecha de vencimiento de política'||dtRecov_Date,1);

               if (dtLastExp is null) then
                 dtLastExp := dtRecov_Date;
                 nuLastPolicyId := p.quota_assign_policy_id;
               else
                 if (dtLastExp < dtRecov_Date) then
                   ut_trace.trace('Fecha de vencimiento '||dtRecov_Date,1);
                   dtLastExp := dtRecov_Date;
                   nuLastPolicyId := p.quota_assign_policy_id;
                 end if;

               end if;

          end loop;

            if (blValidateFut) then
              ut_trace.trace('Se evalúa la fecha de vencimiento con el período de evaluación futuro',1);

               if nuContPolFut > 0 then
                /*Valida si la fecha de incumplimiento vence en los N meses*/
                 if (trunc(add_months(ut_date.fdtsysdate,nvl(inuMeses,0))) >= trunc(nvl(dtLastExp,ut_date.fdtsysdate)) and (trunc(nvl(dtLastExp,ut_date.fdtsysdate)) > trunc(add_months(ut_date.fdtsysdate,nvl(nuMesesMedi,0))))) then
                    sbResult := cnuSegmentFutuL;
                 else
                    sbResult := null;
                 end if;
               else
                 sbResult := null;

               end if;

             end if;

           end if;

         end if;

      end if;

      /*Indica que ya evaluó la segmentación Futuro*/
      ldc_bocommercialsegmentfnb.blFlagFuture := true;

      ut_trace.trace('ldc_bccommercialsegmentfnb.fsbFuturSuscL - Resultado '||nvl(sbResult,'Ninguno'),1);

      return sbResult;

    EXCEPTION
      when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
      when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    END fsbFuturSuscL;

END LDC_BCCOMMERCIALSEGMENTFNB;
/
PROMPT Otorgando permisos de ejecucion a LDC_BCCOMMERCIALSEGMENTFNB
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_BCCOMMERCIALSEGMENTFNB', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LDC_BCCOMMERCIALSEGMENTFNB para reportes
GRANT EXECUTE ON adm_person.LDC_BCCOMMERCIALSEGMENTFNB TO rexereportes;
/
