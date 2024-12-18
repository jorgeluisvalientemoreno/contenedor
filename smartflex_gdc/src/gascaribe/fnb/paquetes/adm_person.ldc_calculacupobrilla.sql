create or replace PACKAGE ADM_PERSON.LDC_CALCULACUPOBRILLA IS

  /***********************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad         : LDC_CALCULACUPOBRILLA
  Descripcion    :
  Autor          :
  Fecha          : 16/07/2012
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========     ===================   ===============================================
  18-03-2015    KCienfuegos.NC4942  Se modifica el metodo <<AllocateQuota>>
  09-03-2015    KCienfuegos.NC4942  Se modifica metodo <<AllocateQuota>>
  22-10-2014    Llozada RQ 1172     se modifica el metodo <<fnuAllocatQuotaZeroCons>>
  22-10-2014    Llozada [RQ 1172]   se modifica el metodo <<fblExcecutePolicy>>
  21-10-2014    llozada [NC 2253]   se modifica el metodo <<frfgetExtraQuoteBySubs>>
  24-09-2014    Llozada. RQ 1172      Se modifica el metodo <<fnuAllocatQuotaZeroCons>>
  19-12-2016    miguelm 200-749     metodos blockSubscriptionQuote unblockSubscriptionQuote
  03/03/2017    leidyc  200-749     Se modifican los metodos blockSubscriptionQuote y unblockSubscriptionQuote
  12/05/2017    SEBTAP 200-749      Se modifica el servicio blockUnblocQuote
  24/11/2023	JSOTO  OSF-1829		Se elimina el método CreateProductFNB
  ***********************************************************************************/

  FUNCTION fsbVersion RETURN VARCHAR2;
  -- Declaracion de Tipos de datos publicos
  nuDocTypeSaleFNB NUMBER(15) := 135;

  /*Tipo Record para Generacion de ordenes FNB*/

  TYPE rfFnbOrder IS RECORD(
    order_id    or_order.order_id%type,
    activity_id or_order.order_id%type);

  TYPE tbFnbOrder IS TABLE OF rfFnbOrder;

  TYPE rfVisitPackage IS RECORD(
    package_id   mo_packages.package_id%type,
    request_date mo_packages.request_date%type);

  TYPE tbVisitPackage IS TABLE OF rfVisitPackage;

  TYPE tyrcManualQuota IS RECORD(
    manual_quota_id ld_manual_quota.manual_quota_id%type,
    subscription_id ld_manual_quota.subscription_id%type,
    quota_value     ld_manual_quota.quota_value%type,
    initial_date    ld_manual_quota.initial_date%type,
    final_date      ld_manual_quota.final_date%type);

  TYPE tbManualQuota IS TABLE OF tyrcManualQuota;

  TYPE tyrcSubcription IS RECORD(
    susccodi       suscripc.susccodi%type,
    SUSCCBANC      suscripc.SUSCBANC%type,
    SUSCCBANC_DESC varchar2(200),
    SUSCSUBA       suscripc.SUSCSUBA%type,
    SUSCTCBA       suscripc.SUSCTCBA%type,
    SUSCTCBA_DESC  varchar2(200),
    SUSCBAPA       suscripc.SUSCBAPA%type,
    SUSCBAPA_DESC  varchar2(200),
    SUSCSBBP       suscripc.SUSCSBBP%type,
    SUSCTCBP       suscripc.SUSCTCBP%type,
    SUSCTCBP_DESC  varchar2(200),
    SUSCCUBP       suscripc.SUSCCUBP%type,
    SUSCCUCO       suscripc.SUSCCUCO%type,
    SUSCCECO       suscripc.SUSCCECO%type,
    SUSCCEMD       suscripc.SUSCCEMD%type,
    SUSCCEMD_DESC  varchar2(200),
    SUSCCEMF       suscripc.SUSCCEMF%type,
    SUSCCEMF_DESC  varchar2(200),
    SUSCCICL       suscripc.SUSCCICL%type,
    SUSCCICL_DESC  varchar2(200),
    SUSCCLIE       suscripc.SUSCCLIE%type,
    SUSCCLIE_DESC  varchar2(200),
    SUSCDECO       suscripc.SUSCDECO%type,
    SUSCDETA       suscripc.SUSCDETA%type,
    SUSCEFCE       suscripc.SUSCEFCE%type,
    SUSCENCO       suscripc.SUSCENCO%type,
    SUSCENCO_DESC  varchar2(200),
    SUSCTDCO       suscripc.SUSCTDCO%type,
    SUSCTDCO_DESC  varchar2(200),
    SUSCIDDI       suscripc.SUSCIDDI%type,
    SUSCIDDI_DESC  varchar2(200),
    SUSCIDTT       suscripc.SUSCIDTT%type,
    SUSCMAIL       suscripc.SUSCMAIL%type,
    SUSCNUPR       suscripc.SUSCNUPR%type,
    SUSCPRCA       suscripc.SUSCPRCA%type,
    SUSCPRCA_DESC  varchar2(200),
    SUSCSAFA       suscripc.SUSCSAFA%type,
    SUSCSIST       suscripc.SUSCSIST%type,
    SUSCSIST_DESC  varchar2(200),
    SUSCTIMO       suscripc.SUSCTIMO%type,
    SUSCTIMO_DESC  varchar2(200),
    SUSCTISU       suscripc.SUSCTISU%type,
    SUSCTISU_DESC  varchar2(200),
    SUSCTTPA       suscripc.SUSCTTPA%type,
    SUSCTTPA_DESC  varchar2(200),
    SUSCVETC       suscripc.SUSCVETC%type);

  cnuDEUDOR           NUMBER := 1;
  cnuCOSIGNER         NUMBER := 2;
  cnuCLIENT_COPY      NUMBER := 1;
  cnuFINAN_INSTI_COPY NUMBER := 2;
  cnuCONTRAC_COPY     NUMBER := 3;
  type tyRefCursor is REF CURSOR;

  -- Declaracion de variables publicas
  nuActivityId or_order_activity.activity_id%type;
  nuBlock_id   ld_quota_by_subsc.quota_by_subsc_id%type;

  -- Declaracion de metodos publicos

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : PrintPromissoryCopy
  Descripcion    : Procedimiento que imprime un pagare.
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE updateQuota(inuSubscription suscripc.susccodi%type,
                        inuValue        ld_credit_quota.quota_value%type,
                        isbResult       ld_quota_historic.result%type,
                        isbObservation  ld_quota_historic.observation%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuGetAvalibleQuote
  Descripcion    : Funcion que retorna el cupo disponible o actual
                   de un contrato
  
  Autor          :
  Fecha          : 13/08/2013
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuGetAvalibleQuote(inusubscription in suscripc.susccodi%type)
    RETURN ld_quota_by_subsc.quota_value%type;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : quotaTotal
  Descripcion    : Calcula el cupo total.
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuQuotaTotal(inuQuotaValue ld_quota_by_subsc.quota_value%type,
                         inuValue      ld_extra_quota.value%type,
                         sbQuotaOption ld_extra_quota.quota_option%type)
    return number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : PrintPromissoryFile
  Descripcion    : Procedimiento que imprime un pagare.
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrintPromissoryFile;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : PrintPromissoryCopy
  Descripcion    : Procedimiento que imprime un pagare.
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId:        Identificador de la solicitud
  inuDeudor:           Se?ala si es deudor o codeudor
  inuCopy:             Identifica cual copia se imprimira
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrintPromissoryCopy;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnugetGasProduct
  Descripcion    : funcion que obtiene el identificador del producto
  GAS.
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnugetGasProduct(inuSubscription suscripc.susccodi%type)
    return number;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : AllocateQuota
  Descripcion    : Calcula el valor del cupo dependiendo de la cuota de politica,cuota manual
                   o rollover ademas al final del proceso se le resta el saldo pendiente,
                   valor corriente y valor de la solicitud de venta
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE AllocateQuota(inuSubscription suscripc.susccodi%type,
                          onuTotal        out ld_credit_quota.quota_value%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : AllocateRolloverQuota
  Descripcion    : Calcula el cupo rollover del contrato.
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  --PROCEDURE AllocateRolloverQuota(inuSubscription suscripc.susccodi%type);
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : AllocateTotalQuota
  Descripcion    : Calcula el cupo del contrato.
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE AllocateTotalQuota(inuSubscription suscripc.susccodi%type,
                               onuTotal        out ld_credit_quota.quota_value%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : GetTotalQuotaWithOutExtra
  Descripcion    : Calcula el cupo
  Autor          : gavargas
  Fecha          : 20/08/2013
  
  Parametros              Descripcion
  ============         ===================
  inuSuscripc     in    Identificador del contrato.
  onuTotalQuota   out   Total valor del cupo.
  odtApprovedDate out   Fecha de aprobacion.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  20/08/2013      gavargas            Creacion.
  ******************************************************************/
  PROCEDURE GetTotalQuotaWithOutExtra(inuSuscripc     in servsusc.sesususc%type,
                                      onuTotalQuota   out diferido.difesape%type,
                                      odtApprovedDate out diferido.difefein%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : AllocateSimuTotalQuota
  Descripcion    : Simula el calculo de un cupo para un contrato.
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE AllocateSimuTotalQuota(inuSubscription suscripc.susccodi%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : blockSubscriptionQuote
  Descripcion    : Funcion que bloquea un contrato. Esta funcion
                   registra en la tabla LD_Quota_Block, que un contrato
                   estara bloqueado. Guardando la causal especificada.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE blockSubscriptionQuote(inuSubscription ld_quota_block.subscription_id%type,
                                   idtRegister     ld_quota_block.register_date%type,
                                   inuCausal       cc_causal.causal_id%type,
                                   isbObservation  ld_quota_block.observation%type,
                                   isbUser         ld_quota_block.username%type,
                                   isbTerminal     ld_quota_block.terminal%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : blockGeographLocaQuote
  Descripcion    : Funcion que bloquea los contratos de una ubicacion
                   geografica y un estrato
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE blockGeographLocaQuote(inuGeographLoca ge_geogra_location.geograp_location_id%type,
                                   inuCategory     categori.catecodi%type,
                                   inuStratum      subcateg.sucacodi%type,
                                   idtRegister     ld_quota_block.register_date%type,
                                   inuCausal       cc_causal.causal_id%type,
                                   isbObservation  ld_quota_block.observation%type,
                                   isbUser         ld_quota_block.username%type,
                                   isbTerminal     ld_quota_block.terminal%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : blockIdentificaQuote
  Descripcion    : Funcion que bloquea los contratos de una identificacion.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE blockIdentificaQuote(inuIdentType      ge_subscriber.ident_type_id%type,
                                 isbIdentification ge_subscriber.identification%type,
                                 idtRegister       ld_quota_block.register_date%type,
                                 inuCausal         cc_causal.causal_id%type,
                                 isbObservation    varchar2,
                                 isbUser           varchar2,
                                 isbTerminal       varchar2);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : blockIdentificaQuote
  Descripcion    : Funcion que bloquea los contratos de una identificacion.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  inuCausal: Identificador de la causal.
  isbObservation: Observacion del bloqueo.
  iboRaiseError: Indica si se levanta al intentar desbloquear.
  isbUsuario: Nombre de usario conectado.
  isbTerminal: Nombre terminal
  
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE unblockSubscriptionQuote(inuSubscription ld_quota_block.subscription_id%type,
                                     idtRegister     ld_quota_block.register_date%type,
                                     inuCausal       cc_causal.causal_id%type,
                                     isbObservation  ld_quota_block.observation%type,
                                     isbUser         ld_quota_block.username%type,
                                     isbTerminal     ld_quota_block.terminal%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : unblockGeographLocaQuote
  Descripcion    : Funcion que desbloquea los contratos de una ubicacion
  geografica y un estrato.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuGeographLoca: Identificador del contrato.
  inuStratum: Identificador del estrato.
  inuCausal: Identificador de la causal.
  isbObservation: Observacion del bloqueo.
  isbUsuario: Nombre de usario conectado.
  isbTerminal: Nombre terminal
  
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE unblockGeographLocaQuote(
                                     
                                     inuGeographLoca ge_geogra_location.geograp_location_id%type,
                                     inuCategory     categori.catecodi%type,
                                     inuStratum      subcateg.sucacodi%type,
                                     idtRegister     ld_quota_block.register_date%type,
                                     inuCausal       cc_causal.causal_id%type,
                                     isbObservation  ld_quota_block.observation%type,
                                     isbUser         ld_quota_block.username%type,
                                     isbTerminal     ld_quota_block.terminal%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : unblockIdentificaQuote
  Descripcion    : Funcion que desbloquea los contratos de una identificacion.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuIdentType: Identificador del tipo de identificacion.
  isbIdentification: Numero de identificacion del  cliente.
  inuCausal: Identificador de la causal.
  isbObservation: Observacion del bloqueo.
  isbUsuario: Nombre de usario conectado.
  isbTerminal: Nombre terminal
  
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE unblockIdentificaQuote(inuIdentType      ge_subscriber.ident_type_id%type,
                                   isbIdentification ge_subscriber.identification%type,
                                   idtRegister       ld_quota_block.register_date%type,
                                   inuCausal         cc_causal.causal_id%type,
                                   isbObservation    ld_quota_block.observation%type,
                                   isbUser           ld_quota_block.username%type,
                                   isbTerminal       ld_quota_block.terminal%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : blockUnblocQuote
  Descripcion    : Funcion que recibe los parametros para procesar
  el bloqueo o desbloque de cupo, esta funcion esta relacionada con
  el proceso batch encargado del desbloqueo.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE blockUnblocQuote(inuIdentType      ge_subscriber.ident_type_id%type,
                             isbIdentification ge_subscriber.identification%type,
                             inuGeographLoca   ge_geogra_location.geograp_location_id%type,
                             inuCategory       categori.catecodi%type,
                             inuStratum        subcateg.sucacodi%type,
                             inuSubscription   ge_subscriber.subscriber_id%type,
                             idtRegister       ld_quota_block.register_date%type,
                             inuCausal         cc_causal.causal_id%type,
                             isbObservation    ld_quota_block.observation%type,
                             isbUser           ld_quota_block.username%type,
                             isbTerminal       ld_quota_block.terminal%type,
                             iboBlock          ld_quota_block.block%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         :  getblockUnblocQuoteData
  Descripcion    : Funcion que obtiene los datos del proceso batch.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE getblockUnblocQuoteData;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : changeConsecutive
  Descripcion    : Cambia el consecutivo de una venta
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId: Numero de la solicitud.
  inuConsecutive: Identificador del consecutivo.
  inuExcutiveId: Identificador del ejecutivo.
  inuRegisterDate: Identificador del registro.
  
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE changeConsecutive(inuPackageId mo_packages.package_id%type,
                              /*inuConsecutive    campo de consecutivo*/
                              inuExcutiveId   mo_packages.person_id%type,
                              inuRegisterDate mo_packages.request_date%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : getConsecutive
  Descripcion    : Obtiene el consecutivo actual de la venta.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId: Numero de la solicitud.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE getConsecutive(inupackage mo_packages.package_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fblValidateBills
  Descripcion    : Valida las facturas ingresadas.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId: Numero de la solicitud.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fblValidateBills(inuSubscription suscripc.susccodi%type,
                            inuBill1        factura.factcodi%type,
                            idtBill1        factura.factfege%type,
                            inuBill2        factura.factcodi%type,
                            idtBill2        factura.factfege%type)
    return boolean;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : GetSupplierData
  Descripcion    : Obtiene los datos de los proveedores.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId: Numero de la solicitud.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  03-09-2013     vhurtadoSAO213189 Se agrega campo oblEditPointDel
  ******************************************************************/
  PROCEDURE GetSupplierData(inuSubscription     suscripc.susccodi%type,
                            inuAddress          ab_address.address_id%type,
                            osbSupplierName     out ge_contratista.nombre_contratista%type,
                            onuSupplierId       out ge_contratista.id_contratista%type,
                            osbPointSaleName    out or_operating_unit.name%type,
                            onuPointSaleId      out or_operating_unit.operating_unit_id%type,
                            oblTransferQuote    out boolean,
                            oblCosigner         out boolean,
                            oblConsignerGasProd out boolean,
                            oblModiSalesChanel  out boolean,
                            onuSalesChanel      out ld_suppli_settings.default_chan_sale%type,
                            osbPromissoryType   out ld_suppli_settings.type_promiss_note%type,
                            oblRequiApproAnnulm out boolean,
                            oblRequiApproReturn out boolean,
                            osbSaleNameReport   out ld_suppli_settings.sale_name_report%type,
                            osbExeRulePostSale  out ld_suppli_settings.exe_rule_post_sale%type,
                            osbPostLegProcess   out ld_suppli_settings.post_leg_process%type,
                            onuMinForDelivery   out ld_suppli_settings.min_for_delivery%type,
                            oblDelivInPoint     out boolean,
                            oblEditPointDel     out boolean,
                            oblLegDelivOrdeAuto out boolean,
                            osbTypePromissNote  out ld_suppli_settings.type_promiss_note%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : GetSubcriptionData
  Descripcion    : Obtiene los datos del contrato.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId: Numero de la solicitud.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE GetSubcriptionData(inuSubscription   suscripc.susccodi%type,
                               osbIdentType      out varchar2,
                               osbIdentification out ge_subscriber.identification%type,
                               onuSubscriberId   out ge_subscriber.subscriber_id%type,
                               osbSubsName       out ge_subscriber.subscriber_name%type,
                               osbSubsLastName   out ge_subscriber.subs_last_name%type,
                               osbAddress        out ab_address.address_parsed%type,
                               onuAddress_Id     out ab_address.address_id%type,
                               onuGeoLocation    out ge_geogra_location.geograp_location_id%type,
                               osbFullPhone      out ge_subs_phone.full_phone_number%type,
                               osbCategory       out varchar2,
                               osbSubcategory    out varchar2,
                               onuCategory       out number,
                               onuSubcategory    out number,
                               onuRedBalance     out number,
                               onuAssignedQuote  out number,
                               onuUsedQuote      out number,
                               onuAvalibleQuote  out number);

  PROCEDURE GetSubcriptionData(inuSubscription   suscripc.susccodi%type,
                               osbIdentType      out varchar2,
                               osbIdentification out ge_subscriber.identification%type,
                               onuSubscriberId   out ge_subscriber.subscriber_id%type,
                               osbSubsName       out ge_subscriber.subscriber_name%type,
                               osbSubsLastName   out ge_subscriber.subs_last_name%type,
                               osbAddress        out ab_address.address_parsed%type,
                               onuAddress_Id     out ab_address.address_id%type,
                               onuGeoLocation    out ge_geogra_location.geograp_location_id%type,
                               osbFullPhone      out ge_subs_phone.full_phone_number%type,
                               osbCategory       out varchar2,
                               osbSubcategory    out varchar2,
                               onuCategory       out number,
                               onuSubcategory    out number,
                               onuRedBalance     out number,
                               onuAssignedQuote  out number,
                               onuUsedQuote      out number,
                               onuAvalibleQuote  out number,
                               osbEmail          out ge_subscriber.e_mail%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : RegisterDeudorData
  Descripcion    : Registra los datos de un deudor.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId: Numero de la solicitud.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE RegisterDeudorData(inuSubscriberId      in ge_subscriber.subscriber_id%type,
                               inuPromissory_id     in ld_promissory.promissory_id%type,
                               isbHolder_Bill       in ld_promissory.holder_bill%type,
                               isbDebtorName        in ld_promissory.debtorname%type,
                               inuIdentType         in ld_promissory.ident_type_id%type,
                               isbIdentification    in ld_promissory.identification%type,
                               inuForwardingPlace   in ld_promissory.forwardingplace%type,
                               idtForwardingDate    in ld_promissory.forwardingdate%type,
                               isbGender            in ld_promissory.gender%type,
                               inuCivil_State_Id    in ld_promissory.civil_state_id%type,
                               idtBirthdayDate      in ld_promissory.birthdaydate%type,
                               inuSchool_Degree_    in ld_promissory.school_degree_%type,
                               inuAddress_Id        in ld_promissory.address_id%type,
                               isbPropertyPhone     in ld_promissory.propertyphone_id%type,
                               inuDependentsNumber  in ld_promissory.dependentsnumber%type,
                               inuHousingTypeId     in ld_promissory.housingtype%type,
                               inuHousingMonth      in ld_promissory.housingmonth%type,
                               isbHolderRelation    in ld_promissory.holderrelation%type,
                               isbOccupation        in ld_promissory.occupation%type,
                               isbCompanyName       in ld_promissory.companyname%type,
                               inuCompanyAddress_Id in ld_promissory.companyaddress_id%type,
                               isbPhone1            in ld_promissory.phone1_id%type,
                               isbPhone2            in ld_promissory.phone2_id%type,
                               isbMovilPhone        in ld_promissory.movilphone_id%type,
                               inuOldLabor          in ld_promissory.oldlabor%type,
                               inuActivityId        in ld_promissory.activity%type,
                               inuMonthlyIncome     in ld_promissory.monthlyincome%type,
                               inuExpensesIncome    in ld_promissory.expensesincome%type,
                               isbFamiliarReference in ld_promissory.familiarreference%type,
                               isbPhoneFamiRefe     in ld_promissory.phonefamirefe%type,
                               inuMovilPhoFamiRefe  in ld_promissory.movilphofamirefe%type,
                               inuaddressfamirefe   in ld_promissory.addresspersrefe%type,
                               isbPersonalReference in ld_promissory.personalreference%type,
                               isbPhonePersRefe     in ld_promissory.phonepersrefe%type,
                               isbMovilPhoPersRefe  in ld_promissory.movilphopersrefe%type,
                               inuaddresspersrefe   in ld_promissory.addresspersrefe%type,
                               isbcommerreference   in ld_promissory.commerreference%type,
                               isbphonecommrefe     in ld_promissory.phonecommrefe%type,
                               isbmovilphocommrefe  in ld_promissory.movilphocommrefe%type,
                               inuaddresscommrefe   in ld_promissory.addresscommrefe%type,
                               isbEmail             in ld_promissory.email%type,
                               inuPackage_Id        in ld_promissory.package_id%type,
                               inuCategoryId        in ld_promissory.category_id%type,
                               inuSubcategoryId     in ld_promissory.subcategory_id%type,
                               inuContractType      in ld_promissory.contract_type_id%type,
                               isblastname          in ld_promissory.last_name%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : RegisterCosignerData
  Descripcion    : Registra los datos de un codeudor.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId: Numero de la solicitud.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE RegisterCosignerData(inuPromissory_id     in ld_promissory.promissory_id%type,
                                 isbHolder_Bill       in ld_promissory.holder_bill%type,
                                 isbDebtorName        in ld_promissory.debtorname%type,
                                 inuIdentType         in ld_promissory.ident_type_id%type,
                                 isbIdentification    in ld_promissory.identification%type,
                                 inuForwardingPlace   in ld_promissory.forwardingplace%type,
                                 idtForwardingDate    in ld_promissory.forwardingdate%type,
                                 isbGender            in ld_promissory.gender%type,
                                 inuCivil_State_Id    in ld_promissory.civil_state_id%type,
                                 idtBirthdayDate      in ld_promissory.birthdaydate%type,
                                 inuSchool_Degree_    in ld_promissory.school_degree_%type,
                                 inuAddress_Id        in ld_promissory.address_id%type,
                                 isbPropertyPhone     in ld_promissory.propertyphone_id%type,
                                 inuDependentsNumber  in ld_promissory.dependentsnumber%type,
                                 inuHousingTypeId     in ld_promissory.housingtype%type,
                                 inuHousingMonth      in ld_promissory.housingmonth%type,
                                 isbHolderRelation    in ld_promissory.holderrelation%type,
                                 isbOccupation        in ld_promissory.occupation%type,
                                 isbCompanyName       in ld_promissory.companyname%type,
                                 inuCompanyAddress_Id in ld_promissory.companyaddress_id%type,
                                 isbPhone1            in ld_promissory.phone1_id%type,
                                 isbPhone2            in ld_promissory.phone2_id%type,
                                 isbMovilPhone        in ld_promissory.movilphone_id%type,
                                 inuOldLabor          in ld_promissory.oldlabor%type,
                                 inuActivityId        in ld_promissory.activity%type,
                                 inuMonthlyIncome     in ld_promissory.monthlyincome%type,
                                 inuExpensesIncome    in ld_promissory.expensesincome%type,
                                 isbFamiliarReference in ld_promissory.familiarreference%type,
                                 isbPhoneFamiRefe     in ld_promissory.phonefamirefe%type,
                                 inuMovilPhoFamiRefe  in ld_promissory.movilphofamirefe%type,
                                 inuaddressfamirefe   in ld_promissory.addresspersrefe%type,
                                 isbPersonalReference in ld_promissory.personalreference%type,
                                 isbPhonePersRefe     in ld_promissory.phonepersrefe%type,
                                 isbMovilPhoPersRefe  in ld_promissory.movilphopersrefe%type,
                                 inuaddresspersrefe   in ld_promissory.addresspersrefe%type,
                                 isbcommerreference   in ld_promissory.commerreference%type,
                                 isbphonecommrefe     in ld_promissory.phonecommrefe%type,
                                 isbmovilphocommrefe  in ld_promissory.movilphocommrefe%type,
                                 inuaddresscommrefe   in ld_promissory.addresscommrefe%type,
                                 isbEmail             in ld_promissory.email%type,
                                 inuPackage_Id        in ld_promissory.package_id%type,
                                 inuCategoryId        in ld_promissory.category_id%type,
                                 inuSubcategoryId     in ld_promissory.subcategory_id%type,
                                 inuContractType      in ld_promissory.contract_type_id%type,
                                 isblastname          in ld_promissory.last_name%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : RegisterFNBsale
  Descripcion    : Registra la solicitud de venta.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId: Numero de la solicitud.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE RegisterFNBsale(inupackage mo_packages.package_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : RegisterSuscShare
  Descripcion    : Registra el cupo de los suscritores
  
  Autor          : AAcuna
  Fecha          : 15/02/2013
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId: Numero de la solicitud.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE RegisterSuscShare;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : registerArticleFNBsale
  Descripcion    : Registra un articulo para vender.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId: Numero de la solicitud.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE registerArticleFNBsale(inupackage mo_packages.package_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         :  ValidateDueBill
  Descripcion    :  Verifica las solicitudes de venta que se encuentra
                    en estado stop para verificar si la factura asociada
                    se encuentra sin saldo pendiente , si se encuentra
                    con saldo pendiente se procede a mover la actividad espera
                    pago de factura del flujo (Proceso ejecutado por job)..
  
  Autor          :  AAcuna
  Fecha          :  11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  PROCEDURE ValidateDueBill;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         :  getArticleInfo
  Descripcion    : Registra un
  
  Autor          :  eramos
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId:        Identificador de la solicitud
  otbArtcile:          Tabla con articulos relacionados con la venta
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE getArticleInfo;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         :  getSaleInfo
  Descripcion    : Registra un
  
  Autor          :  eramos
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId:        Identificador de la solicitud
  otbArtcile:          Tabla con articulos relacionados con la venta
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE getSaleInfo;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         :  fblValidateParcialQuota
  Descripcion    : Registra un
  
  Autor          :  eramos
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId:        Identificador de la solicitud
  otbArtcile:          Tabla con articulos relacionados con la venta
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE fblValidateParcialQuota;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         :  printSaleFile
  Descripcion    : Registra un
  
  Autor          :  eramos
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId:        Identificador de la solicitud
  otbArtcile:          Tabla con articulos relacionados con la venta
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE printSaleFile;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         :  getFIFAPInfo
  Descripcion    : Registra un
  
  Autor          :  eramos
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId:        Identificador de la solicitud
  otbArtcile:          Tabla con articulos relacionados con la venta
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  03/09/2013    vhurtadoSAO213189  Se agrega el campo oblEditPointDel out boolean,
        que indica si el campo Entrega en punto debe estar habilitado o no en FIFAP.
  09/09/2013   vhurtadoSAO213189 Se cambia el campo osbPostLegProcess para que
                                corresponda a post_leg_process Indica si es o no
                                gran superficie (Y/N)
  ******************************************************************/
  PROCEDURE getFIFAPInfo(inuSubscription     suscripc.susccodi%type,
                         osbIdentType        out varchar2,
                         osbIdentification   out ge_subscriber.identification%type,
                         onuSubscriberId     out ge_subscriber.subscriber_id%type,
                         osbSubsName         out ge_subscriber.subscriber_name%type,
                         osbSubsLastName     out ge_subscriber.subs_last_name%type,
                         osbAddress          out ab_address.address_parsed%type,
                         onuAddress_Id       out ab_address.address_id%type,
                         onuGeoLocation      out ge_geogra_location.geograp_location_id%type,
                         osbFullPhone        out ge_subs_phone.full_phone_number%type,
                         osbCategory         out varchar2,
                         osbSubcategory      out varchar2,
                         onuCategory         out number,
                         onuSubcategory      out number,
                         onuRedBalance       out number,
                         onuAssignedQuote    out number,
                         onuUsedQuote        out number,
                         onuAvalibleQuote    out number,
                         osbSupplierName     out ge_contratista.nombre_contratista%type,
                         onuSupplierId       out ge_contratista.id_contratista%type,
                         osbPointSaleName    out or_operating_unit.name%type,
                         onuPointSaleId      out or_operating_unit.operating_unit_id%type,
                         oblTransferQuote    out boolean,
                         oblCosigner         out boolean,
                         oblConsignerGasProd out boolean,
                         oblModiSalesChanel  out boolean,
                         onuSalesChanel      out ld_suppli_settings.default_chan_sale%type,
                         osbPromissoryType   out ld_suppli_settings.type_promiss_note%type,
                         oblRequiApproAnnulm out boolean,
                         oblRequiApproReturn out boolean,
                         osbSaleNameReport   out ld_suppli_settings.sale_name_report%type,
                         osbExeRulePostSale  out ld_suppli_settings.exe_rule_post_sale%type,
                         osbPostLegProcess   out ld_suppli_settings.post_leg_process%type,
                         onuMinForDelivery   out ld_suppli_settings.min_for_delivery%type,
                         oblDelivInPoint     out boolean,
                         oblEditPointDel     out boolean,
                         oblLegDelivOrdeAuto out boolean,
                         osbTypePromissNote  out ld_suppli_settings.type_promiss_note%type,
                         onuInsuranceRate    out number,
                         odtDate_Birth       out ge_subs_general_data.date_birth%TYPE,
                         osbGender           out ge_subs_general_data.gender%TYPE,
                         odtPefeme           out perifact.pefafeem%TYPE,
                         osbValidateBill     OUT VARCHAR2,
                         osbLocation         out varchar2,
                         osbdepartment       out varchar2,
                         osbEmail            out ge_subscriber.e_mail%type);


  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).
  
    Unidad         : getAvalibleArticle
    Descripcion    : Procedimiento para obtener la lista de articulos por
                     Proveedor, Canal de venta, Ubicaci?n geografica.
  
    Autor          : Evens Herard Gorut.
    Fecha          : 31/10/2012
  
    Parametros              Descripcion
    ============         ===================
    InuContractorId       Codigo de Contratista de Venta
    inugeogra_location    Parametro de entrada con el valor de la Ubicacon geografica
    inuSale_Chanel_Id     Parametro de entrada con el valor del Canal de venta
    Inucategory_Id        Codigo de la categoria
    InuSbcategory_Id      Codigo de la subcategoria.
  
    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
  ******************************************************************/
  PROCEDURE getAvalibleArticle(inuContractorId    ge_contratista.id_contratista%type,
                               inugeogra_location ld_price_list_deta.geograp_location_id%type,
                               inuSale_Chanel_Id  ld_price_list_deta.sale_chanel_id%type,
                               inuCategori_Id     Categori.Catecodi%type,
                               inuSubcateg_Id     Subcateg.Sucacodi%type,
                               ocuArtList         out constants.tyrefcursor,
                               idtDate            DATE default sysdate);

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
  
   Unidad         : fsbSublines
   Descripcion    : Funcion que retorna todas las sublineas asociadas a un proveedor
  
   Autor          : Evens Herard Gorut.
   Fecha          : 02/11/2012
  
   Parametros              Descripcion
   ============         ===================
   ld_segmen_supplier
  
   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========       =========           ====================
  ******************************************************************/
  FUNCTION fsbSublines(inuContractor_id ld_catalog.sale_contractor_id%type)
    return varchar2;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : ftbgetAvalibleArticle
  Descripcion    : Obtener los articulos vigentes.
  
  Autor          : AdoJim
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId: Numero de la solicitud.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuGetUsedQuote(inuSusc in suscripc.susccodi%type) return number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuGetValueByRoll
  Descripcion    : Retorna el valor de cupo que debe tener un cliente dependiendo
                   su comportamiento de pago y si tiene configurado un tipo porcentaje
                   o valor , todo estos datos son traidos de la configuracion de rollover.
  Autor          : AAcuna
  Fecha          : 28/02/2013
  
  Parametros              Descripcion
  ============         ===================
  inuSubscriber: Identificador del cliente.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuGetValueByRoll(isbQuota_Option in ld_rollover_quota.quota_option%type,
                             inuValue        in ld_rollover_quota.value%type,
                             inuValuePol     in ld_credit_quota.quota_value%type)
  
   RETURN ld_credit_quota.quota_value%type;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuGetOrderInstall
  Descripcion    : Genera las ordenes de instalaci?n para los items que lo requieran.
  
  Autor          : AdoJim
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuorder:            Orden de trabajo.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuGetOrderInstall(inuorder in or_order.order_id%type)
    return number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuGetOrderInstall
  Descripcion    : Genera las ordenes de instalaci?n para los items que lo requieran.
  
  Autor          : AdoJim
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuorder:            Orden de trabajo.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuGetDebtInstall(inuSubscription in suscripc.susccodi%type)
    return number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : ftbgetExtraQuoteBySubs
  Descripcion    : Devuelve deuda de instalaci?n.
  
  Autor          : AdoJim
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription        Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor               Modificacion
  =========         =========           ====================
  18/10/2013        JCarmona.SAO220573  Se modifica para que retorne el cupo extra
                                        de los proveedores del contratista cuando
                                        la clasificacion es 70 y retorne el cupo
                                        extra del proveedor cuando la clasificacion
                                        es 71.
  ******************************************************************/
  FUNCTION frfgetExtraQuoteBySubs(inuSubscription in suscripc.susccodi%type)
    return constants.tyrefcursor;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : CreditQuotaData
  Descripcion    : Datos de cupo de credito
  
  Autor          : Alex Valencia Ayola
  Fecha          : 16/11/2012
  
  Parametros              Descripcion
  ============         ===================
  inuIdentType        Tipo de identificacion
  inuIdentification   Identificacion
  onuSusccodi         Contrato
  onuAssignedQuote    Cupo asignado
  onuUsedQuote        Cupo usado
  onuAvalibleQuote    Cupo disponible
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE CreditQuotaData(inuIdentType      IN ge_subscriber.ident_type_id%TYPE,
                            inuIdentification IN ge_subscriber.identification%TYPE,
                            onuSusccodi       OUT suscripc.susccodi%TYPE,
                            onuAssignedQuote  OUT NUMBER,
                            onuUsedQuote      OUT NUMBER,
                            onuAvalibleQuote  OUT NUMBER);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : frcGetTransferQuotebySubs
  Descripcion    :
  
  Autor          : Evens Herard Gorut.
  Fecha          : 24/10/2012
  
  Parametros             Descripcion
  ============           ===================
  inuSubscription        Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  FUNCTION frcGetTransferQuotebySubs(inususcripc in suscripc.susccodi%type)
    return constants.tyrefcursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : createSaleOrderActivity
  Descripcion    : Crea las actividades de venta FNB
  
  Autor          : Eduar Ramos Barragan
  Fecha          : 20/11/2012
  
  Parametros              Descripcion
  ============         ===================
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE createSaleOrderActivity(inuMotive        in mo_motive.motive_id%type,
                                    ionuOrder        in out or_order.order_id%type,
                                    onuOrderActivity out or_order_activity.order_activity_id%type);

  PROCEDURE GetSubscriptionBasicData(inuSubscription   suscripc.susccodi%type,
                                     onuIdentType      out ge_subscriber.ident_type_id%type,
                                     osbIdentification out ge_subscriber.identification%type,
                                     onuSubscriberId   out ge_subscriber.subscriber_id%type,
                                     osbSubsName       out ge_subscriber.subscriber_name%type,
                                     osbSubsLastName   out ge_subscriber.subs_last_name%type,
                                     osbAddress        out ab_address.address_parsed%type,
                                     onuAddress_Id     out ab_address.address_id%type,
                                     onuGeoLocation    out ge_geogra_location.geograp_location_id%type,
                                     osbFullPhone      out ge_subs_phone.full_phone_number%type,
                                     osbCategory       out varchar2,
                                     osbSubcategory    out varchar2,
                                     onuCategory       out Servsusc.Sesucate%type,
                                     onuSubcategory    out Servsusc.Sesusuca%type);

  FUNCTION frcGetDataCancelReq(inuPackageSale mo_packages.package_id%TYPE,
                               inuPackageAnnu mo_packages.package_id%TYPE,
                               inuOrder       or_order.order_id%type,
                               inuCausal      Number := 11111111,
                               idtMinSaleDate mo_packages.request_date%type := '17/12/12',
                               idtMaxSaleDate mo_packages.request_date%type := sysdate,
                               idtMinDateAnnu mo_packages.request_date%type := '17/12/12',
                               idtMaxDateAnnu mo_packages.request_date%type := sysdate,
                               inuIdentType   ge_subscriber.ident_type_id%type := 16,
                               isbIdentific   ge_subscriber.identification%type := '588DD17-68A5-11E1-B',
                               inuSusccodi    suscripc.susccodi%type := 12020)
    Return constants.tyrefcursor;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : createDeliveryOrderActivity
  Descripcion    : Crea las actividades de venta FNB
  
  Autor          : Eduar Ramos Barragan
  Fecha          : 20/11/2012
  
  Parametros              Descripcion
  ============         ===================
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE createDeliveryOrderActivity(inuOrderActivity    in or_order_activity.order_activity_id%type,
                                        ionuOrder           in out or_order.order_id%type,
                                        inuOrderActivityDev out or_order_activity.order_activity_id%type
                                        
                                        );

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : createReviewOrderActivity
  Descripcion    : Crea las actividades de revicion FNB
  
  Autor          : Eduar Ramos Barragan
  Fecha          : 20/11/2012
  
  Parametros              Descripcion
  ============         ===================
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE createReviewOrderActivity(inuOrderActivity    in or_order_activity.order_activity_id%type,
                                      ionuOrder           in out or_order.order_id%type,
                                      inuOrderActivityRev out or_order_activity.order_activity_id%type
                                      
                                      );

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : legalizeOrderActivity
  Descripcion    : Legaliza actividades de venta
  Autor          : Eduar Ramos Barragan
  Fecha          : 20/11/2012
  
  Parametros              Descripcion
  ============         ===================
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE legalizeOrderActivity(inuOrden        or_order.order_id%type,
                                  inuPerson       or_operating_unit.operating_unit_id%type,
                                  onuError        out ge_message.message_id%type,
                                  osbErrorMessage out ge_message.description%type);

  PROCEDURE Dummy;

  FUNCTION frfGetRecords_fnbcr(inufindvalue in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_ID%type)
    RETURN tyRefCursor;

  function fnugetContratid(inufindvalue in mo_packages.package_id%type)
    return number;
  PROCEDURE InsertManualQuota(inumanual_quota_id in ld_manual_quota.manual_quota_id%type,
                              inusubscription_id in ld_manual_quota.subscription_id%type,
                              inuquota_value     in ld_manual_quota.quota_value%type,
                              inuinitial_date    in ld_manual_quota.initial_date%type default trunc(sysdate),
                              inufinal_date      in ld_manual_quota.final_date%type,
                              inusupport_file    in ld_manual_quota.support_file%type,
                              inuobservation     in ld_manual_quota.observation%type,
                              inuprint_in_bill   in ld_manual_quota.print_in_bill%type);
  function fnugetManualquota return number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : RegisterStatusChange
  Descripcion    : Obtiene los datos para realizar una transferencia de cupo.
  
  Autor          : Eduar Ramos Barragan
  Fecha          : 20/11/2012
  
  Parametros              Descripcion
  ============         ===================
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE RegisterStatusChange(inuOrder              or_order.order_id%type,
                                 inuStatus             ld_quota_transfer.status%type,
                                 isbRequestObservation ld_quota_transfer.request_observation%type,
                                 isbReviewObservation  ld_quota_transfer.review_observation%type);

  /*  \*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : registerBlUnSh
  Descripcion    : Ingresa la informacion de bloqueo y desbloqueo de cupo
  Autor          : Aacuna
  Fecha          : 29/01/2013
  
  Parametros              Descripcion
  ============        ===================
  inuPackage          Numero de solicitud
  
  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================
  
  ******************************************************************\
  PROCEDURE registerBlUnSh(inuPackage    IN MO_PACKAGES.PACKAGE_ID%TYPE);*/

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuSimuAllocateQuota
  Descripcion    :
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuSimuAllocateQuota(inuSubscription suscripc.susccodi%type)
    return number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuValidateQuota
  Descripcion    : Valida si el contrato tiene cupo
  Autor          : AAcuna
  Fecha          : 28/01/2013
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuValidateQuota(inuSubscription suscripc.susccodi%type)
    return number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuValQuotaBySub
  Descripcion    : Valida si al menos algun contrato del cliente tiene cupo
  Autor          : AAcuna
  Fecha          : 28/01/2013
  
  Parametros              Descripcion
  ============         ===================
  inuSubscriber: Identificador del cliente.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuValQuotaBySub(inuSubscriber IN ge_subscriber.subscriber_id%TYPE)
    return number;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : GenerCupon
  Descripcion    : Servicio el cual debe recibira el numero de la solicitud
                   y el valor del cupo y debera arrojar el numero del cupon generado
  
  Autor          : AAcuna
  Fecha          : 20/05/2013
  
  Parametros              Descripcion
  ============         ===================
  inuPackage           :Numero de solicitud
  inuValorCup          :Valor del cupo
  onuCuponCurr         :Cupon generado
  
  
  Historia de Modificaciones
  Fecha             Autor                Modificacion
  =========       =========           ====================
  20/05/2013      AAcuna              Creacion
  ******************************************************************/

  PROCEDURE GenerCupon(inuPackage   in mo_packages.package_id%type,
                       inuValorCup  in cupon.cupovalo%type,
                       onuCuponCurr out cupon.cuponume%type);
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : AssignedQuotaMassive
  Descripcion    : Asigna cupos de forma masiva
  Autor          : Alex Valencia
  Fecha          : 05/02/2013
  
  Parametros              Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE AssignedQuotaMassive;

  PROCEDURE simulateQuota(inuGeographLoca ge_geogra_location.geograp_location_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  
  Unidad         : GetPriceArticle
  Descripcion    : Muestra si el precio del articulo ha cambiado a partir de la fecha de visita
                   realizada al cliente y ademas retornara los siguientes valores:
                   S(Si el precio vario a partir de la fecha de visita enviada por parametro)
                   N(Si el precio no vario a partir de la fecha de visita enviada por parametro)
                   Precio: (Precio)
  Autor          : AAcuna
  Fecha          : 06/03/2013 04:55:27 p.m.
  
  Parametros              Descripcion
  ============            ===================
  inuArticle              Numero de articulo
  inuSusccodi             Numero de contrato
  inuPrice                Precio actual del articulo
  idtVisit                Fecha  limite de visita
  osbMessage              Mensaje de cambio de precio
  onuPriceApproved        Precio
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  
  ******************************************************************/

  PROCEDURE GetPriceArticle(inuArticle       in ld_article.article_id%type,
                            inuSusccodi      in suscripc.susccodi%type default NULL,
                            inuPrice         in ld_price_list_deta.price%type,
                            idtVisit         in mo_packages.request_date%type,
                            osbMessage       out varchar2,
                            onuPriceApproved out ld_price_list_deta.price%type,
                            osbError         out varchar2);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuGetPriceArticle
  Descripcion    : Retorna si el precio del articulo ha cambiado a partir de la fecha de visita
                   realizada al cliente y ademas retornara los siguientes valores:
                   Precio: (Precio)
  Autor          : AAcuna
  Fecha          : 21/03/2013 04:55:27 p.m.
  
  Parametros              Descripcion
  ============            ===================
  nuArticle              Numero de articulo
  nuSusccodi             Numero de contrato
  nuPrice                Precio actual del articulo
  dtVisit                Fecha  limite de visita
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  
  ******************************************************************/

  FUNCTION fnuGetPriceArticle(nuArticle  in ld_article.article_id%type,
                              nuSusccodi in suscripc.susccodi%type,
                              nuPrice    in ld_price_list_deta.price%type,
                              dtVisit    in mo_packages.request_date%type)
  
   RETURN ld_price_list_deta.price%type;

  function fnuSaleValue(inuSalePackage in mo_packages.package_id%type)
    return number;

  function fnuSaleActiType return number;

  function fnuReviActiType return number;

  function fnuReviTaskType return number;

  procedure legalizeReviwOrder(inuOrder or_order.order_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : GetPolicyHistoric
  Descripcion    : Retorna true o false dependiendo si el contrato tiene alguna politica
                   incumplida y su valor de asignacion de cuota
  
  Autor          : AAcuna
  Fecha          : 15/03/2013
  
  Parametros              Descripcion
  ============         ===================
  inuSubscriptionId       Identificador del cupo de credito.
  oblType                 Retorna true/false si cumple o incumple las politicas.
  onuAssignedQuota        Valor de asignacion de cuota.
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  PROCEDURE GetPolicyHistoric(inuSubscriptionId suscripc.susccodi%type,
                              oblType           out boolean,
                              onuAssignedQuota  out ld_quota_historic.assigned_quote%type);

  /*PROCEDURE validateNumberFNB(inuNumero   in fa_consdist.codiulnu%type,
                              inuOperUnit in or_operating_unit.operating_unit_id%type);
  
  PROCEDURE setNumberFNB(inuNumero   in fa_consdist.codiulnu%type,
                         inuOperUnit in or_operating_unit.operating_unit_id%type);*/

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : validateNumberFNB
  Descripcion    :
  
  Autor          : Evens Herard Gorut
  Fecha          : 21/03/2013
  
  Parametros              Descripcion
  ============         ===================
  inuNumero            Numero de consecutivo
  inuOperUnit          Unidad operativa
  inuTipoProd          Tipo de producto
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE validateNumberFNB(inuNumero   in fa_consdist.codiulnu%type, ---consecutivo
                              inuOperUnit in or_operating_unit.operating_unit_id%type, -- Unidad
                              inuTipoProd in servicio.servcodi%type -- tipo de producto
                              );

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : setNumberFNB
  Descripcion    : E
  
  Autor          : Evens Herard Gorut
  Fecha          : 21/03/2013
  
  Parametros              Descripcion
  ============         ===================
  inuNumero            Numero de consecutivo
  inuOperUnit          Unidad operativa
  inuTipoProd          Tipo de producto
  oboGenePend          Variable boolean de salida
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE setNumberFNB(inuNumero   in fa_consdist.codiulnu%type, -- consecutivo
                         inuTipoProd in servicio.servcodi%type,
                         inuOperUnit in or_operating_unit.operating_unit_id%type,
                         oboGenePend out boolean);
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : UpRequestsetNumberFNB
  Descripcion    : Actualiza el tipo de documento y el numero de documento en la solicitud.
  
  Autor          : Evens Herard Gorut
  Fecha          : 21/03/2013
  
  Parametros              Descripcion
  ============         ===================
  inuRequest           Numero de la solicitud.
  inuNumero            Numero de consecutivo
  inuOperUnit          Unidad operativa
  inuTipoProd          Tipo de producto
  oboGenePend          Variable boolean de salida
  
    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========   =========               ====================
  ******************************************************************/
  PROCEDURE UpRequestSetNumberFNB(inuRequest  in mo_packages.package_id%type,
                                  inuNumero   in fa_consdist.codiulnu%type,
                                  inuTipoProd in servicio.servcodi%type,
                                  inuOperUnit in or_operating_unit.operating_unit_id%type,
                                  oboGenePend out boolean);

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  UpRequestNumberFNB
  Descripcion :  Actualiza tipo comprobante y consecutivo en solicitud de
                 venta FNB por pagare digital.
                 Adicionalmente actualiza numero como usado en modelo de
                 numeracion autorizada.
  
  Autor       :  Santiago Gomez Rico
  Fecha       :  20-11-2013
  Parametros  :  inuPackage       Solicitud de venta.
                 inuVouchTyp      Tipo comprobante.
                 inuOperUnit      Unidad operativa.
                 inuNumber        Consecutivo.
  
  Historia de Modificaciones
  Fecha        Autor              Modificacion
  =========    =========          ====================
  20-11-2013   sgomez.SAO223765   Creacion.
  ***************************************************************/

  PROCEDURE UpRequestNumberFNB(inuPackage  in mo_packages.package_id%type,
                               inuVouchTyp in tipocomp.ticocodi%type,
                               inuOperUnit in or_operating_unit.operating_unit_id%type,
                               inuNumber   in fa_consdist.codiulnu%type);

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  UpRequestVoucherFNB
  Descripcion :  Actualiza numero como usado en modelo de
                 numeracion autorizada.
  
  Autor       :  John Wilmer Robayo Sanchez
  Fecha       :  10-12-2013
                 inuVouchTyp      Tipo comprobante.
                 inuOperUnit      Unidad operativa.
                 inuNumber        Consecutivo.
  
  Historia de Modificaciones
  Fecha        Autor              Modificacion
  =========    =========          ====================
  10-12-2013   jrobayo.SAO226817   Creacion.
  ***************************************************************/

  PROCEDURE UpRequestVoucherFNB(inuVouchTyp in tipocomp.ticocodi%type,
                                inuOperUnit in or_operating_unit.operating_unit_id%type,
                                inuNumber   in fa_consdist.codiulnu%type);

  /************************************************************************
    Propiedad intelectual de Open International Systems (c).
  
     Unidad         : Fbllegalizeorder
     Descripci?n    : Se encarga de determinar si una orden fue legalizada
                      con ?xito
     Autor          : jonathan alberto consuegra lara
     Fecha          : 20/03/2013
  
     Par?metros       Descripci?n
     ============     ===================
     inuorder         Identificador de la orden de trabajo
  
     Historia de Modificaciones
     Fecha            Autor                 Modificaci?n
     =========        =========             ====================
     20/03/2013       jconsuegra.SAO139854  Creaci?n
  /*************************************************************************/
  Function Fbllegalizeorder(inuorder in or_order.order_id%type)
    return boolean;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : validateCosigner
  Descripcion    : Procedimiento que valida un codeudor.
  Autor          : Alex Valencia Ayola
  Fecha          : 10/04/2013
  
  Parametros              Descripcion
  ============         ===================
  inuSupplierId        Identificador del proveedor
  isbIdentification    Identificacion del codeudor
  onuErrCod            Codigo de error
  osbErrMsg            Mensaje de error
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  
  ******************************************************************/
  PROCEDURE validateCosigner(inuSupplierId     IN ld_suppli_settings.supplier_id%TYPE,
                             isbIdentification IN ld_promissory.identification%TYPE,
                             inuIdent_Type_Id  IN ge_subscriber.Ident_Type_Id%TYPE,
                             blResult          OUT boolean);

  /************************************************************************
    Propiedad intelectual de Open International Systems (c).
  
     Unidad         : RegisterProspect
     Descripcion    : Se encarga de registrar un prospecto
     Autor          : jonathan alberto consuegra lara
     Fecha          : 12/04/2013
  
     Parametros            Descripcion
     ============          ===================
     inuident_type_id      Tipo de identificacion
     isbidentification     Identificacion
     isbsubscriber_name    Nombre del cliente
  
     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     12/04/2013       jconsuegra.SAO139854  Creacion
  /*************************************************************************/
  Procedure RegisterProspect(inuident_type_id   ge_Subscriber.ident_type_id%type,
                             isbidentification  ge_Subscriber.identification%type,
                             isbsubscriber_name ge_Subscriber.subscriber_name%type,
                             isbSUBS_LAST_NAME  ge_Subscriber.SUBS_LAST_NAME%type default NULL);

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
  
   Unidad         : fnuValiStateClient
   Descripcion    : validar si el cliente posee buen comportamiento.
                    Es decir, que su estado financiero sea paz y salvo.
                    si el cliente no posee ningun servicio suscrito se
                    retornara que esta a paz y salvo.
  
   Autor          : Evens Herard Gorut
   Fecha          : 10/04/2013
  
   Parametros       Descripcion
   ============     ===================
  
   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   10/04/2013       Eherard.SAO156577     Creacion
  ******************************************************************/
  FUNCTION fnuValiStateClient(inuSusbcriber in ge_subscriber.subscriber_id%type,
                              inuraiseError in number default 1)
    Return boolean;

  /************************************************************************
    Propiedad intelectual de Open International Systems (c).
  
    Unidad         : Update_Cosigner_Information
    Descripcion    : Se encarga de actualizar cierta informacion de un
                     cliente que es codeudor
    Autor          : jonathan alberto consuegra lara
    Fecha          : 15/04/2013
  
    Parametros         Descripcion
    ============       ===================
    isbidentification  identificacion del suscriptor
    inuIdent_Type_Id   identificador del tipo de identificacion
    isbName            nombre del suscriptor
    isbPhone           telefono del suscriptor
    isbMail            email del suscriptor
  
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    15/04/2013       jconsuegra.SAO139854  Creacion
  /*************************************************************************/
  Procedure Update_Cosigner_Information(isbidentification ge_subscriber.subscriber_id%type,
                                        inuIdent_Type_Id  ge_subscriber.Ident_Type_Id%type,
                                        isbName           ge_subscriber.subscriber_name%type,
                                        isbPhone          ge_subscriber.phone%type,
                                        isbMail           ge_subscriber.e_mail%type);

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
  
   Unidad         : fnuBillNumber
   Descripcion    : Valida que el contraro no tiene mas de n facturas vencidas.
  
  
   Autor          : Eduar Ramos Barragan
   Fecha          : 15/05/2013
  
   Parametros       Descripcion
   ============     ===================
   inuSuscripc    : Contrato
  
   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
  ******************************************************************/
  FUNCTION fnuBillNumber(inuSuscripc in suscripc.susccodi%type) Return number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
  
   Unidad         : registerBillPending
   Descripcion    : Realiza el registro en la entidad facturas pendientes por pagar,
                    a partir de la factura y solicitud se deja la marca de pago o no pago
                    de la factura ingresada.
  
  
   Autor          : AAcuna
   Fecha          : 19/05/2013
  
   Parametros       Descripcion
   ============     ===================
   inuPackage       : Solicitud
   inuFact          : Factura
  
  
   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
  ******************************************************************/
  PROCEDURE registerBillPending(inuPackage in mo_packages.package_id%type,
                                inuFact    in factura.factcodi%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuValExiVisFNB
  Descripcion    : Servicio para verificar si existe una solicitud de visita para un contrato en particular, hace n dias (lo determina el parametro DAY_MAX_VISIT)
                   retorna los siguientes valores:
                   0 no hay visita 1 si hay visita.
  Autor          : AAcuna
  Fecha          : 19/03/2013
  
  Parametros          Descripcion
  ============     ===================
  inuSuscripc    : Numero del contrato
  idtRegister    : Fecha de solicitud
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  19/03/2013      AAcuna              Creacion
  ******************************************************************/

  FUNCTION fnuValExiVisFNB(inuSuscripc in suscripc.susccodi%type,
                           idtRegister in mo_packages.request_date%type)
  
   RETURN number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
  
   Unidad         : fnuQuotaTransferCalc
   Descripcion    : Metodo que calcula la transferencia de cupo
  
   Autor          : Evens Herard Gorut
   Fecha          : 25/04/2013
  
   Parametros       Descripcion
   ============     ===================
  
   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   25/04/2013       Eherard.SAO156577     Creacion
  ******************************************************************/
  FUNCTION fnuQuotaTransferCalc(inuPackage_id in mo_packages.package_id%type,
                                inuSuscripc   in suscripc.susccodi%type,
                                inuraiseError in number default 1)
  
   RETURN Number;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
  
   Unidad         : UpdDebCos
   Descripcion    : Metodo que actualiza los campos en Ge_subscriber dependiendo de la
                    configuracion que se tenga en la tabla de LD_parameter
  
   Autor          : KBaquero
   Fecha          : 20/05/2013
  
   Parametros       Descripcion
   ============     ===================
    Inuidtype:        Id. tipo de identificacion
    ISbname:          Nombre de cliente
    Isbtel:           Telefono del cliente
    Isbmail:          Email del cliente
    Isbidentid:       Identificacion del Cliente
    opcion:           D: si el cliente ingresado es un Deudor C: Si el
                     cliente ingresado es un coodeudor.
  
   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   03/10/2013       jrobayo.SAO218266       Se modifica para crear un deudor como cliente
   20/05/2013       KBaquero                 Creacion
  ******************************************************************/

  PROCEDURE UpdDebCos(Inuidtype  in ge_subscriber.ident_type_id%type,
                      Isbidentid in ge_subscriber.identification%type,
                      Isbtel     in ge_subscriber.phone%type,
                      ISbname    in ge_subscriber.subscriber_name%type,
                      Isblastnam in ge_subscriber.subs_last_name%type,
                      Isbmail    in ge_subscriber.e_mail%type,
                      inuAddress in ge_subscriber.address_id%type,
                      IsbBirth   in ge_subs_general_data.date_birth%type,
                      IsbGender  in ge_subs_general_data.gender%type,
                      isbCvSt    in ge_subs_general_data.civil_state_id%type,
                      isbSchool  in ge_subs_general_data.school_degree_id%type,
                      isbProf    in ge_subs_general_data.profession_id%type,
                      opcion     in Varchar2);

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
  
   Unidad         : UpdateOrderActivityPack
   Descripcion    : Metodo que realiza la actualizacion del codigo del
                    paquete en todos las actividades de Or_order_activity
  
   Autor          : KBaquero
   Fecha          : 20/05/2013
  
   Parametros       Descripcion
   ============     ===================
    Inupackage:       Id. paquete
    Inuorder:         Id. De orden
  
  
   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   20/05/2013       KBaquero                 Creacion
  ******************************************************************/

  procedure UpdateOrderActivityPack(Inupackage in mo_packages.package_id%type,
                                    Inuorder   in or_order.order_id%type);

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
  
   Unidad         : IdeInfProm
   Descripcion    : Metodo que el cual dada una identificacion y tipo de identificacion
                    consultara la tabla LD_PROMISSORY, TENIENDO EN CUENTA EL PAQUETE SE IDENTIFICARA LA FECHA DE REGISTRO,
                    Y CON ESTE CAMPO (FECHA DE REGISTRO de la solicitud) se EVualara el parametro MAX_DAYS
                    (si la fecha de registro de la solicitud restandole el sysdate ) es menor o igual al parametro
                    se tomara el registro mas cercano al sysdate  y se enviara esa informacion en un Cursor referenciado.
  
   Autor          : AAcuna
   Fecha          : 22/05/2013
  
   Parametros                 Descripcion
   ============           ===================
   inuTypeId:              Tipo de identificacion
   inuIdentification:      Numero de identificacion
   orfCursorPromissory:    Cursor referenciado con la informacion de la entidad ld_prommisory
  
   Historia de Modificaciones
   Fecha               Autor                 Modificacion
   =========        =========             ====================
   25/05/2013         AAcuna              Creacion
  ******************************************************************/

  PROCEDURE IdeInfProm(inuTypeId           in ld_promissory.ident_type_id%type,
                       inuIdentification   in ld_promissory.identification%type,
                       orfCursorPromissory out constants.tyRefCursor);

  /**********************************************************************
    Propiedad intelectual de OPEN International Systems
    Nombre              getLastCosigner
  
    Autor        Andres Felipe Esguerra Restrepo
  
    Fecha               03-sep-2013
  
    Descripcion         Obtiene el ultimo codeudor usado en la venta Brilla
                        a un cliente especifico
  
    ***Parametros***
    Nombre          Descripcion
    inuTypeId        Tipo de identificacion
  inuIdentification    Numero de identificacion
  orfCursorPromissory    Cursor referenciado con la informacion de
              la entidad ld_prommisory
  ***********************************************************************/
  PROCEDURE getLastCosigner(inuTypeId           in ld_promissory.ident_type_id%type,
                            inuIdentification   in ld_promissory.identification%type,
                            orfCursorPromissory out constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         :  getFIHOSInfo
  Descripcion    : Obtiene informacion para la ejecucion de FOHOS
  
  Autor          :  eramos
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId:        Identificador de la solicitud
  otbArtcile:          Tabla con articulos relacionados con la venta
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE getFIHOSInfo(inuSubscription     suscripc.susccodi%type,
                         osbIdentType        out varchar2,
                         osbIdentification   out ge_subscriber.identification%type,
                         onuSubscriberId     out ge_subscriber.subscriber_id%type,
                         osbSubsName         out ge_subscriber.subscriber_name%type,
                         osbSubsLastName     out ge_subscriber.subs_last_name%type,
                         osbAddress          out ab_address.address_parsed%type,
                         onuAddress_Id       out ab_address.address_id%type,
                         onuGeoLocation      out ge_geogra_location.geograp_location_id%type,
                         osbFullPhone        out ge_subs_phone.full_phone_number%type,
                         osbCategory         out varchar2,
                         osbSubcategory      out varchar2,
                         onuCategory         out number,
                         onuSubcategory      out number,
                         onuRedBalance       out number,
                         onuAssignedQuote    out number,
                         onuUsedQuote        out number,
                         onuAvalibleQuote    out number,
                         osbSupplierName     out ge_contratista.nombre_contratista%type,
                         onuSupplierId       out ge_contratista.id_contratista%type,
                         osbPointSaleName    out or_operating_unit.name%type,
                         onuPointSaleId      out or_operating_unit.operating_unit_id%type,
                         oblTransferQuote    out boolean,
                         oblCosigner         out boolean,
                         oblConsignerGasProd out boolean,
                         oblModiSalesChanel  out boolean,
                         onuSalesChanel      out ld_suppli_settings.default_chan_sale%type,
                         osbPromissoryType   out ld_suppli_settings.type_promiss_note%type,
                         oblRequiApproAnnulm out boolean,
                         oblRequiApproReturn out boolean,
                         osbSaleNameReport   out ld_suppli_settings.sale_name_report%type,
                         osbExeRulePostSale  out ld_suppli_settings.exe_rule_post_sale%type,
                         osbPostLegProcess   out ld_suppli_settings.leg_process_orders%type,
                         onuMinForDelivery   out ld_suppli_settings.min_for_delivery%type,
                         oblDelivInPoint     out boolean,
                         oblLegDelivOrdeAuto out boolean,
                         osbTypePromissNote  out ld_suppli_settings.type_promiss_note%type,
                         onuInsuranceRate    out number,
                         odtDate_Birth       out ge_subs_general_data.date_birth%TYPE,
                         osbGender           out ge_subs_general_data.gender%TYPE,
                         odtPefeme           out perifact.pefafeem%TYPE,
                         osbValidateBill     OUT VARCHAR2);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuSubshasExpirDebt
  Descripcion    : Metodo que indica si un contrato tiene deuda vencida
                   Verifica deuda de un contrato
                   Retorna 0: si no tiene deuda
                   Retorna 1: Si tiene deuda
  
  Autor          : hvera
  Fecha          : 25/06/2013
  
  Parametros       Descripcion
  ============     ===================
  
  Historia de Modificaciones
  Fecha            Autor                 Modificacion
  =========        =========             ====================
  25/06/2013       hvera.SAOxxxxxx       Creacion
  ******************************************************************/
  FUNCTION fnuSubshasExpirDebt(inuPackageId in mo_packages.package_id%type)
    RETURN Number;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : UpdAditionalDataSaleFNB
  Descripcion    : Guarda datos adicionales de la venta, en este servicio se actualizara
                   la cuota aproximada mensual, valor aproximado del seguro y el valor total de la venta
  Autor          : Evelio Sanjuanelo
  Fecha          : 18/Julio/2013
  
  Parametros              Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  24-10-2013      jhagudelo.SAO221218 Se incluyo el parametro de entrada inutransfer para
                                      indica si hubo o no traslado de cupo(Y-N).
  ******************************************************************/
  PROCEDURE UpdAditionalDataSaleFNB(inuPackage_id            ld_non_ba_fi_requ.non_ba_fi_requ_id%type,
                                    inuquota_Aprox_Month     ld_non_ba_fi_requ.quota_aprox_month%type,
                                    inuvalue_aprox_insurance ld_non_ba_fi_requ.value_aprox_insurance%type,
                                    inuvalue_total           ld_non_ba_fi_requ.value_total%type,
                                    inutransfer              ld_non_ba_fi_requ.trasfer_quota%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : availableQuota
  Descripcion    : Obtiene el saldo disponible del cupo de un contrato
  
  Autor          : gavargas
  Fecha          : 16/08/2013
  
  Parametros       Descripcion
  ============     ===================
  
  Historia de Modificaciones
  Fecha            Autor                 Modificacion
  =========        =========             ====================
  16/08/2013       gavargas.SAO211900    Creacion
  ******************************************************************/

  FUNCTION availableQuota(inuSuscripc in suscripc.susccodi%type)
    RETURN Number;

  /***************************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Procedure   :   fnuGetVisitTypeByPackage
  Descripcion :   Retorna el Tipo de Visita dada la solicitud.
  
  Autor       :   Jorge Alejandro Carmona Duque
  Fecha       :   27-08-2013
  Parametros  :
      inuPackageId:    Identificador de la Solicitud.
  
  Retorno     : Tipo de Visita.
  
  Historia de Modificaciones
  Fecha      IDEntrega               Descripcion
  ==========  ======================= ========================================
  27-08-2013  JCarmona.SAO215223      Creacion.
  ***************************************************************************/
  FUNCTION fnuGetVisitTypeByPackage(inuPackageId in mo_packages.package_id%type)
    RETURN ld_sales_visit.visit_type_id%type;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : validatedSolAnuDevPend
  Descripcion :   Valida si existen solicitudes de anulacion o devolucion asociadas
                  a una solicitud de venta registradas
  
  Autor       :   Erika Alejandra Montenegro Gaviria
  Fecha       :   30-08-2013
  
  Parametros       Descripcion
  ============     ===================
  
  Historia de Modificaciones
  Fecha            Autor                 Modificacion
  =========        =========             ====================
  26/08/2013       emontenegro.SAO212156    Creacion
  ******************************************************************/

  PROCEDURE validatedSolAnuDevPend(inuPackageSale in mo_packages.package_id%type);

  function fsbValAvailability(inuSubscription in suscripc.susccodi%type,
                              inuAddress      in ab_address.address_id%type,
                              idtSaleDate     in mo_packages.request_date%type)
    return varchar;

  /**********************************************************************
   Propiedad intelectual de OPEN International Systems
   Nombre              fnuBoIsProvExito
   Autor               Andres Hurtado Gutierrez.
   Fecha               9/5/2013 8:27:04 AM
  
   Descripcion         Retorna TRUE si el contratista del parametro es el exito
  
   Parametros
   Nombre              Descripcion
   inuContractorId     El codigo del contratista
  
   Historia de Modificaciones
   Fecha             Autor         Modificacion
  ***********************************************************************/
  FUNCTION fnuBoIsProvExito(inuContractorId ge_contratista.id_contratista%type)
    RETURN boolean;

  /**********************************************************************
      Propiedad intelectual de OPEN International Systems
      Nombre              fnuBoIsProvOlimpica
      Autor               Andres Hurtado Gutierrez.
      Fecha               9/5/2013 8:27:04 AM
  
      Descripcion         Retorna TRUE si el contratista del parametro es Olimpica
  
      Parametros
      Nombre              Descripcion
      inuContractorId     El codigo del contratista
  
      Historia de Modificaciones
      Fecha             Autor         Modificacion
  ***********************************************************************/
  FUNCTION fnuBoIsProvOlimpica(inuContractorId ge_contratista.id_contratista%type)
    RETURN boolean;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : RegisterExtraQuotFNB
  Descripcion    : Registra el cupo extra utilizado en la venta.
  Autor          :
  Fecha          : 04/09/2013
  
  Parametros              Descripcion
  ============         ===================
  inuExtraQuota        Cupo extra
  inuSubscription      Contrato sobre el que se realiza la venta
  inuUsedQuota         Cupo utilizado
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  04-09-2013     emontenegro. SAO215832   Creacion.
  ******************************************************************/
  PROCEDURE RegisterExtraQuotaFNB(inuExtraQuota   ld_extra_quota.extra_quota_id%type,
                                  inuSubscription suscripc.susccodi%type,
                                  inuUsedQuota    ld_quota_historic.result%type);

  /**********************************************************************
    Propiedad intelectual de OPEN International Systems
    Nombre              GetSubscriberInfo
  
    Autor        Andres Felipe Esguerra Restrepo
  
    Fecha               05-sep-2013
  
    Descripcion         Obtiene datos basicos del cliente con su documento
  
    ***Parametros***
    Nombre        Descripcion
    inuTypeId         Tipo de documento
    inuIdentification   Documento
    orfCursorPromissory CURSOR de salida
  ***********************************************************************/

  PROCEDURE GetSubscriberInfo(inuTypeId           in ge_subscriber.subscriber_id%type,
                              inuIdentification   in ge_subscriber.identification%type,
                              orfCursorPromissory out constants.tyRefCursor);

  PROCEDURE GetConsecutiveByReq(inuRequestId   in ld_non_ba_fi_requ.non_ba_fi_requ_id%type,
                                onuConsecutive out ld_non_ba_fi_requ.manual_prom_note_cons%type);

  PROCEDURE AllocateTempQuota(inuSubscription in suscripc.susccodi%type,
                              inuAssignPolicy in ld_quota_assign_policy.quota_assign_policy_id%type,
                              onuTotal        out ld_credit_quota.quota_value%type);

  FUNCTION fnuAllocateTotalQuota(inuSubscription suscripc.susccodi%type)
    return ld_credit_quota.quota_value%type;

  FUNCTION fnuAllocatQuotaZeroCons(inuSubscription suscripc.susccodi%type)
    RETURN ld_credit_quota.quota_value%type;

  FUNCTION LockSubscription(inuSubscriptionID IN suscripc.susccodi%type)
    return boolean;

  PROCEDURE ReleaseSubscription(inuSubscriptionID IN suscripc.susccodi%type);

  FUNCTION fnugetPackageByCons(inuConsecutive IN ld_non_ba_fi_requ.digital_prom_note_cons%type)
    RETURN mo_packages.package_id%type;

  FUNCTION fnugetConsByPackage(inuPackageId mo_packages.package_id%type)
    RETURN ld_non_ba_fi_requ.digital_prom_note_cons%type;

  PROCEDURE ProcessQuotaByLoca(inuLocalidad in ge_geogra_location.geograp_location_id%type);

  PROCEDURE RegAditionalFNBInfo(inuPackageSale         IN mo_packages.package_id%type,
                                inCosigner_Subs_Id     IN suscripc.susccodi%type,
                                inuAproxMonthInsurance IN ld_aditional_fnb_info.aprox_month_insurance%type);

  PROCEDURE AnnulReqVoucherFNB(inuVouchTyp in tipocomp.ticocodi%type,
                               inuNumber   in fa_consdist.codiulnu%type);

END LDC_CALCULACUPOBRILLA;
/
create or replace PACKAGE BODY ADM_PERSON.LDC_CALCULACUPOBRILLA IS
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : LDC_CALCULACUPOBRILLA
  Descripcion    : Paquete con la logica de negocio para el manejo
                   de financiaciones no bancarias.
  Autor          :
  Fecha          : 11/07/2012
  
  Historia de Modificaciones
  Fecha         Autor               Modificacion
  -------------------------------------------------
  18-03-2015    KCienfuegos.NC4942  Se modifica el metodo <<AllocateQuota>>
  09-03-2015    KCienfuegos.NC4942  Se modifica metodo <<AllocateQuota>>
  22-10-2014    Llozada RQ 1172     se modifica el metodo <<fnuAllocatQuotaZeroCons>>
  22-10-2014    Llozada [RQ 1172]   se modifica el metodo <<fblExcecutePolicy>>
  21-10-2014    llozada [NC 2253]   se modifica el metodo <<frfgetExtraQuoteBySubs>>
  26-09-2014    KCienfuegos.RNP198  Se modifica el metodo <<AllocateQuota>>
  24-09-2014    Llozada. RQ 1172    Se modifica el metodo <<fnuAllocatQuotaZeroCons>>
  18-09-2014    KCienfuegos.NC2250  Se modifica metodo <<AllocateQuota>>
  12-09-2014    KCienfuegos.RNP513  Se modifica <<fblExcecutePolicy>>
  02-09-2014    KCienfuegos.NC2039  Se modifica <<AllocateQuota>>
  04-03-2014    hjgomez.SAO234698   Se modifica <<UpdDebCos>>
  03-03-2014    AecheverrySAO234429 se modifican <<AllocateQuota>> y <<AllocateTempQuota>>
  17-02-2014    AEcheverrtSAO232729 se modifica <<fnuSubshasExpirDebt>>
  19-01-2014    AEcheverrySAO230074 Se modifica <<fnuGetUsedQuote>>
  18-12-2013    LDiuza.SAO227806    Se crea el metodo <<RegAditionalFNBInfo>>
  11-12-2013    hjgomez.SAO227057   Se modifica <<frcGetDataCancelReq>>
  05-12-2013    AEcheverrySAO226231 creacion <<ProcessQuotaByLoca>>
  28-11-2013    hjgomez.SAO225175   Se modifican los metodos que actualizan el historico del cupo
                                    para agregarles un enter
  27-11-2013    sgomez.SAO224773    Se modifica obtencion de cupo usado para que
                                    SOLO tenga en cuenta las cuotas de diferido,
                                    al momento de calcular el saldo no pagado.
  
  25-nov-2013   AEcheverrySAO224617 Se modifica <<AllocateQuota>> y <<AllocateTempQuota>>
                                    por problemas de memoria
  20-11-2013    sgomez.SAO223765    Se elimina procedimiento <GetSaleData> por
                                    desuso.
                                    Se adiciona procedimiento
                                    <UpRequestNumberFNB> para actualizacion
                                    de consecutivo de Pagare Digital.
  
  14-11-2013    hjgomez.SAO222578   Se modifica <GetSupplierData> <UpdDebCos>
  29-10-2013    LDiuza.SAO221194    Se adiciona el metodo <fnuAllocatQuotaZeroCons>
  09-Oct-2013   jacuna.SAO218931 Se adiciona el metodo <UpRequestSetNumberFNB>
  
  27-Sep-2013   jcarrillo.SAO217948 Se modifica el metodo <simulateQuota>
  25-06-2013    hvera               Se crea el metodo <fnuSubshasExpirDebt>
                                    Se modifica el metodo <registerBillPending>
  03-09-2013    vhurtado            Se modifica metodo getFIFAPInfo
  04-09-2013    vhurtadoSAO214540   Se modifica metodo getAvalibleArticle
  05-09-2013    vhurtadoSAO212016   Se crea metodo fnuBoIsProvExito
  05-09-2013    vhurtadoSAO212016   Se crea metodo fnuBoIsProvOlimpica
  06-09-2013    jcastroSAO212991    Se modifican los metodos GetSupplierData
                                    y GetSupplierFIHOSData.
  ******************************************************************/

  -- Declaracion de variables y tipos globales privados del paquete
  -- CONSTANTES
  csbVERSION constant varchar2(20) := 'SAO234698';

  csbPolicyHistoric constant varchar2(20) := 'COD_POLICY_HISTORIC';

  nuQuotaTotal ld_credit_quota.quota_value%type := 0;

  TYPE tyrcLocations IS RECORD(
    geograp_location_id ge_geogra_location.geograp_location_id%type,
    description         ge_geogra_location.description%type);

  isbPosLegProcess ld_suppli_settings.post_leg_process%TYPE;
  isbDeliveryPoint ld_non_ba_fi_requ.delivery_point%TYPE;
  dtMaxBreachDate  date := null;
  nuswblockquota   number := ld_boconstans.cnuCero_Value;

  cnuTypoPrBr           constant servicio.servcodi%type := Dald_parameter.fnuGetNumeric_Value(ld_boconstans.cnuCodTypeProductBR);
  cnuTypoPrBrPG         constant servicio.servcodi%type := Dald_parameter.fnuGetNumeric_Value(ld_boconstans.cnuCodTypeProductBRP);
  cnuActivityTypeFNB    constant ld_parameter.numeric_value%type := Dald_parameter.fnuGetNumeric_Value('ACTIVITY_TYPE_FNB');
  cnuActivityTypeDelFNB constant ld_parameter.numeric_value%type := Dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB');
  cnuTaskTypeRevFNB ld_parameter.numeric_value%type := null;
  /*Producto Promigas*/
  cnuPromigas CONSTANT servicio.servcodi%TYPE := dald_parameter.fnuGetNumeric_Value('COD_PRODUCT_TYPE_BRILLA_PROM');
  /*Producto BRILLA*/
  cnuBrilla            CONSTANT servicio.servcodi%TYPE := dald_parameter.fnuGetNumeric_Value('COD_PRODUCT_TYPE_BRILLA');
  cnuQuotaCero         constant ld_quota_by_subsc.quota_value%type := 0;
  csbNOGASPRODUCTMESS  constant ld_quota_historic.observation%type := 'El usuario no posee producto GAS Activo';
  sbTypeDeferWarr      constant diferido.difetire%type := pkGeneralParametersMgr.fsbGetStringParameter('TIPO_REGIS_DEPOSITO_GARANTIA');
  cnuERROR_SUBS_LOCKED CONSTANT ge_message.message_id%type := 900782;
  -- Definicion de metodos publicos y privados del paquete

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : cuGetunitBySeller
  Descripcion    : Obtiene la unidad actual del usuario conectado
  Autor          : Albeyro Echeverry
  Fecha          : 13/06/2013
  
  Parametros              Descripcion
  ============         ===================
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  CURSOR cuGetunitBySeller IS
    SELECT organizat_area_id
      FROM cc_orga_area_seller
     WHERE person_id = GE_BOPersonal.fnuGetPersonId
       AND IS_current = 'Y'
       AND rownum = 1;

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  BEGIN
    RETURN csbVersion;
  END;

  Function Fnugetsesunuse(inususcripc   in servsusc.sesususc%type,
                          inuRaiseError in number default 1)
    return servsusc.sesunuse%type is
    nusesunuse servsusc.sesunuse%type;
    cnuInactiveService constant servsusc.sesuesco%type := 96;
  
    CURSOR cuProduct IS
      SELECT /*+ leading( a )
                          index( a IDX_PR_PRODUCT_010 )
                          index( s PK_SERVSUSC )
                          index( c PK_PS_PRODUCT_STATUS ) */
       s.sesunuse
        FROM pr_product a, servsusc s, ps_product_status c
       WHERE a.subscription_id = inususcripc
         AND a.product_type_id = ld_boconstans.cnuGasService
         AND s.sesunuse = a.product_id
         AND (s.sesufere is null OR s.sesufere > sysdate)
         AND a.product_status_id = c.product_status_id --
         AND c.is_active_product = 'Y'
         and c.is_final_status = 'Y'
         AND s.sesuesco <> cnuInactiveService
         And rownum = 1;
  
  Begin
    ut_trace.trace('Inicio Ld_BcSubsidy.Fnugetsesunuse', 10);
  
    open cuProduct;
    fetch cuProduct
      INTO nusesunuse;
    close cuProduct;
  
    ut_trace.trace('Fin Ld_BcSubsidy.Fnugetsesunuse ', 10);
    Return(nusesunuse);
  
  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      if inuRaiseError = 1 then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
  End Fnugetsesunuse;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : quotaTotal
  Descripcion    : Calcula el cupo total.
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuQuotaTotal(inuQuotaValue ld_quota_by_subsc.quota_value%type,
                         inuValue      ld_extra_quota.value%type,
                         sbQuotaOption ld_extra_quota.quota_option%type)
    return number IS
  
  BEGIN
  
    if sbQuotaOption = 'V' then
    
      return inuValue;
    
    else
    
      return inuQuotaValue *(inuValue / 100);
    
    end if;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuQuotaTotal;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : PrintPromissoryCopy
  Descripcion    : Procedimiento que imprime un pagare.
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  28-11-2013      hjgomez.SAO225175   Se agrega el enter al final de la observacion
  ******************************************************************/
  PROCEDURE updateQuota(inuSubscription suscripc.susccodi%type,
                        inuValue        ld_credit_quota.quota_value%type,
                        isbResult       ld_quota_historic.result%type,
                        isbObservation  ld_quota_historic.observation%type) IS
  
    rcQuotaRegister dald_quota_by_subsc.styLD_quota_by_subsc;
    --rcQuotaHistoric dald_quota_historic.styLD_quota_historic;
  
  BEGIN
  
    rcQuotaRegister := ld_bcnonbankfinancing.frcGetQuotaRegister(inuSubscription);
  
    if rcQuotaRegister.quota_by_subsc_id is null then
      rcQuotaRegister.quota_by_subsc_id := ld_bosequence.fnuSeqQuotaBySubsc;
      rcQuotaRegister.subscription_id   := inuSubscription;
      rcQuotaRegister.quota_value       := inuValue;
      dald_quota_by_subsc.insRecord(rcQuotaRegister);
    else
      rcQuotaRegister.quota_value := inuValue;
      dald_quota_by_subsc.updRecord(rcQuotaRegister);
    end if;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END updateQuota;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fblExcecutePolicy
  Descripcion    : Ejecutas las politicas asociadas a un cupo de credito.
  
  Autor          : Eduar Ramos Barragan
  Fecha          : 17/10/2012
  
  Parametros              Descripcion
  ============         ===================
  inuCreditQuota       Identificador del cupo de credito.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  12-09-2014      KCienfuegos.RNP513  Se modifica para que setee la observacion a nula.
  ******************************************************************/
  FUNCTION fblExcecutePolicy(inuCreditQuota      ld_policy_by_cred_quot.credit_quota_id%type,
                             inuSubscriptionId   suscripc.susccodi%type,
                             inuValue            ld_credit_quota.quota_value%type,
                             inuExcludeAssignPol in ld_quota_assign_policy.quota_assign_policy_id%type,
                             orcQuotaHistoric    out dald_quota_historic.styLD_quota_historic,
                             otbQuotaPolicy      out dald_policy_historic.tytbLD_policy_historic)
    return boolean IS
    tbPolicyCrediQuota dald_policy_by_cred_quot.tytbLD_policy_by_cred_quot;
    nuIndex            number;
    sbResult           varchar2(1) := ld_boconstans.csbYesFlag;
    nuLastQuota        ld_quota_historic.assigned_quote%type;
    nohistPolicyCount  number;
    nuCont             number := 0;
    tbpolicyHist       dald_policy_historic.tytbLD_policy_historic;
  
    /*Llozada [RQ 1172]: Contador para identificar cuando las politicas del parametro
    COD_POLICY_HISTORIC las tiene el contrato a evaluar*/
    nuCupoParcial number := 0;
  
    /*Llozada [RQ 1172]: Cursor que trae las politicas configuradas en COD_POLICY_HISTORIC*/
    CURSOR cuPolicyPartialQuota IS
      SELECT column_value
        FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbGetValue_Chain(csbPolicyHistoric),
                                                ','));
  
  BEGIN
  
    /*Se sube a la instancia el contrato que sera evaluado,
    para que pueda ser obtenido desde las reglas*/
    ld_boinstance.setSubsInstance(inuSubscriptionId);
  
    /*Obtiene las politicas para la evaluaci?n del cupo*/
    tbPolicyCrediQuota := ld_bcnonbankfinancing.ftbgetPolicybyCredit(inuCreditQuota);
  
    /*Si no existe registro de historial o si el n?mero de pol?ticas cambio o
    si el valor del cupo asignado cambio registra historial*/
  
    orcQuotaHistoric.quota_historic_id := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LD_QUOTA_HISTORIC',
                                                                              'SEQ_LD_QUOTA_HISTORIC');
    orcQuotaHistoric.assigned_quote    := round(inuValue, 0);
    orcQuotaHistoric.register_date     := sysdate;
    orcQuotaHistoric.result            := ld_boconstans.fsbNoFlag;
    orcQuotaHistoric.subscription_id   := inuSubscriptionId;
    orcQuotaHistoric.observation       := 'Cupo de credito a evaluar: ' ||
                                          to_char(round(inuValue, 0),
                                                  '$999G999G999G999G999',
                                                  'NLS_NUMERIC_CHARACTERS = ",."') || ' ' ||
                                          chr(13) || CHR(10);
  
    /*Si existen politicas las evalua*/
    if (tbPolicyCrediQuota.count > 0) then
    
      nuIndex := tbPolicyCrediQuota.first;
    
      while nuIndex is not null loop
        /*Llozada [RQ 1172]: Solo se hace cuando no es null, porque esto indica que es cupo parcial*/
        IF inuExcludeAssignPol is not null then
          /*Llozada [RQ 1172]: Se compara cada politica con las configuradas en el parametro COD_POLICY_HISTORIC*/
          for rc in cuPolicyPartialQuota loop
            if tbPolicyCrediQuota(nuIndex)
             .QUOTA_ASSIGN_POLICY_ID = rc.column_value then
              /*Llozada [RQ 1172]: Se inicializa en UNO para indicar que esta en el parametro*/
              nuCupoParcial := 1;
              exit;
            end if;
          end loop;
        end if;
      
        --if (tbPolicyCrediQuota(nuIndex).QUOTA_ASSIGN_POLICY_ID !=
        --    nvl(inuExcludeAssignPol, -2)) then
        /*Llozada [RQ 1172]: Si es CERO indica que la politica NO esta configurada en el parametro
        y por ende la debe evaluar*/
        IF nuCupoParcial = 0 Then
          ld_boinstance.setInstance(tbPolicyCrediQuota(nuIndex)
                                    .parameter_value);
          ld_boinstance.setCurrentPolicy(tbPolicyCrediQuota(nuIndex)
                                         .quota_assign_policy_id);
          ge_boInstanceControl.ExecuteExpression(dald_quota_assign_policy.fnuGetAssign_Rule_Id(tbPolicyCrediQuota(nuIndex)
                                                                                               .quota_assign_policy_id));
        
          if (ld_boinstance.fsbgetInstanceResult = ld_boconstans.csbNOFlag) then
            sbResult := ld_boconstans.csbNOFlag;
            -- solo si se inclumple se coloca fecha de incumplimiento (si es nula , se coloca la actual)
            otbQuotaPolicy(nuIndex).breach_date := nvl(ld_boinstance.fdtgetBreachDate,
                                                       sysdate);
          
            nuCont := nuCont + 1;
          else
            sbResult := ld_boconstans.csbYesFlag;
          end if;
        
          -- se limpia la fecha de incumplimiento
          ld_boinstance.setBreachDate(null);
        
          otbQuotaPolicy(nuIndex).policy_historic_id := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LD_POLICY_HISTORIC',
                                                                                            'SEQ_LD_POLICY_HISTORIC');
          otbQuotaPolicy(nuIndex).quota_historic_id := orcQuotaHistoric.quota_historic_id;
          otbQuotaPolicy(nuIndex).result := sbResult;
          otbQuotaPolicy(nuIndex).quota_assign_policy_id := tbPolicyCrediQuota(nuIndex)
                                                            .quota_assign_policy_id;
          otbQuotaPolicy(nuIndex).observation := 'Para la politica [' || otbQuotaPolicy(nuIndex)
                                                .quota_assign_policy_id ||
                                                 '] el resultado fue: ' ||
                                                 sbResult;
        
          if ld_boinstance.fsbgetObservation is not null then
          
            otbQuotaPolicy(nuIndex).observation := otbQuotaPolicy(nuIndex)
                                                   .observation ||
                                                    ' Con la siguiente observacion :' ||
                                                    ld_boinstance.fsbgetObservation;
            /*Se setea la observacion*/
            ld_boinstance.setObservation(null);
          else
          
            if sbResult = ld_boconstans.csbYesFlag then
              otbQuotaPolicy(nuIndex).observation := otbQuotaPolicy(nuIndex)
                                                     .observation ||
                                                      ' Sin observacion';
            else
              otbQuotaPolicy(nuIndex).observation := otbQuotaPolicy(nuIndex)
                                                     .observation || ' ' ||
                                                      dald_quota_assign_policy.fsbGetObservation(otbQuotaPolicy(nuIndex)
                                                                                                 .quota_assign_policy_id);
            END if;
          
          end if;
        
          orcQuotaHistoric.observation := orcQuotaHistoric.observation || otbQuotaPolicy(nuIndex)
                                         .observation || chr(13) || CHR(10);
        
          ld_boinstance.clearInstance;
          ld_boinstance.clearCurrentPolicy;
          ld_boinstance.clearInstanceResult;
        
        END if;
        nuIndex := tbPolicyCrediQuota.next(nuIndex);
      end loop;
    
      if (nuCont > 0) then
        orcQuotaHistoric.result := ld_boconstans.csbNOFlag;
        return false;
      else
        orcQuotaHistoric.result := ld_boconstans.csbYesFlag;
        return true;
      end if;
    
    else
    
      orcQuotaHistoric.observation := orcQuotaHistoric.observation ||
                                      'No existen politicas que evaluar, no asigno cupo' ||
                                      chr(13) || CHR(10);
    
      return false;
    
    end if;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fblExcecutePolicy;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fblExcecutePolicySimu
  Descripcion    : Ejecutas las politicas asociadas a un cupo de credito.
  
  Autor          : Eduar Ramos Barragan
  Fecha          : 17/10/2012
  
  Parametros              Descripcion
  ============         ===================
  inuCreditQuota       Identificador del cupo de credito.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
    11-oct-2013     AEcheverrySAO219857     se modifica para no retornar verdader si no hay politicas configuradas
  ******************************************************************/
  FUNCTION fblExcecutePolicySimuReal(inuCreditQuota    ld_policy_by_cred_quot.credit_quota_id%type,
                                     inuSubscriptionId suscripc.susccodi%type,
                                     inuValue          ld_credit_quota.quota_value%type)
    return boolean IS
    tbPolicyCrediQuota dald_policy_by_cred_quot.tytbLD_policy_by_cred_quot;
    nuIndex            number;
    sbResult           varchar2(1) := ld_boconstans.csbYesFlag;
    --rcQuotaHistoric    dald_quota_historic.styLD_quota_historic;
    --rcQuotaPolicy      dald_policy_historic.styLD_policy_historic;
  BEGIN
  
    ld_boinstance.setSubsInstance(inuSubscriptionId);
  
    tbPolicyCrediQuota := ld_bcnonbankfinancing.ftbgetPolicybyCredit(inuCreditQuota);
    nuIndex            := tbPolicyCrediQuota.first;
  
    if (tbPolicyCrediQuota.count > 0) then
      while nuIndex is not null loop
        ld_boinstance.setInstance(tbPolicyCrediQuota(nuIndex)
                                  .parameter_value);
        ge_boInstanceControl.ExecuteExpression(dald_quota_assign_policy.fnuGetAssign_Rule_Id(tbPolicyCrediQuota(nuIndex)
                                                                                             .quota_assign_policy_id));
      
        ld_boinstance.setCurrentPolicy(tbPolicyCrediQuota(nuIndex)
                                       .quota_assign_policy_id);
      
        if (ld_boinstance.fsbgetInstanceResult = ld_boconstans.csbNOFlag) then
          sbResult := ld_boconstans.csbNOFlag;
        end if;
      
        ld_boinstance.clearInstance;
        ld_boinstance.clearCurrentPolicy;
      
        nuIndex := tbPolicyCrediQuota.next(nuIndex);
      end loop;
    
      if (sbResult = ld_boconstans.csbNOFlag) then
      
        return false;
      else
      
        return true;
      end if;
    else
      return false;
    END if;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fblExcecutePolicySimuReal;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : PrintPromissoryFile
  Descripcion    : Procedimiento que imprime un pagare.
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrintPromissoryFile IS
  BEGIN
  
    null;
  
    /* null;
    
    FPDF.*/
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END PrintPromissoryFile;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : PrintPromissoryCopy
  Descripcion    : Procedimiento que imprime un pagare.
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId:        Identificador de la solicitud
  inuDeudor:           Se?ala si es deudor o codeudor
  inuCopy:             Identifica cual copia se imprimira
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PrintPromissoryCopy IS
  BEGIN
  
    null;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END PrintPromissoryCopy;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnugetGasProduct
  Descripcion    : funcion que obtiene el identificador del producto
  GAS.
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  Procedure getGasProductData(inuSubscription in suscripc.susccodi%type,
                              onuProductId    out pr_product.product_id%type,
                              onuAddressId    out pr_product.address_id%type) is
  
    tbGasProduct dapr_product.tytbPR_product;
  
  BEGIN
    onuProductId := null;
    onuAddressId := null;
  
    tbGasProduct := pr_bcproduct.ftbGetProdBySubsNType(inuSubscription,
                                                       ld_boconstans.cnuGasService);
  
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
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnugetGasProduct
  Descripcion    : funcion que obtiene el identificador del producto
  GAS.
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnugetGasProduct(inuSubscription suscripc.susccodi%type)
    return number IS
  
    nuProductId pr_product.product_id%type;
    nuAddressId pr_product.address_id%type;
  
  BEGIN
  
    getGasProductData(inuSubscription, nuProductId, nuAddressId);
  
    return nuProductId;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnugetGasProduct;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : AllocateQuota
  Descripcion    : Calcula el valor del cupo dependiendo de la cuota de politica,cuota manual
                   o rollover ademas al final del proceso se le resta el saldo pendiente,
                   valor corriente y valor de la solicitud de venta
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor                   Modificacion
  =========         =========               ====================
  18-03-2014        KCienfuegos.NC4942      Se modifica para que valide los servicios Brilla y/o Promigas
                                            por contrato y no por codigo de cliente.
  09-03-2014        KCienfuegos.NC4942      Se modifica para que valide el numero de cuotas de todos
                                            los diferidos si es necesario.
  26-09-2014        KCienfuegos.RNP198      Se modifica para que realice el llamado al proceso de
                                            segmentacion comercial.
  18-09-2014        KCienfuegos.NC2250      Se modifica para que valide la existencia del diferido
                                            en la evaluacion del cupo Rollover.
  02-09-2014        KCienfuegos.NC2039      Se modifica para que valide si cumple politicas.
  03-04-2014        AEcheverrySAO234429     Se modifica para quitar accesos inecesarios
                                            a suscripc y producto, se eliminan
                                            validaciones innecesarias.
  
  18-10-2013        bhernandezSAO220617     Se modifica el calculo de la cuota para que
                                            obtenga la cuota dependiendo de la ubicacion
                                            mas especifica.
  06/10/2013        JCarmona.SAO218706      Se modifica para que obtenga la
                                            asignacion de cupo de la ubicacion
                                            geografica y no teniendo en cuenta las
                                            ubicaciones padres.
  02/10/2013        JCarmona.SAO218227      Se modifica para que valide que si
                                            el numero de cuotas pendientes es
                                            mayor al numero de cuotas
                                            que viene por configuracion.
  ******************************************************************/
  PROCEDURE AllocateQuota(inuSubscription suscripc.susccodi%type,
                          onuTotal        out ld_credit_quota.quota_value%type)
  
   IS
    nuProduct        number;
    rcSubscription   suscripc%rowtype;
    nuGeogLoca       ge_geogra_location.geograp_location_id%type;
    sbParentLocation varchar2(2000);
    tbCreditQuota    dald_credit_quota.tytbLD_credit_quota;
    blPolicyResult   boolean;
    rcServsusc       servsusc%rowtype;
    tyrcQuota        LDC_CALCULACUPOBRILLA.tyrcManualQuota;
    tbManualQuota    dald_manual_quota.tytbLD_manual_quota;
    tbBlockQuota     dald_quota_block.tytbBlock;
    sbBlock          ld_quota_block.block%type;
    sbComment        varchar2(2000);
    subscriberId     ge_subscriber.subscriber_id%type;
    nuCategory       Servsusc.Sesucate%type;
    nuSubcategory    Servsusc.Sesusuca%type;
    tbSesuServ       pktblservsusc.tySesuserv;
    tbSesuType       pktblservsusc.tySesunuse;
    nuServ           servsusc.sesuserv%type;
    nuSesunuse       servsusc.sesunuse%type;
    nuDifesape       diferido.difesape%type := 0;
    rcRollover       ld_bcnonbankfinancing.tytbLD_Rollover_quota;
    nuIndex          number;
    nuProductType    ld_rollover_quota.product_type_id%type;
    nuValue          ld_rollover_quota.value%type;
    sbQuota_option   ld_rollover_quota.Quota_option%type;
    nuTotal          ld_credit_quota.quota_value%type := -1;
    nuQuotas_number  ld_rollover_quota.quotas_number%type;
    nuCont           number := 0;
    nuValidator      number := 0;
    nuDiscount       number := 0;
    nuLastQuota      ld_quota_historic.assigned_quote%type;
    nuDifenucu       diferido.difenucu%type;
  
    rcQuotaHistoric   dald_quota_historic.styLD_quota_historic;
    sbMessage         varchar2(32000);
    tbPolicyHist      dald_policy_historic.tytbLD_policy_historic;
    rcQuotaHistLast   dald_quota_historic.styLD_quota_historic;
    nuquotavalue      ld_credit_quota.quota_value%type;
    nuNeighborthoodId ab_address.neighborthood_id%type;
  
    nuLevelAsig    NUMBER := -1;
    nuTempAsig     NUMBER;
    nuTempTotal    NUMBER := -1;
    tbString       ut_string.TyTB_String;
    tbTempString   ut_string.TyTB_String;
    blAssigByArea  boolean;
    blExistsDeferr boolean;
    nuGasAddressId ab_address.address_id%type;
    rcPendQuotes   ld_bcnonbankfinancing.tytbPendingQuotes;
  
  BEGIN
  
    ut_trace.trace('Inicia LDC_CALCULACUPOBRILLA.AllocateQuota', 1);
  
    onuTotal     := cnuQuotaCero;
    nuQuotaTotal := cnuQuotaCero;
  
    /*Obtiene los datos del producto gas*/
    getGasProductData(inuSubscription, nuProduct, nuGasAddressId);
  
    dtMaxBreachDate := null;
  
    /*Valida si el contrato tiene producto gas*/
    ut_trace.trace('nuProduct: ' || nuProduct, 10);
  
    if nuProduct is not null then
    
      /*Obtiene los datos del suscritor retornando un tipo record*/
      rcSubscription := pktblsuscripc.frcgetrecord(inuSubscription);
      /*Obtiene el cliente del contrato para el proceso de rollover*/
      subscriberId := rcSubscription.suscclie;
      /*Obtiene la ubicacion geografica a partir de la direccion del producto gas*/
      nuGeogLoca := daab_address.fnuGetGeograp_Location_Id(nuGasAddressId);
      /*Obtiene el record de los datos del sesunuse del servicio gas*/
      rcServsusc := pktblservsusc.frcGetRecord(nuProduct);
      /*Obtiene la subcategoria del servicio gas*/
      nuSubcategory := rcServsusc.Sesusuca;
      /*Obtiene la categoria del servicio gas*/
      nuCategory := rcServsusc.Sesucate;
      /* Se obtienen los datos de la direccion del contrato*/
      nuNeighborthoodId := daab_address.fnugetneighborthood_id(rcSubscription.susciddi);
    
      /* Valida si debe obtener la asignacion de cupo del barrio o de la localidad */
      IF (nuNeighborthoodId IS null OR
         nuNeighborthoodId = LD_BOConstans.cnuallrows) THEN
        /*Obtiene los padres de la ubicacion geografica*/
        ge_bogeogra_location.GetGeograpParents(nuGeogLoca,
                                               sbParentLocation);
      else
        /*Obtiene los padres de la ubicacion geografica*/
        ge_bogeogra_location.GetGeograpParents(nuNeighborthoodId,
                                               sbParentLocation);
      END IF;
    
      /*Obtiene la direccion parseada de la ubicacion geografica*/
      tbCreditQuota := LD_BCNONBANKFINANCING.ftbGetCreditQuote(nuCategory,
                                                               nuSubcategory,
                                                               sbParentLocation);
      /*Valida si tiene credito*/
      if (tbCreditQuota.count > 0) then
      
        /*Se valida el valor a evaluar. Si el proceso que se ejecuto anteriomente fue
        un bloqueo de cupo el valor a procesar sera cero, en caso contrario el que
        se encuentre almacenado en la tabla tbCreditQuota*/
        if nuswblockquota = ld_boconstans.cnuonenumber then
          nuquotavalue := ld_boconstans.cnuCero_Value;
        else
          nuquotavalue := tbCreditQuota(tbCreditQuota.first).quota_value;
        end if;
      
        /*Le asigna el valor que le corresponde por politica de cupo*/
        blPolicyResult := fblExcecutePolicy(tbCreditQuota(tbCreditQuota.first)
                                            .credit_quota_id,
                                            inuSubscription,
                                            nuquotavalue,
                                            null,
                                            rcQuotaHistoric,
                                            tbPolicyHist);
      
      else
      
        onuTotal     := cnuQuotaCero;
        nuQuotaTotal := cnuQuotaCero;
      
        updateQuota(inuSubscription,
                    nuQuotaTotal,
                    ld_boconstans.csbNOFlag,
                    null);
      
        /*registra historico de cupo en 0*/
        rcQuotaHistoric.quota_historic_id := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LD_QUOTA_HISTORIC',
                                                                                 'SEQ_LD_QUOTA_HISTORIC');
        rcQuotaHistoric.assigned_quote    := nuQuotaTotal;
        rcQuotaHistoric.register_date     := sysdate;
        rcQuotaHistoric.result            := ld_boconstans.csbYesFlag;
        rcQuotaHistoric.subscription_id   := inuSubscription;
        rcQuotaHistoric.observation       := 'No existe configuracion definida' ||
                                             chr(13) || CHR(10);
      
        dald_quota_historic.insRecord(rcQuotaHistoric);
        goto final;
      
      end if;
    
      /*Valida si el contrato tiene un cupo de politica definido*/
      if (blPolicyResult) then
        onuTotal := tbCreditQuota(tbCreditQuota.first).quota_value;
      
        /*Si el valor asignado por politica es mayor a cero se le asigna a la variable
        global valor final de cuota el valor de la politica*/
      
        if (onuTotal > nuQuotaTotal) then
          nuQuotaTotal := onuTotal;
        end if;
      
        rcQuotaHistoric.assigned_quote := nuQuotaTotal;
        onuTotal                       := nuQuotaTotal;
        updateQuota(inuSubscription,
                    nuQuotaTotal,
                    ld_boconstans.csbYesFlag,
                    null);
      
        /* Se le asigna una couta con valor cero*/
      else
        onuTotal     := cnuQuotaCero;
        nuQuotaTotal := cnuQuotaCero;
      
        updateQuota(inuSubscription,
                    nuQuotaTotal,
                    ld_boconstans.csbNOFlag,
                    null);
        rcQuotaHistoric.assigned_quote := nuQuotaTotal;
      
        -- si no se evaluaron politicas -->NO SE DEBE ASIGNAR CUPO MANUAL
        if (tbPolicyHist.count < 1) then
          dtMaxBreachDate := TRUNC(SYSDATE);
        END if;
      end if;
    
      /* Valido que el cursor de cuota manual trae registros , asi verifico que
      el contrato tenga un cupo manual reciente. */
    
      /*Recorre las politicas para verificar la fecha m?xima de incumplimiento*/
      nuIndex := tbPolicyHist.first;
    
      while nuIndex is not null loop
      
        if (tbPolicyHist(nuIndex).breach_date is not null) then
        
          if (dtMaxBreachDate IS null) OR
             (dtMaxBreachDate < tbPolicyHist(nuIndex).breach_date) then
          
            dtMaxBreachDate := tbPolicyHist(nuIndex).breach_date;
          
          end if;
        
        end if;
      
        nuIndex := tbPolicyHist.next(nuIndex);
      end loop;
    
      /*Manejo para cupo manual*/
      tbManualQuota := LD_BCNONBANKFINANCING.FtbGetbestManualQuota(inuSubscription);
    
      /*Recorrido para asignacion de cuota manual */
      nuIndex := tbManualQuota.first;
      while nuIndex is not null loop
      
        /* Valida si la fecha final es nula, si lo es agrega al comentario de la observacion
        que la fecha final es indefinida.*/
        if (tbManualQuota(nuIndex).final_date is null) then
          sbComment := 'Indefinida';
        else
          sbComment := tbManualQuota(nuIndex).final_date;
        end if;
      
        /* Ingresa el registro historico a partir de los datos de la cuota manual.*/
        rcQuotaHistoric.observation := rcQuotaHistoric.observation ||
                                       'Asignacion de cupo de manual: ' ||
                                       to_char(tbManualQuota(nuIndex)
                                               .quota_value,
                                               '$999G999G999G999G999',
                                               'NLS_NUMERIC_CHARACTERS = ",."') ||
                                       ' Fecha inicial: ' || tbManualQuota(nuIndex)
                                      .initial_date || ' Fecha final: ' ||
                                       sbComment || chr(13);
      
        if (nvl(dtMaxBreachDate, tbManualQuota(nuIndex).initial_date - 1) < tbManualQuota(nuIndex)
           .initial_date) then
        
          rcQuotaHistoric.observation := rcQuotaHistoric.observation ||
                                         '     Cumple con las politicas posteriores a la fecha de asignacion' ||
                                         chr(13) || CHR(10);
        
          /* Verifico  si el valor de la cuota manual
          es mayor al que trae la variable global de cupo final, entonces
          se le asigna a la varible global la couta manual*/
          if (tbManualQuota(nuIndex).quota_value > nuQuotaTotal) then
            nuQuotaTotal := tbManualQuota(nuIndex).quota_value;
          end if;
        
          /* Actualiza la cuota de cupo */
          onuTotal := nuQuotaTotal;
          updateQuota(tbManualQuota(tbManualQuota.first).subscription_id,
                      nuQuotaTotal,
                      ld_boconstans.csbYesFlag,
                      null);
          rcQuotaHistoric.assigned_quote := nuQuotaTotal;
          /* Fin del ingreso del registro historico */
        else
          rcQuotaHistoric.observation := rcQuotaHistoric.observation ||
                                         ' No cumple con las politicas posteriores a la fecha de asignacion' ||
                                         chr(13) || CHR(10);
        end if;
      
        nuIndex := tbManualQuota.next(nuIndex);
      
      end loop;
    
      /*Obtiene los bloqueos de cupo*/
      tbBlockQuota := LD_BCNONBANKFINANCING.FtbGetQuota_Block(inuSubscription);
    
      /* Trae el registro de bloqueo y desbloqueo mas reciente a partir del contrato*/
      if tbBlockQuota.count > 0 then
      
        /* Verifica que el contrato tenga cupo bloqueado */
        if (tbBlockQuota(tbBlockQuota.first) = 'Y') then
          onuTotal     := cnuQuotaCero;
          nuQuotaTotal := cnuQuotaCero;
          /* Ingresa el registro historico de bloqueo y desbloqueo con un valor cero .*/
          rcQuotaHistoric.observation := rcQuotaHistoric.observation ||
                                         ' Existe un bloqueo de cupo, se actualiza el cupo a: ' ||
                                         to_char(onuTotal,
                                                 '$999G999G999G999G999',
                                                 'NLS_NUMERIC_CHARACTERS = ",."') ||
                                         chr(13) || CHR(10);
          /* Actualiza la cuota de cupo, asignandole un valor cero debido a que el
          contrato tiene cupo bloqueado.*/
          updateQuota(inuSubscription,
                      nuQuotaTotal,
                      ld_boconstans.csbYesFlag,
                      null);
          rcQuotaHistoric.assigned_quote := nuQuotaTotal;
          goto final;
        else
          rcQuotaHistoric.observation := rcQuotaHistoric.observation ||
                                         'El contrato posee un desbloqueo de cupo ' ||
                                         chr(13) || CHR(10);
        
        end if;
      
        nuQuotaTotal := onuTotal;
      else
        rcQuotaHistoric.observation := rcQuotaHistoric.observation ||
                                       'El contrato no posee bloqueos ni desbloqueos' ||
                                       chr(13) || CHR(10);
        nuQuotaTotal                := onuTotal;
      end if;
    
      /*Valida que el subscriber no sea not null*/
      if (subscriberId is not null) then
        /*Obtengo los tipos productos Brilla y brilla Promigas asociados al cliente*/
        /*Se coloca en comentario porque debe buscar por contrato y no por codigo de cliente*/
        --tbSesuServ := ld_bcnonbankfinancing.FtbGetServBySubscr(subscriberId);
      
        /*Obtengo los tipos productos Brilla y brilla Promigas asociados al contrato NC4942*/
        tbSesuServ := ld_bcnonbankfinancing.ftbGetProdBySuscription(inuSubscription);
      
        /* sino tiene un tipo de producto brilla asociado no entrara al proceso de rollover*/
        if tbSesuServ.count > 0 then
          /* Se obtiene la configuracion de asignacion de cupo llamando al cursor
          de calculo de rollover*/
          ld_bcnonbankfinancing.GetConfRolloverQuota(nuCategory,
                                                     nuSubcategory,
                                                     sbParentLocation,
                                                     rcRollover);
        
          nuIndex := rcRollover.FIRST;
          While nuIndex Is Not Null Loop
            ut_trace.trace('Recorre Cupos Rollover [' || rcRollover(nuIndex)
                           .value || ']',
                           5);
            /* Obtiene los datos de configuracion de rollover*/
            nuProductType := rcRollover(nuIndex).product_type_id;
          
            nuValue := rcRollover(nuIndex).value;
          
            sbQuota_option := rcRollover(nuIndex).quota_option;
          
            nuQuotas_number := rcRollover(nuIndex).quotas_number;
          
            /* Busca los servicios asociados al cliente y tipo de producto
            capturado de la configuracion*/
            /*Se coloca en comentario ya que no debe buscar por codigo de cliente sino por contrato*/
            /*tbSesuType := ld_bcnonbankfinancing.FtbGetServByProdTy(subscriberId,
            nuProductType);*/ --NC4942
          
            /* Busca los servicios asociados al contrato y tipo de producto capturado de la configuracion*/
            tbSesuType := ld_bcnonbankfinancing.FtbGetServBySusc(inuSubscription,
                                                                 nuProductType); --NC4942
          
            /* Recorro el tipo tabla para saber si el cliente tiene saldo pendiente
            por un producto*/
            if tbSesuType.count > 0 then
            
              ut_trace.trace('Tipo de Producto [' || nuProductType ||
                             ' ] Cuenta [' || tbSesuType.count || ']',
                             5);
              nuCont := nuCont + 1;
            
              for i in tbSesuType.FIRST .. tbSesuType.LAST loop
                nuSesunuse := tbSesuType(i);
                /*Se llama al servicio que valida si el producto tiene deuda*/
                nuDifesape := nuDifesape +
                              pkdeferredmgr.fnugetdeferredbalservice(nuSesunuse);
              end loop;
            else
              --nuCont := 0;
              ut_trace.trace('No encuentra productos con saldo pendiente',
                             5);
            end if;
          
            nuIndex := rcRollover.NEXT(nuIndex);
          
          End Loop;
        
          /* Valida si por lo menos el cliente tiene algun producto asociado al tipo de producto
          traido de la configuracion de rollover*/
          if (nuCont > 0) then
            if (nuDifesape > 0 or blPolicyResult) then
            
              /*Hallo el numero de cuotas pendientes*/
            
              /* Busca los servicios asociados al cliente y al tipo de producto
              capturado de la configuracion*/
              nuIndex := rcRollover.FIRST;
            
              While nuIndex Is Not Null Loop
                nuValidator     := 0;
                nuProductType   := rcRollover(nuIndex).product_type_id;
                sbQuota_option  := rcRollover(nuIndex).quota_option;
                nuQuotas_number := rcRollover(nuIndex).quotas_number;
                /*Se coloca en comentario ya que no debe buscar por codigo de cliente sino por contrato*/ --NC4942
                /*tbSesuType := ld_bcnonbankfinancing.FtbGetServByProdTy(subscriberId,
                nuProductType);*/
              
                /* Busca los servicios asociados al contrato y tipo de producto capturado de la configuracion*/
                tbSesuType := ld_bcnonbankfinancing.FtbGetServBySusc(inuSubscription,
                                                                     nuProductType); --NC4942
              
                /* Recorro el tipo tabla para saber si el cliente tiene saldo pendiente
                por un producto*/
                if tbSesuType.count > 0 then
                  /*Recorre los productos del tipo de producto configurado en cupo rollover,
                  y valida por cada uno el numero de cuotas pendientes*/
                  for i in tbSesuType.FIRST .. tbSesuType.LAST loop
                  
                    if tbSesuType.EXISTS(i) then
                    
                      nuSesunuse := tbSesuType(i);
                    
                      /*Este retorna, el numero de cuotas pendientes de un diferido , si existen varios retornara el mayor numero de cuotas de todos los diferidos */
                      /*nuDifenucu := ld_bcnonbankfinancing.fnuGetQuotaLast(nuSesunuse,
                      sbTypeDeferWarr);*/
                      --NC 4942
                      ld_bcnonbankfinancing.GetPendingQuotes(nuSesunuse,
                                                             sbTypeDeferWarr,
                                                             rcPendQuotes);
                    
                      IF rcPendQuotes.count > 0 THEN
                        FOR i IN rcPendQuotes.first .. rcPendQuotes.last LOOP
                          nuDifenucu := rcPendQuotes(i);
                          IF nuDifenucu <= nuQuotas_number THEN
                            EXIT;
                          END IF;
                        END LOOP;
                      END IF;
                      --FIN NC4942
                    
                      /*Verifica si tiene diferido para el servicio evaluado*/
                      blExistsDeferr := ld_bcnonbankfinancing.fblHasDeferredServ(nuSesunuse);
                    
                      /*Se verifica que si el numero de cuotas pendientes es mayor a el numero de quotas
                      que viene por configuracion */
                      if (nvl(nuDifenucu, 0) > nuQuotas_number or
                         not blExistsDeferr) then
                        --incrementa por cada servicio que no cumpla con las cuotas configuradas.
                        nuValidator := nuValidator + 1;
                      
                      end if;
                    
                    end if;
                  
                  end loop;
                end if;
              
                /*Si el contador de servicios con cuotas mayor o igual al numero de cuotas configuradas, es igual
                al numero de servicios por tipo de producto, no cumple con el cupo rollover, si por lo menos uno
                cumple asigna el valor del cupo rollover */
                if (nuValidator = tbSesuType.count) then
                  rcQuotaHistoric.observation := rcQuotaHistoric.observation ||
                                                 'El contrato  no aplica para un cupo rollover de: ' ||
                                                 to_char(nuValue,
                                                         '$999G999G999G999G999',
                                                         'NLS_NUMERIC_CHARACTERS = ",."') ||
                                                 chr(13) || CHR(10);
                  nuValidator                 := 0;
                
                else
                  ut_string.extstring(sbParentLocation, ',', tbTempString);
                
                  if (tbTempString.COUNT > 0) then
                    for i in tbTempString.FIRST .. tbTempString.LAST loop
                      tbString(tbTempString(i)) := tbTempString(i);
                    END loop;
                  END if;
                
                  if (tbString.exists(nvl(rcRollover(nuIndex)
                                          .geograp_location_id,
                                          -1))) then
                    nuTempTotal := fnuGetValueByRoll(rcRollover(nuIndex)
                                                     .quota_option,
                                                     rcRollover(nuIndex)
                                                     .value,
                                                     onuTotal);
                  
                    nuTempAsig    := dage_geogra_location.fnugetgeog_loca_area_type(rcRollover(nuIndex)
                                                                                    .geograp_location_id) * 1000;
                    blAssigByArea := TRUE;
                  else
                    if (rcRollover(nuIndex).subcategory_id = nuSubcategory AND rcRollover(nuIndex)
                       .category_id = nuCategory) then
                    
                      nuTempTotal   := fnuGetValueByRoll(rcRollover(nuIndex)
                                                         .quota_option,
                                                         rcRollover(nuIndex)
                                                         .value,
                                                         onuTotal);
                      nuTempAsig    := 104;
                      blAssigByArea := FALSE;
                    else
                      if (rcRollover(nuIndex).category_id = nuCategory) then
                        nuTempTotal   := fnuGetValueByRoll(rcRollover(nuIndex)
                                                           .quota_option,
                                                           rcRollover(nuIndex)
                                                           .value,
                                                           onuTotal);
                        nuTempAsig    := 103;
                        blAssigByArea := FALSE;
                      else
                        nuTempTotal   := fnuGetValueByRoll(rcRollover(nuIndex)
                                                           .quota_option,
                                                           rcRollover(nuIndex)
                                                           .value,
                                                           onuTotal);
                        nuTempAsig    := 102;
                        blAssigByArea := FALSE;
                      END if;
                    END if;
                  END if;
                
                  if (nuLevelAsig = nuTempAsig) then
                    if (nuTotal < nuTempTotal) then
                      nuTotal := nuTempTotal;
                    END if;
                  END if;
                
                  if ((not blAssigByArea AND nuTempAsig > nuLevelAsig) OR
                     (blAssigByArea AND nuTempAsig > nuLevelAsig)) then
                    nuTotal     := nuTempTotal;
                    nuLevelAsig := nuTempAsig;
                  END if;
                
                end if;
                nuIndex := rcRollover.NEXT(nuIndex);
              
              end Loop;
            
              if (nuTotal > nuQuotaTotal) then
                nuQuotaTotal := nuTotal;
              END if;
            
              onuTotal := nuQuotaTotal;
              updateQuota(inuSubscription,
                          nuQuotaTotal,
                          ld_boconstans.csbYesFlag,
                          null);
              rcQuotaHistoric.ASSIGNED_QUOTE := nuQuotaTotal;
              rcQuotaHistoric.observation    := rcQuotaHistoric.observation ||
                                                'Cupo asignado: ' ||
                                                to_char(nuQuotaTotal /*nuTotal*/,
                                                        '$999G999G999G999G999',
                                                        'NLS_NUMERIC_CHARACTERS = ",."') ||
                                                chr(13) || CHR(10);
            
            elsif nuDifesape <= 0 then
            
              rcQuotaHistoric.observation := rcQuotaHistoric.observation ||
                                             'El contrato no tiene saldo diferido pendiente, no aplica a ningun cupo rollover.' ||
                                             chr(13) || CHR(10);
            else
              rcQuotaHistoric.observation := rcQuotaHistoric.observation ||
                                             'El contrato incumple alguna politica o no existen politicas configuradas.' ||
                                             chr(13) || CHR(10);
            
            end if;
          end if;
        end if;
      
      end if;
    
    else
      onuTotal     := cnuQuotaCero;
      nuQuotaTotal := cnuQuotaCero;
    
      updateQuota(inuSubscription,
                  nuQuotaTotal,
                  ld_boconstans.csbNOFlag,
                  csbNOGASPRODUCTMESS);
    
      /*registra historico de cupo en 0*/
      rcQuotaHistoric.quota_historic_id := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LD_QUOTA_HISTORIC',
                                                                               'SEQ_LD_QUOTA_HISTORIC');
      rcQuotaHistoric.assigned_quote    := cnuQuotaCero;
      rcQuotaHistoric.register_date     := sysdate;
      rcQuotaHistoric.result            := ld_boconstans.csbYesFlag;
      rcQuotaHistoric.subscription_id   := inuSubscription;
      rcQuotaHistoric.observation       := rcQuotaHistoric.observation ||
                                           'Cupo con valor = ' ||
                                           cnuQuotaCero ||
                                           ', porque el suscriptor ' ||
                                           inuSubscription ||
                                           ', no cuenta con el producto GAS';
    
    end if;
    <<final>>
  /*Obtiene el ultimo registro del historico de cupo*/
    rcQuotaHistLast := ld_bcnonbankfinancing.frcGetLastHistoricQuo(inuSubscription);
  
    if rcQuotaHistLast.observation is null or
       rcQuotaHistoric.observation <> rcQuotaHistLast.observation then
    
      dald_quota_historic.insRecord(rcQuotaHistoric);
    
      if tbPolicyHist.count > 0 then
        dald_policy_historic.insRecords(tbPolicyHist);
      end if;
    
    end if;
  
    /*Se actualiza la segmentacion comercial del contrato*/
    ldc_bocommercialsegmentfnb.proCommercialSegment(inuSubscription);
    --commit;
  
    ut_trace.trace('Finaliza LDC_CALCULACUPOBRILLA.AllocateQuota', 1);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      ut_trace.trace('ex.CONTROLLED_ERROR Error procesando: ' ||
                     inuSubscription || ' ' ||
                     DBMS_UTILITY.FORMAT_ERROR_STACK || Chr(10) ||
                     DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
      --rollback;;
      raise ex.CONTROLLED_ERROR;
    when others then
      ut_trace.trace('others Error procesando: ' || inuSubscription || ' ' ||
                     DBMS_UTILITY.FORMAT_ERROR_STACK || Chr(10) ||
                     DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
      Errors.setError;
      --rollback;;
      raise ex.CONTROLLED_ERROR;
  END AllocateQuota;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : AllocateTotalQuota
  Descripcion    : Calcula el cupo del contrato.
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE AllocateTotalQuota(inuSubscription suscripc.susccodi%type,
                               onuTotal        out ld_credit_quota.quota_value%type)
  
   IS
  
  BEGIN
  
    if pktblsuscripc.fblexist(inuSubscription) then
    
      /*Obtiene el cupo de credito a asignar*/
      AllocateQuota(inuSubscription, onuTotal);
    
    else
    
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'Este contrato no existe');
    
    end if;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END AllocateTotalQuota;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : GetTotalQuotaWithOutExtra
  Descripcion    : Calcula el cupo
  Autor          : gavargas
  Fecha          : 20/08/2013
  
  Parametros              Descripcion
  ============         ===================
  inuSuscripc     in    Identificador del contrato.
  onuTotalQuota   out   Total valor del cupo.
  odtApprovedDate out   Fecha de aprobacion.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  20/08/2013      gavargas            Creacion.
  ******************************************************************/
  PROCEDURE GetTotalQuotaWithOutExtra(inuSuscripc     in servsusc.sesususc%type,
                                      onuTotalQuota   out diferido.difesape%type,
                                      odtApprovedDate out diferido.difefein%type) IS
  
  BEGIN
  
    ut_trace.trace('Inicio LDC_CALCULACUPOBRILLA.GetTotalQuotaWithOutExtra ' ||
                   inuSuscripc,
                   10);
  
    if pktblsuscripc.fblExist(inuSuscripc) THEN
      LDC_CALCULACUPOBRILLA.AllocateTotalQuota(inuSuscripc, onuTotalQuota);
      odtApprovedDate := sysdate;
    
    END if;
  
    ut_trace.trace('Fin LDC_CALCULACUPOBRILLA.GetTotalQuotaWithOutExtra ' ||
                   inuSuscripc,
                   10);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetTotalQuotaWithOutExtra;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : AllocateSimuTotalQuota
  Descripcion    : Simula el calculo de un cupo para un contrato.
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE AllocateSimuTotalQuota(inuSubscription suscripc.susccodi%type)
  
   IS
  BEGIN
    null;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END AllocateSimuTotalQuota;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : blockSubscriptionQuote
  Descripcion    : Funcion que bloquea un contrato. Esta funcion
                   registra en la tabla LD_Quota_Block, que un contrato
                   estara bloqueado. Guardando la causal especificada.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE blockSubscriptionQuote(inuSubscription ld_quota_block.subscription_id%type,
                                   idtRegister     ld_quota_block.register_date%type,
                                   inuCausal       cc_causal.causal_id%type,
                                   isbObservation  ld_quota_block.observation%type,
                                   isbUser         ld_quota_block.username%type,
                                   isbTerminal     ld_quota_block.terminal%type)
  
   IS
  
    rcBlock      dald_quota_block.styLD_quota_block;
    tbQuotaBlock dald_quota_block.tytbLD_quota_block;
    --rcBlUnSh     dald_block_unblock_sh.styLD_block_unblock_sh;
    nuquotavalue ld_credit_quota.quota_value%type;
    --
    -- miguelm
    -- 19-12-2016
    -- validacion usuario y terminal que ejecuta el bloqueo
    --
    /*CURSOR cuConsulta (par1 ld_quota_block.subscription_id%type ) IS
    SELECT c.user_id||' - '||d.name_,b.terminal_id
     FROM or_order_activity a, mo_packages b, sa_user c,ge_person d, suscripc e
     WHERE a.task_type_id=10069
     --AND Trunc(a.exec_estimate_date)=Trunc(sysdate)
     AND b.package_id = a.package_id
     AND a.subscriber_id = e.suscclie
     --AND ((a.register_date-b.request_date)*60*24) BETWEEN 0 AND 10
     AND c.mask = b.user_id
     AND d.user_id = c.user_id
     AND e.susccodi = par1
     AND ROWNUM=1;   */
  
    -- leidyc
    -- 03-03-2016
    -- validacion usuario y terminal que ejecuta el bloqueo por person_id
    CURSOR cuConsulta(par1 ld_quota_block.subscription_id%type) IS
      SELECT c.user_id || ' - ' || d.name_, b.terminal_id
        FROM or_order_activity a,
             mo_packages       b,
             sa_user           c,
             ge_person         d,
             suscripc          e
       WHERE a.task_type_id = 10069
            --AND Trunc(a.exec_estimate_date)=Trunc(sysdate)
         AND b.package_id = a.package_id
         AND a.subscriber_id = e.suscclie
            --AND ((a.register_date-b.request_date)*60*24) BETWEEN 0 AND 10
            --AND c.mask = b.user_id
         AND d.user_id = c.user_id
         AND b.person_id = d.person_id
         AND e.susccodi = par1
         AND ROWNUM = 1;
  
  BEGIN
  
    /*Obtiene el ultimo registro de bloqueo*/
    --    tbQuotaBlock := ld_bcnonbankfinancing.ftbgetQuotaBlocksbySub(inuSubscription);
  
    /*Si el ultimo registro es un bloqueo y
    se especifico un error leventa error, sino no realiza nada*/
  
    /*   if(tbQuotaBlock(1).block <> ld_boconstans.csbNOFlag) then */
  
    /*si no existe un registro o el registro es un desbloque,
    bloquea el contrato, registrando en la tabla ld_tmpquota_block */
    rcBlock.quota_block_id  := ld_bosequence.fnuSeqQuotaBlock;
    rcBlock.block           := ld_boconstans.csbYesFlag;
    rcBlock.subscription_id := inuSubscription;
    rcBlock.causal_id       := inuCausal;
    rcBlock.register_date   := idtRegister;
    rcBlock.observation     := isbObservation;
    --
    -- miguelm
    -- 19-12-2016
    -- validacion usuario y terminal que ejecuta el bloqueo
    --
  
    --IF isbUser='1' OR isbTerminal = 'UNKNOWN' THEN
    -- consultamos la orden relacionada
    OPEN cuConsulta(inuSubscription);
    FETCH cuConsulta
      INTO rcBlock.username, rcBlock.terminal;
    IF cuConsulta%NOTFOUND THEN
      rcBlock.username := isbUser;
      rcBlock.terminal := isbTerminal;
    END IF;
    CLOSE cuConsulta;
    --  END IF;
  
    ut_trace.trace('Subscription: ' || inuSubscription || '. Causal: ' ||
                   inuCausal || '. Register: ' || idtRegister ||
                   '. Observation: ' || isbObservation || '. User: ' ||
                   isbUser || '. Terminal: ' || isbTerminal ||
                   ' nuBlock_id: ' || nuBlock_id,
                   10);
    dald_quota_block.insRecord(rcBlock);
  
    if (ld_bopackagefnb.nuPackage is not null) then
      ld_bopackagefnb.registerBlUnSh(rcBlock.quota_block_id);
    end if;
  
    /*Recalcular el cupo y crear un nuevo registro de hitorico a partir del cupo re calculado*/
    AllocateQuota(inuSubscription, nuQuotaValue);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END blockSubscriptionQuote;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : blockGeographLocaQuote
  Descripcion    : Funcion que bloquea los contratos de una ubicacion
                   geografica y un estrato
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============            ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  04/Oct/2013     Darias.SAO218979    Adicion de traza
  17/Junio/2013   Evelio
  ******************************************************************/

  PROCEDURE blockGeographLocaQuote(inuGeographLoca ge_geogra_location.geograp_location_id%type,
                                   inuCategory     categori.catecodi%type,
                                   inuStratum      subcateg.sucacodi%type,
                                   idtRegister     ld_quota_block.register_date%type,
                                   inuCausal       cc_causal.causal_id%type,
                                   isbObservation  ld_quota_block.observation%type,
                                   isbUser         ld_quota_block.username%type,
                                   isbTerminal     ld_quota_block.terminal%type)
  
   IS
  
    sbLocations   varchar2(32000);
    curfLocations constants.tyrefcursor;
  
    TYPE tyrcLocations IS RECORD(
      geograp_location_id ge_geogra_location.geograp_location_id%type,
      description         ge_geogra_location.description%type);
  
    rcLocations   tyrcLocations;
    nuGasType     number;
    tbSubcription dapr_product.tytbSubscription_Id;
    nuIndex       number;
    nuquotavalue  ld_credit_quota.quota_value%type;
  
  BEGIN
    ut_trace.trace('Inicia blockGeographLocaQuote
                                   inuGeographLoca [' ||
                   inuGeographLoca || ']
                                   inuCategory     [' ||
                   inuCategory || ']
                                   inuStratum      [' ||
                   inuStratum || ']
                                   idtRegister     [' ||
                   idtRegister || ']
                                   inuCausal       [' ||
                   inuCausal || ']
                                   isbObservation  [' ||
                   isbObservation || ']
                                   isbUser         [' ||
                   isbUser || ']
                                   isbTerminal     [' ||
                   isbTerminal || ']',
                   2);
  
    ge_bogeogra_location.GetNeighborhoodsByFather(inuGeographLoca,
                                                  curfLocations);
    if (inuGeographLoca is not null) then
      sbLocations := inuGeographLoca || ', ';
    end if;
  
    ut_trace.trace('sbLocations - ' || sbLocations, 3);
  
    loop
      fetch curfLocations
        into rcLocations;
      IF (rcLocations.geograp_location_id IS NOT NULL) THEN
        sbLocations := sbLocations || rcLocations.geograp_location_id || ', ';
      END IF;
      exit when(curfLocations%notFound);
    end loop;
  
    sbLocations := lpad(sbLocations, length(sbLocations) - 2, ' ');
  
    ut_trace.trace('sbLocations - ' || sbLocations, 3);
  
    nuGasType := dald_parameter.fnuGetNumeric_Value('COD_TIPO_SERV');
  
    tbSubcription := LD_BCNONBANKFINANCING.ftbgetSubsGeoSubcate(sbLocations,
                                                                inuCategory,
                                                                inuStratum,
                                                                nuGasType);
  
    nuIndex := tbSubcription.first;
  
    while nuIndex is not null loop
    
      ut_trace.trace('Ini blockSubscriptionQuote ' ||
                     tbSubcription(nuIndex),
                     3);
    
      blockSubscriptionQuote(tbSubcription(nuIndex),
                             idtRegister,
                             inuCausal,
                             isbObservation,
                             isbUser,
                             isbTerminal);
    
      ut_trace.trace('Fin blockSubscriptionQuote ' ||
                     tbSubcription(nuIndex),
                     3);
    
      /*Recalcular el cupo y crear un nuevo registro de hitorico a partir del cupo re calculado*/
      AllocateQuota(tbSubcription(nuIndex), nuQuotaValue);
    
      nuIndex := tbSubcription.next(nuIndex);
    end loop;
  
    ut_trace.trace('Finaliza blockGeographLocaQuote', 2);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END blockGeographLocaQuote;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : blockIdentificaQuote
  Descripcion    : Funcion que bloquea los contratos de una identificacion.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE blockIdentificaQuote(inuIdentType      ge_subscriber.ident_type_id%type,
                                 isbIdentification ge_subscriber.identification%type,
                                 idtRegister       ld_quota_block.register_date%type,
                                 inuCausal         cc_causal.causal_id%type,
                                 isbObservation    varchar2,
                                 isbUser           varchar2,
                                 isbTerminal       varchar2)
  
   IS
  
    rfCursor constants.tyrefcursor;
    type tytbSubscription is table of pktblsuscripc.tytbSuscripc;
    --tbSubscription tytbSubscription;
    --nuIndex        number;
    --rcQuotaBlock   dald_quota_block.styLD_quota_block;
  
    --curfSubcription constants.tyrefcursor;
  
    rcSubcription tyrcSubcription;
  
    nuquotavalue ld_credit_quota.quota_value%type;
  
  BEGIN
  
    /*Obtiene el codigo de un cliente dado si identificaciom*/
  
    /*Obtiene los contratos asociados al cliente*/
    cc_bosubscription.getsubscription(null,
                                      null,
                                      inuIdentType,
                                      isbIdentification,
                                      null,
                                      null,
                                      null,
                                      rfCursor);
  
    loop
      fetch rfCursor
        into rcSubcription;
      exit when(rfCursor%notFound);
    
      blockSubscriptionQuote(rcSubcription.susccodi,
                             idtRegister,
                             inuCausal,
                             isbObservation,
                             isbUser,
                             isbTerminal);
    
      /*Recalcular el cupo y crear un nuevo registro de hitorico a partir del cupo re calculado*/
      AllocateQuota(rcSubcription.susccodi, nuQuotaValue);
    
    end loop;
  
    close rfCursor;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      --rollback;;
      raise ex.CONTROLLED_ERROR;
    when others then
      --rollback;;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END blockIdentificaQuote;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : blockIdentificaQuote
  Descripcion    : Funcion que bloquea los contratos de una identificacion.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  inuCausal: Identificador de la causal.
  isbObservation: Observacion del bloqueo.
  iboRaiseError: Indica si se levanta al intentar desbloquear.
  isbUsuario: Nombre de usario conectado.
  isbTerminal: Nombre terminal
  
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  18/04/2022      LJLB                CA - OSF-199 -- se valida que si el campo isbUser es nulo o
                                      isbTerminal es nulo se consulte los valores de la solicitud
                                      de bloqueo
  ******************************************************************/
  PROCEDURE unblockSubscriptionQuote(inuSubscription ld_quota_block.subscription_id%type,
                                     idtRegister     ld_quota_block.register_date%type,
                                     inuCausal       cc_causal.causal_id%type,
                                     isbObservation  ld_quota_block.observation%type,
                                     isbUser         ld_quota_block.username%type,
                                     isbTerminal     ld_quota_block.terminal%type)
  
   IS
  
    rcBlock            dald_quota_block.styLD_quota_block;
    sbactivequotablock ld_quota_block.block%type;
    nuquotavalue       ld_credit_quota.quota_value%type;
  
    --
    -- miguelm
    -- 19-12-2016
    -- validacion usuario y terminal que ejecuta el bloqueo
    --
    /*CURSOR cuConsulta (par1 ld_quota_block.subscription_id%type ) IS
    SELECT c.user_id||' - '||d.name_,b.terminal_id
     FROM or_order_activity a, mo_packages b, sa_user c,ge_person d, suscripc e
     WHERE a.task_type_id=10069
    -- AND Trunc(a.exec_estimate_date)=Trunc(sysdate)
     AND b.package_id = a.package_id
     AND a.subscriber_id = e.suscclie
    -- AND ((a.register_date-b.request_date)*60*24) BETWEEN 0 AND 10
     AND c.mask = b.user_id
     AND d.user_id = c.user_id
     AND e.susccodi = par1
     AND ROWNUM=1;  */
  
    -- leidyc
    -- 03-03-2016
    -- validacion usuario y terminal que ejecuta el bloqueo por person_id
    CURSOR cuConsulta(par1 ld_quota_block.subscription_id%type) IS
      SELECT c.user_id || ' - ' || d.name_, b.terminal_id
        FROM or_order_activity a,
             mo_packages       b,
             sa_user           c,
             ge_person         d,
             suscripc          e
       WHERE a.task_type_id = 10069
            -- AND Trunc(a.exec_estimate_date)=Trunc(sysdate)
         AND b.package_id = a.package_id
         AND a.subscriber_id = e.suscclie
            -- AND ((a.register_date-b.request_date)*60*24) BETWEEN 0 AND 10
            --AND c.mask = b.user_id
         AND d.user_id = c.user_id
         AND b.person_id = d.person_id
         AND e.susccodi = par1
         AND ROWNUM = 1;
         
      --INICIO CA OSF-199
      sbAplicaEntOSF199 VARCHAR2(1):= 'N';
      --FIN CA OSF-199
  
  BEGIN
  
    /*Determinar si el suscriptor posee un bloqueo activo*/
    sbactivequotablock := ld_bcnonbankfinancing.fnuamountquotablocks(inuSubscription,
                                                                     null);
  
    if sbactivequotablock = ld_boconstans.csbYesFlag then
    
      /*Obtiene el ultimo registro de bloqueo*/
    
      /*Si el ultimo registro es un bloqueo y
      se especifico un error levanta error, sino no realiza nada*/
    
      /*si no existe un registro o el registro es un desbloque,
      desbloquea el contrato, registrando en la tabla ld_quota_block */
      rcBlock.quota_block_id  := ld_bosequence.fnuSeqQuotaBlock;
      rcBlock.block           := ld_boconstans.csbNOFlag;
      rcBlock.subscription_id := inuSubscription;
      rcBlock.causal_id       := inuCausal;
      rcBlock.register_date   := idtRegister;
      rcBlock.observation     := isbObservation;
      --
      -- miguelm
      -- 19-12-2016
      -- validacion de usuario que ejecuta el proceso
      --
      --INICIO CA OSF-199
      IF FBLAPLICAENTREGAXCASO('OSF-199') THEN
         sbAplicaEntOSF199 := 'S';
      END IF;
      --FIN CA OSF-199
      IF sbAplicaEntOSF199 = 'S' AND (isbUser is null OR isbTerminal is null) THEN
          -- consultamos la orden relacionada
          OPEN cuConsulta(inuSubscription);
          FETCH cuConsulta INTO rcBlock.username, rcBlock.terminal;
          IF cuConsulta%NOTFOUND THEN
              rcBlock.username := NVL(isbUser,'-1');
              rcBlock.terminal := NVL(isbTerminal,'UNKNOWN');
          END IF;
          CLOSE cuConsulta;
      ELSE
      
        IF isbUser = '1' OR isbTerminal = 'UNKNOWN' THEN
          -- consultamos la orden relacionada
          OPEN cuConsulta(inuSubscription);
          FETCH cuConsulta
            INTO rcBlock.username, rcBlock.terminal;
          IF cuConsulta%NOTFOUND THEN
            rcBlock.username := isbUser;
            rcBlock.terminal := isbTerminal;
          END IF;
          CLOSE cuConsulta;
		else
		    rcBlock.username := isbUser;
            rcBlock.terminal := isbTerminal;
        END IF;
      END IF;
    
      dald_quota_block.insRecord(rcBlock);
    
      if (ld_bopackagefnb.nuPackage is not null) then
        ld_bopackagefnb.registerBlUnSh(rcBlock.quota_block_id);
      end if;
      /*Recalcular el cupo y crear un nuevo registro de hitorico a partir del cupo re calculado*/
      AllocateQuota(inuSubscription, nuQuotaValue);
    end if;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END unblockSubscriptionQuote;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : unblockGeographLocaQuote
  Descripcion    : Funcion que desbloquea los contratos de una ubicacion
  geografica y un estrato.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuGeographLoca: Identificador del contrato.
  inuStratum: Identificador del estrato.
  inuCausal: Identificador de la causal.
  isbObservation: Observacion del bloqueo.
  isbUsuario: Nombre de usario conectado.
  isbTerminal: Nombre terminal
  
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE unblockGeographLocaQuote(
                                     
                                     inuGeographLoca ge_geogra_location.geograp_location_id%type,
                                     inuCategory     categori.catecodi%type,
                                     inuStratum      subcateg.sucacodi%type,
                                     idtRegister     ld_quota_block.register_date%type,
                                     inuCausal       cc_causal.causal_id%type,
                                     isbObservation  ld_quota_block.observation%type,
                                     isbUser         ld_quota_block.username%type,
                                     isbTerminal     ld_quota_block.terminal%type)
  
   IS
  
    sbLocations        varchar2(32000);
    curfLocations      constants.tyrefcursor;
    nuQuotaValue       number;
    rcLocations        tyrcLocations;
    nuGasType          number;
    tbSubcription      dapr_product.tytbSubscription_Id;
    nuIndex            number;
    sbactivequotablock ld_quota_block.block%type;
  
  BEGIN
  
    ge_bogeogra_location.GetNeighborhoodsByFather(inuGeographLoca,
                                                  curfLocations);
    if (inuGeographLoca is not null) then
      sbLocations := inuGeographLoca || ', ';
    end if;
    loop
      fetch curfLocations
        into rcLocations;
      IF (rcLocations.geograp_location_id IS NOT NULL) THEN
        sbLocations := sbLocations || rcLocations.geograp_location_id || ', ';
      END IF;
      exit when(curfLocations%notFound);
    end loop;
  
    sbLocations := lpad(sbLocations, length(sbLocations) - 2, ' ');
  
    nuGasType := dald_parameter.fnuGetNumeric_Value('COD_TIPO_SERV');
  
    tbSubcription := LD_BCNONBANKFINANCING.ftbgetSubsGeoSubcate(sbLocations,
                                                                inuCategory,
                                                                inuStratum,
                                                                nuGasType);
  
    nuIndex := tbSubcription.first;
  
    while nuIndex is not null loop
    
      /*Determinar si el suscriptor posee un bloquo activo*/
      sbactivequotablock := ld_bcnonbankfinancing.fnuamountquotablocks(tbSubcription(nuIndex),
                                                                       null);
    
      if sbactivequotablock = ld_boconstans.csbYesFlag then
      
        unblockSubscriptionQuote(tbSubcription(nuIndex),
                                 idtRegister,
                                 inuCausal,
                                 isbObservation,
                                 isbUser,
                                 isbTerminal);
        /*Recalcular el cupo y crear un nuevo registro de hitorico a partir del cupo re calculado*/
        AllocateQuota(tbSubcription(nuIndex), nuQuotaValue);
      
      end if;
    
      nuIndex := tbSubcription.next(nuIndex);
    
    end loop;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END unblockGeographLocaQuote;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : unblockIdentificaQuote
  Descripcion    : Funcion que desbloquea los contratos de una identificacion.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuIdentType: Identificador del tipo de identificacion.
  isbIdentification: Numero de identificacion del  cliente.
  inuCausal: Identificador de la causal.
  isbObservation: Observacion del bloqueo.
  isbUsuario: Nombre de usario conectado.
  isbTerminal: Nombre terminal
  
  
  
  Historia de Modificaciones
  Fecha             Autor               Modificacion
  =========       =========             ====================
  14-08-2013   Erika. A. Montenegro G.  Se valida para que muestre mensaje al usuario
                                        si el cliente de la identificacion ingresada
                                        no tiene contratos con bloqueos.
  ******************************************************************/
  PROCEDURE unblockIdentificaQuote(inuIdentType      ge_subscriber.ident_type_id%type,
                                   isbIdentification ge_subscriber.identification%type,
                                   idtRegister       ld_quota_block.register_date%type,
                                   inuCausal         cc_causal.causal_id%type,
                                   isbObservation    ld_quota_block.observation%type,
                                   isbUser           ld_quota_block.username%type,
                                   isbTerminal       ld_quota_block.terminal%type) is
    rfCursor constants.tyrefcursor;
    type tytbSubscription is table of pktblsuscripc.tytbSuscripc;
    --tbSubscription tytbSubscription;
    --nuIndex        number;
    --rcQuotaBlock   dald_quota_block.styLD_quota_block;
  
    --curfSubcription constants.tyrefcursor;
  
    rcSubcription      tyrcSubcription;
    sbactivequotablock ld_quota_block.block%type;
    nuCont             number := 0;
  BEGIN
  
    /*Obtiene el codigo de un cliente dado si identificaciom*/
  
    /*Obtiene los contratos asociados al cliente*/
    cc_bosubscription.getsubscription(null,
                                      null,
                                      inuIdentType,
                                      isbIdentification,
                                      null,
                                      null,
                                      null,
                                      rfCursor);
  
    loop
      fetch rfCursor
        into rcSubcription;
      exit when(rfCursor%notFound);
    
      /*Determinar si el suscriptor posee un bloquo activo*/
      sbactivequotablock := ld_bcnonbankfinancing.fnuamountquotablocks(rcSubcription.susccodi,
                                                                       null);
    
      if sbactivequotablock = ld_boconstans.csbYesFlag then
        nuCont := nuCont + 1;
        unblockSubscriptionQuote(rcSubcription.susccodi,
                                 idtRegister,
                                 inuCausal,
                                 isbObservation,
                                 isbUser,
                                 isbTerminal);
      
      end if;
    
    end loop;
  
    close rfCursor;
  
    /*Si no encuentra contratos del cliente con bloqueo, muestra mensaje.*/
    if nuCont = 0 then
    
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El cliente con identificacion ' ||
                                       isbIdentification ||
                                       ' no tiene bloqueos');
    
    END if;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END unblockIdentificaQuote;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : blockUnblocQuote
  Descripcion    : Funcion que recibe los parametros para procesar
  el bloqueo o desbloque de cupo, esta funcion esta relacionada con
  el proceso batch encargado del desbloqueo.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  14/08/2013  Erika A. Montenegro G.  Se valida que la identificacion ingresada exista.
  12/05/2017    SEBTAP 200-749        Se incluye una nueva asiganacion de usuario y terminal.
  ******************************************************************/
  PROCEDURE blockUnblocQuote(inuIdentType      ge_subscriber.ident_type_id%type,
                             isbIdentification ge_subscriber.identification%type,
                             inuGeographLoca   ge_geogra_location.geograp_location_id%type,
                             inuCategory       categori.catecodi%type,
                             inuStratum        subcateg.sucacodi%type,
                             inuSubscription   ge_subscriber.subscriber_id%type,
                             idtRegister       ld_quota_block.register_date%type,
                             inuCausal         cc_causal.causal_id%type,
                             isbObservation    ld_quota_block.observation%type,
                             isbUser           ld_quota_block.username%type,
                             isbTerminal       ld_quota_block.terminal%type,
                             iboBlock          ld_quota_block.block%type)
  
   IS
  
    /*Cursor para validar que la identificacion ingresada existe*/
    CURSOR cuSubscriber is
      SELECT /*+ index (ge_subscriber IDX_GE_SUBSCRIBER_02)*/
       identification, ident_type_id
        FROM ge_subscriber
       WHERE ident_type_id = inuIdentType
         AND identification = isbIdentification;
    ---Variable tipo Cursor
    rcSubscriber cuSubscriber%Rowtype;
    -----
    /* Ca 200-749 || Sebastian Tapias || JM */
    --Variables para consultar y almacenar el usuario y la terminal
    v_isbUser     ld_quota_block.username%type;
    v_isbTerminal ld_quota_block.terminal%type;
    sbUserDB      sa_user.mask%type;
    nuUser        sa_user.user_id%TYPE;
    sbUser        VARCHAR2(100);
    sbTerminal    varchar2(100);
    -- Cursor para consultar el Usuario
    CURSOR cuConsultaUsuario(par1 sa_user.user_id%TYPE) IS
      SELECT SubStr(a.user_id || ' - ' || b.name_, 1, 100)
        FROM sa_user a, ge_person b
       WHERE a.user_id = par1
         AND b.user_id = a.user_id;
    -----
  
  BEGIN
    -----
    /* Ca 200-749 || Sebastian Tapias || JM*/
    -- captura la mascara del usuario oracle
       sbUserDB   := UT_SESSION.GETUSER;
      -- si la mascara no es vacia averigua el id de conexion
      IF sbUserDB IS NOT NULL THEN
        nuUser := SA_BOUSER.FNUGETUSERID(sbUserDB);
        UT_TRACE.TRACE('Id Del usuario conectado:['||sbUserDB||'] ['||nuUser||']',10);
      ELSE
        nuUser := SA_BOUSER.FNUGETUSERID(UT_SESSION.GETUSER);
        UT_TRACE.TRACE('Corrige Id Del usuario conectado:['||sbUserDB||'] ['||nuUser||']',10);
      END IF;
      -- con el id del usuario de la base de datos averiguamos el nombre del usuario
      -- nombre del usuario conectado
      IF nuUser>0 THEN
        OPEN cuConsultaUsuario (nuUser);
        FETCH cuConsultaUsuario INTO sbUser;
        IF cuConsultaUsuario%NOTFOUND THEN
          sbUser := '1 - ADMINISTRADOR DEL SISTEMA OPEN';
        END IF;
        CLOSE cuConsultaUsuario;
      ELSE
        sbUser := '1 - ADMINISTRADOR DEL SISTEMA OPEN';
      END IF;
      
      sbTerminal  := AU_BOSystem.getsystemuserterminal;
      -- Asignamos a las nuevas variables
      v_isbUser := sbUser;
      v_isbTerminal := sbTerminal;
     /* Fin Ca 200-749 */
    -----
    ut_trace.trace('Inicio LDC_CALCULACUPOBRILLA.blockUnblocQuote', 10);
    if (inuIdentType is not null) and (isbIdentification is not null) then
      null;
    elsif inuSubscription is not null then
      null;
    elsif (inuGeographLoca is not null) or (inuCategory is not null) or
          (inuStratum is not null and inuCategory is not null) then
      null;
    else
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'No existen suficientes datos para realizar un bloqueo o desbloqueo');
    end if;
  
    if (inuIdentType is not null) and (isbIdentification is not null) then
      OPEN cuSubscriber;
      FETCH cuSubscriber
        INTO rcSubscriber;
      /*Si la identificacion existe realiza el proceso de bloqueo o desbloqueo, sino
      muestra mensaje al usuario.*/
      if (cuSubscriber%found) then
        if iboBlock = ld_boconstans.csbYesFlag then
          blockIdentificaQuote(inuIdentType,
                               isbIdentification,
                               idtRegister,
                               inuCausal,
                               isbObservation,
                               v_isbUser,
                               v_isbTerminal);
        else
          unblockIdentificaQuote(inuIdentType,
                                 isbIdentification,
                                 idtRegister,
                                 inuCausal,
                                 isbObservation,
                                 v_isbUser,
                                 v_isbTerminal);
        end if;
      else
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                         'La identificacion ' ||
                                         isbIdentification ||
                                         ' no existe, o no es del tipo de identificacion ingresado');
      
      END if;
      close cuSubscriber;
    elsif inuSubscription is not null then
      if iboBlock = ld_boconstans.csbYesFlag then
        blockSubscriptionQuote(inuSubscription,
                               idtRegister,
                               inuCausal,
                               isbObservation,
                               v_isbUser,
                               v_isbTerminal);
      else
        unblockSubscriptionQuote(inuSubscription,
                                 idtRegister,
                                 inuCausal,
                                 isbObservation,
                                 v_isbUser,
                                 v_isbTerminal);
      end if;
    elsif (inuGeographLoca is not null) or (inuCategory is not null) or
          (inuCategory is not null and inuStratum is not null) then
      if iboBlock = ld_boconstans.csbYesFlag then
        blockGeographLocaQuote(inuGeographLoca,
                               inuCategory,
                               inuStratum,
                               idtRegister,
                               inuCausal,
                               isbObservation,
                               v_isbUser,
                               v_isbTerminal);
      else
        unblockGeographLocaQuote(inuGeographLoca,
                                 inuCategory,
                                 inuStratum,
                                 idtRegister,
                                 inuCausal,
                                 isbObservation,
                                 v_isbUser,
                                 v_isbTerminal);
      end if;
    end if;
    ut_trace.trace('Finaliza LDC_CALCULACUPOBRILLA.blockUnblocQuote', 10);
    /* dald_policy*/
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END blockUnblocQuote;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         :  getblockUnblocQuoteData
  Descripcion    : Funcion que obtiene los datos del proceso batch.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  22/May/2013     Evelio Sanjuanelo   Se valida que al momento de desbloquear cupo a un
                                      contrato, este haya tenido por lo menos un bloqueo
  14/8/2013       Erika A. Montengro G. Se modifica la variable que hace referencia a la
                                        identificacion, ya que debe ser de tipo cadena y
                                        no numerica.
  ******************************************************************/
  PROCEDURE getblockUnblocQuoteData IS
  
    nuSubscription   number;
    nuCasual         number;
    nuCategori       number;
    nuSubcate        number;
    nuIdentType      number;
    sbIdentification ge_subscriber.identification%type;
    nuGeoLocation    number;
    sbObservation    varchar2(3200);
    sbBlock          varchar2(1);
    sbUser           varchar2(200);
    sbTerminal       varchar2(200);
    --resul            number;
    --
    sbactivequotablock ld_quota_block.block%type;
    nuquotavalue       ld_credit_quota.quota_value%type;
  
    Cursor cuEstadoCupo(contrato ld_quota_block.subscription_id%type) is
      SELECT *
        FROM (SELECT q.block, q.causal_id, q.register_date
                FROM ld_quota_block q
               WHERE q.subscription_id = contrato
               ORDER BY q.register_date desc) a
       WHERE ROWNUM = 1;
    regEstadoCupo cuEstadoCupo%rowtype;
  
  BEGIN
    ut_trace.trace('Inicio LDC_CALCULACUPOBRILLA.getblockUnblocQuoteData',
                   10);
  
    sbUser     := GE_BOPersonal.fnuGetPersonId;
    sbTerminal := userenv('TERMINAL');
  
    nuSubscription   := ge_boInstanceControl.fsbGetFieldValue('LD_QUOTA_BLOCK',
                                                              'SUBSCRIPTION_ID');
    nuCasual         := ge_boInstanceControl.fsbGetFieldValue('LD_QUOTA_BLOCK',
                                                              'CAUSAL_ID');
    nuCategori       := ge_boInstanceControl.fsbGetFieldValue('CATEGORI',
                                                              'CATECODI');
    nuSubcate        := ge_boInstanceControl.fsbGetFieldValue('SUBCATEG',
                                                              'SUCACODI');
    nuIdentType      := ge_boInstanceControl.fsbGetFieldValue('GE_IDENTIFICA_TYPE',
                                                              'IDENT_TYPE_ID');
    sbIdentification := ge_boInstanceControl.fsbGetFieldValue('GE_SUBSCRIBER',
                                                              'IDENTIFICATION');
    nuGeoLocation    := ge_boInstanceControl.fsbGetFieldValue('GE_GEOGRA_LOCATION',
                                                              'GEOGRAP_LOCATION_ID');
    sbObservation    := ge_boInstanceControl.fsbGetFieldValue('LD_QUOTA_BLOCK',
                                                              'OBSERVATION');
    sbBlock          := ge_boInstanceControl.fsbGetFieldValue('LD_QUOTA_BLOCK',
                                                              'BLOCK');
    /*  nuSubscription := 355656;
    sbBlock := 'Y';
    nuCasual := 569;
    sbObservation := 'AAA';*/
  
    --Se valida que al momento de desbloquear cupo a un
    --contrato, este haya tenido por lo menos un bloqueo
    --Si no ha tenido bloqueo, se detendra la accion y se mandara
    --un mensaje al usuario. --* EVESAN *--
    declare
      resul number(15);
    BEGIN
      if (pktblsuscripc.fblexist(nuSubscription)) then
        if (nuSubscription is not null and sbBlock = 'N') then
          select q.subscription_id
            into resul
            from ld_quota_block q
           where q.subscription_id = nuSubscription
             and ROWNUM = 1;
        end if;
      end if;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                         'No se puede desbloquear este contrato, ya que este no ha tenido bloqueo');
      
    END;
    --Validar que el contrato no tenga un bloqueo con la misma causal al momento del bloqueo
    --EveSan
    for regEstadoCupo in cuEstadoCupo(nuSubscription) loop
      if (regEstadoCupo.Block = sbBlock and
         regEstadoCupo.Causal_Id = nuCasual and regEstadoCupo.Block = 'Y') then
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                         'El suscriptor ' || nuSubscription ||
                                         ', ya tiene un BLOQUEO con la misma causal, desde el dia ' ||
                                         regEstadoCupo.Register_Date);
      end if;
    end loop;
    --***************************************************************************
  
    if (pktblsuscripc.fblexist(nuSubscription)) then
      if (nuSubscription is not null and sbBlock = 'N') then
      
        /*Validar si el suscriptor posee un bloquo activo*/
        sbactivequotablock := ld_bcnonbankfinancing.fnuamountquotablocks(nuSubscription,
                                                                         null);
      
        if sbactivequotablock = ld_boconstans.csbNOFlag then
        
          ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                           'El suscriptor ' ||
                                           nuSubscription ||
                                           ' no posee un bloqueo activo');
        
        end if;
      
      end if;
    end if;
    -------------------------------------------------------------
    /*Setear variable que determina el valor a evaluar del cupo en caso tal de realizar
    el llamado al procedimiento AllocateQuota previo a un bloqueo de cupo*/
    if sbBlock = ld_boconstans.csbYesFlag then
      nuswblockquota := ld_boconstans.cnuonenumber;
    end if;
    -------------------------------------------------------------
  
    /*obtiene el usuario*/
    blockUnblocQuote(nuIdentType,
                     sbIdentification,
                     nuGeoLocation,
                     nuCategori,
                     nuSubcate,
                     nuSubscription,
                     sysdate,
                     nuCasual,
                     sbObservation,
                     sbUser,
                     sbTerminal,
                     sbBlock);
  
    -------------------------------------------------------------
    ut_trace.trace('sbBlock = ' || sbBlock ||
                   ' - ld_boconstans.csbYesFlag = ' ||
                   ld_boconstans.csbYesFlag,
                   10);
  
    --commit;
  
    ut_trace.trace('Finaliza LDC_CALCULACUPOBRILLA.getblockUnblocQuoteData',
                   10);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END getblockUnblocQuoteData;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : changeConsecutive
  Descripcion    : Cambia el consecutivo de una venta
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId: Numero de la solicitud.
  inuConsecutive: Identificador del consecutivo.
  inuExcutiveId: Identificador del ejecutivo.
  inuRegisterDate: Identificador del registro.
  
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE changeConsecutive(inuPackageId mo_packages.package_id%type,
                              /*inuConsecutive    campo de consecutivo*/
                              inuExcutiveId   mo_packages.person_id%type,
                              inuRegisterDate mo_packages.request_date%type)
  
   IS
  BEGIN
    null;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END changeConsecutive;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : getConsecutive
  Descripcion    : Obtiene el consecutivo actual de la venta.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId: Numero de la solicitud.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE getConsecutive(inupackage mo_packages.package_id%type)
  
   IS
  BEGIN
  
    null;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END getConsecutive;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fblValidateBills
  Descripcion    : Valida las facturas ingresadas.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId: Numero de la solicitud.
  
  
  Historia de Modificaciones
  Fecha       Autor                 Modificacion
  =========   =========             ====================
  30-08-2013  lfernandez.SAO211609  Se corrige validacion de la fecha de la
                                    factura 2
  29-08-2013  lfernandez.SAO211609  Se muestran mensajes de error cuando se
                                    ingresan valores invalidos
  ******************************************************************/
  FUNCTION fblValidateBills(inuSubscription suscripc.susccodi%type,
                            inuBill1        factura.factcodi%type,
                            idtBill1        factura.factfege%type,
                            inuBill2        factura.factcodi%type,
                            idtBill2        factura.factfege%type)
    return boolean IS
    ------------------------------------------------------------------------
    --  Variables
    ------------------------------------------------------------------------
    rcBill1        factura%rowtype;
    rcBill2        factura%rowtype;
    dtBill1        date;
    dtBill2        date;
    nuMesesValFact ld_parameter.numeric_value%type;
  
  BEGIN
  
    UT_Trace.Trace('LDC_CALCULACUPOBRILLA.fblValidateBills', 15);
  
    nuMesesValFact := nvl(dald_parameter.fnuGetNumeric_Value('NUM_MESES_VAFA_FNB'),
                          0);
  
    --  Si se envio la factura 1
    if (inuBill1 IS not null) then
    
      --  Obtiene la informacion de la factura 1
      rcBill1 := pkTblFactura.frcGetRecord(inuBill1);
    
      --  Si la suscripcion de la factura es diferente a la enviada
      if (rcBill1.factsusc <> inuSubscription) then
      
        GE_BOErrors.SetErrorCodeArgument(2741,
                                         'La primera factura no pertenece a la suscripcion');
      
      end if;
    
      --  Si las fechas son diferentes
      if (trunc(rcBill1.factfege) <> trunc(idtBill1)) then
      
        GE_BOErrors.SetErrorCodeArgument(2741,
                                         'La fecha de generacion ingresada de la primera factura no es igual a la fecha de generacion de la primera factura');
      
      end if;
    
      if (abs(months_between(rcBill1.factfege, sysdate)) > nuMesesValFact) then
        GE_BOErrors.SetErrorCodeArgument(2741,
                                         'La fecha de generacion de la primera factura no pueden ser inferior a: ' ||
                                         nuMesesValFact || ' meses.');
      END if;
    
    END if;
  
    --  Si se envio la factura 2
    if (inuBill2 IS not null) then
    
      --  Obtiene la informacion de la factura 2
      rcBill2 := pkTblFactura.frcGetRecord(inuBill2);
    
      --  Si la suscripcion de la factura es diferente a la enviada
      if (rcBill2.factsusc <> inuSubscription) then
      
        GE_BOErrors.SetErrorCodeArgument(2741,
                                         'La segunda factura no pertenece a la suscripcion');
      
      end if;
    
      --  Si las fechas son diferentes
      if (trunc(rcBill2.factfege) <> trunc(idtBill2)) then
      
        GE_BOErrors.SetErrorCodeArgument(2741,
                                         'La fecha de generacion ingresada de la segunda factura no es igual a la fecha de generacion de la segunda factura');
      
      end if;
    
      if (abs(months_between(rcBill2.factfege, sysdate)) > nuMesesValFact) then
        GE_BOErrors.SetErrorCodeArgument(2741,
                                         'La fecha de generacion de la segunda factura no pueden ser inferior a: ' ||
                                         nuMesesValFact || ' meses.');
      END if;
    
    END if;
  
    --  Si los valores enviados son correctos
    if (rcBill1.factsusc = inuSubscription AND
       rcBill2.factsusc = inuSubscription AND
       trunc(rcBill1.factfege) = trunc(idtBill1) AND
       trunc(rcBill2.factfege) = trunc(idtBill2)) then
      return true;
    else
      return false;
    end if;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fblValidateBills;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : GetSupplierData
  Descripcion    : Obtiene los datos de los proveedores.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  inuPackageId            Numero de la solicitud.
  
  
  Historia de Modificaciones
  Fecha         Autor               Modificacion
  14-11-2013    hjgomez.SAO222578   Se valida que la unidad sea 70 o 71
  05-Sep-2013   jcastroSAO212991    Se incluye la validacion de que si para el Contratista
                                    asociado a la Unidad Operativa no se encuentra configuracion
                                    asociada en FICBS, se obtiene el Id del Contratista
                                    generico del parametro CONTRATISTA_CONFIG_DEFAU_FICBS
                                    y se busca para este la configuracion en FICBS que es
                                    la configuracion por defecto a ser tomada.
                                    Open Cali.
  
  03-Sep-2013   vhurtadoSAO213189   Se agrega campo oblEditPointDel
  ******************************************************************/

  PROCEDURE GetSupplierData(inuSubscription     suscripc.susccodi%type,
                            inuAddress          ab_address.address_id%type,
                            osbSupplierName     out ge_contratista.nombre_contratista%type,
                            onuSupplierId       out ge_contratista.id_contratista%type,
                            osbPointSaleName    out or_operating_unit.name%type,
                            onuPointSaleId      out or_operating_unit.operating_unit_id%type,
                            oblTransferQuote    out boolean,
                            oblCosigner         out boolean,
                            oblConsignerGasProd out boolean,
                            oblModiSalesChanel  out boolean,
                            onuSalesChanel      out ld_suppli_settings.default_chan_sale%type,
                            osbPromissoryType   out ld_suppli_settings.type_promiss_note%type,
                            oblRequiApproAnnulm out boolean,
                            oblRequiApproReturn out boolean,
                            osbSaleNameReport   out ld_suppli_settings.sale_name_report%type,
                            osbExeRulePostSale  out ld_suppli_settings.exe_rule_post_sale%type,
                            osbPostLegProcess   out ld_suppli_settings.post_leg_process%type,
                            onuMinForDelivery   out ld_suppli_settings.min_for_delivery%type,
                            oblDelivInPoint     out boolean,
                            oblEditPointDel     out boolean,
                            oblLegDelivOrdeAuto out boolean,
                            osbTypePromissNote  out ld_suppli_settings.type_promiss_note%type) IS
  
    rcOperatingUnit   daor_operating_unit.styOR_operating_unit;
    tbSuppliSettings  dald_suppli_settings.tytbLD_suppli_settings;
    nuOperatingUnit   or_operating_unit.operating_unit_id%type;
    nuValidate        number := 0;
    nuContraGeneFICBS ge_contratista.id_contratista%TYPE; -- Id del Contratista generico en FICBS
    boConfContExis    BOOLEAN; -- Configuracion para el Contratista existe en FICBS ?
    blFlag            boolean := false;
  
    CURSOR cugetSuppliSettings(nuSupplierId in ld_suppli_settings.supplier_id%type) IS
      SELECT 1 nuProv
        FROM ld_suppli_settings
       WHERE supplier_id = nuSupplierId;
  
  BEGIN
    --{
    execute immediate 'ALTER SESSION SET NLS_DATE_FORMAT = ' ||
                      '''DD-MM-YYYY HH24:MI:SS''';
  
    /*Obtiene la persona conectada*/
    ut_trace.trace('Inicia LDC_CALCULACUPOBRILLA.GetSupplierData. -- Persona conectada: ' ||
                   GE_BOPersonal.fnuGetPersonId,
                   5);
  
    open cuGetunitBySeller;
    fetch cuGetunitBySeller
      INTO nuOperatingUnit;
    close cuGetunitBySeller;
  
    if (nuOperatingUnit IS null) then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'No hay area organizacional vigente para la persona actual');
    END if;
  
    daor_operating_unit.getRecord(nuOperatingUnit, rcOperatingUnit);
  
    --Valida si la unidad operativa es clasificacion 70 o 71
    if ((rcOperatingUnit.oper_unit_classif_id = 70) OR
       (rcOperatingUnit.oper_unit_classif_id = 71)) then
      blFlag := true;
    end if;
    if (not blFlag) then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'Para realizar Financiaciones de Articulos debe ser Contratista o Proveedor');
    end if;
  
    osbPointSaleName := rcOperatingUnit.name;
  
    onuPointSaleId := rcOperatingUnit.operating_unit_id;
  
    onuSupplierId := rcOperatingUnit.contractor_id;
  
    ut_trace.trace('Identificador del contratista de venta  ' ||
                   onuSupplierId);
  
    if onuSupplierId is not null then
    
      osbSupplierName := dage_contratista.fsbGetNombre_Contratista(onuSupplierId);
    
      -- Obtiene la configuracion del Contratista / Proveedor desde FICBS
    
      BEGIN
        --{
        boConfContExis := TRUE; -- Se asume que existe la configuracion para el Contratista en FICBS
      
        -- Obtiene la configuracion del Contratista desde FICBS
        dald_suppli_settings.getRecords('ld_suppli_settings.supplier_id = ' ||
                                        onuSupplierId,
                                        tbSuppliSettings);
      
      EXCEPTION
        when ex.CONTROLLED_ERROR then
          -- No encontro configuracion en FICBS para el Contratista asociado a la Unidad Operativa
          boConfContExis := FALSE;
          ut_trace.trace('No existe configuracion en FICBS para el Contratista' ||
                         onuSupplierId ||
                         '. Se buscara la configuracion del Contratista generico en FICBS.');
          --}
      END;
    
      -- Valida si no pudo obtener la configuracion del Contratista / Proveedor desde FICBS
    
      IF (NOT boConfContExis) THEN
        --{
        -- Obtiene el Id del Contratista con que se busca la configuracion generica
        -- en FICBS en caso de que el Contratista asociado a la Unidad Operativa
        -- no este configurado explicitamente
        nuContraGeneFICBS := DALD_PARAMETER.fnuGetNumeric_Value('CONTRATISTA_CONFIG_DEFAU_FICBS');
        ut_trace.trace('Contratista generico en FICBS: ' ||
                       nuContraGeneFICBS);
      
        -- Obtiene la configuracion desde FICBS
      
        open cugetSuppliSettings(nuContraGeneFICBS);
        fetch cugetSuppliSettings
          INTO nuValidate;
        close cugetSuppliSettings;
      
        -- Valida si encontro configuracion en FICBS
      
        if (nvl(nuValidate, 0) <> 1) then
          --{
          ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                           'No existe configuracion en FICBS para el Contratista generico:' ||
                                           nuContraGeneFICBS);
          --}
        end if;
      
        -- Obtiene la configuracion desde FICBS para el Contratista generico
        dald_suppli_settings.getRecords('ld_suppli_settings.supplier_id = ' ||
                                        nuContraGeneFICBS,
                                        tbSuppliSettings);
        --}
      END IF;
    
      if (tbSuppliSettings(tbSuppliSettings.first)
         .allow_transf_quota = ld_boconstans.csbYesFlag) then
        oblTransferQuote := true;
      else
        oblTransferQuote := false;
      end if;
    
      if (tbSuppliSettings(tbSuppliSettings.first)
         .debtor_required = ld_boconstans.csbYesFlag) then
        oblCosigner := true;
      else
        oblCosigner := false;
      end if;
    
      if (tbSuppliSettings(tbSuppliSettings.first)
         .DEBTOR_PRODUCT_GAS = ld_boconstans.csbYesFlag) then
        oblConsignerGasProd := true;
      else
        oblConsignerGasProd := false;
      end if;
    
      if (tbSuppliSettings(tbSuppliSettings.first)
         .SEL_SALES_CHANNEL = ld_boconstans.csbYesFlag) then
        oblModiSalesChanel := true;
      else
        oblModiSalesChanel := false;
      end if;
    
      onuSalesChanel := tbSuppliSettings(tbSuppliSettings.first)
                        .default_chan_sale;
    
      osbPromissoryType := tbSuppliSettings(tbSuppliSettings.first)
                           .type_promiss_note;
    
      if (tbSuppliSettings(tbSuppliSettings.first)
         .requi_approv_annulm = ld_boconstans.csbYesFlag) then
        oblRequiApproAnnulm := true;
      else
        oblRequiApproAnnulm := false;
      end if;
    
      if (tbSuppliSettings(tbSuppliSettings.first)
         .requi_approv_return = ld_boconstans.csbYesFlag) then
        oblRequiApproReturn := true;
      else
        oblRequiApproReturn := false;
      end if;
    
      osbSaleNameReport := tbSuppliSettings(tbSuppliSettings.first)
                           .sale_name_report;
    
      osbExeRulePostSale := tbSuppliSettings(tbSuppliSettings.first)
                            .exe_rule_post_sale;
    
      osbPostLegProcess := tbSuppliSettings(tbSuppliSettings.first)
                           .post_leg_process;
    
      onuMinForDelivery := tbSuppliSettings(tbSuppliSettings.first)
                           .min_for_delivery;
    
      if (tbSuppliSettings(tbSuppliSettings.first)
         .deliv_in_point = ld_boconstans.csbYesFlag) then
        oblDelivInPoint := true;
      else
        oblDelivInPoint := false;
      end if;
    
      if (tbSuppliSettings(tbSuppliSettings.first)
         .edit_deliv_in_point = ld_boconstans.csbYesFlag) then
        oblEditPointDel := true;
      else
        oblEditPointDel := false;
      end if;
    
      if (tbSuppliSettings(tbSuppliSettings.first)
         .leg_deliv_orde_auto = ld_boconstans.csbYesFlag) then
      
        oblLegDelivOrdeAuto := true;
      
      else
        oblLegDelivOrdeAuto := false;
      
      end if;
    
      osbTypePromissNote := tbSuppliSettings(tbSuppliSettings.first)
                            .type_promiss_note;
    
    else
    
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'La unidad operativa no posee un contratista asociado');
    
    end if;
    ut_trace.trace('FIN LDC_CALCULACUPOBRILLA.GetSupplierData', 5);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
      --}
  END GetSupplierData;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : GetSubcriptionData
  Descripcion    : Obtiene los datos del contrato.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId: Numero de la solicitud.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE GetSubcriptionData(inuSubscription   suscripc.susccodi%type,
                               osbIdentType      out varchar2,
                               osbIdentification out ge_subscriber.identification%type,
                               onuSubscriberId   out ge_subscriber.subscriber_id%type,
                               osbSubsName       out ge_subscriber.subscriber_name%type,
                               osbSubsLastName   out ge_subscriber.subs_last_name%type,
                               osbAddress        out ab_address.address_parsed%type,
                               onuAddress_Id     out ab_address.address_id%type,
                               onuGeoLocation    out ge_geogra_location.geograp_location_id%type,
                               osbFullPhone      out ge_subs_phone.full_phone_number%type,
                               osbCategory       out varchar2,
                               osbSubcategory    out varchar2,
                               onuCategory       out number,
                               onuSubcategory    out number,
                               onuRedBalance     out number,
                               onuAssignedQuote  out number,
                               onuUsedQuote      out number,
                               onuAvalibleQuote  out number) IS
    email ge_subscriber.e_mail%type;
  BEGIN
    GetSubcriptionData(inuSubscription,
                       osbIdentType,
                       osbIdentification,
                       onuSubscriberId,
                       osbSubsName,
                       osbSubsLastName,
                       osbAddress,
                       onuAddress_Id,
                       onuGeoLocation,
                       osbFullPhone,
                       osbCategory,
                       osbSubcategory,
                       onuCategory,
                       onuSubcategory,
                       onuRedBalance,
                       onuAssignedQuote,
                       onuUsedQuote,
                       onuAvalibleQuote,
                       email);
  END;

  PROCEDURE GetSubcriptionData(inuSubscription   suscripc.susccodi%type,
                               osbIdentType      out varchar2,
                               osbIdentification out ge_subscriber.identification%type,
                               onuSubscriberId   out ge_subscriber.subscriber_id%type,
                               osbSubsName       out ge_subscriber.subscriber_name%type,
                               osbSubsLastName   out ge_subscriber.subs_last_name%type,
                               osbAddress        out ab_address.address_parsed%type,
                               onuAddress_Id     out ab_address.address_id%type,
                               onuGeoLocation    out ge_geogra_location.geograp_location_id%type,
                               osbFullPhone      out ge_subs_phone.full_phone_number%type,
                               osbCategory       out varchar2,
                               osbSubcategory    out varchar2,
                               onuCategory       out number,
                               onuSubcategory    out number,
                               onuRedBalance     out number,
                               onuAssignedQuote  out number,
                               onuUsedQuote      out number,
                               onuAvalibleQuote  out number,
                               osbEmail          out ge_subscriber.e_mail%type)
  
   IS
    rcSubscription Suscripc%rowtype;
    rcSubscriber   dage_subscriber.styGE_subscriber;
    rcProduct      dapr_product.stypr_product;
    nuGasProduct   pr_product.product_id%type;
    --nuPhoneId      pr_product.subs_phone_id%type;
    rcServsusc servsusc%rowtype;
  
  BEGIN
  
    AllocateTotalQuota(inuSubscription, onuAssignedQuote);
    /*Obtiene los datos del contrato.
    Usando el paquete de primer nivel obtiene el registro del contrato.*/
    rcSubscription := pktblsuscripc.frcGetRecord(inuSubscription);
  
    onuSubscriberId := rcSubscription.Suscclie;
  
    dage_subscriber.getRecord(rcSubscription.Suscclie, rcSubscriber);
  
    osbIdentType := rcSubscriber.ident_type_id;
  
    osbIdentification := rcSubscriber.identification;
  
    osbSubsName := rcSubscriber.subscriber_name;
  
    osbSubsLastName := rcSubscriber.subs_last_name;
  
    osbEmail := rcSubscriber.e_mail;
  
    nuGasProduct := fnugetGasProduct(inuSubscription);
  
    if nuGasProduct is not null then
      dapr_product.getrecord(nuGasProduct, rcProduct);
    
      onuAddress_Id := rcProduct.address_id;
    
      onuGeoLocation := daab_address.fnuGetGeograp_Location_Id(onuAddress_Id);
    
      osbAddress := daab_address.fsbGetAddress_Parsed(rcProduct.address_id);
    
      osbFullPhone := DAGE_SUBSCRIBER.FSBGETPHONE(onuSubscriberId, 0);
    
      rcServsusc := pktblservsusc.frcGetRecord(nuGasProduct);
    
      onuSubcategory := rcServsusc.Sesusuca;
    
      onuCategory := rcServsusc.Sesucate;
    
      osbSubcategory := to_char(rcServsusc.Sesusuca) || ' - ' ||
                        pktblsubcateg.fsbgetdescription(rcServsusc.Sesucate,
                                                        rcServsusc.Sesusuca);
    
      osbCategory := to_char(rcServsusc.Sesucate) || ' - ' ||
                     pktblcategori.fsbgetdescription(rcServsusc.Sesucate);
    
    end if;
  
    onuUsedQuote     := LDC_CALCULACUPOBRILLA.fnuGetUsedQuote(inuSubscription);
    onuAvalibleQuote := onuAssignedQuote - onuUsedQuote;
  
    if (onuAvalibleQuote < 0) then
      onuAvalibleQuote := 0;
    end if;
    onuRedBalance := LD_BONonBankFiRules.fnuAcquittedFinan(inuSubscription);
  
    /*
    Usando el codigo del cliente , obtiene de la tabla GE_SUBSCRIBER, el nombre del usuario, el tipo de identificacion, la identificacion, y el codigo del telefono.
    Con el codigo del telefono obtiene el numero de telefono a mostrar.
    Usando el codigo de la direccion obtiene la direccion para mostrar del cliente.
    Obtiene el cupo asignado usando el metodo GetSubcriptionData al cual le pasa como parametros la identificacion del contrato.
    Obtiene el cupo utilizado(fnuGetUsedQuote)
    Obtiene el cupo disponible restando el cupo asignado menos el cupo disponible.
    */
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetSubcriptionData;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : RegisterDeudorData
  Descripcion    : Registra los datos de un deudor.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  
  inuSubscriberId   Codigo del cliente
  inuPackageId      Numero de la solicitud.
  
  
    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========   =========               ====================
    24-09-2013  lfernandez.SAO217737    Se adiciona parametro cliente, se
                                        actualiza/registra el genero del cliente
                                        en los datos generales
  ******************************************************************/
  PROCEDURE RegisterDeudorData(inuSubscriberId      in ge_subscriber.subscriber_id%type,
                               inuPromissory_id     in ld_promissory.promissory_id%type,
                               isbHolder_Bill       in ld_promissory.holder_bill%type,
                               isbDebtorName        in ld_promissory.debtorname%type,
                               inuIdentType         in ld_promissory.ident_type_id%type,
                               isbIdentification    in ld_promissory.identification%type,
                               inuForwardingPlace   in ld_promissory.forwardingplace%type,
                               idtForwardingDate    in ld_promissory.forwardingdate%type,
                               isbGender            in ld_promissory.gender%type,
                               inuCivil_State_Id    in ld_promissory.civil_state_id%type,
                               idtBirthdayDate      in ld_promissory.birthdaydate%type,
                               inuSchool_Degree_    in ld_promissory.school_degree_%type,
                               inuAddress_Id        in ld_promissory.address_id%type,
                               isbPropertyPhone     in ld_promissory.propertyphone_id%type,
                               inuDependentsNumber  in ld_promissory.dependentsnumber%type,
                               inuHousingTypeId     in ld_promissory.housingtype%type,
                               inuHousingMonth      in ld_promissory.housingmonth%type,
                               isbHolderRelation    in ld_promissory.holderrelation%type,
                               isbOccupation        in ld_promissory.occupation%type,
                               isbCompanyName       in ld_promissory.companyname%type,
                               inuCompanyAddress_Id in ld_promissory.companyaddress_id%type,
                               isbPhone1            in ld_promissory.phone1_id%type,
                               isbPhone2            in ld_promissory.phone2_id%type,
                               isbMovilPhone        in ld_promissory.movilphone_id%type,
                               inuOldLabor          in ld_promissory.oldlabor%type,
                               inuActivityId        in ld_promissory.activity%type,
                               inuMonthlyIncome     in ld_promissory.monthlyincome%type,
                               inuExpensesIncome    in ld_promissory.expensesincome%type,
                               isbFamiliarReference in ld_promissory.familiarreference%type,
                               isbPhoneFamiRefe     in ld_promissory.phonefamirefe%type,
                               inuMovilPhoFamiRefe  in ld_promissory.movilphofamirefe%type,
                               inuaddressfamirefe   in ld_promissory.addresspersrefe%type,
                               isbPersonalReference in ld_promissory.personalreference%type,
                               isbPhonePersRefe     in ld_promissory.phonepersrefe%type,
                               isbMovilPhoPersRefe  in ld_promissory.movilphopersrefe%type,
                               inuaddresspersrefe   in ld_promissory.addresspersrefe%type,
                               isbcommerreference   in ld_promissory.commerreference%type,
                               isbphonecommrefe     in ld_promissory.phonecommrefe%type,
                               isbmovilphocommrefe  in ld_promissory.movilphocommrefe%type,
                               inuaddresscommrefe   in ld_promissory.addresscommrefe%type,
                               isbEmail             in ld_promissory.email%type,
                               inuPackage_Id        in ld_promissory.package_id%type,
                               inuCategoryId        in ld_promissory.category_id%type,
                               inuSubcategoryId     in ld_promissory.subcategory_id%type,
                               inuContractType      in ld_promissory.contract_type_id%type,
                               isblastname          in ld_promissory.last_name%type) IS
    ------------------------------------------------------------------------
    --  Variables
    ------------------------------------------------------------------------
    rcSubsGenData   DAGE_Subs_General_Data.styGE_Subs_General_Data;
    rcLd_Promissory dald_promissory.styld_promissory;
  BEGIN
  
    rcLd_Promissory.promissory_id     := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LD_PROMISSORY',
                                                                             'SEQ_LD_PROMISSORY');
    rcLd_Promissory.holder_bill       := isbHolder_Bill;
    rcLd_Promissory.debtorname        := isbDebtorName;
    rcLd_Promissory.identification    := isbIdentification;
    rcLd_Promissory.ident_type_id     := inuIdentType;
    rcLd_Promissory.forwardingplace   := inuForwardingPlace;
    rcLd_Promissory.forwardingdate    := idtForwardingDate;
    rcLd_Promissory.gender            := isbGender;
    rcLd_Promissory.civil_state_id    := inuCivil_State_Id;
    rcLd_Promissory.birthdaydate      := idtBirthdayDate;
    rcLd_Promissory.school_degree_    := inuSchool_Degree_;
    rcLd_Promissory.address_id        := inuAddress_Id;
    rcLd_Promissory.propertyphone_id  := isbPropertyPhone;
    rcLd_Promissory.dependentsnumber  := inuDependentsNumber;
    rcLd_Promissory.housingtype       := inuHousingTypeId;
    rcLd_Promissory.housingmonth      := inuHousingMonth;
    rcLd_Promissory.holderrelation    := isbHolderRelation;
    rcLd_Promissory.occupation        := isbOccupation;
    rcLd_Promissory.companyname       := isbCompanyName;
    rcLd_Promissory.companyaddress_id := inuCompanyAddress_Id;
    rcLd_Promissory.phone1_id         := isbPhone1;
    rcLd_Promissory.phone2_id         := isbPhone2;
    rcLd_Promissory.movilphone_id     := isbMovilPhone;
    rcLd_Promissory.oldlabor          := inuOldLabor;
    rcLd_Promissory.activity          := inuActivityId;
    rcLd_Promissory.monthlyincome     := inuMonthlyIncome;
    rcLd_Promissory.expensesincome    := inuExpensesIncome;
  
    rcLd_Promissory.familiarreference := isbFamiliarReference;
    rcLd_Promissory.phonefamirefe     := isbPhoneFamiRefe;
    rcLd_Promissory.movilphofamirefe  := inuMovilPhoFamiRefe;
    rcld_promissory.addressfamirefe   := inuaddressfamirefe;
    rcld_promissory.category_id       := inuCategoryId;
    rcld_promissory.subcategory_id    := inuSubcategoryId;
    rcld_promissory.contract_type_id  := inuContractType;
  
    rcLd_Promissory.personalreference := isbPersonalReference;
    rcLd_Promissory.phonepersrefe     := isbPhonePersRefe;
    rcLd_Promissory.movilphopersrefe  := isbMovilPhoPersRefe;
    rcld_promissory.addresspersrefe   := inuaddresspersrefe;
  
    IF (isbcommerreference IS NOT NULL) THEN
    
      rcld_promissory.commerreference  := isbcommerreference;
      rcld_promissory.phonecommrefe    := isbphonecommrefe;
      rcld_promissory.movilphocommrefe := isbmovilphocommrefe;
      rcld_promissory.addresscommrefe  := inuaddresscommrefe;
    
    END IF;
  
    rcLd_Promissory.email           := isbEmail;
    rcLd_Promissory.package_id      := inuPackage_Id;
    rcLd_Promissory.promissory_type := ld_boconstans.csbDEUDORPROTYPE;
    rcLd_Promissory.last_name       := isblastname;
  
    /*guarda en la tabla*/
    dald_promissory.insRecord(ircLd_Promissory => rcLd_Promissory);
  
    --  Si es el titular de la factura
    if (isbHolder_Bill = GE_BOConstants.csbYES) then
    
      --  Si existe informacion general del cliente
      if (DAGE_Subs_General_Data.fblExist(inuSubscriberId)) then
      
        --  Si no tiene genero
        if (DAGE_Subs_General_Data.fsbGetGender(inuSubscriberId) IS null) then
        
          --  Actualiza el genero
          DAGE_Subs_General_Data.updGender(inuSubscriberId, isbGender);
        
        END if;
      
      else
      
        --  Crea el registro de la informacion general
        rcSubsGenData.subscriber_id := inuSubscriberId;
        rcSubsGenData.gender        := isbGender;
      
        DAGE_Subs_General_Data.insRecord(rcSubsGenData);
      
      END if;
    
    end if;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END RegisterDeudorData;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : RegisterCosignerData
  Descripcion    : Registra los datos de un codeudor.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId: Numero de la solicitud.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE RegisterCosignerData(inuPromissory_id     in ld_promissory.promissory_id%type,
                                 isbHolder_Bill       in ld_promissory.holder_bill%type,
                                 isbDebtorName        in ld_promissory.debtorname%type,
                                 inuIdentType         in ld_promissory.ident_type_id%type,
                                 isbIdentification    in ld_promissory.identification%type,
                                 inuForwardingPlace   in ld_promissory.forwardingplace%type,
                                 idtForwardingDate    in ld_promissory.forwardingdate%type,
                                 isbGender            in ld_promissory.gender%type,
                                 inuCivil_State_Id    in ld_promissory.civil_state_id%type,
                                 idtBirthdayDate      in ld_promissory.birthdaydate%type,
                                 inuSchool_Degree_    in ld_promissory.school_degree_%type,
                                 inuAddress_Id        in ld_promissory.address_id%type,
                                 isbPropertyPhone     in ld_promissory.propertyphone_id%type,
                                 inuDependentsNumber  in ld_promissory.dependentsnumber%type,
                                 inuHousingTypeId     in ld_promissory.housingtype%type,
                                 inuHousingMonth      in ld_promissory.housingmonth%type,
                                 isbHolderRelation    in ld_promissory.holderrelation%type,
                                 isbOccupation        in ld_promissory.occupation%type,
                                 isbCompanyName       in ld_promissory.companyname%type,
                                 inuCompanyAddress_Id in ld_promissory.companyaddress_id%type,
                                 isbPhone1            in ld_promissory.phone1_id%type,
                                 isbPhone2            in ld_promissory.phone2_id%type,
                                 isbMovilPhone        in ld_promissory.movilphone_id%type,
                                 inuOldLabor          in ld_promissory.oldlabor%type,
                                 inuActivityId        in ld_promissory.activity%type,
                                 inuMonthlyIncome     in ld_promissory.monthlyincome%type,
                                 inuExpensesIncome    in ld_promissory.expensesincome%type,
                                 isbFamiliarReference in ld_promissory.familiarreference%type,
                                 isbPhoneFamiRefe     in ld_promissory.phonefamirefe%type,
                                 inuMovilPhoFamiRefe  in ld_promissory.movilphofamirefe%type,
                                 inuaddressfamirefe   in ld_promissory.addresspersrefe%type,
                                 isbPersonalReference in ld_promissory.personalreference%type,
                                 isbPhonePersRefe     in ld_promissory.phonepersrefe%type,
                                 isbMovilPhoPersRefe  in ld_promissory.movilphopersrefe%type,
                                 inuaddresspersrefe   in ld_promissory.addresspersrefe%type,
                                 isbcommerreference   in ld_promissory.commerreference%type,
                                 isbphonecommrefe     in ld_promissory.phonecommrefe%type,
                                 isbmovilphocommrefe  in ld_promissory.movilphocommrefe%type,
                                 inuaddresscommrefe   in ld_promissory.addresscommrefe%type,
                                 isbEmail             in ld_promissory.email%type,
                                 inuPackage_Id        in ld_promissory.package_id%type,
                                 inuCategoryId        in ld_promissory.category_id%type,
                                 inuSubcategoryId     in ld_promissory.subcategory_id%type,
                                 inuContractType      in ld_promissory.contract_type_id%type,
                                 isblastname          in ld_promissory.last_name%type) IS
    rcLd_Promissory dald_promissory.styld_promissory;
  BEGIN
  
    rcLd_Promissory.promissory_id     := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LD_PROMISSORY',
                                                                             'SEQ_LD_PROMISSORY');
    rcLd_Promissory.holder_bill       := isbHolder_Bill;
    rcLd_Promissory.debtorname        := isbDebtorName;
    rcLd_Promissory.identification    := isbIdentification;
    rcLd_Promissory.ident_type_id     := inuIdentType;
    rcLd_Promissory.forwardingplace   := inuForwardingPlace;
    rcLd_Promissory.forwardingdate    := idtForwardingDate;
    rcLd_Promissory.gender            := isbGender;
    rcLd_Promissory.civil_state_id    := inuCivil_State_Id;
    rcLd_Promissory.birthdaydate      := idtBirthdayDate;
    rcLd_Promissory.school_degree_    := inuSchool_Degree_;
    rcLd_Promissory.address_id        := inuAddress_Id;
    rcLd_Promissory.propertyphone_id  := isbPropertyPhone;
    rcLd_Promissory.dependentsnumber  := inuDependentsNumber;
    rcLd_Promissory.housingtype       := inuHousingTypeId;
    rcLd_Promissory.housingmonth      := inuHousingMonth;
    rcLd_Promissory.holderrelation    := isbHolderRelation;
    rcLd_Promissory.occupation        := isbOccupation;
    rcLd_Promissory.companyname       := isbCompanyName;
    rcLd_Promissory.companyaddress_id := inuCompanyAddress_Id;
    rcLd_Promissory.phone1_id         := isbPhone1;
    rcLd_Promissory.phone2_id         := isbPhone2;
    rcLd_Promissory.movilphone_id     := isbMovilPhone;
    rcLd_Promissory.oldlabor          := inuOldLabor;
    rcLd_Promissory.activity          := inuActivityId;
    rcLd_Promissory.monthlyincome     := inuMonthlyIncome;
    rcLd_Promissory.expensesincome    := inuExpensesIncome;
  
    rcLd_Promissory.familiarreference := isbFamiliarReference;
    rcLd_Promissory.phonefamirefe     := isbPhoneFamiRefe;
    rcLd_Promissory.movilphofamirefe  := inuMovilPhoFamiRefe;
    rcld_promissory.addressfamirefe   := inuaddressfamirefe;
    rcld_promissory.category_id       := inuCategoryId;
    rcld_promissory.subcategory_id    := inuSubcategoryId;
    rcld_promissory.contract_type_id  := inuContractType;
  
    rcLd_Promissory.personalreference := isbPersonalReference;
    rcLd_Promissory.phonepersrefe     := isbPhonePersRefe;
    rcLd_Promissory.movilphopersrefe  := isbMovilPhoPersRefe;
    rcld_promissory.addresspersrefe   := inuaddresspersrefe;
  
    rcld_promissory.commerreference  := isbcommerreference;
    rcld_promissory.phonecommrefe    := isbphonecommrefe;
    rcld_promissory.movilphocommrefe := isbmovilphocommrefe;
    rcld_promissory.addresscommrefe  := inuaddresscommrefe;
  
    rcLd_Promissory.email           := isbEmail;
    rcLd_Promissory.package_id      := inuPackage_Id;
    rcLd_Promissory.promissory_type := ld_boconstans.csbCOSIGNERPROTYPE;
  
    rcLd_Promissory.last_name := isblastname;
  
    dald_promissory.insRecord(ircLd_Promissory => rcLd_Promissory);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END RegisterCosignerData;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : RegisterFNBsale
  Descripcion    : Registra la solicitud de venta.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId: Numero de la solicitud.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE RegisterFNBsale(inupackage mo_packages.package_id%type)
  
   IS
  BEGIN
  
    /*registra solicitud del tipo de venta fnb*/
    -- OS_RegisterRequestWithXML();
  
    /*mo_boaction.*/
  
    /*registra datos adicionales*/
  
    /*registra un motivo por cada articulo*/
  
    /*Registra en la tabla LD_NON_BAN_FI_ITEM
    los datos adicionales de cada uno de los articulos.*/
  
    /*Registra el pagare del deudor usando el metodo
    RegisterDeudorData.*/
  
    /*Si se registro codeudor se registra en la tabla
    CosignerData.*/
    null;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END RegisterFNBsale;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : RegisterSuscShare
  Descripcion    : Registra el cupo de los suscritores
  
  Autor          : AAcuna
  Fecha          : 15/02/2013
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId: Numero de la solicitud.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE RegisterSuscShare
  
   IS
  
    nuTotal    ld_credit_quota.quota_value%type;
    tbSuscripc pktblsuscripc.tysusccodi;
    nuSuscripc suscripc.susccodi%type;
    nuSusccodi suscripc.susccodi%type;
    cnuServGas CONSTANT pr_product.product_type_id%TYPE := Dald_parameter.fnuGetNumeric_Value('COD_TIPO_SERV'); --7014
    nuGeograp_Location_Id ge_geogra_location.geograp_location_id%type;
  
  BEGIN
  
    ut_trace.trace('Inicio LDC_CALCULACUPOBRILLA.RegisterSuscShare');
  
    nuSusccodi            := ge_boInstanceControl.fsbGetFieldValue('SUSCRIPC',
                                                                   'SUSCCODI');
    nuGeograp_Location_Id := ge_boInstanceControl.fsbGetFieldValue('GE_GEOGRA_LOCATION',
                                                                   'GEOGRAP_LOCATION_ID');
    if (nuSusccodi is null) and (nuGeograp_Location_Id is null) then
    
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'No se permite ingresar los dos campos de proceso como vacios');
    else
    
      if (nuSusccodi is not null) and (nuGeograp_Location_Id is null) then
      
        LDC_CALCULACUPOBRILLA.AllocateQuota(nuSusccodi, nuTotal);
      
      else
        tbSuscripc := ld_bcnonbankfinancing.frcgetsuscripc(cnuServGas,
                                                           nuSusccodi,
                                                           nuGeograp_Location_Id);
      
        if tbSuscripc.count > 0 then
        
          for i in tbSuscripc.FIRST .. tbSuscripc.LAST loop
          
            nuSuscripc := tbSuscripc(i);
            LDC_CALCULACUPOBRILLA.AllocateQuota(nuSuscripc, nuTotal);
          
          end loop;
        else
          if (nuSusccodi IS not null) then
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'El contrato escrito no pertenece a la Ubicacion Geografica seleccionada, Favor validar');
          else
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'No se encontraron registros para procesar');
          END if;
        end if;
      end if;
    
    end if;
  
    ut_trace.trace('Finaliza LDC_CALCULACUPOBRILLA.RegisterSuscShare');
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END RegisterSuscShare;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : registerArticleFNBsale
  Descripcion    : Registra un articulo para vender.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId: Numero de la solicitud.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE registerArticleFNBsale(inupackage mo_packages.package_id%type)
  
   IS
  BEGIN
  
    /*ld_tmpitem_work_order;*/
    null;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END registerArticleFNBsale;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         :  ValidateDueBill
  Descripcion    :  Verifica las solicitudes de venta que se encuentra
                    en estado stop para verificar si la factura asociada
                    se encuentra sin saldo pendiente , si se encuentra
                    con saldo pendiente se procede a mover la actividad espera
                    pago de factura del flujo (Proceso ejecutado por job).
  
  Autor          :  AAcuna
  Fecha          :  11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  27-06-2013      hvera               Se modifica la logica para avanzar el flujo
                                      bajo los siguientes casos:
                                      la cartera vencida fue pagada
                                      o su supero la cantidad de dias de espera.
  ******************************************************************/

  PROCEDURE ValidateDueBill
  
   IS
  
    frfResult      constants.tyrefcursor;
    rfBillPending  constants.tyrefcursor;
    recBill        Mo_Wf_Pack_Interfac%rowTYPE;
    recBillPending cuencobr%ROWTYPE;
    frfFact        constants.tyrefcursor;
    recFact        ld_bill_pending_payment%rowtype;
    rcCuencobr     pktblcuencobr.cucuencobr%ROWTYPE;
    nuCucosacu     cuencobr.cucosacu%type := 0;
    nuAccion       ge_action_module.action_id%type;
    tbBillPending  dald_bill_pending_payment.styLD_bill_pending_payment;
    nuGetBill      number;
  
    inuSubscriptionId suscripc.susccodi%type;
    nuExpirDebt       number := 0;
  BEGIN
  
    ut_trace.trace('Inicio LDC_CALCULACUPOBRILLA.ValidateDueBill');
  
    /*Numero de accion de la actividad de espera pago cuenta del flujo de venta,
    esta accion es usada para saber que solicitudes esta en estado stop por la
    actividad espera pago cuenta que en este caso es identificado para el numero
    176*/
  
    nuAccion := dald_parameter.fnuGetNumeric_Value('IDEN_ACCI_ESPA');
  
    /* Se obtiene los paquetes asociados a accion de espera de pago de factura, aqui
    se traeran todas las solicitudes que estan esperando el pago de la factura*/
  
    frfResult := ld_bcnonbankfinancing.frfGetValidateBill;
  
    LOOP
      FETCH frfResult
        INTO recBill;
      exit when(frfResult%notFound);
    
      /* Se obtienen todas las facturas pendientes por pagar y se
      procede a verificar si si tiene saldo pendiente o no*/
    
      frfFact := ld_bcnonbankfinancing.frfGetBill(recBill.package_id);
    
      /*Se recorre todas las facturas en estado pendientes por pagar y su estado sea
      null*/
    
      LOOP
        FETCH frfFact
          INTO recFact;
        exit when(frfFact%notFound);
      
        /* Se obtienen la cartera vencida del contrato de la solicitud */
        inuSubscriptionId := damo_packages.fnugetsubscription_pend_id(recFact.Package_id);
        ut_trace.trace('inuSubscriptionId ' || inuSubscriptionId, 10);
        nuExpirDebt := GC_BODEBTMANAGEMENT.fnuGetExpirDebtBySusc(inuSubscriptionId);
      
        /* Si el saldo de la cuenta de cobro es igual a cero quiere decir que la factura se
        encuentra paga y se procede hacer avanzar el flujo */
        IF (nuExpirDebt <= 0) THEN
        
          /*Se actualiza el registro en la entidad facturas pendientes por pagar
          colocandole estado N ya que la factura se encuentra cancelada*/
        
          dald_bill_pending_payment.updPayment(recFact.bill_pending_payment_id,
                                               'N');
        
          /*Se llama el servicio para hacer continuar el flujo*/
        
          mo_bowf_pack_interfac.PrepNotToWfPack(recBill.package_id,
                                                nuAccion,
                                                MO_BOCausal.fnuGetSuccess,
                                                MO_BOStatusParameter.fnuGetSTA_ACTIV_STANDBY,
                                                FALSE);
        
        ELSE
        
          nuGetBill := sysdate - recFact.register_date;
        
          IF (nuGetBill >
             dald_parameter.fnuGetNumeric_Value('NUM_MAX_DAY_WAIT_PAYMENT')) THEN
          
            /*Se actualiza el registro en la entidad facturas pendientes por pagar
            colocandole estado N ya que la factura se encuentra cancelada*/
          
            dald_bill_pending_payment.updPayment(recFact.bill_pending_payment_id,
                                                 'N');
          
            /*Se llama el servicio para hacer continuar el flujo*/
          
            mo_bowf_pack_interfac.PrepNotToWfPack(recBill.package_id,
                                                  nuAccion,
                                                  MO_BOCausal.fnuGetSuccess,
                                                  MO_BOStatusParameter.fnuGetSTA_ACTIV_STANDBY,
                                                  FALSE);
          
          END IF;
        END IF;
      
      END LOOP;
    
      IF (frfFact%isOpen) THEN
        CLOSE frfFact;
      END if;
    
    END LOOP;
  
    IF (frfResult%isOpen) THEN
      CLOSE frfResult;
    END if;
    --commit;
    ut_trace.trace('Final LDC_CALCULACUPOBRILLA.ValidateDueBill');
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ValidateDueBill;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         :  getArticleInfo
  Descripcion    : Registra un
  
  Autor          :  eramos
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId:        Identificador de la solicitud
  otbArtcile:          Tabla con articulos relacionados con la venta
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE getArticleInfo
  
   IS
    --rcBill factura%rowtype;
  BEGIN
  
    /*Obtiene la informacion de los articulos de una venta.*/
  
    /*La informacion obtenida sera:
    ? Articulo vendido
    ? Proveedor
    ? Estado de la entrega
    ? Direccion de entrega del articulo
    ? Cantidad de articulos vendidos
    ? Valor unitario del articulo
    ? Valor total de los articulos
    ? Dias de garantia del articulo
    ? Fecha final de garantia, la cual corresponde a la fecha de la venta mas el numero de dias de garantia del articulo.
    ? Tasa de Interes.
    ? Numero de cuotas financiacion.
    La cual se encuentra en la tabla LD_NON_BANK_FIN_ITEMS.
    */
  
    null;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END getArticleInfo;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         :  getSaleInfo
  Descripcion    : Registra un
  
  Autor          :  eramos
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId:        Identificador de la solicitud
  otbArtcile:          Tabla con articulos relacionados con la venta
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE getSaleInfo
  
   IS
    --rcBill factura%rowtype;
  BEGIN
  
    /*?  Numero de la solicitud de credito(MO_PACKAGES.PACKAGE_ID)
    ? Fecha de registro de la solicitud(MO_PACKAGES.REGISTER_DATE)
    ? Fecha de Atencion de la solicitud (MO_PACKAGES.ATENTION_DATE)
    ? Fecha real de la venta(LD_NON_BANK_FINAN_REQU.SALE_DATE)
    ? Estado de la solicitud(LD_NON_BANK_FINAN_REQU.SALES_STATUS)
    ? Contratista vendedor(Mediante MO_PACKAGES.OPERATING_UNIT_ID se obtiene el contratista asociado)
    ? Vendedor(MO_PACKAGES.EXECUTIVE_ID)
    ? Canal de venta(MO_PACKAGES.SALES_CHANEL_ID)
    ? Sucursal de la venta(MO_PACKAGES.POINT_OF_SALE_ID)
    ? Cupo de disponible(LD_NON_BANK_FINAN_REQU. Credit_Quota)
    ? Observaciones(MO_PACKAGES.OBSERVATION)
    ? Valor de la venta(SUM(LD_NON_BANK_FIN_ITEMS.unit_value * LD_NON_BANK_FIN_ITEMS.amount)
    ? Valor de la cuota inicial: Valor de la cuota inicial de la financiacion a nivel de
    Financiaciones.( LD_NON_BANK_FINAN_REQU.Payment)
    ? Valor diferido(valor de la venta ? valor de la cuota inicial)
    ? Concepto(CONCEPTO)
    ? Valor de comision pagada al contratista.
    ? Valor de comision pagada al proveedor.
    ? Informacion del usuario que utilizo el cupo brilla.
    (Mediante MO_PACKAGES.subcrition_Id se obtiene el usuario asociado al contrato que asigno el cupo)
    ? Informacion del codeudor: En la informacion del Pagare estara la informacion del codeudor.
    (Mediante LD_Promissory.ident_type_id
    y LD_Promissory.identification se obtiene la informacion del codeudor)
    */
  
    null;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END getSaleInfo;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         :  fblValidateParcialQuota
  Descripcion    : Registra un
  
  Autor          :  eramos
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId:        Identificador de la solicitud
  otbArtcile:          Tabla con articulos relacionados con la venta
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE fblValidateParcialQuota
  
   IS
    --rcBill factura%rowtype;
  BEGIN
  
    null;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fblValidateParcialQuota;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         :  printSaleFile
  Descripcion    : Registra un
  
  Autor          :  eramos
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId:        Identificador de la solicitud
  otbArtcile:          Tabla con articulos relacionados con la venta
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE printSaleFile
  
   IS
    --rcBill factura%rowtype;
  BEGIN
  
    null;
    /*Obtiene el numero del consecutivo de la instancia.*/
  
    /*Obtiene el proveedor asociado.*/
  
    /*Obtiene el nombre del reporte de venta en la tabla de configuracion por proveedor.*/
  
    /*Ejecuta el reporte.*/
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END printSaleFile;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         :  getFIFAPInfo
  Descripcion    : Obtiene informacion para la ejecucion de brill
  
  Autor          :  eramos
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId:        Identificador de la solicitud
  otbArtcile:          Tabla con articulos relacionados con la venta
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE getFIFAPInfo(inuSubscription     in suscripc.susccodi%type,
                         osbIdentType        out varchar2,
                         osbIdentification   out ge_subscriber.identification%type,
                         onuSubscriberId     out ge_subscriber.subscriber_id%type,
                         osbSubsName         out ge_subscriber.subscriber_name%type,
                         osbSubsLastName     out ge_subscriber.subs_last_name%type,
                         osbAddress          out ab_address.address_parsed%type,
                         onuAddress_Id       out ab_address.address_id%type,
                         onuGeoLocation      out ge_geogra_location.geograp_location_id%type,
                         osbFullPhone        out ge_subs_phone.full_phone_number%type,
                         osbCategory         out varchar2,
                         osbSubcategory      out varchar2,
                         onuCategory         out number,
                         onuSubcategory      out number,
                         onuRedBalance       out number,
                         onuAssignedQuote    out number,
                         onuUsedQuote        out number,
                         onuAvalibleQuote    out number,
                         osbSupplierName     out ge_contratista.nombre_contratista%type,
                         onuSupplierId       out ge_contratista.id_contratista%type,
                         osbPointSaleName    out or_operating_unit.name%type,
                         onuPointSaleId      out or_operating_unit.operating_unit_id%type,
                         oblTransferQuote    out boolean,
                         oblCosigner         out boolean,
                         oblConsignerGasProd out boolean,
                         oblModiSalesChanel  out boolean,
                         onuSalesChanel      out ld_suppli_settings.default_chan_sale%type,
                         osbPromissoryType   out ld_suppli_settings.type_promiss_note%type,
                         oblRequiApproAnnulm out boolean,
                         oblRequiApproReturn out boolean,
                         osbSaleNameReport   out ld_suppli_settings.sale_name_report%type,
                         osbExeRulePostSale  out ld_suppli_settings.exe_rule_post_sale%type,
                         osbPostLegProcess   out ld_suppli_settings.post_leg_process%type,
                         onuMinForDelivery   out ld_suppli_settings.min_for_delivery%type,
                         oblDelivInPoint     out boolean,
                         oblEditPointDel     out boolean,
                         oblLegDelivOrdeAuto out boolean,
                         osbTypePromissNote  out ld_suppli_settings.type_promiss_note%type,
                         onuInsuranceRate    out number,
                         odtDate_Birth       out ge_subs_general_data.date_birth%TYPE,
                         osbGender           out ge_subs_general_data.gender%TYPE,
                         odtPefeme           out perifact.pefafeem%TYPE,
                         osbValidateBill     OUT VARCHAR2,
                         osbLocation         out varchar2,
                         osbdepartment       out varchar2,
                         osbEmail            out ge_subscriber.e_mail%type) IS
  
    nuSesunuse   servsusc.sesunuse%type;
    rcperifact   perifact%Rowtype;
    ciclo        servsusc.sesucicl%TYPE;
    nuTemp       number;
    sbTemp       varchar2(3200);
    nuLocation   number;
    sbLocation   varchar2(3200);
    nuDepartment number;
    sbDepartment varchar2(3200);
    sbAddress    varchar2(3200);
  
  BEGIN
  
    /* Obtengo el producto del servicio gas del contrato*/
    nuSesunuse := Fnugetsesunuse(inuSubscription, null);
    if (nuSesunuse is null) then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El contrato no tiene un servicio de gas activo');
    end if;
  
    GetSubcriptionData(inuSubscription,
                       osbIdentType,
                       osbIdentification,
                       onuSubscriberId,
                       osbSubsName,
                       osbSubsLastName,
                       osbAddress,
                       onuAddress_Id,
                       onuGeoLocation,
                       osbFullPhone,
                       osbCategory,
                       osbSubcategory,
                       onuCategory,
                       onuSubcategory,
                       onuRedBalance,
                       onuAssignedQuote,
                       onuUsedQuote,
                       onuAvalibleQuote,
                       osbEmail);
  
    Ab_Boaddress.Getaddressdata(onuAddress_Id,
                                sbAddress,
                                nuTemp,
                                sbTemp,
                                nuLocation,
                                sbLocation);
  
    osbLocation := nuLocation || ' - ' ||
                   dage_geogra_location.fsbgetdescription(nuLocation);
  
    nuDepartment := Ge_Bogeogra_Location.Fnugetge_Geogra_Location(nuLocation,
                                                                  Ab_Boconstants.Csbtoken_Departamento);
  
    osbdepartment := nuDepartment || ' - ' ||
                     dage_geogra_location.fsbgetdescription(nuDepartment);
  
    GetSupplierData(inuSubscription,
                    onuAddress_Id,
                    osbSupplierName,
                    onuSupplierId,
                    osbPointSaleName,
                    onuPointSaleId,
                    oblTransferQuote,
                    oblCosigner,
                    oblConsignerGasProd,
                    oblModiSalesChanel,
                    onuSalesChanel,
                    osbPromissoryType,
                    oblRequiApproAnnulm,
                    oblRequiApproReturn,
                    osbSaleNameReport,
                    osbExeRulePostSale,
                    osbPostLegProcess,
                    onuMinForDelivery,
                    oblDelivInPoint,
                    oblEditPointDel, --agrega campo enable point delivery
                    oblLegDelivOrdeAuto,
                    osbTypePromissNote);
  
    /* Obtengo el ciclo de facturacion  del servicio gas*/
  
    ciclo := pktblservsusc.fnuGetSesucicl(nuSesunuse);
  
    /* Obtengo el periodo de facturacion a partir del ciclo del producto gas*/
  
    pkbcperifact.getcurrperiodbycycle(ciclo, rcperifact);
  
    /* Se asigna la fecha de emision a la variable de salida  odtPefeme*/
  
    odtPefeme := nvl(rcperifact.pefafeem, rcperifact.pefaffmo);
  
    odtDate_Birth := dage_subs_general_data.fdtGetDate_Birth(inuSubscriber_Id => onuSubscriberId,
                                                             inuRaiseError    => 0);
    osbGender     := dage_subs_general_data.fsbGetGender(inuSubscriber_Id => onuSubscriberId,
                                                         inuRaiseError    => 0);
  
    onuInsuranceRate := dald_parameter.fnuGetNumeric_Value('INSURANCE_RATE');
  
    osbValidateBill := dald_parameter.fsbGetValue_Chain('VALIDATE_BILL');
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END getFIFAPInfo;


  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : getAvalibleArticle
  Descripcion    : Procedimiento para obtener la lista de articulos por
                   Proveedor, Canal de venta, Ubicaci?n geografica.
  
  Autor          : Evens Herard Gorut.
  Fecha          : 31/10/2012
  
  Parametros              Descripcion
  ============         ===================
  InuContractorId       Codigo de Contratista de Venta
  inugeogra_location    Parametro de entrada con el valor de la Ubicacon geografica
  inuSale_Chanel_Id     Parametro de entrada con el valor del Canal de venta
  Inucategory_Id        Codigo de la categoria
  InuSbcategory_Id      Codigo de la subcategoria.
  
  Historia de Modificaciones
  Fecha       Autor               Modificacion
  =========   =========           ====================
  08-10-2013  JCarmona.SAO219252  Se modifica para que no muestre en la venta
                                  los articulos con plan de financiacion vencido.
  02-10-2013  JCarmona.SAO218021  Se adiciona los items genericos para que sean
                                  visibles en Ayuda Venta.
  09-09-2013  lfernandez.SAO216609 Se elimina condicion que el codigo de los
                                  articulos no sea el de los items genericos.
                                  Este metodo es usado en venta y en ayuda de
                                  venta, por lo que venta hara este filtro
  06-09-2013  mmira.SAO214195     Se impacta por modificacion en ld_bcnonbankfinancing.fnuvalsha_geo.
  04-09-2013  mmira.SAO214195     Se adiciona el parametro idtDate.
  04-09-2013 vhurtadoSAO214540    Se modifica para que si es el proveedor Exito,
                                  solo incluir el item generico (SHOWN_ARTICLE_EX)
                                  si no es el exito, la consulta queda como estaba antes
  ******************************************************************/
  PROCEDURE getAvalibleArticle(inuContractorId    ge_contratista.id_contratista%type,
                               inugeogra_location ld_price_list_deta.geograp_location_id%type,
                               inuSale_Chanel_Id  ld_price_list_deta.sale_chanel_id%type,
                               inuCategori_Id     Categori.Catecodi%type,
                               inuSubcateg_Id     Subcateg.Sucacodi%type,
                               ocuArtList         out constants.tyrefcursor,
                               idtDate            DATE default sysdate) is
  
    --declaracion de variable
    nuval            number := 0;
    sbCondGenItemsEx varchar2(2000);
    sbItemsGeneric   varchar2(4000);
  
  BEGIN
  
    ut_trace.trace('Inicio LDC_CALCULACUPOBRILLA.getAvalibleArticle', 10);
  
    ut_trace.trace('Contratista: ' || inuContractorId, 10);
  
    ut_trace.trace('Ubicacion: ' || inugeogra_location, 10);
  
    ut_trace.trace('Canal de Venta: ' || inuSale_Chanel_Id, 10);
  
    ut_trace.trace('Categoria: ' || inuCategori_Id, 10);
  
    ut_trace.trace('Subcategoria: ' || inuSubcateg_Id, 10);
  
    --identifica si tiene catalogo
    SELECT count(*)
      INTO nuval
      FROM ld_catalog d
     WHERE d.sale_contractor_id = inuContractorId;
  
    ----Para el Exito, solo incluir items genericos.
    --si no es el exito, la consulta queda como estaba antes
    sbCondGenItemsEx := ' ';
  
    IF dald_parameter.fnuGetNumeric_Value('CODI_CUAD_EXITO', 0) =
       inuContractorId THEN
      sbCondGenItemsEx := ' and d.article_id = ' ||
                          dald_parameter.fnuGetNumeric_Value('SHOWN_ARTICLE_EX',
                                                             1) || ' ';
    END IF;
  
    /* Obtiene los items genericos */
    sbItemsGeneric := ' where d.article_id in (' ||
                      dald_parameter.fsbGetValue_Chain('COD_GENERIC_ITEMS') ||
                      ' ) ';
  
    ut_trace.trace('sbItemsGeneric: ' || sbItemsGeneric, 10);
  
    if nuval > 0 then
      OPEN ocuArtList FOR 'select /*+ index(c IX_LD_CATALOG01 ) index(d IX_LD_ARTICLE_04) */  d.article_id,
                    d.description,
                    d.supplier_id,
                    dage_contratista.fsbGetNombre_Contratista(d.supplier_id, 0) NOMBRE_PROVEEDOR,
                    PR.PRICE_APROVED PRICE,
                    ld_bcnonbankfinancing.fsbInfoPlanDife(d.article_id,
                                                       D.SUBLINE_ID,
                                                       :inugeogra_location,
                                                       :inuSale_Chanel_Id,
                                                       :inuCategori_Id,
                                                       :inuSubcateg_Id,
                                                       ''' || idtDate || ''') INFO_PLAN_DIFE,
                    nvl(D.vat, 0),
                    DALD_SUBLINE.fnuGetLine_Id(D.SUBLINE_ID, 0) LINEID,
                    D.SUBLINE_ID,
                    d.supplier_id SUPPLIERID,
                    D.FINANCIER_ID
                FROM    ld_article d,
                    (select /*+ ordered */ l.supplier_id, article_id, price_aproved
                    FROM (select unique supplier_id FROM ld_catalog WHERE sale_contractor_id = :inuContractorId) c,
                    ld_price_list l, ld_price_list_deta ld
                    where c.supplier_id = l.supplier_id
                     AND l.price_list_id = ld.price_list_id
                     AND l.approved = ''Y''
                     AND TO_DATE(' || chr(39) || TO_CHAR(idtDate,
                                                               'DD/MM/YYYY') || chr(39) || ',''DD/MM/YYYY'') BETWEEN TRUNC(L.INITIAL_DATE) AND TRUNC(L.FINAL_DATE)
                     AND ld_bcnonbankfinancing.fnuvalsha_geo(ld.article_id,
                                                             :inuSale_Chanel_Id,
                                                             :inugeogra_location,
                                                             l.supplier_id,
                                                             ''' || idtDate || ''') = ld.price_list_deta_id) pr
                    , (select unique supplier_id FROM ld_catalog WHERE sale_contractor_id = :inuContractorId)  c
                where   d.supplier_id = c.supplier_id
                and d.active = ''Y''
                and d.avalible = ''Y''
                and d.approved = ''Y''
                and d.price_control = ''Y''
                and ld_bcnonbankfinancing.fnuValld_catalog(:inuContractorId,
                                                        d.supplier_id,
                                                        d.subline_id,
                                                        d.article_id) = 1
                and ld_bcnonbankfinancing.fnuvalld_segment_categ(d.subline_id,
                                                              :inuCategori_Id,
                                                              :inuSubcateg_Id) = 1
                and d.supplier_id = pr.supplier_id
                and d.article_id = pr.article_id

                union

                select /*+ index(c IX_LD_CATALOG01 ) index(d IX_LD_ARTICLE_04) */ d.article_id,
                    d.description,
                    d.supplier_id,
                    dage_contratista.fsbGetNombre_Contratista(d.supplier_id, 0) NOMBRE_PROVEEDOR,
                    0 PRICE,
                    ld_bcnonbankfinancing.fsbInfoPlanDife(d.article_id,
                                                       D.SUBLINE_ID,
                                                       :inugeogra_location,
                                                       :inuSale_Chanel_Id,
                                                       :inuCategori_Id,
                                                       :inuSubcateg_Id,
                                                       ''' || idtDate || ''') INFO_PLAN_DIFE,
                    nvl(D.vat, 0),
                    DALD_SUBLINE.fnuGetLine_Id(D.SUBLINE_ID, 0) LINEID,
                    D.SUBLINE_ID,
                    d.supplier_id SUPPLIERID,
                    D.FINANCIER_ID
                from ld_article d, (select unique supplier_id FROM ld_catalog WHERE sale_contractor_id = :inuContractorId) c
                where  d.supplier_id  = c.supplier_id
                and d.active = ''Y''
                and d.avalible = ''Y''
                and d.approved = ''Y''
                and d.price_control = ''N''
                and ld_bcnonbankfinancing.fnuValld_catalog(:inuContractorId,
                                                        d.supplier_id,
                                                        d.subline_id,
                                                        d.article_id) = 1
                and ld_bcnonbankfinancing.fnuvalld_segment_categ(d.subline_id,
                                                              :inuCategori_Id,
                                                              :inuSubcateg_Id) = 1'
      /****************/
      || ' UNION
                select d.article_id,
                    d.description,
                    d.supplier_id,
                    dage_contratista.fsbGetNombre_Contratista(d.supplier_id, 0) NOMBRE_PROVEEDOR,
                    0 PRICE,
                    ld_bcnonbankfinancing.fsbInfoPlanDife(d.article_id,
                                                         D.SUBLINE_ID,
                                                         :inugeogra_location,
                                                         :inuSale_Chanel_Id,
                                                         :inuCategori_Id,
                                                         :inuSubcateg_Id,
                                                         ''' || idtDate || ''') INFO_PLAN_DIFE,
                    nvl(D.vat, 0),
                    DALD_SUBLINE.fnuGetLine_Id(D.SUBLINE_ID, 0) LINEID,
                    D.SUBLINE_ID,
                    d.supplier_id SUPPLIERID,
                    D.FINANCIER_ID
                from ld_article d
                ' || sbItemsGeneric
      /*********************/
      
        using inugeogra_location, inuSale_Chanel_Id, inuCategori_Id, inuSubcateg_Id, inuContractorId, inuSale_Chanel_Id, inugeogra_location, inuContractorId, inuContractorId, inuCategori_Id, inuSubcateg_Id, inugeogra_location, inuSale_Chanel_Id, inuCategori_Id, inuSubcateg_Id, inuContractorId, inuContractorId, inuCategori_Id, inuSubcateg_Id, inugeogra_location, inuSale_Chanel_Id, inuCategori_Id, inuSubcateg_Id;
    else
      /*Abro el cursor y no lo cierro para poder retornar en la variable de salida
      directamente los registros*/
      -------------------cuando es proveedor
      OPEN ocuArtList FOR 'select d.article_id,
                     d.description,
                     d.supplier_id,
                     dage_contratista.fsbgetNombre_contratista(d.supplier_id, 0) NOMBRE_PROVEEDOR,
                     PR.PRICE_APROVED PRICE,
                     ld_bcnonbankfinancing.fsbInfoPlanDife(d.article_id,
                                                           D.SUBLINE_ID,
                                                           :inugeogra_location,
                                                           :inuSale_Chanel_Id,
                                                           :inuCategori_Id,
                                                           :inuSubcateg_Id,
                                                           ''' || idtDate || ''') INFO_PLAN_DIFE,
                     nvl(D.vat, 0),
                     DALD_SUBLINE.fnuGetLine_Id(D.SUBLINE_ID, 0) LINEID,
                     D.SUBLINE_ID,
                     d.supplier_id SUPPLIERID,
                     D.FINANCIER_ID
                from ld_article d,
                     (select supplier_id, article_id, price_aproved
                        from ld_price_list l, ld_price_list_deta ld
                       where l.price_list_id = ld.price_list_id
                         and l.approved = ''Y''
                         AND TO_DATE(' || chr(39) || TO_CHAR(idtDate,
                                                                   'DD/MM/YYYY') || chr(39) || ',''DD/MM/YYYY'') BETWEEN TRUNC(L.INITIAL_DATE) AND TRUNC(L.FINAL_DATE)
                         AND ld_bcnonbankfinancing.fnuvalsha_geo(ld.article_id,
                                                                 :inuSale_Chanel_Id,
                                                                 :inugeogra_location,
                                                                 l.supplier_id,
                                                                 ''' || idtDate || ''') = ld.price_list_deta_id) pr
                where d.supplier_id = :inuContractorId
                 and d.active = ''Y''
                 and d.avalible = ''Y''
                 and d.approved = ''Y''
                 AND D.PRICE_CONTROL = ''Y''
                 and ld_bcnonbankfinancing.fnuvalld_segment_categ(d.subline_id,
                                                                  :inuCategori_Id,
                                                                  :inuSubcateg_Id) = 1
                 and d.supplier_id = pr.supplier_id
                 and d.article_id = pr.article_id' || sbCondGenItemsEx || ' UNION
                    select d.article_id,
                d.description,
                d.supplier_id,
                dage_contratista.fsbGetNombre_Contratista(d.supplier_id, 0) NOMBRE_PROVEEDOR,
                0 PRICE,
                ld_bcnonbankfinancing.fsbInfoPlanDife(d.article_id,
                                                     D.SUBLINE_ID,
                                                     :inugeogra_location,
                                                     :inuSale_Chanel_Id,
                                                     :inuCategori_Id,
                                                     :inuSubcateg_Id,
                                                     ''' || idtDate || ''') INFO_PLAN_DIFE,
                nvl(D.vat, 0),
                DALD_SUBLINE.fnuGetLine_Id(D.SUBLINE_ID, 0) LINEID,
                D.SUBLINE_ID,
                d.supplier_id SUPPLIERID,
                D.FINANCIER_ID
            from ld_article d
            where d.active = ''Y''
            and d.avalible = ''Y''
            and d.approved = ''Y''
            and d.price_control = ''N''
            AND d.supplier_id = :inuContractorId
            and ld_bcnonbankfinancing.fnuvalld_segment_categ(d.subline_id,
                                                                  :inuCategori_Id,
                                                                  :inuSubcateg_Id) = 1' || sbCondGenItemsEx
      /****************/
      || ' UNION
                select d.article_id,
                    d.description,
                    d.supplier_id,
                    dage_contratista.fsbGetNombre_Contratista(d.supplier_id, 0) NOMBRE_PROVEEDOR,
                    0 PRICE,
                    ld_bcnonbankfinancing.fsbInfoPlanDife(d.article_id,
                                                         D.SUBLINE_ID,
                                                         :inugeogra_location,
                                                         :inuSale_Chanel_Id,
                                                         :inuCategori_Id,
                                                         :inuSubcateg_Id,
                                                         ''' || idtDate || ''') INFO_PLAN_DIFE,
                    nvl(D.vat, 0),
                    DALD_SUBLINE.fnuGetLine_Id(D.SUBLINE_ID, 0) LINEID,
                    D.SUBLINE_ID,
                    d.supplier_id SUPPLIERID,
                    D.FINANCIER_ID
                from ld_article d
                ' || sbItemsGeneric
      /*********************/
        using inugeogra_location, inuSale_Chanel_Id, inuCategori_Id, inuSubcateg_Id, inuSale_Chanel_Id, inugeogra_location, inuContractorId, inuCategori_Id, inuSubcateg_Id, inugeogra_location, inuSale_Chanel_Id, inuCategori_Id, inuSubcateg_Id, inuContractorId, inuCategori_Id, inuSubcateg_Id, inugeogra_location, inuSale_Chanel_Id, inuCategori_Id, inuSubcateg_Id;
    end if;
  
    ut_trace.trace('Finaliza LDC_CALCULACUPOBRILLA.getAvalibleArticle', 10);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END getAvalibleArticle;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
  
   Unidad         : fsbSublines
   Descripcion    : Funci?n que retorna todas las sublineas asociadas a un contratista de venta
  
   Autor          : Evens Herard Gorut.
   Fecha          : 02/11/2012
  
   Parametros              Descripcion
   ============         ===================
   inuContractor_id     Id del contratista de venta
  
   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========       =========           ====================
  ******************************************************************/
  FUNCTION fsbSublines(inuContractor_id ld_catalog.sale_contractor_id%type)
    return varchar2 is
    --Variable de salida
    sbAllItems varchar2(2000);
  
  BEGIN
    ut_trace.trace('Inicia LDC_CALCULACUPOBRILLA.fsbSublines', 10);
  
    sbAllItems := Ld_Bcnonbankfinancing.fsbSublines(inuContractor_id);
  
    ut_trace.trace('Finaliza LDC_CALCULACUPOBRILLA.fsbSublines', 10);
  
    return sbAllItems;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
    
  END fsbSublines;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : ftbgetAvalibleArticle
  Descripcion    : Obtener los articulos vigentes.
  
  Autor          : AdoJim
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId: Numero de la solicitud.
  
  
    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========   =========               ====================
    19-01-2013  AEcheverrySAO230074     Se modifica para no tener en cuenta los
                                        conceptos de interes en una refinanciacion,
                                        ni el concepto de seguro deudores
    27-11-2013  sgomez.SAO224773        Se modifica obtencion de cupo usado para
                                        que SOLO tenga en cuenta las cuotas de
                                        diferido, al momento de calcular el
                                        saldo no pagado.
                                        Bajo la premisa anterior NO se tiene en
                                        cuenta el caso de pago parcial, es decir,
                                        si la cuota no esta saldada en su
                                        totalidad NO se le reduce el cupo usado
                                        al cliente.
  
    10-09-2013  lfernandez.SAO213761    Se elimina restarle los pagos
  ******************************************************************/
  FUNCTION fnuGetUsedQuote(inuSusc in suscripc.susccodi%type) return number IS
    nuDeferredValue number := 0;
    nuAccount       number := 0;
    nuItemsValue    number := 0;
    nuSaleValue     number;
    nuTrasnferValue number := 0;
    nuPackId        mo_packages.package_id%type;
    nuInitQuota     ld_non_ba_fi_requ.payment%type;
    nuPending       number;
  
    -- constantes Sentencias Aecheverry
    csbAnull          Constant ld_item_work_order.state%type := 'AN';
    cnuRegisterStatus Constant OR_order_status.order_status_id%type := 0;
    cnuAssignStatus   Constant OR_order_status.order_status_id%type := 5;
    cnuCloseStatus    Constant OR_order_status.order_status_id%type := 8;
    cnuMotiveStatus   Constant ps_motive_status.motive_status_id%type := 13;
    cnuZero           constant number := 0;
    cnuConcSegVid     constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('COD_CON_SEG');
  
    /********************************************
    analisis de rendimiento aecheverry
    *********************************************/
    cursor cuDeferredFNB(inususc in suscripc.susccodi%type) is
      SELECT sum(difesape) valor
        FROM diferido d, servsusc s /*+LDC_CALCULACUPOBRILLA.fnuGetUsedQuote*/
       WHERE d.difesape > cnuZero
         AND difesusc = sesususc
         AND sesuserv in (cnuTypoPrBr, cnuTypoPrBrPG)
         AND difesusc = inususc
         AND difenuse = sesunuse
         AND difeconc not in
             (select conccore
                FROM concepto
               WHERE conccodi in (select conccoin FROM concepto))
         AND difeconc <> cnuConcSegVid;
  
    CURSOR cuCollectionAccount(inuSusc       in suscripc.susccodi%type,
                               inuServPrBr   in servicio.servcodi%type,
                               inuServPrBrPG in servicio.servcodi%type) IS
      SELECT /*+
                          ordered
                          use_nl(servsusc cuencobr cargos)
                          index_rs_asc(servsusc IX_SERVSUSC12)
                          index_rs_asc(cuencobr IX_CUENCOBR03)
                          index_rs_asc(cargos IX_CARGOS02)
                      */
       sum(cargvalo)
        FROM servsusc, cuencobr, cargos /*+LDC_CALCULACUPOBRILLA.fnuGetUsedQuote*/
       WHERE sesususc = inuSusc
         AND sesuserv in (inuServPrBr, inuServPrBrPG)
         AND sesunuse = cuconuse
         AND cucosacu > 0
         AND cucocodi = cargcuco
         AND cargdoso like 'DF-%'
         AND cargsign = 'DB'
         AND cargtipr = 'A';
  
    cursor cuFNBOrderActivItem(inususc in suscripc.susccodi%type) is
      SELECT p.package_id,
             r.payment cuota_inicial,
             sum((nvl(l.amount, 0) * nvl(l.value, 0)) + nvl(l.iva, 0)) Value_Item
        FROM /*+LDC_CALCULACUPOBRILLA.fnuGetUsedQuote*/ or_order           o,
             ld_item_work_order l,
             or_order_activity  a,
             mo_packages        p,
             ld_non_ba_fi_requ  r
       WHERE o.order_Status_Id in
             (cnuRegisterStatus, cnuAssignStatus, cnuCloseStatus)
         AND a.subscription_id = inususc
         AND o.order_id = a.order_id
         and a.order_activity_id = l.order_activity_id
         and a.activity_id = cnuActivityTypeFNB
         AND a.package_id = p.package_id
         AND p.motive_status_id = cnuMotiveStatus
         AND l.state <> csbAnull
         AND r.non_ba_fi_requ_id = p.package_id
         AND not exists
       (SELECT *
                FROM ld_item_work_order i1, OR_order_activity a1
               WHERE a1.order_activity_id = i1.order_activity_id
                 AND a1.activity_id = cnuActivityTypeDelFNB
                 AND i1.difecodi IS not null
                 AND a1.origin_activity_id = l.order_activity_id)
       GROUP BY p.package_id, value_total, r.payment;
  
    cursor cuFNBSaleValue(inuPackageId in mo_packages.package_id%type) is
      SELECT sum((nvl(l.amount, cnuZero) * nvl(l.value, cnuZero)) +
                 nvl(l.iva, cnuZero)) Value_Item
        FROM /*+LDC_CALCULACUPOBRILLA.fnuGetUsedQuote*/ or_order           o,
             ld_item_work_order l,
             or_order_activity  a
       WHERE o.order_id = a.order_id
         and a.order_activity_id = l.order_activity_id
         AND a.package_id = inuPackageId
         AND l.state <> csbAnull
         and a.activity_id = cnuActivityTypeFNB;
  
  BEGIN
  
    ut_trace.trace('Inicia LDC_CALCULACUPOBRILLA.fnuGetUsedQuote', 10);
  
    open cuDeferredFNB(inuSusc);
    fetch cuDeferredFNB
      INTO nuDeferredValue;
    close cuDeferredFNB;
  
    nuDeferredValue := nvl(nuDeferredValue, 0);
  
    ut_trace.trace('Diferidos ' || nuDeferredValue, 10);
  
    open cuCollectionAccount(inuSusc,
                             LDC_CALCULACUPOBRILLA.cnuTypoPrBr,
                             LDC_CALCULACUPOBRILLA.cnuTypoPrBrPG);
    fetch cuCollectionAccount
      INTO nuAccount;
    close cuCollectionAccount;
  
    nuAccount := nvl(nuAccount, 0);
    ut_trace.trace('Cuotas de financiacion no pagadas ' || nuAccount, 10);
  
    nuTrasnferValue := LD_BOQueryFNB.fnugetCededValue(inuSusc);
  
    ut_trace.trace('Cupo cedido: ' || nuTrasnferValue, 10);
  
    open cuFNBOrderActivItem(inuSusc);
  
    LOOP
      fetch cuFNBOrderActivItem
        INTO nuPackId, nuInitQuota, nuPending;
      EXIT WHEN cuFNBOrderActivItem%notfound;
    
      ut_trace.trace('Solicitud: ' || nuPackId || ' Cuota Inicial: ' ||
                     nuInitQuota || ' Valor Pendiente: ' || nuPending,
                     20);
    
      open cuFNBSaleValue(nuPackId);
      fetch cuFNBSaleValue
        INTO nuSaleValue;
      close cuFNBSaleValue;
    
      ut_trace.trace('Valor total venta: ' || nuSaleValue, 20);
    
      nuInitQuota := nuInitQuota * nuPending / nuSaleValue;
    
      ut_trace.trace('Proporcion Cuota Inicial: ' || nuInitQuota, 20);
    
      nuItemsValue := nuItemsValue + (nuPending - nuInitQuota);
    
      ut_trace.trace('Valor cupo usado por venta: ' || nuItemsValue, 20);
    
    END LOOP;
  
    close cuFNBOrderActivItem;
  
    ut_trace.trace('Total pendiente por diferir: ' || nuItemsValue, 10);
  
    ut_trace.trace('Finaliza LDC_CALCULACUPOBRILLA.fnuGetUsedQuote ', 10);
  
    return(nuDeferredValue + nuAccount + nuItemsValue + nuTrasnferValue);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuGetUsedQuote;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuGetOrderInstall
  Descripcion    : Genera las ordenes de instalaci?n para los items que lo requieran.
  
  Autor          : AdoJim
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuorder:            Orden de trabajo.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuGetOrderInstall(inuorder in or_order.order_id%type)
    return number IS
  
    tbOrdersInstall ld_bcnonbankfinancing.tytbOrdersItems;
    nuIndex         number := 0;
    inuorder_id     or_order.order_id%type;
    inuorderact_id  or_order_activity.order_activity_id%type;
  
  BEGIN
  
    tbOrdersInstall := ld_bcnonbankfinancing.ftbGenOrderInstall(inuorder => inuorder);
    nuIndex         := tbOrdersInstall.first;
    while nuIndex <= tbOrdersInstall.last loop
      if tbOrdersInstall(nuIndex).install_required = 'Y' then
        /*Genera Orden de instalaci?n*/
        or_boorderactivities.createactivity(inuitemsid          => ld_boconstans.cnuActivityInstall,
                                            inupackageid        => tbOrdersInstall(nuIndex)
                                                                   .package_id,
                                            inumotiveid         => tbOrdersInstall(nuIndex)
                                                                   .motive_id,
                                            inucomponentid      => null,
                                            inuinstanceid       => null,
                                            inuaddressid        => tbOrdersInstall(nuIndex)
                                                                   .external_address_id,
                                            inuelementid        => null,
                                            inusubscriberid     => tbOrdersInstall(nuIndex)
                                                                   .subscriber_id,
                                            inusubscriptionid   => tbOrdersInstall(nuIndex)
                                                                   .subscription_id,
                                            inuproductid        => tbOrdersInstall(nuIndex)
                                                                   .product_id,
                                            inuopersectorid     => null,
                                            inuoperunitid       => null,
                                            idtexecestimdate    => null,
                                            inuprocessid        => null,
                                            isbcomment          => null,
                                            iblprocessorder     => false,
                                            inupriorityid       => null,
                                            ionuorderid         => inuorder_id,
                                            ionuorderactivityid => inuorderact_id,
                                            inuordertemplateid  => null,
                                            isbcompensate       => null,
                                            inuconsecutive      => null,
                                            inurouteid          => null,
                                            inurouteconsecutive => null,
                                            inulegalizetrytimes => null,
                                            isbtagname          => null,
                                            iblisacttogroup     => false,
                                            inurefvalue         => null);
      end if;
    
      daor_order_activity.updOrigin_Activity_Id(inuorderact_id,
                                                tbOrdersInstall(nuIndex)
                                                .order_activity_id);
      nuIndex := tbOrdersInstall.next(nuIndex);
    end loop;
  
    return inuorder_id;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuGetOrderInstall;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuGetOrderInstall
  Descripcion    : Genera las ordenes de instalaci?n para los items que lo requieran.
  
  Autor          : AdoJim
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuorder:            Orden de trabajo.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuGetDebtInstall(inuSubscription in suscripc.susccodi%type)
    return number IS
  
    tbDetbInstall   ld_bcnonbankfinancing.tytbDebtInstall;
    nuIndex         number := 0;
    inuValueInstall diferido.difesape%type;
  
  BEGIN
  
    tbDetbInstall := ld_bcnonbankfinancing.ftbDebtInstall(inuSubscription => inuSubscription);
    nuIndex       := tbDetbInstall.first;
    while nuIndex < tbDetbInstall.last loop
      --if tbOrdersInstall(nuIndex).install_required = 'Y' then
      inuValueInstall := inuValueInstall +
                         nvl(tbDetbInstall(nuIndex).difesape, 0);
      nuIndex         := tbDetbInstall.next(nuIndex);
    end loop;
  
    return inuValueInstall;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuGetDebtInstall;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : ftbgetExtraQuoteBySubs
  Descripcion    : Devuelve deuda de instalaci?n.
  
  Autor          : AdoJim
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription        Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor               Modificacion
  =========         =========           ====================
  18/10/2013        JCarmona.SAO220573  Se modifica para que retorne el cupo extra
                                        de los proveedores del contratista cuando
                                        la clasificacion es 70 y retorne el cupo
                                        extra del proveedor cuando la clasificacion
                                        es 71.
  ******************************************************************/
  FUNCTION frfgetExtraQuoteBySubs(inuSubscription in suscripc.susccodi%type)
    return constants.tyrefcursor IS
  
    nuGASProduct      number;
    rcab_address      daab_address.styAB_address;
    sbParentsGeoLoc   varchar2(2000);
    sbSelect          varchar2(5000);
    sbFrom            varchar2(5000);
    sbWhere           varchar2(5000);
    SbSQL             varchar2(5000);
    cuCursor          constants.tyrefcursor;
    rcServ            servsusc%rowtype;
    rcProduct         dapr_product.stypr_product;
    nuQuotaValue      ld_quota_by_subsc.quota_value%type;
    nuOperatingUnitId or_operating_unit.operating_unit_id%type;
    rcOperatingUnit   daor_operating_unit.styor_operating_unit;
  
  BEGIN
    ut_trace.trace('INICIO LDC_CALCULACUPOBRILLA.frfgetExtraQuoteBySubs[' ||
                   inuSubscription || ']',
                   1);
  
    nuGASProduct := LDC_CALCULACUPOBRILLA.fnugetGasProduct(inuSubscription => inuSubscription);
  
    if nuGASProduct is not null then
      rcServ    := pktblservsusc.frcGetRecord(nuGASProduct);
      rcProduct := dapr_product.frcGetRecord(nuGASProduct);
    
      rcab_address := daab_address.frcGetRecord(inuAddress_Id => rcProduct.ADDRESS_ID);
    
      if rcab_address.NEIGHBORTHOOD_ID is not null AND
         rcab_address.NEIGHBORTHOOD_ID != ld_boconstans.cnuallrows then
        ge_bogeogra_location.getgeograpparents(inuChildGeoLocId => rcab_address.NEIGHBORTHOOD_ID,
                                               isbText          => sbParentsGeoLoc);
      elsif rcab_address.GEOGRAP_LOCATION_ID is not null then
        ge_bogeogra_location.getgeograpparents(inuChildGeoLocId => rcab_address.GEOGRAP_LOCATION_ID,
                                               isbText          => sbParentsGeoLoc);
      else
        sbParentsGeoLoc := ' nvl( l.geograp_location_id, l.geograp_location_id) ';
      end if;
    
    else
    
      rcServ.Sesucate := 0;
    
      rcServ.Sesusuca := 0;
    
      sbParentsGeoLoc := 0;
    
    end if;
  
    select ld_quota_by_subsc.quota_value
      into nuQuotaValue
      from ld_quota_by_subsc
     where ld_quota_by_subsc.subscription_id = inuSubscription;
  
    sbSelect := 'select  line_id||decode(line_id, null, null,''-'') || dald_line.fsbGetDescription(line_id,0),
                subline_id||decode(subline_id, null, null,''-'') || dald_subline.fsbGetDescription(subline_id,0),
                supplier_id||decode(supplier_id, null, null,''-'') || dage_contratista.fsbgetnombre_contratista(supplier_id,0),
                sale_chanel_id||decode(sale_chanel_id, null, null,''-'') || dage_reception_type.fsbGetDescription(sale_chanel_id,0),
                (LDC_CALCULACUPOBRILLA.fnuQuotaTotal(' ||
                nuQuotaValue ||
                ',value,l.quota_option))- nvl(f.used_quota,0) ,
                initial_date, final_date, nvl(line_id,0), nvl(subline_id,0), nvl(supplier_id,0), nvl(sale_chanel_id,0), l.extra_quota_id ';
    sbFrom   := 'from ld_extra_quota l, ld_extra_quota_fnb f ';
    sbWhere  := 'where l.extra_quota_id = f.extra_quota_id(+)
                AND f.subscription_id(+) = ' ||
                inuSubscription || '
                AND (l.category_id is null or l.category_id = ' ||
                to_char(rcServ.Sesucate) ||
                ') and (l.subcategory_id is null or l.subcategory_id = ' ||
                to_char(rcServ.Sesusuca) ||
                ') and (l.geograp_location_id is null or l.geograp_location_id in (' ||
                sbParentsGeoLoc ||
                ' )) and trunc(sysdate) between trunc(l.initial_date) and trunc(l.final_date)';
  
    /* Se obtiene el canal de venta del usuario conectado */
    open cuGetunitBySeller;
    fetch cuGetunitBySeller
      INTO nuOperatingUnitId;
    close cuGetunitBySeller;
  
    ut_trace.trace('nuOperatingUnitId: ' || nuOperatingUnitId, 1);
  
    /* Se obtiene el registro de la unidad operativa */
    rcOperatingUnit := daor_operating_unit.frcgetrcdata(nuOperatingUnitId);
  
    ut_trace.trace('Contractor_id: ' || rcOperatingUnit.contractor_id, 1);
    ut_trace.trace('Clasificacion: ' ||
                   rcOperatingUnit.oper_unit_classif_id,
                   1);
  
    /* Si la clasificacion de la unidad operativa es 70 - Contratista de Venta de Brilla,
    se debe mostrar el cupo extra de todos los proveedores que tenga autorizado vender */
  
    IF rcOperatingUnit.oper_unit_classif_id = 70 THEN
      /* Se obtienen los proveedores del contratista */
      sbWhere := sbWhere ||
                 ' AND (l.supplier_id in
                                (select supplier_id FROM ld_catalog
                                WHERE sale_contractor_id = ' ||
                 rcOperatingUnit.contractor_id || ')
                                OR l.supplier_id IS null)';
    END IF;
  
    /* Si la clasificacion de la unidad operativa es 71 - Proveedor de Brilla,
    se debe mostrar el cupo extra configurado para el mismo */
  
    IF rcOperatingUnit.oper_unit_classif_id = 71 THEN
      sbWhere := sbWhere || ' AND (l.supplier_id = ' ||
                 rcOperatingUnit.contractor_id ||
                 ' OR l.supplier_id IS null)';
    
    END IF;
  
    SbSQL := sbSelect || sbFrom || sbWhere;
  
    dbms_output.put_line(SbSQL);
  
    OPEN cuCursor FOR sbSql;
  
    ut_trace.trace('FIN LDC_CALCULACUPOBRILLA.frfgetExtraQuoteBySubs', 1);
  
    return cuCursor;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END frfgetExtraQuoteBySubs;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : dataCreditQuota
  Descripcion    : Datos de cupo de credito
  
  Autor          : Alex Valencia Ayola
  Fecha          : 16/11/2012
  
  Parametros              Descripcion
  ============         ===================
  inuIdentType        Tipo de identificacion
  inuIdentification   Identificacion
  onuSusccodi         Contrato
  onuAssignedQuote    Cupo asignado
  onuUsedQuote        Cupo usado
  onuAvalibleQuote    Cupo disponible
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE CreditQuotaData(inuIdentType      IN ge_subscriber.ident_type_id%TYPE,
                            inuIdentification IN ge_subscriber.identification%TYPE,
                            onuSusccodi       OUT suscripc.susccodi%TYPE,
                            onuAssignedQuote  OUT NUMBER,
                            onuUsedQuote      OUT NUMBER,
                            onuAvalibleQuote  OUT NUMBER) IS
    CURSOR cuContrato IS
      SELECT suscripc.susccodi
        FROM suscripc, ge_subscriber, pr_product, ps_product_status
       WHERE suscripc.suscclie = ge_subscriber.subscriber_id
         AND suscripc.susccodi = pr_product.subscription_id
         AND pr_product.product_status_id =
             ps_product_status.product_status_id
         AND ps_product_status.is_active_product = Ld_Boconstans.csbYesFlag
         AND pr_product.product_id = fnugetGasProduct(suscripc.susccodi)
         AND pr_product.subscription_id = suscripc.susccodi
         AND ge_subscriber.ident_type_id = inuIdentType
         AND ge_subscriber.identification = inuIdentification;
  
    rcContrato cuContrato%ROWTYPE;
  
  BEGIN
  
    OPEN cuContrato;
    --loop
    FETCH cuContrato
      INTO rcContrato;
    AllocateTotalQuota(rcContrato.Susccodi, onuAssignedQuote);
  
    onuSusccodi := rcContrato.Susccodi;
  
    onuUsedQuote     := LDC_CALCULACUPOBRILLA.fnuGetUsedQuote(rcContrato.Susccodi);
    onuAvalibleQuote := onuAssignedQuote - onuUsedQuote;
    --exit when cuContrato%notfound;
  
    --end loop;
    CLOSE cuContrato;
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END CreditQuotaData;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : frcGetTransferQuotebySubs
  Descripcion    :
  
  Autor          : Evens Herard Gorut.
  Fecha          : 24/10/2012
  
  Parametros             Descripcion
  ============           ===================
  inuSubscription        Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  FUNCTION frcGetTransferQuotebySubs(inususcripc in suscripc.susccodi%type)
    return constants.tyrefcursor is
    --Declaraci?n de variables
    sbSelect varchar2(500);
    sbFrom   varchar2(500);
    sbWhere  varchar2(500);
    SbSQL    varchar2(500);
    cuCursor constants.tyrefcursor;
  BEGIN
    sbSelect := 'select quota_transfer_id, destiny_subscrip_id, origin_subscrip_id,
                order_id, transfer_date, trasnfer_value, final_date, approved ';
    sbFrom   := 'from LD_quota_transfer ';
    sbWhere  := 'where destiny_subscrip_id = ' || inususcripc ||
                ' or origin_subscrip_id = ' || inususcripc;
    SbSQL    := sbSelect || sbFrom || sbWhere;
    OPEN cuCursor FOR sbSql;
    return cuCursor;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END frcGetTransferQuotebySubs;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : createSaleOrderActivity
  Descripcion    : Crea las actividades de venta FNB
  
  Autor          : Eduar Ramos Barragan
  Fecha          : 20/11/2012
  
  Parametros              Descripcion
  ============         ===================
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  20-oct-2013       AEcheverry      Se modifica para generar una actividad por cantidad y no por articulo
  ******************************************************************/
  PROCEDURE createSaleOrderActivity(inuMotive        in mo_motive.motive_id%type,
                                    ionuOrder        in out or_order.order_id%type,
                                    onuOrderActivity out or_order_activity.order_activity_id%type) IS
  
    nuPackage        mo_packages.package_id%type;
    nuActivityTypeId number := ld_boconstans.cnuACTIVITY_TYPE_FNB;
    rcPackage        damo_packages.styMO_packages;
    rcMotive         damo_motive.styMO_motive;
    rcItemRequest    dald_non_ban_fi_item.styLD_non_ban_fi_item;
    rcItemsWork      dald_item_work_order.styLD_item_work_order;
  begin
  
    nuPackage := damo_motive.fnuGetPackage_Id(inuMotive);
    damo_packages.getRecord(nuPackage, rcPackage);
    damo_motive.getRecord(inuMotive, rcMotive);
    dald_non_ban_fi_item.getRecord(inuMotive, rcItemRequest);
    ut_trace.trace('actividad[' || nuActivityTypeId || ']nuPackage: ' ||
                   nuPackage,
                   10);
    ut_trace.trace('inuMotive[' || inuMotive || ']address_id: ' ||
                   rcPackage.address_id,
                   10);
  
    -- informacion de la orden de venta
    rcItemsWork.article_id    := rcItemRequest.article_id;
    rcItemsWork.amount        := 1;
    rcItemsWork.credit_fees   := rcItemRequest.quotas_number;
    rcItemsWork.value         := rcItemRequest.unit_value;
    rcItemsWork.iva           := rcItemRequest.vat;
    rcItemsWork.supplier_id   := rcItemRequest.supplier_id;
    rcItemsWork.finan_plan_id := rcItemRequest.finan_plan_id;
  
    if dald_article.fsbGetInstallation(rcItemRequest.article_id) is not null then
      rcItemsWork.install_required := dald_article.fsbGetInstallation(rcItemRequest.article_id);
    
    else
      rcItemsWork.install_required := ld_boconstans.fsbNoFlag;
    end if;
    rcItemsWork.state := 'RE';
  
    -- no se generan actividades de entrega si no hay nada que entregar
    if (rcItemRequest.amount < 1) then
      ut_trace.trace('Cantidad es menor a 1 , no hay nada que entregar',
                     10);
      return;
    END if;
  
    -- se creara una actividad por cada articulo independiente (X cantidad)
    for x in 1 .. rcItemRequest.amount loop
      onuOrderActivity := null;
      /*Genera Orden de instalacion*/
      or_boorderactivities.createactivity(inuitemsid          => nuActivityTypeId,
                                          inupackageid        => nuPackage,
                                          inumotiveid         => inuMotive,
                                          inucomponentid      => null,
                                          inuinstanceid       => null,
                                          inuaddressid        => rcPackage.address_id,
                                          inuelementid        => null,
                                          inusubscriberid     => rcPackage.subscriber_id,
                                          inusubscriptionid   => rcMotive.subscription_id,
                                          inuproductid        => rcMotive.product_id,
                                          inuopersectorid     => null,
                                          inuoperunitid       => null,
                                          idtexecestimdate    => null,
                                          inuprocessid        => null,
                                          isbcomment          => null,
                                          iblprocessorder     => false,
                                          inupriorityid       => null,
                                          ionuorderid         => ionuOrder,
                                          ionuorderactivityid => onuOrderActivity,
                                          inuordertemplateid  => null,
                                          isbcompensate       => null,
                                          inuconsecutive      => null,
                                          inurouteid          => null,
                                          inurouteconsecutive => null,
                                          inulegalizetrytimes => null,
                                          isbtagname          => null,
                                          iblisacttogroup     => false,
                                          inurefvalue         => null);
    
      rcItemsWork.item_work_order_id := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LD_ITEM_WORK_ORDER',
                                                                            'SEQ_LD_ITEM_WORK_ORDER');
      rcItemsWork.ORDER_ID           := ionuOrder;
      rcItemsWork.order_activity_id  := onuOrderActivity;
      dald_item_work_order.insRecord(rcItemsWork);
    END loop;
  
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END createSaleOrderActivity;

  ------------------------------
  -- GetSubscriptionBasicData
  ------------------------------
  PROCEDURE GetSubscriptionBasicData(inuSubscription   suscripc.susccodi%type,
                                     onuIdentType      out ge_subscriber.ident_type_id%type,
                                     osbIdentification out ge_subscriber.identification%type,
                                     onuSubscriberId   out ge_subscriber.subscriber_id%type,
                                     osbSubsName       out ge_subscriber.subscriber_name%type,
                                     osbSubsLastName   out ge_subscriber.subs_last_name%type,
                                     osbAddress        out ab_address.address_parsed%type,
                                     onuAddress_Id     out ab_address.address_id%type,
                                     onuGeoLocation    out ge_geogra_location.geograp_location_id%type,
                                     osbFullPhone      out ge_subs_phone.full_phone_number%type,
                                     osbCategory       out varchar2,
                                     osbSubcategory    out varchar2,
                                     onuCategory       out Servsusc.Sesucate%type,
                                     onuSubcategory    out Servsusc.Sesusuca%type)
  
   IS
    rcSubscription Suscripc%rowtype;
    rcSubscriber   dage_subscriber.styGE_subscriber;
    rcProduct      dapr_product.stypr_product;
    nuGasProduct   pr_product.product_id%type;
    --nuPhoneId      pr_product.subs_phone_id%type;
    rcServsusc servsusc%rowtype;
  
  BEGIN
    /*Obtiene los datos del contrato.
    Usando el paquete de primer nivel obtiene el registro del contrato.*/
  
    rcSubscription := pktblsuscripc.frcGetRecord(inuSubscription);
  
    onuSubscriberId := rcSubscription.Suscclie;
  
    dage_subscriber.getRecord(rcSubscription.Suscclie, rcSubscriber);
  
    onuIdentType := rcSubscriber.ident_type_id;
  
    osbIdentification := rcSubscriber.identification;
  
    osbSubsName := rcSubscriber.subscriber_name;
  
    osbSubsLastName := rcSubscriber.subs_last_name;
  
    nuGasProduct := fnugetGasProduct(inuSubscription);
  
    if nuGasProduct is not null then
      dapr_product.getrecord(nuGasProduct, rcProduct);
    
      onuAddress_Id := rcProduct.address_id;
    
      onuGeoLocation := daab_address.fnuGetGeograp_Location_Id(onuAddress_Id);
    
      osbAddress := daab_address.fsbGetAddress_Parsed(rcProduct.address_id);
    
      if (rcProduct.Subs_Phone_Id is not null) then
        osbFullPhone := dage_subs_phone.fsbGetFull_Phone_Number(rcProduct.Subs_Phone_Id);
      end if;
    
      rcServsusc := pktblservsusc.frcGetRecord(nuGasProduct);
    
      onuSubcategory := rcServsusc.Sesusuca;
    
      onuCategory := rcServsusc.Sesucate;
    
      osbSubcategory := to_char(rcServsusc.Sesusuca) || ' - ' ||
                        pktblsubcateg.fsbgetdescription(rcServsusc.Sesucate,
                                                        rcServsusc.Sesusuca);
    
      osbCategory := to_char(rcServsusc.Sesucate) || ' - ' ||
                     pktblcategori.fsbgetdescription(rcServsusc.Sesucate);
    
    end if;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetSubscriptionBasicData;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : frcGetDataCancelReq
  Descripcion    : Crea las actividades de venta FNB
  
  Autor          :
  Fecha          : 13/06/2013
  
  Parametros            Descripcion
  ============     ===================
  inuPackageSale : Numero de solicitud de venta
  inuPackageAnnu : Numero de solicitud de anulacion.
  inuOrder       : Numero de la orden
  inuCausal      : Numero de la causal
  
  Historia de Modificaciones
  Fecha             Autor               Modificacion
  =========         =========           ====================
  18-12-2013        AEcheverrySAO228263 Se modifica rendimiento de la sentencia
  11-12-2013        hjgomez.SAO227057   Se agregan hints cuando se ingresan fechas
  22/10/2013        JCarmona.SAO221034  Se modifica para que cuando no exista area
                                        organizacional vigente para el usuario, no
                                        levante error sino que devuelva el CURSOR
                                        vacio.
  13/06/2013                            Creacion
  ******************************************************************/

  FUNCTION frcGetDataCancelReq(inuPackageSale mo_packages.package_id%TYPE,
                               inuPackageAnnu mo_packages.package_id%TYPE,
                               inuOrder       or_order.order_id%type,
                               inuCausal      Number,
                               idtMinSaleDate mo_packages.request_date%type,
                               idtMaxSaleDate mo_packages.request_date%type,
                               idtMinDateAnnu mo_packages.request_date%type,
                               idtMaxDateAnnu mo_packages.request_date%type,
                               inuIdentType   ge_subscriber.ident_type_id%type,
                               isbIdentific   ge_subscriber.identification%type,
                               inuSusccodi    suscripc.susccodi%type)
  
   Return constants.tyrefcursor IS
    sbSqlQuery      VARCHAR2(32000);
    sbWhere         VARCHAR2(32000);
    sbIndex         VARCHAR2(32000);
    blFlag          boolean := false;
    curfData        constants.tyrefcursor;
    nuOperatingUnit or_operating_unit.operating_unit_id%type;
  BEGIN
  
    --Causal
    sbIndex := ' /*+  leading(o) index(o IDX_OR_ORDER_3)  */ ';
    IF (inuCausal IS NOT NULL) THEN
      sbWhere := sbWhere || ' AND c.causal_id = ' || inuCausal;
      blFlag  := TRUE;
    END IF;
  
    --Solictud de venta
    IF (inuPackageSale IS NOT NULL) THEN
      sbIndex := ' /*+ ordered */ ';
      sbWhere := sbWhere || 'AND l.package_sale = ' || inuPackageSale;
      blFlag  := TRUE;
    END IF;
  
    --Fecha minima de venta
    IF idtMinSaleDate IS NOT NULL THEN
      sbIndex := ' /*+  leading(o) index(o IDX_OR_ORDER_3)  */ ';
      sbWhere := sbWhere || ' AND trunc(mpv.request_date) >= to_date(''' ||
                 to_char(idtMinSaleDate, 'DD/MM/YYYY') ||
                 ''',''DD/MM/YYYY'')';
    END IF;
  
    --Fecha maxima de venta
    IF idtMaxSaleDate IS NOT NULL THEN
      sbIndex := ' /*+  leading(o) index(o IDX_OR_ORDER_3)   */ ';
      sbWhere := sbWhere || ' AND trunc(mpv.request_date) <= ''' ||
                 substr(idtMaxSaleDate, 1, 10) || '''';
    ELSE
      sbIndex := ' /*+ leading(o) index(o IDX_OR_ORDER_3)  */ ';
      sbWhere := sbWhere || ' AND trunc(mpv.request_date) <= to_date(''' ||
                 to_char(sysdate, 'DD/MM/YYYY') || ''',''DD/MM/YYYY'')';
    END IF;
  
    --Fecha maxima de anulacion
    IF idtMaxDateAnnu IS NOT NULL THEN
      sbIndex := ' /*+ leading(o) index(o IDX_OR_ORDER_3)  */ ';
      sbWhere := sbWhere || ' AND trunc(mp.request_date) <= to_date(''' ||
                 to_char(idtMaxDateAnnu, 'DD/MM/YYYY') ||
                 ''',''DD/MM/YYYY'')';
    END IF;
  
    --Fecha minima de anulacion
    IF idtMinDateAnnu IS NOT NULL THEN
      sbIndex := ' /*+ leading(o) index(o IDX_OR_ORDER_3)  */ ';
      sbWhere := sbWhere || ' AND trunc(mp.request_date) >= to_date(''' ||
                 to_char(idtMinDateAnnu, 'DD/MM/YYYY') ||
                 ''',''DD/MM/YYYY'')';
    END IF;
  
    --Tipo identificacion - Identificacion
    IF (inuIdentType IS NOT NULL AND isbIdentific IS NOT NULL) THEN
      sbIndex := ' /*+ index(gs IDX_GE_SUBSCRIBER_02) */ ';
      sbWhere := sbWhere || ' AND gs.Identification = ''' || isbIdentific || '''';
      sbWhere := sbWhere || ' AND gs.Ident_Type_Id = ' || inuIdentType;
    END IF;
  
    --Orden
    IF (inuOrder IS NOT NULL) THEN
      sbIndex := ' /*+ index(o PK_OR_ORDER) */ ';
      sbWhere := sbWhere || ' AND o.order_id = ' || inuOrder;
    END IF;
  
    --Solicitud de anulacion
    IF (inuPackageAnnu IS NOT NULL) THEN
      sbIndex := ' /*+ index(mp PK_MO_PACKAGES) */ ';
      sbWhere := sbWhere || ' AND mp.package_id = ' || inuPackageAnnu;
    END IF;
  
    --Contrato
    IF (inuSusccodi IS NOT NULL) THEN
      sbIndex := ' /*+ index(s PK_SUSCRIPC) */ ';
      sbWhere := sbWhere || ' AND s.susccodi = ' || inuSusccodi;
    END IF;
  
    open cuGetunitBySeller;
    fetch cuGetunitBySeller
      INTO nuOperatingUnit;
    close cuGetunitBySeller;
  
    if (nuOperatingUnit IS null) then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El usuario conectado no posee un unidad operativa asociada');
    END if;
  
    sbSqlQuery := 'SELECT ' || sbIndex || ' DISTINCT' || chr(10) ||
                  'ld.order_id orden,' || chr(10) ||
                  'ld.return_item_id "identificador",' || chr(10) ||
                  'decode(l.transaction_type, ''A'', ''Anulacion'', ''Devolucion'') "Anulacion_Devolucion",' ||
                  chr(10) || 'l.package_sale "Solicitud de venta",' ||
                  chr(10) || 'mpv.request_date "Fecha de venta",' ||
                  chr(10) || 'l.register_date "FechaAnulac",' || chr(10) ||
                  'mpv.subscription_pend_id "Contrato",' || chr(10) ||
                  'gs.Subscriber_Name||''  ''||gs.Subs_Last_Name cliente,' ||
                  chr(10) ||
                  'git.Description|| '' - '' ||gs.Identification Identification,' ||
                  chr(10) || 'a.Address_Parsed address,' || chr(10) ||
                  'decode(l.origin_anu_dev,1,''Cliente'',2,''Area fnb'',3,''Grandes superficies'',4,''Proveedor'',5,''Contratista'') Origen,' ||
                  chr(10) || 'c.causal_id||'' ''|| c.description "causal",' ||
                  chr(10) ||
                  'decode(l.approved, ''A'', ''Aprobado'', ''No Aprobado'') "Estado",' ||
                  chr(10) || 'O.task_type_id,' || chr(10) ||
                  'O.task_type_id || '' - '' ||ott.description TASK_TYPE_DESC' ||
                  chr(10) ||
                  'FROM OR_ORDER o,or_order_activity t, ld_return_item l, ld_return_item_detail ld, mo_packages mp, mo_motive mo,' ||
                  chr(10) ||
                  '     mo_packages mpv, pr_product p, ab_address a, suscripc s, ge_subscriber gs,' ||
                  chr(10) ||
                  '     ge_identifica_type git,  or_task_type ott, cc_causal c' ||
                  chr(10) || 'WHERE o.operating_unit_id =' ||
                  nuOperatingUnit || chr(10) ||
                  'AND O.order_status_id = 5 ' || chr(10) ||
                  'AND t.order_id = o.order_id' || chr(10) ||
                  'AND l.package_id = t.package_id' || chr(10) ||
                  'AND ld.return_item_id = l.return_item_id' || chr(10) ||
                  'AND ld.order_activity_id = t.order_activity_id' ||
                  chr(10) ||
                  'AND p.product_id = (SELECT LDC_CALCULACUPOBRILLA.fnugetGasProduct(mpv.subscription_pend_id) FROM dual)' ||
                  chr(10) || 'AND a.address_id = p.address_id' || chr(10) ||
                  'AND s.susccodi = mpv.subscription_pend_id' || chr(10) ||
                  'AND gs.subscriber_id = s.Suscclie' || chr(10) ||
                  'AND git.ident_type_id = gs.Ident_Type_Id' || chr(10) ||
                  'AND mpv.package_id = l.package_sale' || chr(10) ||
                  'AND ott.task_type_id = o.task_type_id' || chr(10) ||
                  'AND c.causal_id = mo.causal_id' || chr(10) ||
                  'AND mp.package_id = l.package_id' || chr(10) ||
                  'AND mo.package_id = mp.package_id' || chr(10) || sbWhere;
  
    ut_trace.trace(sbSqlQuery, 15);
  
    OPEN curfData FOR sbSqlQuery;
    Return curfData;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END frcGetDataCancelReq;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : createDeliveryOrderActivity
  Descripcion    : Crea las actividades de venta FNB
  
  Autor          : Eduar Ramos Barragan
  Fecha          : 20/11/2012
  
  Parametros              Descripcion
  ============         ===================
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE createDeliveryOrderActivity(inuOrderActivity    in or_order_activity.order_activity_id%type,
                                        ionuOrder           in out or_order.order_id%type,
                                        inuOrderActivityDev out or_order_activity.order_activity_id%type
                                        
                                        ) IS
  
    nuActivityTypeId number := ld_boconstans.cnuAct_Type_Del_FNB;
    rcOrderActivy    daor_order_activity.styOR_order_activity;
    tbItemRequest    dald_item_work_order.tytbLD_item_work_order;
    rcItemsWork      dald_item_work_order.styLD_item_work_order;
  begin
  
    ut_trace.trace('Inicia createDeliveryOrderActivity', 10);
  
    daor_order_activity.getRecord(inuOrderActivity, rcOrderActivy);
  
    ut_trace.trace('Se obtendran los datos de la actividad: ' ||
                   inuOrderActivity,
                   10);
  
    dald_item_work_order.getRecords(' ld_item_work_order.order_activity_id = ' ||
                                    inuOrderActivity,
                                    tbItemRequest);
  
    or_boorderactivities.createactivity(inuitemsid          => nuActivityTypeId,
                                        inupackageid        => rcOrderActivy.package_id,
                                        inumotiveid         => rcOrderActivy.motive_Id,
                                        inucomponentid      => null,
                                        inuinstanceid       => null,
                                        inuaddressid        => rcOrderActivy.address_id,
                                        inuelementid        => null,
                                        inusubscriberid     => rcOrderActivy.subscriber_id,
                                        inusubscriptionid   => rcOrderActivy.subscription_id,
                                        inuproductid        => rcOrderActivy.product_id,
                                        inuopersectorid     => null,
                                        inuoperunitid       => null,
                                        idtexecestimdate    => null,
                                        inuprocessid        => null,
                                        isbcomment          => null,
                                        iblprocessorder     => false,
                                        inupriorityid       => null,
                                        ionuorderid         => ionuOrder,
                                        ionuorderactivityid => inuOrderActivityDev,
                                        inuordertemplateid  => null,
                                        isbcompensate       => null,
                                        inuconsecutive      => null,
                                        inurouteid          => null,
                                        inurouteconsecutive => null,
                                        inulegalizetrytimes => null,
                                        isbtagname          => null,
                                        iblisacttogroup     => FALSE,
                                        inurefvalue         => null);
  
    ut_trace.trace('Se creara la actividad de entrega =' ||
                   inuOrderActivityDev,
                   10);
    daor_order_activity.updOrigin_Activity_Id(inuOrderActivityDev,
                                              inuOrderActivity);
  
    -- se obtiene el registro origen
    rcItemsWork := tbItemRequest(tbItemRequest.first);
    -- se obtiene la nueva secuencia para la copia del registro
    rcItemsWork.item_work_order_id := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LD_ITEM_WORK_ORDER',
                                                                          'SEQ_LD_ITEM_WORK_ORDER');
    rcItemsWork.ORDER_ID           := ionuOrder;
    rcItemsWork.order_activity_id  := inuOrderActivityDev;
    rcItemsWork.install_required   := nvl(tbItemRequest(tbItemRequest.first)
                                          .install_required,
                                          'N');
    rcItemsWork.supplier_id        := tbItemRequest(tbItemRequest.first)
                                      .supplier_id;
  
    rcItemsWork.state := tbItemRequest(tbItemRequest.first).state;
    dald_item_work_order.insRecord(rcItemsWork);
  
    ut_trace.trace('Finaliza createDeliveryOrderActivity', 10);
  
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END createDeliveryOrderActivity;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : createReviewOrderActivity
  Descripcion    : Crea las actividades de revicion FNB
  
  Autor          : Eduar Ramos Barragan
  Fecha          : 20/11/2012
  
  Parametros              Descripcion
  ============         ===================
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE createReviewOrderActivity(inuOrderActivity    in or_order_activity.order_activity_id%type,
                                      ionuOrder           in out or_order.order_id%type,
                                      inuOrderActivityRev out or_order_activity.order_activity_id%type
                                      
                                      ) IS
  
    nuActivityTypeId number := ld_boconstans.cnuAct_Type_REV_FNB;
    rcOrderActivy    daor_order_activity.styOR_order_activity;
  begin
  
    daor_order_activity.getRecord(inuOrderActivity, rcOrderActivy);
  
    /*Genera Orden de entrega*/
    or_boorderactivities.createactivity(inuitemsid          => nuActivityTypeId,
                                        inupackageid        => rcOrderActivy.package_id,
                                        inumotiveid         => rcOrderActivy.motive_Id,
                                        inucomponentid      => null,
                                        inuinstanceid       => null,
                                        inuaddressid        => rcOrderActivy.address_id,
                                        inuelementid        => null,
                                        inusubscriberid     => rcOrderActivy.subscriber_id,
                                        inusubscriptionid   => rcOrderActivy.subscription_id,
                                        inuproductid        => rcOrderActivy.product_id,
                                        inuopersectorid     => null,
                                        inuoperunitid       => null,
                                        idtexecestimdate    => null,
                                        inuprocessid        => null,
                                        isbcomment          => null,
                                        iblprocessorder     => false,
                                        inupriorityid       => null,
                                        ionuorderid         => ionuOrder,
                                        ionuorderactivityid => inuOrderActivityRev,
                                        inuordertemplateid  => null,
                                        isbcompensate       => null,
                                        inuconsecutive      => null,
                                        inurouteid          => null,
                                        inurouteconsecutive => null,
                                        inulegalizetrytimes => null,
                                        isbtagname          => null,
                                        iblisacttogroup     => false,
                                        inurefvalue         => null);
  
    daor_order_activity.updOrigin_Activity_Id(inuOrderActivityRev,
                                              inuOrderActivity);
  
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END createReviewOrderActivity;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : legalizeOrderActivity
  Descripcion    : Legaliza actividades de venta
  Autor          : Eduar Ramos Barragan
  Fecha          : 20/11/2012
  
  Parametros              Descripcion
  ============         ===================
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE legalizeOrderActivity(inuOrden        or_order.order_id%type,
                                  inuPerson       or_operating_unit.operating_unit_id%type,
                                  onuError        out ge_message.message_id%type,
                                  osbErrorMessage out ge_message.description%type) IS
  
    sbLegText    varchar2(32000);
    tbActivities daor_order_activity.tytbOR_order_activity;
    --rfActivities    constants.tyrefcursor;
    nuCausal number := 1;
    --nuIndex         number;
    tbactivityitems or_bcorderactivities.tytbactivityitems;
  
  begin
  
    sbLegText := inuOrden || '|' || nuCausal || '|' || inuPerson || '||';
  
    DAOR_ORDER_ACTIVITY.getRecords('ORDER_ID = ' || inuOrden, tbActivities);
  
    /*rfActivities := or_bcorderactivities.frfGetActivitiesByOrder(inuOrden);
    
    fetch rfActivities bulk collect
      into tbActivities;
    
    close rfActivities;*/
  
    or_bolegalizeorder.legalizeorderactivities(inuOrden,
                                               inuPerson,
                                               1,
                                               tbactivityitems,
                                               null,
                                               null);
  
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END legalizeOrderActivity;

  PROCEDURE Dummy IS
  
  begin
    null;
  
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END Dummy;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnugetProductBySubsc
  Descripcion    : funcion que obtiene el identificador del producto
                   dada la suscripcion y el tipo de producto.
  Autor          : Alex Valencia Ayola
  Fecha          : 22/02/2013
  
  Parametros           Descripcion
  ============         ===================
  inuSubscription      Codigo del contrato
  inuProductType       Tipo de producto
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnugetProductBySubsc(inuSubscription IN suscripc.susccodi%TYPE,
                                inuProductType  IN pr_product.product_type_id%TYPE)
    RETURN pr_product.product_id%TYPE IS
  
    tbProduct dapr_product.tytbPR_product;
  BEGIN
  
    tbProduct := pr_bcproduct.ftbGetProdBySubsNType(inuSubscription,
                                                    inuProductType);
  
    IF (tbProduct.count > 0) THEN
      RETURN tbProduct(1).product_id;
    END IF;
  
    RETURN NULL;
  
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END fnugetProductBySubsc;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : frfGetRecords_fnbcr
  Descripcion    : consulta del detalle de articullos a anular o devolver
  Fecha          : 22/02/2013
  
  Parametros           Descripcion
  ============         ===================
  inuSubscription      Codigo del contrato
  inuProductType       Tipo de producto
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  23-oct-2013   AECHEVERRY  se modifica consulta para hacer el join entre actividades de venta y detalle de anulacion
                            sin la orden de entrega
  ******************************************************************/
  FUNCTION frfGetRecords_fnbcr(inufindvalue in LD_RETURN_ITEM_DETAIL.RETURN_ITEM_ID%type)
    RETURN tyRefCursor IS
  
    rfQuery tyRefCursor;
  BEGIN
    open rfQuery for
      select DISTINCT D.ARTICLE_ID || '-' || A.DESCRIPTION "articulo",
                      D.AMOUNT "cantidad",
                      I.VALUE /*+ I.IVA*/ valuetotal,
                      D.ORDER_ACTIVITY_ID "order_activity"
        FROM LD_RETURN_ITEM_DETAIL d,
             LD_ITEM_WORK_ORDER    I,
             LD_RETURN_ITEM        L,
             LD_ARTICLE            A,
             OR_ORDER_ACTIVITY     O
       WHERE D.return_item_id = inufindvalue
         AND D.RETURN_ITEM_ID = L.RETURN_ITEM_ID
         AND I.ARTICLE_ID = D.ARTICLE_ID
         AND d.ACTIVITY_DELIVERY_ID = I.order_activity_id
         AND I.ARTICLE_ID = A.ARTICLE_ID
         AND D.ORDER_ACTIVITY_ID = O.ORDER_ACTIVITY_ID
         AND O.STATUS <> 'F';
    return(rfQuery);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END;

  function fnugetContratid(inufindvalue in mo_packages.package_id%type)
    return number is
    nufind number;
  BEGIN
    /*Obtiene la secuencia*/
    BEGIN
      SELECT subscriber_id
        into nufind
        from mo_packages
       where package_id = inufindvalue;
    EXCEPTION
      when no_data_found then
        nufind := null;
      when others then
        nufind := null;
    END;
  
    return nufind;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnugetContratid;

  PROCEDURE InsertManualQuota(inumanual_quota_id in ld_manual_quota.manual_quota_id%type,
                              inusubscription_id in ld_manual_quota.subscription_id%type,
                              inuquota_value     in ld_manual_quota.quota_value%type,
                              inuinitial_date    in ld_manual_quota.initial_date%type,
                              inufinal_date      in ld_manual_quota.final_date%type,
                              inusupport_file    in ld_manual_quota.support_file%type,
                              inuobservation     in ld_manual_quota.observation%type,
                              inuprint_in_bill   in ld_manual_quota.print_in_bill%type) is
    ircLd_Manual_quota dald_manual_quota.styLD_manual_quota;
  
    --  30 de Junio de 2013 EveSan
    --  Cursor para traer el cupo manual vigente
    Cursor CuCupoManualVigente IS
      select *
        from ld_manual_quota m
       where (((initial_date between
             NVL(TRUNC(inuinitial_date), TRUNC(SYSDATE)) and
             TRUNC(inufinal_date)) or
             ((NVL(final_date, SYSDATE + 9999) between
             NVL(TRUNC(inuinitial_date), TRUNC(SYSDATE)) AND
             (DECODE(TRUNC(inufinal_date),
                         NULL,
                         SYSDATE + 9999,
                         TRUNC(inufinal_date)))))) or
             ( --CONSULTA OPTIMIZADA
              (NVL(TRUNC(inuinitial_date), TRUNC(SYSDATE)) between
              initial_date and NVL(final_date, SYSDATE + 9999)) or
              (DECODE(TRUNC(inufinal_date),
                       NULL,
                       SYSDATE + 9999,
                       TRUNC(inufinal_date)) between initial_date and
              NVL(final_date, SYSDATE + 9999))))
         and subscription_id = inusubscription_id;
  
    -----------------------------
    RegCupoManualVigente CuCupoManualVigente%ROWTYPE;
    Updok                number := 0;
  BEGIN
    FOR RegCupoManualVigente IN CuCupoManualVigente LOOP
    
      IF (trunc(RegCupoManualVigente.initial_date) > trunc(sysdate)) THEN
        Dald_Manual_Quota.delRecord(inuManual_Quota_Id => RegCupoManualVigente.manual_quota_id);
      ELSE
        IF (trunc(RegCupoManualVigente.initial_date) = inuinitial_date) THEN
          ircLd_Manual_quota.manual_quota_id := RegCupoManualVigente.manual_quota_id;
          ircLd_Manual_quota.subscription_id := RegCupoManualVigente.subscription_id;
          ircLd_Manual_quota.quota_value     := inuquota_value;
          ircLd_Manual_quota.initial_date    := inuinitial_date;
          ircLd_Manual_quota.final_date      := inufinal_date;
          ircLd_Manual_quota.support_file    := inusupport_file;
          ircLd_Manual_quota.observation     := inuobservation;
          ircLd_Manual_quota.print_in_bill   := inuprint_in_bill;
          dald_manual_quota.updRecord(ircLD_manual_quota => ircLd_Manual_quota);
          dald_manual_quota.updRecord(ircLd_Manual_quota => ircLd_Manual_quota);
          Updok := 1;
        ELSE
          Dald_Manual_Quota.updFinal_Date(idtFinal_Date$     => TRUNC(inuinitial_date - 1),
                                          inuManual_Quota_Id => RegCupoManualVigente.manual_quota_id);
        
        END IF;
      END IF;
    END LOOP;
    if (Updok = 0) then
      ircLd_Manual_quota.manual_quota_id := inumanual_quota_id;
      ircLd_Manual_quota.subscription_id := inusubscription_id;
      ircLd_Manual_quota.quota_value     := inuquota_value;
      ircLd_Manual_quota.initial_date    := inuinitial_date;
      ircLd_Manual_quota.final_date      := inufinal_date;
      ircLd_Manual_quota.support_file    := inusupport_file;
      ircLd_Manual_quota.observation     := inuobservation;
      ircLd_Manual_quota.print_in_bill   := inuprint_in_bill;
      -- return;
      /*guarda en la tabla*/
      dald_manual_quota.insRecord(ircLd_Manual_quota => ircLd_Manual_quota);
    end if;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END InsertManualQuota;

  function fnugetManualquota return number is
    nuSequence number;
  BEGIN
    /*Obtiene la secuencia*/
    BEGIN
      nuSequence := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LD_MANUAL_QUOTA',
                                                        'SEQ_LD_MANUAL_QUOTA');
    EXCEPTION
      when no_data_found then
        nuSequence := null;
      when others then
        nuSequence := null;
    END;
  
    return nuSequence;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnugetManualquota;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : RegisterStatusChange
  Descripcion    : Obtiene los datos para realizar una transferencia de cupo.
  
  Autor          : Eduar Ramos Barragan
  Fecha          : 20/11/2012
  
  Parametros              Descripcion
  ============         ===================
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE RegisterStatusChange(inuOrder              or_order.order_id%type,
                                 inuStatus             ld_quota_transfer.status%type,
                                 isbRequestObservation ld_quota_transfer.request_observation%type,
                                 isbReviewObservation  ld_quota_transfer.review_observation%type) IS
    tbOrder         dald_quota_transfer.tytbLD_quota_transfer;
    styLdQuoHistori Dald_Quota_Historic.styLD_quota_historic;
    nuIndex         number;
    nuPerson        ge_person.person_id%type;
    nuCausal        ge_causal.causal_id%type;
  
    nuPackage OR_order_activity.package_id%type;
  
    cnuFLOW_ACTION constant number := 8181;
    nuErrorCode    ge_error_log.error_log_id%type;
    sbErrorMessage ge_error_log.description%type;
  
  begin
  
    dald_quota_transfer.getRecords('ld_quota_transfer.order_id = ' ||
                                   inuOrder,
                                   tbOrder);
  
    nuPerson := GE_BOPersonal.fnuGetPersonId;
  
    If (inuStatus = 1) then
    
      nuIndex := tbOrder.first;
    
      while nuIndex is not null loop
      
        if (tbOrder(nuIndex).status = 2 or tbOrder(nuIndex).status = 3) then
          ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                           'Esta orden ya fue aprobada o rechazada');
        
        elsif (tbOrder(nuIndex).status = 1) then
          ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                           'Esta orden ya fue revisada');
        
        else
        
          tbOrder(nuIndex).status := inuStatus;
          tbOrder(nuIndex).review_user := nuPerson;
          tbOrder(nuIndex).review_date := sysdate;
          tbOrder(nuIndex).request_observation := isbRequestObservation;
          tbOrder(nuIndex).review_observation := isbReviewObservation;
          dald_quota_transfer.updRecord(tbOrder(nuIndex));
        
        end if;
      
        nuIndex := tbOrder.next(nuIndex);
      end loop;
    
    elsif (inuStatus = 2) then
    
      nuCausal := dald_parameter.fnuGetNumeric_Value('TRASNFER_FAIL_CAUSA');
    
      if nuCausal is not null then
      
        nuIndex := tbOrder.first;
      
        while nuIndex is not null loop
        
          if (tbOrder(nuIndex).status = 2 or tbOrder(nuIndex).status = 3) then
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'Esta orden ya fue aprobada o rechazada');
          
          else
          
            tbOrder(nuIndex).status := inuStatus;
            tbOrder(nuIndex).reject_user := nuPerson;
            tbOrder(nuIndex).reject_date := sysdate;
            tbOrder(nuIndex).approved := 'N';
            tbOrder(nuIndex).request_observation := isbRequestObservation;
            tbOrder(nuIndex).review_observation := isbReviewObservation;
          
            dald_quota_transfer.updRecord(tbOrder(nuIndex));
            ld_bopackagefnb.legalizeOrder(inuOrder, nuCausal);
          
            nuPackage := or_bcorderactivities.fnugetpackidinfirstact(inuOrder);
          
            if (nuPackage IS not null) then
              Ld_BoflowFNBPack.procvalidateFlowmove(cnuFLOW_ACTION,
                                                    nuPackage,
                                                    nuErrorCode,
                                                    sbErrorMessage);
            
              if (nuErrorCode <> 0) then
                ge_boerrors.seterrorcodeargument(nuErrorCode,
                                                 sbErrorMessage);
              end if;
            END if;
          end if;
        
          nuIndex := tbOrder.next(nuIndex);
        end loop;
      
      else
      
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                         'Por favor configuere el parametro TRASNFER_FAIL_CAUSA');
      
      end if;
    
    elsif (inuStatus = 3) then
    
      nuCausal := dald_parameter.fnuGetNumeric_Value('TRASNFER_SUCC_CAUSAL');
    
      if nuCausal is not null then
      
        nuIndex := tbOrder.first;
      
        while nuIndex is not null loop
        
          if (tbOrder(nuIndex).status = 2 or tbOrder(nuIndex).status = 3) then
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'Esta orden ya fue aprobada o rechazada');
            --vhurtadoSAO216207: Se agrega validacion que solo aprueba en estado revisado.
          elsif (tbOrder(nuIndex).status = 0) then
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'Esta orden esta en estado generado y solo se deben aprobar en estado revisado');
          else
            tbOrder(nuIndex).status := inuStatus;
            tbOrder(nuIndex).approved_user := nuPerson;
            tbOrder(nuIndex).approved_date := sysdate;
            tbOrder(nuIndex).approved := 'Y';
            tbOrder(nuIndex).request_observation := isbRequestObservation;
            tbOrder(nuIndex).review_observation := isbReviewObservation;
          
            dald_quota_transfer.updRecord(tbOrder(nuIndex));
            ld_bopackagefnb.legalizeOrder(inuOrder, nuCausal);
            /**/
            --Si la trasferencia de cupo es aprobada, se registra en el historial de cupo
            --Se registra en el historico de la persona que cedio el cupo
            styLdQuoHistori.quota_historic_id := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LD_QUOTA_HISTORIC',
                                                                                     'SEQ_LD_QUOTA_HISTORIC');
            styLdQuoHistori.assigned_quote    := tbOrder(nuIndex)
                                                 .trasnfer_value; --  inuTrasnferValue;
            styLdQuoHistori.register_date     := SYSDATE;
            styLdQuoHistori.result            := 'Y';
            styLdQuoHistori.subscription_id   := tbOrder(nuIndex)
                                                 .destiny_subscrip_id; --inuOriginSubcripId;
            styLdQuoHistori.observation       := 'Se ha realizado una transferencia de cupo al contrato [' || tbOrder(nuIndex)
                                                .origin_subscrip_id || '],
              por valor de : $' || tbOrder(nuIndex)
                                                .trasnfer_value ||
                                                 ', el dia ' ||
                                                 trunc(sysdate);
          
            Dald_Quota_Historic.insRecord(styLdQuoHistori);
            --Se registra en el historico, la persona a la cual se le hizo el traslado de cupo
            styLdQuoHistori.quota_historic_id := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LD_QUOTA_HISTORIC',
                                                                                     'SEQ_LD_QUOTA_HISTORIC');
            styLdQuoHistori.assigned_quote    := tbOrder(nuIndex)
                                                 .trasnfer_value;
            styLdQuoHistori.register_date     := SYSDATE;
            styLdQuoHistori.result            := 'Y';
            styLdQuoHistori.subscription_id   := tbOrder(nuIndex)
                                                 .origin_subscrip_id;
            styLdQuoHistori.observation       := 'Se ha recibido una transferencia de cupo del contrato [' || tbOrder(nuIndex)
                                                .destiny_subscrip_id || '],
              por valor de : $' || tbOrder(nuIndex)
                                                .trasnfer_value ||
                                                 ', el dia ' ||
                                                 trunc(sysdate);
          
            Dald_Quota_Historic.insRecord(styLdQuoHistori);
            ------------------------------------------------------------------------
            /**/
            nuPackage := or_bcorderactivities.fnugetpackidinfirstact(inuOrder);
          
            if (nuPackage IS not null) then
              Ld_BoflowFNBPack.procvalidateFlowmove(cnuFLOW_ACTION,
                                                    nuPackage,
                                                    nuErrorCode,
                                                    sbErrorMessage);
            
              if (nuErrorCode <> 0) then
                ge_boerrors.seterrorcodeargument(nuErrorCode,
                                                 sbErrorMessage);
              end if;
            END if;
          
          end if;
          nuIndex := tbOrder.next(nuIndex);
        end loop;
      
      else
      
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                         'Por favor configure el parametro TRASNFER_FAIL_CAUSA');
      
      end if;
    
    end if;
  
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END RegisterStatusChange;

  /*  \*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : registerBlUnSh
  Descripcion    : Ingresa la informacion de bloqueo y desbloqueo de cupo
  Autor          : Aacuna
  Fecha          : 29/01/2013
  
  Parametros              Descripcion
  ============        ===================
  inuPackage          Numero de solicitud
  
  Historia de Modificaciones
  Fecha         Autor       Modificacion
  =========   ========= ====================
  
  ******************************************************************\
  PROCEDURE registerBlUnSh(inuPackage    IN MO_PACKAGES.PACKAGE_ID%TYPE) IS
  
    rcBlUnSh     dald_block_unblock_sh.styLD_block_unblock_sh;
  
  BEGIN
  
   rcBlUnSh.block_unblock_sh_id := ld_bosequence.FnuSeq_ld_BlUnSh;
   rcBlUnSh.package_id:= inuPackage;
   rcBlUnSh.quota_block_id:= nuBlock_id;
  
  
  
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END registerBlUnSh;*/

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuGetAvalibleQuote
  Descripcion    : Funcion que retorna el cupo disponible o actual
                   de un contrato
  
  Autor          : Erika A. Montenegro G.
  Fecha          : 13/08/2013
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuGetAvalibleQuote(inusubscription in suscripc.susccodi%type)
    RETURN ld_quota_by_subsc.quota_value%type IS
  
    nuQuotaValue ld_quota_by_subsc.quota_value%type;
    nuUsedQuote  number := 0;
  
  BEGIN
  
    nuQuotaValue := ld_bcnonbankfinancing.FnuGetQuotaAssigned(inusubscription);
    nuUsedQuote  := LDC_CALCULACUPOBRILLA.fnuGetUsedQuote(inuSubscription);
  
    if (nuQuotaValue >= nuUsedQuote) then
      nuQuotaValue := nuQuotaValue - nuUsedQuote;
    else
      nuQuotaValue := 0;
    END if;
  
    RETURN nvl(nuQuotaValue, 0);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuGetAvalibleQuote;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : blockGeographLocaQuote
  Descripcion    : Funcion que bloquea los contratos de una ubicacion
                 geografica y un estrato
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  12-oct-2013     AEcheverrySAO219857 Se modifica para calcular el cupo de credito real, y
                                      mejorar el rendimiento de la consulta y del procesamiento del
                                      calculo de cupo para simulacion
  27-Sep-2013     jcarrillo.SAO217948 Se modifica las sentencias mejorando el
                                      rendimiento
  20-Ago-2013     AEcheverrySAO       Se modifica sentencia de seleccion cuando
                                      se eligue una localidad.
  ******************************************************************/
  PROCEDURE simulateQuota(inuGeographLoca ge_geogra_location.geograp_location_id%type) IS
    sbLocations varchar2(32000);
    sbQuery     varchar2(32000);
  
    curfQuery constants.tyrefcursor;
  
    TYPE tyrcLocations IS RECORD(
      geograp_location_id ge_geogra_location.geograp_location_id%type,
      description         varchar2(1000));
  
    nuGasType number;
    rcTable   dald_simulated_quota.styLD_simulated_quota;
  
    nuIndexTable number := 0;
    nuAreaType   ge_geogra_location.geog_loca_area_type%type;
  
    ------------------------------------
    tbLD_simulated_quota dald_simulated_quota.tytbLD_simulated_quota;
  
  BEGIN
  
    DELETE FROM ld_simulated_quota;
    --commit;
  
    if (curfQuery%isOpen) then
      close curfQuery;
    END if;
  
    nuAreaType := dage_geogra_location.fnugetgeog_loca_area_type(inuGeographLoca);
  
    if (nuAreaType =
       dald_parameter.fnuGetNumeric_Value('COD_TYPE_NEIGHBORHOOD')) then
    
      sbLocations := inuGeographLoca;
    
      If (sbLocations Is NOT NULL) THEN
        nuGasType := ld_boconstans.cnuGasService;
      
        open curfQuery for
          SELECT /*+
                                      leading (ab_address)
                                      use_nl( ab_address pr_product )
                                      use_nl( pr_product servsusc )
                                      use_nl( ab_address tb_location)
                                      use_nl( tb_location tb_department )
                                      index( ab_address IDX_AB_ADDRESS14 )
                                      index( pr_product IDX_PR_PRODUCT_09)
                                      index( servsusc PK_SERVSUSC)
                                      index( tb_location PK_GE_GEOGRA_LOCATION)
                                      index( tb_department PK_GE_GEOGRA_LOCATION)
                                  */
           rownum simulated_quota_id,
           pr_product.subscription_id subscription,
           tb_department.geograp_location_id || ' - ' ||
           tb_department.description department,
           tb_location.geograp_location_id || ' - ' ||
           tb_location.description location,
           ab_address.neighborthood_id || ' - ' ||
           dage_geogra_location.fsbGetDescription(ab_address.neighborthood_id,
                                                  0) barrio,
           decode(sesumult, 1, 'MULTIFAMILIAR', 'UNIFAMILIAR') housing,
           servsusc.sesucate || ' - ' ||
           pktblcategori.fsbgetdescription(servsusc.sesucate) category,
           servsusc.sesusuca || ' - ' ||
           pktblsubcateg.fsbgetdescription(servsusc.sesucate,
                                           servsusc.sesusuca) subcategory,
           LDC_CALCULACUPOBRILLA.fnuAllocateTotalQuota(pr_product.subscription_id) current_quota,
           LDC_CALCULACUPOBRILLA.fnuSimuAllocateQuota(pr_product.subscription_id) quota_assigned,
           null
            FROM /*+ LDC_CALCULACUPOBRILLA.simulateQuota*/ ab_address,
                 pr_product,
                 servsusc,
                 ge_geogra_location tb_location,
                 ge_geogra_location tb_department
           WHERE ab_address.neighborthood_id = sbLocations
             AND pr_product.address_id = ab_address.address_id
             AND pr_product.product_type_id = nuGasType
             AND pr_product.product_type_id = servsusc.sesuserv
             AND pr_product.product_id = servsusc.sesunuse
             AND EXISTS
           (SELECT 'x'
                    FROM Ps_Product_Status status
                   WHERE status.Product_Status_Id =
                         pr_product.Product_Status_Id
                     AND status.Is_Active_Product = GE_BOConstants.csbYES)
             AND ab_address.geograp_location_id =
                 tb_location.geograp_location_id
             AND tb_location.geo_loca_father_id =
                 tb_department.geograp_location_id(+);
      
        fetch curfQuery bulk collect
          INTO tbLD_simulated_quota;
        if (tbLD_simulated_quota.count > 0) then
          dald_simulated_quota.insrecords(tbLD_simulated_quota);
        END if;
        close curfQuery;
      
        /*
        loop
            fetch curfQuery into rcTable;
        
            exit when(curfQuery%notFound);
        
            rcTable.simulated_quota_id := nuIndexTable + 1;
            AllocateTotalQuota(rcTable.subscription, rcTable.current_quota);
        
            dald_simulated_quota.insrecord(rcTable);
            nuIndexTable := nuIndexTable + 1;
        end loop;
        */
      END IF;
    
      --commit;
    else
      /* Se llama la funcion que retorna las localidades */
      if (nuAreaType =
         dald_parameter.fnuGetNumeric_Value('COD_TYPE_COUNTRY')) then
        sbLocations := ld_bcnonbankfinancing.fsbLocationByCountry(inuGeographLoca,
                                                                  dald_parameter.fnuGetNumeric_Value('COD_TYPE_LOCATION'));
      elsif (nuAreaType =
            dald_parameter.fnuGetNumeric_Value('COD_TYPE_DEPARTMENT')) then
        sbLocations := ld_bcnonbankfinancing.fsbLocationByDepar(inuGeographLoca,
                                                                dald_parameter.fnuGetNumeric_Value('COD_TYPE_LOCATION'));
      
      end if;
    
      if (sbLocations is null) then
        if (not dage_geogra_location.fblexist(inuGeographLoca)) then
          ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                           'Esta ubicacion no existe');
          raise ex.CONTROLLED_ERROR;
        else
          sbLocations := inuGeographLoca;
        end if;
      end if;
    
      ut_trace.trace('Localidades [' || sbLocations || ']', 10);
      If (sbLocations Is NOT NULL) THEN
        nuGasType := ld_boconstans.cnuGasService;
      
        sbQuery := 'SELECT  /*+                                                ' ||
                   chr(10) ||
                   '            leading (tb_location)                          ' ||
                   chr(10) ||
                   '            use_nl( tb_location ab_address )               ' ||
                   chr(10) ||
                   '            use_nl( ab_address pr_product )                ' ||
                   chr(10) ||
                   '            use_nl( pr_product servsusc )                  ' ||
                   chr(10) ||
                   '            use_nl( tb_location tb_department )            ' ||
                   chr(10) ||
                   '            index( tb_location PK_GE_GEOGRA_LOCATION)      ' ||
                   chr(10) ||
                   '            index( ab_address  IX_AB_ADDRESS16 )           ' ||
                   chr(10) ||
                   '            index( pr_product IDX_PR_PRODUCT_09)           ' ||
                   chr(10) ||
                   '            index( servsusc PK_SERVSUSC)                   ' ||
                   chr(10) ||
                   '            index( tb_department PK_GE_GEOGRA_LOCATION)    ' ||
                   chr(10) ||
                   '        */                                                 ' ||
                   chr(10) ||
                   '        rownum simulated_quota_id,                              ' ||
                   chr(10) ||
                   '        pr_product.subscription_id subscription,           ' ||
                   chr(10) ||
                   '        tb_department.geograp_location_id||'' - ''||tb_department.Description department,  ' ||
                   chr(10) ||
                   '        tb_location.geograp_location_id||'' - ''||tb_location.Description location ,       ' ||
                   chr(10) ||
                   '        ab_address.neighborthood_id ||'' - ''|| dage_geogra_location.fsbGetDescription(ab_address.neighborthood_id,0) barrio,  ' ||
                   chr(10) ||
                   '        decode(sesumult,1,''MULTIFAMILIAR'',''UNIFAMILIAR'')  housing,                                                         ' ||
                   chr(10) ||
                   '        servsusc.sesucate ||'' - ''||  pktblcategori.fsbgetdescription(servsusc.sesucate) category ,                           ' ||
                   chr(10) ||
                   '        servsusc.sesusuca ||'' - ''||  pktblsubcateg.fsbgetdescription(servsusc.sesucate,servsusc.sesusuca) subcategory,       ' ||
                   chr(10) ||
                   '        LDC_CALCULACUPOBRILLA.fnuAllocateTotalQuota(pr_product.subscription_id)  current_quota,      ' ||
                   chr(10) ||
                   '        LDC_CALCULACUPOBRILLA.fnuSimuAllocateQuota(pr_product.subscription_id) quota_assigned,     ' ||
                   chr(10) ||
                   '        null                                                                                       ' ||
                   chr(10) ||
                   'FROM    /*+ LDC_CALCULACUPOBRILLA.simulateQuota*/                                                  ' ||
                   chr(10) ||
                   '        ge_geogra_location tb_location, ab_address,  pr_product,                                   ' ||
                   chr(10) ||
                   '        servsusc, ge_geogra_location tb_department                                                 ' ||
                   chr(10) ||
                   'WHERE   tb_location.geograp_location_id in (' ||
                   sbLocations || ')                                     ' ||
                   chr(10) ||
                   'AND     ab_address.geograp_location_id = tb_location.geograp_location_id                           ' ||
                   chr(10) ||
                   'AND     pr_product.address_id = ab_address.address_id                                              ' ||
                   chr(10) || 'AND     pr_product.product_type_id = ' ||
                   nuGasType ||
                   '                                               ' ||
                   chr(10) ||
                   'AND     pr_product.product_id = servsusc.sesunuse                                                  ' ||
                   chr(10) ||
                   'AND     pr_product.product_type_id = servsusc.sesuserv                                             ' ||
                   chr(10) ||
                   'AND     EXISTS ( SELECT ''x''                                                                      ' ||
                   chr(10) ||
                   '                 FROM   Ps_Product_Status status                                                   ' ||
                   chr(10) ||
                   '                 WHERE  status.Product_Status_Id = pr_product.Product_Status_Id                    ' ||
                   chr(10) ||
                   '                 AND    status.Is_Active_Product = ''' ||
                   GE_BOConstants.csbYES || ''' )               ' ||
                   chr(10) ||
                   'AND     tb_location.geo_loca_father_id = tb_department.geograp_location_id(+)';
      
        ut_trace.trace('Query=' || sbQuery, 15);
      
        open curfQuery for sbQuery;
        fetch curfQuery bulk collect
          INTO tbLD_simulated_quota;
        if (tbLD_simulated_quota.count > 0) then
          dald_simulated_quota.insrecords(tbLD_simulated_quota);
        END if;
        close curfQuery;
      END IF;
    
      --commit;
    
    end if;
  
    tbLD_simulated_quota.delete;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      if (curfQuery%isOpen) then
        close curfQuery;
      END if;
      --rollback;;
      raise ex.CONTROLLED_ERROR;
    when others then
      if (curfQuery%isOpen) then
        close curfQuery;
      END if;
      --rollback;;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END simulateQuota;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuSimuAllocateQuota
  Descripcion    :
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuSimuAllocateQuota(inuSubscription suscripc.susccodi%type)
    return number
  
   IS
    nuProduct        number;
    rcProduct        dapr_product.stypr_product;
    rcSubscription   suscripc%rowtype;
    nuGeogLoca       ge_geogra_location.geograp_location_id%type;
    sbParentLocation varchar2(2000);
    tbCreditQuota    dald_credit_quota.tytbLD_credit_quota;
    --tbManualQuota    dald_manual_quota.tytbLD_manual_quota;
    blPolicyResult boolean := false;
    rcServsusc     servsusc%rowtype;
    nuTotal        ld_credit_quota.quota_value%type;
  
  BEGIN
  
    ut_trace.trace('Inicio LDC_CALCULACUPOBRILLA.fnuSimuAllocateQuota', 10);
  
    nuTotal := cnuQuotaCero;
  
    nuProduct := fnugetGasProduct(inuSubscription);
  
    if nuProduct is not null then
    
      rcSubscription := pktblsuscripc.frcgetrecord(inuSubscription);
    
      dapr_product.getRecord(nuProduct, rcProduct);
    
      rcServsusc := pktblservsusc.frcGetRecord(nuProduct);
    
      nuGeogLoca := daab_address.fnuGetGeograp_Location_Id(rcProduct.address_id);
    
      ge_bogeogra_location.GetGeograpParents(nuGeogLoca, sbParentLocation);
    
      tbCreditQuota := LD_BCNONBANKFINANCING.ftbGetSimuCreditQuote(rcServsusc.Sesucate,
                                                                   rcServsusc.Sesusuca,
                                                                   sbParentLocation);
    
      if tbCreditQuota.first is not null then
      
        blPolicyResult := fblExcecutePolicySimuReal(tbCreditQuota  (tbCreditQuota.first)
                                                    .credit_quota_id,
                                                    inuSubscription,
                                                    tbCreditQuota  (tbCreditQuota.first)
                                                    .quota_value);
      end if;
    
      if (blPolicyResult) then
        ut_trace.trace('Cumple las politicas ', 10);
        nuTotal := tbCreditQuota(tbCreditQuota.first).quota_value;
        return nuTotal;
      else
        ut_trace.trace('No cumple las politicas ', 10);
        nuTotal := cnuQuotaCero;
        return nuTotal;
      end if;
    
    end if;
  
    return nuTotal;
  
    ut_trace.trace('Fin LDC_CALCULACUPOBRILLA.fnuSimuAllocateQuota');
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return null;
    when others then
      return null;
  END fnuSimuAllocateQuota;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuValidateQuota
  Descripcion    : Valida si el contrato tiene cupo
  Autor          : AAcuna
  Fecha          : 28/01/2013
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuValidateQuota(inuSubscription suscripc.susccodi%type)
  
   return number
  
   IS
  
    nuTotal      ld_quota_by_subsc.quota_value%type;
    rcQuotaSubsc dald_quota_by_subsc.styLD_quota_by_subsc;
  
  BEGIN
  
    ut_trace.trace('Inicio LDC_CALCULACUPOBRILLA.fnuValidateQuota');
  
    rcQuotaSubsc := ld_bcnonbankfinancing.frcGetQuotaRegister(inuSubscription);
  
    if (rcQuotaSubsc.quota_value > 0) then
    
      nuTotal := 1;
    
    else
    
      nuTotal := 0;
    
    end if;
  
    return nuTotal;
  
    ut_trace.trace('Final LDC_CALCULACUPOBRILLA.fnuValidateQuota');
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return null;
    when others then
      return null;
  END fnuValidateQuota;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuValQuotaBySub
  Descripcion    : Valida si al menos algun contrato del cliente tiene cupo
  Autor          : AAcuna
  Fecha          : 28/01/2013
  
  Parametros              Descripcion
  ============         ===================
  inuSubscriber: Identificador del cliente.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION fnuValQuotaBySub(inuSubscriber IN ge_subscriber.subscriber_id%TYPE)
  
   return number
  
   IS
  
    nuTotal       ld_quota_by_subsc.quota_value%type;
    rcSubcription tyrcSubcription;
    rcQuotaSubsc  dald_quota_by_subsc.styLD_quota_by_subsc;
    rfCursor      constants.tyrefcursor;
  
  BEGIN
  
    ut_trace.trace('Inicia Ld_BoNonBankFinacing.fnuValQuotaBySub', 10);
  
    /*Obtiene los contratos asociados al cliente*/
    cc_bosubscription.getsubscription(null,
                                      null,
                                      dage_subscriber.fnuGetIdent_Type_Id(inuSubscriber),
                                      dage_subscriber.fsbGetIdentification(inuSubscriber),
                                      null,
                                      null,
                                      null,
                                      rfCursor);
  
    loop
      fetch rfCursor
        into rcSubcription;
      exit when(rfCursor%notFound);
    
      rcQuotaSubsc := ld_bcnonbankfinancing.frcGetQuotaRegister(rcSubcription.susccodi);
    
      dbms_output.put_line('Sucripc: ' || rcSubcription.susccodi ||
                           ' Valor: ' || rcQuotaSubsc.quota_value);
    
      if (rcQuotaSubsc.quota_value > 0) then
      
        nuTotal := 1;
      
      end if;
    
    end loop;
  
    if (nuTotal > 0) then
    
      nuTotal := 1;
    
    else
    
      nuTotal := 0;
    
    end if;
  
    return nuTotal;
  
    ut_trace.trace('Fin Ld_BoNonBankFinacing.fnuValQuotaBySub', 10);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return null;
    when others then
      return null;
  END fnuValQuotaBySub;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuGetValueByRoll
  Descripcion    : Retorna el valor de cupo que debe tener un cliente dependiendo
                   su comportamiento de pago y si tiene configurado un tipo porcentaje
                   o valor , todo estos datos son traidos de la configuracion de rollover.
  Autor          : AAcuna
  Fecha          : 28/02/2013
  
  Parametros              Descripcion
  ============         ===================
  inuSubscriber: Identificador del cliente.
  
  
  Historia de Modificaciones
  Fecha             Autor                   Modificacion
  =========         =========               ====================
  02/10/2013        JCarmona.SAO218227      Se modifica para que calcule el valor del
                                            cupo dependiendo del valor ingresado como
                                            paramentro inuValue.
  ******************************************************************/
  FUNCTION fnuGetValueByRoll(isbQuota_Option in ld_rollover_quota.quota_option%type,
                             inuValue        in ld_rollover_quota.value%type,
                             inuValuePol     in ld_credit_quota.quota_value%type)
  
   RETURN ld_credit_quota.quota_value%type
  
   IS
  
    nuTotal ld_credit_quota.quota_value%type;
  
  BEGIN
  
    ut_trace.trace('Inicia Ld_BoNonBankFinacing.fnuGetValueByRoll [' ||
                   isbQuota_Option || '] [' || inuValue || ']',
                   10);
  
    /*Valida si el tipo es P(Porcentaje) o V(Valor*/
  
    if (isbQuota_Option = 'P') then
    
      nuTotal := inuValuePol + ((inuValuePol * inuValue) / 100);
    
    else
    
      nuTotal := inuValue;
    
    end if;
    ut_trace.trace('Fin Ld_BoNonBankFinacing.fnuGetValueByRoll [' ||
                   nuTotal || ']',
                   10);
    return nuTotal;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return null;
    when others then
      return null;
  END fnuGetValueByRoll;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : AssignedQuotaMassive
  Descripcion    : Asigna cupos de forma masiva
  Autor          : Alex Valencia
  Fecha          : 05/02/2013
  
  Parametros              Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE AssignedQuotaMassive IS
    cnuServGas CONSTANT pr_product.product_type_id%TYPE := Dald_parameter.fnuGetNumeric_Value('COD_TIPO_SERV'); --7014
    nuTotal ld_credit_quota.quota_value%TYPE;
    TYPE suscripc_rec IS RECORD(
      susccodi suscripc.susccodi%TYPE);
    TYPE SuscripcSet IS TABLE OF suscripc_rec;
    suscriptor SuscripcSet;
  BEGIN
    SELECT DISTINCT s.susccodi BULK COLLECT
      INTO suscriptor
      FROM suscripc s, pr_product p
     WHERE s.susccodi = p.subscription_id
       AND p.product_type_id = cnuServGas
       AND LDC_CALCULACUPOBRILLA.fnugetGasProduct(s.susccodi) IS NOT NULL;
  
    FOR i IN suscriptor.FIRST .. suscriptor.LAST LOOP
      LDC_CALCULACUPOBRILLA.AllocateQuota(inuSubscription => suscriptor(i)
                                                             .susccodi,
                                          onuTotal        => nuTotal);
    END LOOP;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END AssignedQuotaMassive;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : GetPriceArticle
  Descripcion    : Muestra si el precio del articulo ha cambiado a partir de la fecha de visita
                   realizada al cliente y ademas retornara los siguientes valores:
                   S(Si el precio vario a partir de la fecha de visita enviada por parametro)
                   N(Si el precio no vario a partir de la fecha de visita enviada por parametro)
                   Precio: (Precio)
  Autor          : AAcuna
  Fecha          : 06/03/2013 04:55:27 p.m.
  
  Parametros              Descripcion
  ============            ===================
  inuArticle              Numero de articulo
  inuSusccodi             Numero de contrato
  inuPrice                Precio actual del articulo
  idtVisit                Fecha  limite de visita
  osbMessage              Mensaje de cambio de precio (S) Vario (N) No vario precio
  onuPriceApproved        Precio
  osbError                Mensaje de error
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
    06/09/2013      mmira.SAO216200     Se modifica para no validar variacion
                                        cuando el articulo no tiene control de precio.
  ******************************************************************/
  PROCEDURE GetPriceArticle(inuArticle       in ld_article.article_id%type,
                            inuSusccodi      in suscripc.susccodi%type default NULL,
                            inuPrice         in ld_price_list_deta.price%type,
                            idtVisit         in mo_packages.request_date%type,
                            osbMessage       out varchar2,
                            onuPriceApproved out ld_price_list_deta.price%type,
                            osbError         out varchar2) IS
  
    dtRequest mo_packages.request_date%type;
    --rcPackage       LDC_CALCULACUPOBRILLA.rfVisitPackage;
    nuPriceApproved ld_price_list_deta.price%type;
    sbPriceControl  ld_article.price_control%type;
  
  BEGIN
  
    ut_trace.trace('Inicia LDC_CALCULACUPOBRILLA.GetPriceArticle', 10);
  
    if (inuArticle is not null AND inuPrice is not null AND
       idtVisit is not null) then
    
      /* Valida que si el articulo no tiene control de precio, en cuyo caso retorna
      que no hubo variacion */
    
      sbPriceControl := dald_article.fsbGetPrice_Control(inuArticle);
    
      if (sbPriceControl = 'Y') then
      
        /* Se trae el precio aprobado que tenia el articulo en la fecha de visita*/
      
        nuPriceApproved := ld_bcnonbankfinancing.FnuGetPriceVisit(inuArticle,
                                                                  idtVisit);
      
        /* Se verifica que el articulo por lo menos tenga un registro historico*/
        if (nuPriceApproved is not null) then
        
          /* Se valida que el precio actual no haya cambiado su valor desde la fecha de visita,
          si cambio su valor asignara S(Precio modificado desde la fecha de visita)
          a la variable mensaje de salida si no cambio asignara
          N(Precio no modificado desde la fecha de visita) a la variable mensaje de salida*/
        
          if (nuPriceApproved != inuPrice) then
          
            osbMessage       := 'Y';
            onuPriceApproved := nuPriceApproved;
          
          else
          
            osbMessage       := 'N';
            onuPriceApproved := nuPriceApproved;
          
          end if;
        
        else
        
          osbError := 'No se encontro registro historico para este articulo';
        
        end if;
      
      else
        osbMessage      := 'N';
        nuPriceApproved := 0;
      END IF;
    else
      osbError := 'Verifique los campos obligatorios';
    end if;
  
    ut_trace.trace('Finaliza LDC_CALCULACUPOBRILLA.GetPriceArticle', 10);
  
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END GetPriceArticle;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuGetPriceArticle
  Descripcion    : Retorna si el precio del articulo ha cambiado a partir de la fecha de visita
                   realizada al cliente y ademas retornara los siguientes valores:
                   Precio: (Precio)
  Autor          : AAcuna
  Fecha          : 21/03/2013 04:55:27 p.m.
  
  Parametros              Descripcion
  ============            ===================
  nuArticle              Numero de articulo
  nuSusccodi             Numero de contrato
  nuPrice                Precio actual del articulo
  dtVisit                Fecha  limite de visita
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  
  ******************************************************************/

  FUNCTION fnuGetPriceArticle(nuArticle  in ld_article.article_id%type,
                              nuSusccodi in suscripc.susccodi%type,
                              nuPrice    in ld_price_list_deta.price%type,
                              dtVisit    in mo_packages.request_date%type)
  
   RETURN ld_price_list_deta.price%type IS
  
    nuPriceAp ld_price_list_deta.price%type;
    sbMessage varchar2(2000);
    sbError   varchar2(2000);
  
  BEGIN
  
    ut_trace.trace('Inicio Ld_BoNonBankFinacing.fnuGetPriceArticle', 10);
  
    /*Se llama la funcion que retorna el precio aprobado del articulo*/
  
    GetPriceArticle(nuArticle,
                    nuSusccodi,
                    nuPrice,
                    dtVisit,
                    sbMessage,
                    nuPriceAp,
                    sbError);
  
    return nuPriceAp;
  
    ut_trace.trace('Finaliza Ld_BoNonBankFinacing.fnuGetPriceArticle', 10);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      return 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuGetPriceArticle;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : GenerCupon
  Descripcion    : Servicio el cual debe recibira el numero de la solicitud
                   y el valor del cupo y debera arrojar el numero del cupon generado
  
  Autor          : AAcuna
  Fecha          : 20/05/2013
  
  Parametros              Descripcion
  ============         ===================
  inuPackage           :Numero de solicitud
  inuValorCup          :Valor del cupo
  onuCuponCurr         :Cupon generado
  
  
  Historia de Modificaciones
  Fecha             Autor                Modificacion
  =========       =========           ====================
  20/05/2013      AAcuna              Creacion
  ******************************************************************/

  PROCEDURE GenerCupon(inuPackage   in mo_packages.package_id%type,
                       inuValorCup  in cupon.cupovalo%type,
                       onuCuponCurr out cupon.cuponume%type) is
  BEGIN
  
    /*Se llama al servicio de creacion de cupon, se le pasa la solicitud de documento y
    el valor de cupon y retornando el cupon generado*/
  
    pkCouponMgr.GenerateCouponService('PP',
                                      inuPackage,
                                      inuValorCup,
                                      null,
                                      sysdate,
                                      onuCuponCurr);
  
  Exception
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
    
  END GenerCupon;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuSaleValue
  Descripcion    : identifica el valor en la venta.
  
  Autor          :
  Fecha          : 15/03/2013
  
  Parametros              Descripcion
  ============         ===================
  inuSalePackage       numero del paquete
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  function fnuSaleValue(inuSalePackage in mo_packages.package_id%type)
    return number is
  
    nuResult number;
  
  BEGIN
    begin
      select (sum(unit_value * amount) + sum(vat))
        into nuResult
        from ld_non_ban_fi_item
       where ld_non_ban_fi_item.non_ba_fi_requ_id = inuSalePackage;
    exception
      when others then
        return - 1;
    end;
    return nuResult;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuSaleValue;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuReviActiType
  Descripcion    :
  
  Autor          :
  Fecha          : 15/03/2013
  
  Parametros              Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  function fnuReviActiType return number is
  
  BEGIN
  
    return ld_boconstans.cnuAct_Type_REV_FNB;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuReviActiType;

  function fnuReviTaskType return number is
  BEGIN
  
    if (cnuTaskTypeRevFNB IS null) then
      cnuTaskTypeRevFNB := or_bcorderactivities.fnugettasktypebyactid(ld_boconstans.cnuAct_Type_REV_FNB);
    END if;
  
    return cnuTaskTypeRevFNB;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuReviTaskType;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuSaleActiType
  Descripcion    :
  
  Autor          :
  Fecha          : 15/03/2013
  
  Parametros              Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  function fnuSaleActiType return number is
  
  BEGIN
  
    return cnuActivityTypeFNB;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuSaleActiType;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : legalizeReviwOrder
  Descripcion    :
  
  Autor          :
  Fecha          : 15/03/2013
  
  Parametros              Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  procedure legalizeReviwOrder(inuOrder or_order.order_id%type) is
  
    nuCausal        ge_causal.causal_id%type;
    nuzoneid        OR_operating_zone.operating_zone_id%type;
    nuOperatingUnit OR_operating_unit.operating_unit_id%type;
    rcOrder         daor_order.styor_order;
  
  BEGIN
  
    nuCausal := or_boconstants.cnuSuccesCausal;
  
    if (daor_order.fnugetorder_status_id(inuOrder) = 0) then
    
      open cuGetunitBySeller;
      fetch cuGetunitBySeller
        INTO nuOperatingUnit;
      close cuGetunitBySeller;
    
      if (nuOperatingUnit IS not null) then
        rcOrder := Daor_Order.Frcgetrecord(inuOrder);
      
        OR_boProcessOrder.updBasicData(rcOrder,
                                       rcOrder.operating_sector_id,
                                       null);
      
        or_boprocessorder.assign(rcOrder,
                                 nuOperatingUnit,
                                 sysdate,
                                 false,
                                 TRUE);
      END if;
    
    END if;
  
    ld_bopackagefnb.legalizeOrder(inuOrder, nuCausal);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END legalizeReviwOrder;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : GetPolicyHistoric
  Descripcion    : Retorna true o false dependiendo si el contrato tiene alguna politica
                   incumplida y su valor de asignacion de cuota
  
  Autor          : AAcuna
  Fecha          : 15/03/2013
  
  Parametros              Descripcion
  ============         ===================
  inuSubscriptionId       Identificador del cupo de credito.
  oblType                 Retorna true/false si cumple o incumple las politicas.
  onuAssignedQuota        Valor de asignacion de cuota.
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

  PROCEDURE GetPolicyHistoric(inuSubscriptionId suscripc.susccodi%type,
                              oblType           out boolean,
                              onuAssignedQuota  out ld_quota_historic.assigned_quote%type)
  
   IS
  
    nuCont  number := 0;
    nuContd number := 0;
  
  BEGIN
  
    ut_trace.trace('Inicio Ld_BoNonBankFinacing.GetPolicyHistoric', 10);
  
    oblType := false;
  
    /*Se verifica que el contrato no tenga mas de n politicas incumplidas si la funcion
    FnuGetPolicyHistoric retorna cero se valida que el contrato no tiene otra politica incumplida
    diferente al parametro de configuracion */
  
    nuContd := ld_bcnonbankfinancing.FnuGetPolicyHistoric(inuSubscriptionId);
  
    if (nuContd = 0) then
    
      /* Se valida que el contrato tenga un tipo de politica incumplida de acuerdo
      al parametro de politicas configurado*/
    
      ld_bcnonbankfinancing.GetPolicyHistoric(inuSubscriptionId,
                                              nuCont,
                                              onuAssignedQuota);
    
      /*Si la variable nuCont es mayor que cero retorna true debido a que el contrato
      tiene una politica incumplida sino retorna false*/
    
      if (nuCont > 0) then
      
        oblType := true;
      
      else
      
        oblType := false;
      
      end if;
    
    else
    
      oblType := false;
    
    end if;
  
    ut_trace.trace('Finaliza Ld_BoNonBankFinacing.GetPolicyHistoric', 10);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetPolicyHistoric;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : validateNumberFNB
  Descripcion    :
  
  Autor          : Evens Herard Gorut
  Fecha          : 21/03/2013
  
  Parametros              Descripcion
  ============         ===================
  inuNumero            Numero de consecutivo
  inuOperUnit          Unidad operativa
  inuTipoProd          Tipo de producto
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE validateNumberFNB(inuNumero   in fa_consdist.codiulnu%type,
                              inuOperUnit in or_operating_unit.operating_unit_id%type,
                              inuTipoProd in servicio.servcodi%type)
  
   is
  
    /*Declaracion de variables*/
    nuType_of_proof tipocomp.ticocodi%type;
  
  BEGIN
  
    /*Valida el tipo de producto para obtener el tipo de comprobante*/
    if (inuTipoProd = cnuBrilla) then
    
      /*Obtener el parametro del tipo de comprobante de servicios financieros*/
      nuType_of_proof := Dald_Parameter.fnuGetNumeric_Value('COD_TYPE_OF_PROOF',
                                                            null);
    
    elsif (inuTipoProd = cnuPromigas) then
    
      /*Obtener el parametro del tipo de comprobante de promigas*/
      nuType_of_proof := Dald_Parameter.fnuGetNumeric_Value('TYPE_OF_PROOF_PROMIGAS',
                                                            null);
    
    END if;
  
    /*Call the procedure*/
    pkconsecutivemgr.valauthnumber(inutipodocu => nuDocTypeSaleFNB,
                                   inucliente  => Null,
                                   inuempresa  => Null,
                                   inunumero   => inuNumero,
                                   inutipocomp => nuType_of_proof,
                                   inuoperunit => inuOperUnit,
                                   inutipoprod => inuTipoProd);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END validateNumberFNB;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuGetgetCompType
  Descripcion    : Devuelve el tipo de comprobante dado el tipo de producto.
  
  Autor          : jacuna
  Fecha          : 21/03/2013
  
  Parametros              Descripcion
  ============         ===================
  inuTipoProd          Tipo de producto
  
    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========   =========               ====================
  
  ******************************************************************/
  FUNCTION fnuGetCompType(inuTipoProd in servicio.servcodi%type)
    return tipocomp.ticocodi%type IS
    /*Declaracion de variables*/
    nuType_of_proof tipocomp.ticocodi%type;
  BEGIN
    /*Valida el tipo de producto para obtener el tipo de comprobante*/
    if (inuTipoProd = cnuBrilla) then
    
      /*Obtener el parametro del tipo de comprobante de servicios financieros*/
      nuType_of_proof := Dald_Parameter.fnuGetNumeric_Value('COD_TYPE_OF_PROOF');
    
    elsif (inuTipoProd = cnuPromigas) then
    
      /*Obtener el parametro del tipo de comprobante de promigas*/
      nuType_of_proof := Dald_Parameter.fnuGetNumeric_Value('TYPE_OF_PROOF_PROMIGAS');
    
    END if;
    return nuType_of_proof;
  END fnuGetCompType;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : setNumberFNB
  Descripcion    :
  
  Autor          : Evens Herard Gorut
  Fecha          : 21/03/2013
  
  Parametros              Descripcion
  ============         ===================
  inuNumero            Numero de consecutivo
  inuOperUnit          Unidad operativa
  inuTipoProd          Tipo de producto
  oboGenePend          Variable boolean de salida
  
    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========   =========               ====================
    02-09-2013  lfernandez.SAO214326    Se envia el tipo de comprobante de
                                        acuerdo al tipo de producto
  ******************************************************************/
  PROCEDURE setNumberFNB(inuNumero   in fa_consdist.codiulnu%type,
                         inuTipoProd in servicio.servcodi%type,
                         inuOperUnit in or_operating_unit.operating_unit_id%type,
                         oboGenePend out boolean) IS
    nuType_of_proof tipocomp.ticocodi%type;
  BEGIN
    nuType_of_proof := fnugetCompType(inuTipoProd);
    /*Call the procedure*/
    pkconsecutivemgr.setusednumber(inutipodocu => nuDocTypeSaleFNB,
                                   inucliente  => Null,
                                   inuempresa  => Null,
                                   inutipoprod => inuTipoProd,
                                   inunumero   => inuNumero,
                                   inutipocomp => nuType_of_proof,
                                   inuoperunit => inuOperUnit,
                                   inucodirefe => Null,
                                   obogenepend => oboGenePend);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END setNumberFNB;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : UpRequestsetNumberFNB
  Descripcion    : Actualiza el tipo de documento y el numero de documento en la solicitud.
  
  Autor          : jacuna
  Fecha          : 21/03/2013
  
  Parametros              Descripcion
  ============         ===================
  inuRequest           Numero de la solicitud.
  inuNumero            Numero de consecutivo
  inuOperUnit          Unidad operativa
  inuTipoProd          Tipo de producto
  oboGenePend          Variable boolean de salida
  
    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========   =========               ====================
  ******************************************************************/
  PROCEDURE UpRequestSetNumberFNB(inuRequest  in mo_packages.package_id%type,
                                  inuNumero   in fa_consdist.codiulnu%type,
                                  inuTipoProd in servicio.servcodi%type,
                                  inuOperUnit in or_operating_unit.operating_unit_id%type,
                                  oboGenePend out boolean) IS
    /*Declaracion de variables*/
    nuType_of_proof tipocomp.ticocodi%type;
  BEGIN
  
    nuType_of_proof := fnugetCompType(inuTipoProd);
    damo_packages.upddocument_key(inuRequest, inuNumero);
    damo_packages.upddocument_type_id(inuRequest, nuType_of_proof);
    /*Call the procedure*/
    pkconsecutivemgr.setusednumber(inutipodocu => nuDocTypeSaleFNB,
                                   inucliente  => Null,
                                   inuempresa  => Null,
                                   inutipoprod => inuTipoProd,
                                   inunumero   => inuNumero,
                                   inutipocomp => nuType_of_proof,
                                   inuoperunit => inuOperUnit,
                                   inucodirefe => Null,
                                   obogenepend => oboGenePend);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END UpRequestsetNumberFNB;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  UpRequestNumberFNB
  Descripcion :  Actualiza tipo comprobante y consecutivo en solicitud de
                 venta FNB por pagare digital.
                 Adicionalmente actualiza numero como usado en modelo de
                 numeracion autorizada.
  
  Autor       :  Santiago Gomez Rico
  Fecha       :  20-11-2013
  Parametros  :  inuPackage       Solicitud de venta.
                 inuVouchTyp      Tipo comprobante.
                 inuOperUnit      Unidad operativa.
                 inuNumber        Consecutivo.
  
  Historia de Modificaciones
  Fecha        Autor              Modificacion
  =========    =========          ====================
  10-12-2013   jrobayo.SAO226817  Se elimina la actualizacion del modelo
                                  de numeracion.
  20-11-2013   sgomez.SAO223765   Creacion.
  ***************************************************************/

  PROCEDURE UpRequestNumberFNB(inuPackage  in mo_packages.package_id%type,
                               inuVouchTyp in tipocomp.ticocodi%type,
                               inuOperUnit in or_operating_unit.operating_unit_id%type,
                               inuNumber   in fa_consdist.codiulnu%type) IS
    ------------------------------------------------------------------------
    -- Variables
    ------------------------------------------------------------------------
  
    /* Flag genera pendiente */
    boGenePend boolean;
  
  BEGIN
  
    UT_Trace.Trace('Inicia LDC_CALCULACUPOBRILLA.UpRequestNumberFNB', 1);
  
    /* Actualiza solicitud */
    DAMO_Packages.updDocument_Key(inuPackage, inuNumber);
    DAMO_Packages.updDocument_Type_Id(inuPackage, inuVouchTyp);
  
    UT_Trace.Trace('Fin LDC_CALCULACUPOBRILLA.UpRequestNumberFNB', 1);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when OTHERS then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END UpRequestNumberFNB;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  UpRequestVoucherFNB
  Descripcion :  Actualiza numero como usado en modelo de
                 numeracion autorizada.
  
  Autor       :  John Wilmer Robayo Sanchez
  Fecha       :  10-12-2013
                 inuVouchTyp      Tipo comprobante.
                 inuOperUnit      Unidad operativa.
                 inuNumber        Consecutivo.
  
  Historia de Modificaciones
  Fecha        Autor              Modificacion
  =========    =========          ====================
  10-12-2013   jrobayo.SAO226817   Creacion.
  ***************************************************************/

  PROCEDURE UpRequestVoucherFNB(inuVouchTyp in tipocomp.ticocodi%type,
                                inuOperUnit in or_operating_unit.operating_unit_id%type,
                                inuNumber   in fa_consdist.codiulnu%type) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  
    ------------------------------------------------------------------------
    -- Variables
    ------------------------------------------------------------------------
  
    /* Flag genera pendiente */
    boGenePend boolean;
  
  BEGIN
  
    UT_Trace.Trace('Inicia LDC_CALCULACUPOBRILLA.UpRequestVoucherFNB', 1);
  
    /* Actualiza modelo numeracion */
    pkConsecutiveMgr.SetUsedNumber(LDC_CALCULACUPOBRILLA.nuDocTypeSaleFNB,
                                   NULL,
                                   NULL,
                                   -1, -- Tipo producto
                                   inuNumber,
                                   inuVouchTyp,
                                   inuOperUnit,
                                   NULL,
                                   boGenePend);
  
    --commit;
    UT_Trace.Trace('Fin LDC_CALCULACUPOBRILLA.UpRequestVoucherFNB', 1);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when OTHERS then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
      --rollback;;
  END UpRequestVoucherFNB;

  /************************************************************************
    Propiedad intelectual de Open International Systems (c).
  
     Unidad         : Fbllegalizeorder
     Descripci?n    : Se encarga de determinar si una orden fue legalizada
                      con ?xito
     Autor          : jonathan alberto consuegra lara
     Fecha          : 20/03/2013
  
     Par?metros       Descripci?n
     ============     ===================
     inuorder         Identificador de la orden de trabajo
  
     Historia de Modificaciones
     Fecha            Autor                 Modificaci?n
     =========        =========             ====================
     20/03/2013       jconsuegra.SAO139854  Creaci?n
  /*************************************************************************/
  Function Fbllegalizeorder(inuorder in or_order.order_id%type)
    return boolean is
  
    blanswer boolean := false;
    rcorder  daor_order.styOR_order;
  
  Begin
  
    ut_trace.trace('Inicio LDC_CALCULACUPOBRILLA.Fbllegalizeorder', 10);
  
    /*Obtener los datos de la orden*/
    Daor_order.getRecord(inuorder, rcorder);
  
    /*Determinar si la orden se encuentra en estado legalizada = 8
    si la fecha de legalizaci?n no se encuentra nula y que adem?s
    la causa de legalizaci?n sea exitosa*/
    if ((rcorder.Order_Status_Id = ld_boconstans.cnulegalizeorderstatus) and
       (rcorder.legalization_date is not null) and
       (rcorder.Causal_Id = or_boconstants.cnuSuccesCausal)) then
    
      blanswer := true;
    
      return blanswer;
    
    else
    
      return blanswer;
    
    end if;
  
    ut_trace.trace('Fin LDC_CALCULACUPOBRILLA.Fbllegalizeorder', 10);
  
  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  End Fbllegalizeorder;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : validateCosigner
  Descripcion    : Procedimiento que valida un codeudor.
  Autor          : Alex Valencia Ayola
  Fecha          : 10/04/2013
  
  Parametros              Descripcion
  ============         ===================
  inuSupplierId        Identificador del proveedor
  isbIdentification    Identificacion del codeudor
  onuErrCod            Codigo de error
  osbErrMsg            Mensaje de error
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  ==============    ===============   ====================
  02/09/2013        AECheverrySAO213690 Se valida que el codeudor no se enuentre registrado como codeudor de otra solicitud.
  15/Julio/2013     EveSan            Se valida la configuracion del proveedor, si este requiere
                                      codeudor, y ademas que este tengas gas activo
  ******************************************************************/
  PROCEDURE validateCosigner(inuSupplierId     IN ld_suppli_settings.supplier_id%TYPE,
                             isbIdentification IN ld_promissory.identification%TYPE,
                             inuIdent_Type_Id  IN ge_subscriber.Ident_Type_Id%TYPE,
                             blResult          OUT boolean) IS
  
    cnuProdType CONSTANT pr_product.product_type_id%TYPE := Dald_parameter.fnuGetNumeric_Value('COD_TIPO_SERV',
                                                                                               0);
  
    frfGeSubs   dage_subscriber.tyRefCursor;
    frgSuppSett dald_suppli_settings.tyRefCursor;
  
    rcrecord  dage_subscriber.styGE_subscriber;
    rcRecSupp dald_suppli_settings.styLD_suppli_settings;
  
    tbResSusc      ld_bcnonbankfinancing.tytbsuscripc;
    tbPackCosigner dald_promissory.tytbpackage_id;
  
    nuSuscIndex  PLS_INTEGER;
    nuPackIndex  PLS_INTEGER;
    nuCumulSape  diferido.difesape%TYPE := 0;
    nuCumulQuota NUMBER := 0;
    nuQuotaValue ld_quota_by_subsc.quota_value%TYPE;
  
    TYPE rcsubscr IS RECORD(
      subscr_name ge_subscriber.subscriber_name%TYPE,
      subsc_Phone ge_subscriber.phone%TYPE,
      subscr_mail ge_subscriber.e_mail%TYPE);
  
    subscr_info rcsubscr;
  
    boIsActive BOOLEAN := FALSE;
    boExistId  BOOLEAN := FALSE;
  BEGIN
  
    frgSuppSett := dald_suppli_settings.frfGetRecords(' SUPPLIER_ID=' ||
                                                      inuSupplierId);
    FETCH frgSuppSett
      INTO rcRecSupp;
    CLOSE frgSuppSett;
  
    IF rcRecSupp.DEBTOR_PRODUCT_GAS = 'Y' THEN
    
      -- Call the function (Obtiene suscriptores por la identificacion)
      frfGeSubs := dage_subscriber.frfGetRecords(' Ident_Type_Id=' ||
                                                 inuIdent_Type_Id ||
                                                 ' AND identification =' ||
                                                 chr(39) ||
                                                 isbIdentification ||
                                                 chr(39));
    
      LOOP
        FETCH frfGeSubs
          INTO rcrecord;
        EXIT WHEN frfGeSubs%NOTFOUND;
      
        boExistId := TRUE;
      
        -- Call the function (Obtiene productos activos gas por cliente)
        tbResSusc   := ld_bcnonbankfinancing.fnugetsuscperclientprodtype(rcrecord.subscriber_id,
                                                                         cnuProdType);
        nuSuscIndex := tbResSusc.FIRST;
      
        WHILE nuSuscIndex IS NOT NULL LOOP
          boIsActive := TRUE;
          -- Call the function (Obtiene cupo actual de cada contrato)
          nuQuotaValue := ld_bcnonbankfinancing.frcgetquotaregister(tbResSusc(nuSuscIndex))
                          .quota_value; --suscripc.susccodi
          nuCumulQuota := nuCumulQuota + NVL(nuQuotaValue, 0);
        
          nuSuscIndex := tbResSusc.NEXT(nuSuscIndex);
        END LOOP;
      END LOOP;
      CLOSE frfGeSubs;
    
      IF NOT boExistId THEN
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                         'El codeudor no existe en la tabla de suscriptores de productos y servicios');
      END IF;
    
      IF (rcRecSupp.DEBTOR_PRODUCT_GAS = 'Y') THEN
        IF NOT boIsActive THEN
          ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                           'El codeudor no tiene servicio gas activo');
        END IF;
      END IF;
    
      IF NVL(nuCumulQuota, 0) = 0 THEN
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                         'El codeudor no posee cupo');
      END IF;
    
      blResult := TRUE;
    END IF;
  
    -- Call the function (Obtiene solicitudes de venta del codeudor)
    tbPackCosigner := ld_bcnonbankfinancing.fnugetpackcosigner(isbIdentification);
    nuPackIndex    := tbPackCosigner.FIRST;
  
    WHILE nuPackIndex IS NOT NULL LOOP
      -- Call the function (Obtiene saldo pendiente de la solicitud)
      nuCumulSape := nuCumulSape +
                     (ld_bcnonbankfinancing.fnugetsesusapebypackage(inupackageid => tbPackCosigner(nuPackIndex)));
    
      nuPackIndex := tbPackCosigner.NEXT(nuPackIndex);
    END LOOP;
  
    ut_trace.trace('Saldo pendiente de ventas de las cuales es codeudor: ' ||
                   nuCumulSape,
                   10);
  
    IF nuCumulSape > 0 THEN
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El codeudor se encuentra registrado como codeudor de otra solicitud con saldo');
    END IF;
  
    /*
    if(ld_bcnonbankfinancing.fnuGetPackPendCosigner(inuIdent_Type_Id, isbIdentification) > 0 ) then
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error, 'El codeudor se encuentra registrado como codeudor de otra solicitud');
    END if;
    */
  
    blResult := TRUE;
  
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      blResult := FALSE;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      blResult := FALSE;
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END validateCosigner;

  /************************************************************************
    Propiedad intelectual de Open International Systems (c).
  
     Unidad         : RegisterProspect
     Descripcion    : Se encarga de registrar un prospecto
     Autor          : jonathan alberto consuegra lara
     Fecha          : 12/04/2013
  
     Parametros            Descripcion
     ============          ===================
     inuident_type_id      Tipo de identificacion
     isbidentification     Identificacion
     isbsubscriber_name    Nombre del cliente
  
     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     12/04/2013       jconsuegra.SAO139854  Creacion
  /*************************************************************************/
  Procedure RegisterProspect(inuident_type_id   ge_Subscriber.ident_type_id%type,
                             isbidentification  ge_Subscriber.identification%type,
                             isbsubscriber_name ge_Subscriber.subscriber_name%type,
                             isbSUBS_LAST_NAME  ge_Subscriber.SUBS_LAST_NAME%type default NULL) is
  
    PRAGMA AUTONOMOUS_TRANSACTION;
  
    rgProspect Dage_Subscriber.styGE_subscriber;
  
  Begin
  
    ut_trace.trace('Inicio LDC_CALCULACUPOBRILLA.RegisterProspect', 10);
  
    /*Identificador unico de registro*/
    rgProspect.subscriber_id := LD_BOSequence.Fnuseqge_subscriber;
  
    /*IDENTIFICADOR DEL TIPO DE IDENTIFICAcion*/
    rgProspect.ident_type_id := inuident_type_id;
  
    /*IDENTIFICADOR DEL TIPO DE SUSCRIPTOR*/
    rgProspect.subscriber_type_id := Ld_Boconstans.cnuProspectType;
  
    /*IDENTIFICAcion DEL SUSCRIPTOR*/
    rgProspect.identification := isbidentification;
  
    /*NOMBRE DEL SUSCRIPTOR*/
    rgProspect.subscriber_name := isbsubscriber_name;
  
    /*APELLIDO DEL SUSCRIPTOR*/
    rgProspect.SUBS_LAST_NAME := isbSUBS_LAST_NAME;
  
    /*ESTADO DEL SUSCRIPTOR ACTIVO Y:[SI] N:[NO]*/
    rgProspect.active := ld_boconstans.csbafirmation;
  
    --INDICA SI EL CLIENTE ES CORPORATIVO Y:[SI] N:[NO]
    rgProspect.is_corporative := ld_boconstans.csbNOFlag;
  
    /*Registrar prospecto*/
    Dage_Subscriber.insRecord(rgProspect);
  
    /*Confirmar transaccion*/
    --commit;
  
    ut_trace.trace('Fin LDC_CALCULACUPOBRILLA.RegisterProspect', 10);
  
  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  End RegisterProspect;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
  
   Unidad         : fnuValiStateClient
   Descripcion    : validar si el cliente posee buen comportamiento.
                    Es decir, que su estado financiero sea paz y salvo.
                    si el cliente no posee ningun servicio suscrito se
                    retornara que esta a paz y salvo.
  
   Autor          : Evens Herard Gorut
   Fecha          : 10/04/2013
  
   Parametros       Descripcion
   ============     ===================
  
   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   10/04/2013       Eherard.SAO156577     Creacion
  ******************************************************************/
  FUNCTION fnuValiStateClient(inuSusbcriber in ge_subscriber.subscriber_id%type,
                              inuraiseError in number default 1)
    Return boolean IS
    /*Variables*/
    nuSusccodi suscripc.susccodi%type;
    nuContEsfn number := 0;
    blResult   boolean;
  
    /*Cursores*/
    CURSOR cuNuses(inususccodi in suscripc.susccodi%type) is
      Select s.* from servsusc s where s.sesususc = inuSusccodi;
  
    /*Variables tipo cursor*/
    rcNuses cuNuses%rowtype;
  
  BEGIN
    ut_trace.trace('Inicia LDC_CALCULACUPOBRILLA.fnuValiStateClient');
  
    /*Obtener el contrato a aprtir del cliente*/
    nuSusccodi := LD_BCNonbankfinancing.fnuGetSusccodi(inuSusbcriber, null);
  
    /*Recorrer el cursor y Verificar si existe algun servicio
    suscrito que no este a paz y salvo*/
    for rcnuses in cuNuses(nuSusccodi) loop
    
      if (rcNuses.Sesunuse is not null) then
        if (rcNuses.Sesuesfn != 'A') then
          nuContEsfn := nuContEsfn + 1;
        end if;
      end if;
    
    end loop;
  
    if nuContEsfn = ld_boconstans.cnuCero_Value then
      blResult := true;
    else
      blResult := false;
    end if;
  
    ut_trace.trace('Finaliza LDC_CALCULACUPOBRILLA.fnuValiStateClient');
  
    return blResult;
  
  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      if inuRaiseError = 1 then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
    
  END fnuValiStateClient;

  /************************************************************************
    Propiedad intelectual de Open International Systems (c).
  
    Unidad         : Update_Cosigner_Information
    Descripcion    : Se encarga de actualizar cierta informacion de un
                     cliente que es codeudor
    Autor          : jonathan alberto consuegra lara
    Fecha          : 15/04/2013
  
    Parametros         Descripcion
    ============       ===================
    isbidentification  identificacion del suscriptor
    inuIdent_Type_Id   identificador del tipo de identificacion
    isbName            nombre del suscriptor
    isbPhone           telefono del suscriptor
    isbMail            email del suscriptor
  
    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    15/04/2013       jconsuegra.SAO139854  Creacion
  /*************************************************************************/
  Procedure Update_Cosigner_Information(isbidentification ge_subscriber.subscriber_id%type,
                                        inuIdent_Type_Id  ge_subscriber.Ident_Type_Id%type,
                                        isbName           ge_subscriber.subscriber_name%type,
                                        isbPhone          ge_subscriber.phone%type,
                                        isbMail           ge_subscriber.e_mail%type) is
  
    sbupdate_information   ld_parameter.value_chain%type;
    rgCosigner             pkConstante.tyRefCursor;
    rgSubscriber           dage_subscriber.styGE_subscriber;
    sbupdate_Ident_Type_Id ld_parameter.value_chain%type;
    sbupdate_Name          ld_parameter.value_chain%type;
    sbupdate_Phone         ld_parameter.value_chain%type;
    sbupdate_Mail          ld_parameter.value_chain%type;
  
  Begin
  
    ut_trace.trace('Inicio LDC_CALCULACUPOBRILLA.Update_Cosigner_Information',
                   10);
  
    /*Obtener el valor del parametro que determina si se actualizara la informacion del codeudor*/
    sbupdate_information := DALD_PARAMETER.fsbGetValue_Chain('UPDATE_COSIGNER_INFORMATION');
  
    if sbupdate_information = ld_boconstans.csbafirmation then
    
      /*Obtener valor que determinara si se actualizara el tipo de identificacion del codeudor*/
      sbupdate_Ident_Type_Id := DALD_PARAMETER.fsbGetValue_Chain('UPDATE_IDENT_TYPE');
    
      /*Obtener valor que determinara si se actualizara el nombre del codeudor*/
      sbupdate_Name := DALD_PARAMETER.fsbGetValue_Chain('UPDATE_COSIGNER_NAME');
    
      /*Obtener valor que determinara si se actualizara el telefono del codeudor*/
      sbupdate_Phone := DALD_PARAMETER.fsbGetValue_Chain('UPDATE_COSIGNER_PHONE');
    
      /*Obtener valor que determinara si se actualizara el e-mail del codeudor*/
      sbupdate_Mail := DALD_PARAMETER.fsbGetValue_Chain('UPDATE_COSIGNER_MAIL');
    
      rgCosigner := dage_subscriber.frfGetRecords(' identification  = ' ||
                                                  chr(39) ||
                                                  isbidentification ||
                                                  chr(39));
    
      LOOP
        FETCH rgCosigner
          INTO rgSubscriber;
        EXIT WHEN rgCosigner%NOTFOUND;
      
        /*Actualizar tipo de identificacion*/
        if sbupdate_Ident_Type_Id = ld_boconstans.csbafirmation then
          Dage_Subscriber.updIdent_Type_Id(rgSubscriber.subscriber_id,
                                           inuIdent_Type_Id);
        end if;
      
        /*Actualizar nombre*/
        if sbupdate_Name = ld_boconstans.csbafirmation then
          Dage_Subscriber.updSubscriber_Name(rgSubscriber.subscriber_id,
                                             isbName);
        end if;
      
        /*Actualizar telefono*/
        if sbupdate_Phone = ld_boconstans.csbafirmation then
          Dage_Subscriber.updPhone(rgSubscriber.subscriber_id, isbPhone);
        end if;
      
        /*Actualizar E-Mail*/
        if sbupdate_Mail = ld_boconstans.csbafirmation then
          Dage_Subscriber.updE_Mail(rgSubscriber.subscriber_id, isbMail);
        end if;
      
      END LOOP;
    
    end if;
  
    ut_trace.trace('Fin LDC_CALCULACUPOBRILLA.Update_Cosigner_Information',
                   10);
  
  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  End Update_Cosigner_Information;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
  
   Unidad         : fnuBillNumber
   Descripcion    : Valida que el contraro no tiene mas de n facturas vencidas.
  
  
   Autor          : Eduar Ramos Barragan
   Fecha          : 15/05/2013
  
   Parametros       Descripcion
   ============     ===================
   inuSuscripc    : Contrato
  
   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
  ******************************************************************/
  FUNCTION fnuBillNumber(inuSuscripc in suscripc.susccodi%type) Return number IS
  
    nuNumberBillPara     number;
    nuBillExpired        number;
    tbBillAccount        pktblfactura.tyFACTCODI;
    tbBillAccountPendind pktblfactura.tyFACTCODI;
    nuFactcodi           factura.factcodi%type;
    nuBillNumber         number;
  
  BEGIN
    ut_trace.trace('Inicia LDC_CALCULACUPOBRILLA.fnuBillNumber');
  
    /*Se valida que el parametro exista sino lanzara mensaje de error*/
  
    if (DALD_PARAMETER.fblexist('NUM_FAVEN_FNB')) then
    
      if ((nvl(dald_parameter.fnuGetNumeric_Value('NUM_FAVEN_FNB'),
               LD_BOConstans.cnuCero) <> LD_BOConstans.cnuCero)) then
      
        /*Se obtiene el valor del parametro*/
      
        nuNumberBillPara := dald_parameter.fnuGetNumeric_Value('NUM_FAVEN_FNB');
      
        /* Se calcula a partir del contrato si tiene facturas vencidas dependiendo lo que
        obtenga de datos se retornara el valor*/
      
        ld_bcnonbankfinancing.ProcBillPen(inuSuscripc, tbBillAccount);
      
        /*Si trae datos el metodo de factura*/
      
        if tbBillAccount.count > 0 then
        
          for i in tbBillAccount.FIRST .. tbBillAccount.LAST loop
          
            if tbBillAccount.EXISTS(i) then
            
              /*Se obtienen las facturas */
            
              nuFactcodi := tbBillAccount(1);
            
              /* Si las facturas vencidas
              es mayor al parametro retornara -1*/
            
              if tbBillAccount.count > nuNumberBillPara then
              
                return - 1;
              
              else
              
                /* Si las facturas vencidas no supera el parametro retorna el numero
                de la factura*/
              
                if tbBillAccount.count <= nuNumberBillPara then
                
                  return nuFactcodi;
                
                end if;
              
              end if;
            
            end if;
          
          end loop;
        
        else
        
          /* Si las facturas vencidas
          es igual a cero retorna 0*/
        
          if tbBillAccount.count = 0 then
          
            return 0;
          
          end if;
        
        end if;
      
      else
      
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                         'No tiene datos configurado el parametro NUM_FAVEN_FNB');
      
      end if;
    
    else
    
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'No existe el parametro configurado NUM_FAVEN_FNB');
    
    end if;
  
    ut_trace.trace('Inicia LDC_CALCULACUPOBRILLA.fnuBillNumber');
  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      return null;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuBillNumber;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
  
   Unidad         : registerBillPending
   Descripcion    : Realiza el registro en la entidad facturas pendientes por pagar,
                    a partir de la factura y solicitud se deja la marca de pago o no pago
                    de la factura ingresada.
  
  
   Autor          : AAcuna
   Fecha          : 19/05/2013
  
   Parametros       Descripcion
   ============     ===================
   inuPackage       : Solicitud
   inuFact          : Factura
  
  
   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   25-06-2013       hvera                 Se modifica para registrar el valor 'Y'
                                          en el campo 'payment' cuando el contrato
                                          tenga deuda vencida.
  ******************************************************************/
  PROCEDURE registerBillPending(inuPackage in mo_packages.package_id%type,
                                inuFact    in factura.factcodi%type) IS
  
    rcldbill          dald_bill_pending_payment.styLD_bill_pending_payment;
    inuSubscriptionId suscripc.susccodi%type;
    nuExpirDebt       number := 0;
  BEGIN
  
    ut_trace.trace('Inicia LDC_CALCULACUPOBRILLA.registerBillPending');
  
    /*Realiza el ingreso a la entidad LD_bill_pending_payment*/
  
    rcldbill.bill_pending_payment_id := ld_bosequence.Fnuseqld_bill_pending_payment;
    rcldbill.PACKAGE_ID              := inuPackage;
  
    rcldbill.factcodi      := inuFact;
    rcldbill.register_date := sysdate;
  
    rcldbill.payment := 'N';
  
    inuSubscriptionId := damo_packages.fnugetsubscription_pend_id(inuPackage);
    ut_trace.trace('inuSubscriptionId ' || inuSubscriptionId, 10);
    nuExpirDebt := GC_BODEBTMANAGEMENT.fnuGetExpirDebtBySusc(inuSubscriptionId);
    ut_trace.trace('Deuda ' || nuExpirDebt, 10);
    if (nuExpirDebt > 0) then
      rcldbill.payment := 'Y';
    END if;
  
    dald_bill_pending_payment.insRecord(rcldbill);
  
    ut_trace.trace('Fin LDC_CALCULACUPOBRILLA.registerBillPending');
  
  Exception
    When ex.CONTROLLED_ERROR then
      --rollback;;
      raise ex.CONTROLLED_ERROR;
    When others then
      --rollback;;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
    
  END registerBillPending;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuValExiVisFNB
  Descripcion    : Servicio para verificar si existe una solicitud de visita para un contrato en particular, hace n dias (lo determina el parametro DAY_MAX_VISIT)
                   retorna los siguientes valores:
                   0 no hay visita 1 si hay visita.
  Autor          : AAcuna
  Fecha          : 19/03/2013
  
  Parametros          Descripcion
  ============     ===================
  inuSuscripc    : Numero del contrato
  idtRegister    : Fecha de solicitud
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  19/03/2013      AAcuna              Creacion
  ******************************************************************/

  FUNCTION fnuValExiVisFNB(inuSuscripc in suscripc.susccodi%type,
                           idtRegister in mo_packages.request_date%type)
  
   RETURN number
  
   IS
  
    nuVisit number;
  
  BEGIN
  
    ut_trace.Trace('INICIO LDC_CALCULACUPOBRILLA.fnuValExiVisFNB', 10);
  
    /*Se valida que el parametro DAY_MAX_VISIT exista*/
  
    if (DALD_PARAMETER.fblexist('DAY_MAX_VISIT')) then
    
      /*Se valida que el parametro tenga datos configurados*/
    
      if ((nvl(dald_parameter.fnuGetNumeric_Value('DAY_MAX_VISIT'),
               LD_BOConstans.cnuCero) <> LD_BOConstans.cnuCero)) then
      
        /*Se valida si el contrato ingresado tiene solicitudes de visita en una determinada fecha
        y no sea mayor al parametro Day_max_visit*/
      
        nuVisit := ld_bcnonbankfinancing.fnuValExiVisFNB(inuSuscripc,
                                                         idtRegister);
      
        /*Si la variable de visita es mayor que cero obtenemos
        que para el contrato hay una visita, sino no tiene visita */
      
        if (nuVisit > 0) then
        
          nuVisit := 1;
        
        else
        
          nuVisit := 0;
        
        end if;
      
      else
      
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                         'No tiene datos configurado el parametro DAY_MAX_VISIT');
      
      end if;
    
    else
    
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'No existe el parametro configurado DAY_MAX_VISIT');
    
    end if;
  
    Return(nuVisit);
  
    ut_trace.Trace('FIN LDC_CALCULACUPOBRILLA.fnuValExiVisFNB', 10);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      return 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuValExiVisFNB;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
  
   Unidad         : fnuQuotaTransferCalc
   Descripcion    : Metodo que calcula la transferencia de cupo
  
   Autor          : Evens Herard Gorut
   Fecha          : 25/04/2013
  
   Parametros       Descripcion
   ============     ===================
  
   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   25/04/2013       Eherard.SAO156577     Creacion
  ******************************************************************/
  FUNCTION fnuQuotaTransferCalc(inuPackage_id in mo_packages.package_id%type,
                                inuSuscripc   in suscripc.susccodi%type,
                                inuraiseError in number default 1)
    RETURN Number is
  
    /*Variables*/
    nuResult          number := 0;
    nuIndexOrder      number := 0;
    frgDelivOrders    constants.tyrefcursor;
    tbDelivOrder      daor_order_activity.tytbOrder_Id;
    tbOrderActivity   daor_order_activity.tytbOR_order_activity;
    tbQuotaTransfer   dald_quota_transfer.tytbLD_quota_transfer;
    nuTransferOrder   ld_quota_transfer.order_id%type;
    nuContOt          number := 0;
    nuContOtLeg       number := 0;
    nuTransferValue   ld_quota_transfer.trasnfer_value%type;
    nuIndex           number;
    nuTranferActivity ld_parameter.numeric_value%type;
    tbQuotaTransferT  dald_quota_transfer.styLD_quota_transfer;
    --Variable de los total contratos anteriores
    nuTotalTransfer number := 0;
    -- Variable del valor transferido del contrato
    nuTotalTransferSusc ld_quota_transfer.trasnfer_value%type;
    --Variable del total diferido pagados
    nuTotalDife number := 0;
    --Variable de valor temporal
    nuValueTemp number := 0;
    tbItemWork  dald_item_work_order.tytbLD_item_work_order;
  
  BEGIN
  
    ut_trace.trace('Inicia LDC_CALCULACUPOBRILLA.fnuQuotaTransferCalc');
    /*Obtener el parametro de actividad de transferencia de cupo para OT de FNB*/
  
    if (cnuActivityTypeDelFNB IS not null) then
    
      nuTranferActivity := cnuActivityTypeDelFNB;
    
      /*Obtener la orden de transferencia en la tabla or_order_activity asociada a la
      solicitud de venta y legalizada con exito*/
      daor_order_activity.getRecords('or_order_activity.activity_id = ' ||
                                     nuTranferActivity ||
                                     ' and or_order_activity.package_id = ' ||
                                     inuPackage_id ||
                                     ' and or_order_activity.status = ' || 'F',
                                     tbOrderActivity);
    
      nuTransferOrder := tbOrderActivity(tbOrderActivity.first).order_id;
    
      If (nuTransferOrder is not null) then
        /*Obtener de la tabla (or_order_activity), las ordenes de entrega asociadas
        a la solicitid de venta*/
        frgDelivOrders := ld_bcNonBankFinancing.frfGetDeliverOrders(inuPackage_id);
      
        FETCH frgDelivOrders BULK COLLECT
          INTO tbDelivOrder;
        CLOSE frgDelivOrders;
      
        nuIndex := tbDelivOrder.FIRST;
      
        WHILE nuIndex IS NOT NULL LOOP
          nuContOt := nuContOt + 1;
        
          /*Busco los diferidos asociados a la orden de transferencia, estos diferidos se buscan
          en la entidad ld_item_work_order*/
        
          dald_item_work_order.getRecords(' order_id=' ||
                                          tbDelivOrder(nuIndex),
                                          tbItemWork);
        
          nuIndexOrder := tbItemWork.FIRST;
        
          /*Se recorre el cursor de las diferidos asociados a la orden de transferencia*/
        
          WHILE nuIndexOrder IS NOT NULL LOOP
          
            nuTotalDife := pktbldiferido.fnugetdifesape(tbItemWork(nuIndex)
                                                        .DIFECODI) -
                           pktbldiferido.fnugetdifesape(tbItemWork(nuIndex)
                                                        .DIFECODI);
          
            nuIndexOrder := tbItemWork.NEXT(nuIndexOrder);
          
          END LOOP;
        
          /* Se valida si la orden de entrega se encuentra legalizada*/
        
          if (daor_order_activity.fsbGetStatus(tbDelivOrder(nuIndex)) = 'F') then
            nuContOtLeg := nuContOtLeg + 1;
          end if;
        
          nuIndex := tbDelivOrder.NEXT(nuIndex);
        
        END LOOP;
      
        If (nuContOt != nuContOtLeg) then
          /*Si las ordenes de entrega no estan legalizadas. Se consulta con la orden de traslado
          de cupo (nuTransferOrder) y el contrato ( inuSuscripc), la tabla ld_Quota_transfer
          y se retorna el valor transferido*/
          dald_quota_transfer.getRecords('ld_quota_transfer.order_id =' ||
                                         nuTransferOrder ||
                                         ' and origin_subscrip_id = ' ||
                                         inuSuscripc,
                                         tbQuotaTransfer);
        
          nuTransferValue := tbQuotaTransfer(tbOrderActivity.first)
                             .trasnfer_value;
        
          nuResult := nuTransferValue;
        
        Else
          /*Si las Ordenes de entrega se encuentran legalizadas Exitosamente, se capturan los
          registros de ordenes asociadas a la solicitud (inuPackage_id), consultando la tabla
          (ld_quota_transfer) y organizando por fecha de registro mas reciente*/
        
          dald_quota_transfer.getRecords(' ld_quota_transfer.order_id =' ||
                                         nuTransferOrder ||
                                         ' order by TRANSFER_DATE desc ',
                                         tbQuotaTransfer);
        
          nuIndex := tbQuotaTransfer.FIRST;
        
          WHILE nuIndex IS NOT NULL LOOP
          
            /* Se valida cuando el contrato ingresado por el parametro se encuentra
            dentro de la Transferencia de Cupo se procede a salir del proceso y captura
            el valor transferido de ese contrato*/
          
            if (tbQuotaTransfer(nuIndex).destiny_subscrip_id = inuSuscripc) then
            
              nuTotalTransferSusc := tbQuotaTransfer(nuIndex).trasnfer_value;
              exit;
            
            else
            
              /* Si no se ha encontrado a un el contrato, se realiza una sumatoria de los contratos anteriores, sumandole
              el valor transferidos para esa orden*/
            
              nuTotalTransfer := nuTotalTransfer + tbQuotaTransfer(nuIndex)
                                .trasnfer_value;
            
            end if;
          
            nuIndex := tbDelivOrder.NEXT(nuIndex);
          
          END LOOP;
        
        End if;
      
        /* Se calcula el valor temporal a partir del la resta de Total diferidos pagados  - Total Contratos Anteriores*/
      
        nuValueTemp := nuTotalDife - nuTotalTransfer;
      
        /*Si el resultado es mayor que cero y menor que el valor transferido del contrato:
        
        Retornar valor del contrato ? ?valor temporal?
        */
      
        if (nuValueTemp > 0) and (nuValueTemp < nuTotalTransferSusc) then
        
          nuResult := nuTotalTransferSusc - nuValueTemp;
        
        end if;
      
        /*Si el valor temporal es menor que cero
        Retornar el valor del transferido del contrato
        */
      
        if (nuValueTemp < 0) then
        
          nuResult := nuTotalTransferSusc;
        
        end if;
      
        /*Si el Valor temporal es mayor que el transferido del contrato, entonces Retornar cero  */
      
        if (nuValueTemp > nuTotalTransferSusc) then
        
          nuResult := ld_boconstans.cnuCero_Value;
        
        end if;
      
      Else
        nuResult := ld_boconstans.cnuCero_Value;
      End if;
    
    else
    
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'No existe el parametro ACT_TYPE_DEL_FNB configurado');
    
    end if;
  
    ut_trace.trace('Finaliza LDC_CALCULACUPOBRILLA.fnuQuotaTransferCalc');
  
    return nuResult;
  
  EXCEPTION
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      if inuRaiseError = 1 then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
      else
        return null;
      end if;
    
  END fnuQuotaTransferCalc;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
  
   Unidad         : UpdDebCos
   Descripcion    : Metodo que actualiza los campos en Ge_subscriber dependiendo de la
                    configuracion que se tenga en la tabla de LD_parameter
  
   Autor          : KBaquero
   Fecha          : 20/05/2013
  
   Parametros       Descripcion
   ============     ===================
    Inuidtype:        Id. tipo de identificacion
    ISbname:          Nombre de cliente
    Isbtel:           Telefono del cliente
    Isbmail:          Email del cliente
    Isbidentid:       Identificacion del Cliente
    Inusubs:          Id. Del Cliente
    opcion:           D: si el cliente ingresado es un Deudor C: Si el
                     cliente ingresado es un coodeudor.
  
   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   04-03-2014       hjgomez.SAO234698     Se valida que exista registro en ge_subs_general_data
   15-11-2013       hjgomez.SAO222578     Se actualizan los datos del deudor y del codeudor
   02/10/2013       jrobayo.SAO218266        Se cambia el metodo para creacion  del nuevo cliente
                                             con datos adicionales
   20/05/2013       KBaquero                 Creacion
  ******************************************************************/
  PROCEDURE UpdDebCos(Inuidtype  in ge_subscriber.ident_type_id%type,
                      Isbidentid in ge_subscriber.identification%type,
                      Isbtel     in ge_subscriber.phone%type,
                      ISbname    in ge_subscriber.subscriber_name%type,
                      Isblastnam in ge_subscriber.subs_last_name%type,
                      Isbmail    in ge_subscriber.e_mail%type,
                      inuAddress in ge_subscriber.address_id%type,
                      IsbBirth   in ge_subs_general_data.date_birth%type,
                      IsbGender  in ge_subs_general_data.gender%type,
                      isbCvSt    in ge_subs_general_data.civil_state_id%type,
                      isbSchool  in ge_subs_general_data.school_degree_id%type,
                      isbProf    in ge_subs_general_data.profession_id%type,
                      opcion     in Varchar2) IS
    boExist       boolean;
    nuClient      ge_subscriber.subscriber_id%type;
    rcClient      DAGE_Subscriber.styGE_Subscriber;
    sbparaid_type ld_parameter.value_chain%type;
    sbparaname    ld_parameter.value_chain%type;
    sbparaPhone   ld_parameter.value_chain%type;
    sbparamail    ld_parameter.value_chain%type;
    sbparaiden    ld_parameter.value_chain%type;
    rcSubs        dage_subs_general_data.styGE_subs_general_data;
  
    /* Variables de coodeudor*/
    sbparanamec    ld_parameter.value_chain%type;
    sbparaPhonec   ld_parameter.value_chain%type;
    sbparamailC    ld_parameter.value_chain%type;
    sbparaid_typec ld_parameter.value_chain%type;
    sbparaidenc    ld_parameter.value_chain%type;
  
  BEGIN
  
    UT_Trace.Trace('INICIA LDC_CALCULACUPOBRILLA.UpdDebCos .. opcion=' ||
                   opcion,
                   15);
  
    --  Obtiene el codigo del cliente a partir de la identificacion
    boExist := GE_BOSubscriber.ValidIdentification(isbIdentId, --in
                                                   inuIdType, --in
                                                   nuClient); --out
  
    --  Si no encontro cliente, debe registrar los datos
    if (nuClient IS null) then
    
      GE_BOSubscriber.Register(nuClient, --  codigo cliente
                               inuIdType, -- Tipo de identificacion
                               isbIdentId, -- Identificacion
                               null,
                               GE_BOConstants.cnuSubscriberTypeNormal, --Suscriptor normal
                               null, -- Direccion
                               Isbtel, -- Telefono
                               isbName, -- Nombre
                               isbLastNam, -- Apellido
                               Isbmail, -- Correo
                               null,
                               null,
                               null,
                               null,
                               null,
                               null,
                               null,
                               GE_BOConstants.cnuSubscriberStaPotential, --Cliente potencial
                               FALSE,
                               inuAddress, -- Id de direccion
                               IsbBirth, -- Fecha de nacimiento
                               null,
                               IsbGender -- Genero
                               );
    
      --  Si encontro cliente, debe actualizar los datos
      dage_subscriber.updaddress(nuClient,
                                 daab_address.fsbGetAddress_Parsed(inuAddress,
                                                                   1),
                                 0);
    
      --Se valida que exista el registro  ge_subs_general_data
      IF (dage_subs_general_data.fblexist(nuClient)) THEN
        dage_subs_general_data.updCivil_State_Id(nuClient, isbCvSt, 0);
        dage_subs_general_data.updSchool_Degree_Id(nuClient, isbSchool, 0);
        dage_subs_general_data.updProfession_Id(nuClient, isbProf);
      
        dage_subs_general_data.updgender(nuClient, IsbGender);
        dage_subs_general_data.upddate_birth(nuClient, IsbBirth);
      else
        --Si no existe, inserta el registro
        rcSubs.subscriber_id    := nuClient;
        rcSubs.civil_state_id   := isbCvSt;
        rcSubs.school_degree_id := isbSchool;
        rcSubs.profession_id    := isbProf;
        rcSubs.gender           := IsbGender;
        rcSubs.date_birth       := IsbBirth;
        dage_subs_general_data.insrecord(rcSubs);
      
      END IF;
    
      UT_Trace.Trace('Actualizando Deudor# ' || nuClient, 15);
    else
    
      --  Obtiene la informacion del cliente
      rcClient := DAGE_Subscriber.frcGetRecord(nuClient);
    
      --  Si son los datos del deudor
      if (opcion = 'D') then
      
        --  Si debe actualizar nombre del deudor
        sbparaname := dald_parameter.fsbGetValue_Chain('UPDATE_DEBTOR_NAME',
                                                       null);
      
        if (sbparaname = ld_boconstans.csbYesFlag) then
        
          rcClient.subscriber_name := isbName;
          rcClient.subs_last_name  := isbLastNam;
        
        end if;
      
        --  Si debe actualizar el telefono deudor
        sbparaPhone := dald_parameter.fsbGetValue_Chain('UPDATE_DEBTOR_PHONE',
                                                        null);
      
        if (sbparaPhone = ld_boconstans.csbYesFlag) then
        
          rcClient.phone := isbTel;
        
        end if;
      
        --  Si debe actualizar el e mail deudor
        sbparamail := dald_parameter.fsbGetValue_Chain('UPDATE_DEBTOR_MAIL',
                                                       null);
      
        if (sbparamail = ld_boconstans.csbYesFlag) then
        
          rcClient.e_mail := isbMail;
        
        end if;
      
        --  Si son los datos del codeudor
      else
      
        --  Si debe actualizar el nombre coodeudor
        sbparanamec := dald_parameter.fsbGetValue_Chain('UPDATE_COSIGNER_NAME',
                                                        null);
      
        if (sbparanamec = ld_boconstans.csbYesFlag) then
        
          rcClient.subscriber_name := isbName;
          rcClient.subs_last_name  := isbLastNam;
        
        end if;
      
        --  Si debe actualizar el telefono coodeudor
        sbparaPhonec := dald_parameter.fsbGetValue_Chain('UPDATE_COSIGNER_PHONE',
                                                         null);
      
        if (sbparaPhonec = ld_boconstans.csbYesFlag) then
        
          rcClient.phone := isbTel;
        
        end if;
      
        --  Si debe actualizar el e mail coodeudor
        sbparamailC := dald_parameter.fsbGetValue_Chain('UPDATE_COSIGNER_MAIL',
                                                        null);
      
        if (sbparamailC = ld_boconstans.csbYesFlag) then
        
          rcClient.e_mail := isbMail;
        
        end if;
      
      END if;
    
      --  Si encontro cliente, debe actualizar los datos
      dage_subscriber.updaddress(nuClient,
                                 daab_address.fsbGetAddress_Parsed(inuAddress,
                                                                   1),
                                 0);
      --Se valida que exista el registro  ge_subs_general_data
      IF (dage_subs_general_data.fblexist(nuClient)) THEN
        dage_subs_general_data.updCivil_State_Id(nuClient, isbCvSt, 0);
        dage_subs_general_data.updSchool_Degree_Id(nuClient, isbSchool, 0);
        dage_subs_general_data.updProfession_Id(nuClient, isbProf);
      
        dage_subs_general_data.updgender(nuClient, IsbGender);
        dage_subs_general_data.upddate_birth(nuClient, IsbBirth);
      else
        --Si no existe, inserta el registro
        rcSubs.subscriber_id    := nuClient;
        rcSubs.civil_state_id   := isbCvSt;
        rcSubs.school_degree_id := isbSchool;
        rcSubs.profession_id    := isbProf;
        rcSubs.gender           := IsbGender;
        rcSubs.date_birth       := IsbBirth;
        dage_subs_general_data.insrecord(rcSubs);
      END IF;
    
      --  Actualiza la informacion del cliente
      DAGE_Subscriber.updRecord(rcClient);
    
    end if;
  
    UT_Trace.Trace('Fin LDC_CALCULACUPOBRILLA.UpdDebCos', 15);
  
  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END UpdDebCos;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
  
   Unidad         : UpdateOrderActivityPack
   Descripcion    : Metodo que realiza la actualizacion del codigo del
                    paquete en todos las actividades de Or_order_activity
  
   Autor          : KBaquero
   Fecha          : 20/05/2013
  
   Parametros       Descripcion
   ============     ===================
    Inupackage:       Id. paquete
    Inuorder:         Id. De orden
  
  
   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   20/05/2013       KBaquero                 Creacion
  ******************************************************************/

  procedure UpdateOrderActivityPack(Inupackage in mo_packages.package_id%type,
                                    Inuorder   in or_order.order_id%type) is
  
    rcor_orderact daor_order_activity.tytbOR_order_activity;
    nuorderacti   or_order_activity.order_activity_id%type;
  
  begin
  
    ut_trace.Trace('INICIO LDC_CALCULACUPOBRILLA.UpdateOrderActivityPack',
                   10);
  
    daor_order_activity.getRecords('order_id =' || Inuorder, rcor_orderact);
  
    if rcor_orderact.count > 0 then
    
      for i in rcor_orderact.FIRST .. rcor_orderact.LAST loop
      
        if rcor_orderact.EXISTS(i) then
        
          /*Se obtienen el numero de la actividad por orden */
        
          nuorderacti := rcor_orderact(i).order_activity_id;
        
          daor_order_activity.updPackage_Id(nuorderacti, Inupackage);
        
        end if;
      
      end loop;
    
    end if;
  
    ut_trace.Trace('FIN LDC_CALCULACUPOBRILLA.UpdateOrderActivityPack', 10);
  
  Exception
    When ex.CONTROLLED_ERROR then
      --rollback;;
      raise ex.CONTROLLED_ERROR;
    When others then
      --rollback;;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
    
  end UpdateOrderActivityPack;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).
  
   Unidad         : IdeInfProm
   Descripcion    : Metodo que el cual dada una identificacion y tipo de identificacion
                    consultara la tabla LD_PROMISSORY, TENIENDO EN CUENTA EL PAQUETE SE IDENTIFICARA LA FECHA DE REGISTRO,
                    Y CON ESTE CAMPO (FECHA DE REGISTRO de la solicitud) se EVualara el parametro MAX_DAYS
                    (si la fecha de registro de la solicitud restandole el sysdate ) es menor o igual al parametro
                    se tomara el registro mas cercano al sysdate  y se enviara esa informacion en un Cursor referenciado.
  
   Autor          : AAcuna
   Fecha          : 22/05/2013
  
   Parametros                 Descripcion
   ============           ===================
   inuTypeId:              Tipo de identificacion
   inuIdentification:      Numero de identificacion
   orfCursorPromissory:    Cursor referenciado con la informacion de la entidad ld_prommisory
  
   Historia de Modificaciones
   Fecha               Autor                 Modificacion
   =========        =========             ====================
   25/05/2013         AAcuna              Creacion
  ******************************************************************/

  PROCEDURE IdeInfProm(inuTypeId           in ld_promissory.ident_type_id%type,
                       inuIdentification   in ld_promissory.identification%type,
                       orfCursorPromissory out constants.tyRefCursor)
  
   is
  
    rcMopackage damo_packages.styMO_packages;
  
  begin
  
    ut_trace.trace('Inicia LDC_CALCULACUPOBRILLA.IdeInfProm');
  
    /*Se valida si el parametro existe y tiene dato configurados*/
  
    if (DALD_PARAMETER.fblexist('MAX_DAYS')) then
    
      if ((nvl(dald_parameter.fnuGetNumeric_Value('MAX_DAYS'),
               LD_BOConstans.cnuCero) <> LD_BOConstans.cnuCero)) then
      
        /*Se toma el registro mas cercano a el sysdate y ademas que la
        fecha de solicitud menos el sysdate sea menor igual al parametro de max days*/
      
        orfCursorPromissory := ld_bcnonbankfinancing.getIdTypeByPrommisory(inuTypeId,
                                                                           inuIdentification);
      
      else
      
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                         'No tiene datos configurado el parametro MAX_DAYS');
      
      end if;
    
    else
    
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'No existe el parametro configurado MAX_DAYS');
    
    end if;
  
    ut_trace.trace('Fin LDC_CALCULACUPOBRILLA.IdeInfProm');
  
  Exception
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
    
  end IdeInfProm;

  /**********************************************************************
    Propiedad intelectual de OPEN International Systems
    Nombre              getLastCosigner
  
    Autor        Andres Felipe Esguerra Restrepo
  
    Fecha               03-sep-2013
  
    Descripcion         Obtiene el ultimo codeudor usado en la venta Brilla
                        a un cliente especifico
  
    ***Parametros***
    Nombre          Descripcion
    inuTypeId        Tipo de identificacion
  inuIdentification    Numero de identificacion
  orfCursorPromissory    Cursor referenciado con la informacion de
              la entidad ld_prommisory
  ***********************************************************************/

  PROCEDURE getLastCosigner(inuTypeId           in ld_promissory.ident_type_id%type,
                            inuIdentification   in ld_promissory.identification%type,
                            orfCursorPromissory out constants.tyRefCursor)
  
   is
  
    rcMopackage damo_packages.styMO_packages;
  
  begin
  
    ut_trace.trace('Inicia LDC_CALCULACUPOBRILLA.getLastCosigner', 10);
  
    /*Se valida si el parametro existe y tiene dato configurados*/
  
    if (DALD_PARAMETER.fblexist('MAX_DAYS')) then
    
      ut_trace.trace('Existe el parametro MAX_DAYS', 10);
    
      if ((nvl(dald_parameter.fnuGetNumeric_Value('MAX_DAYS'),
               LD_BOConstans.cnuCero) <> LD_BOConstans.cnuCero)) then
      
        ut_trace.trace('El parametro MAX_DAYS tiene valor numerico asignado',
                       10);
      
        /*Se toma el registro mas cercano a el sysdate y ademas que la
        fecha de solicitud menos el sysdate sea menor igual al parametro de max days*/
      
        orfCursorPromissory := ld_bcnonbankfinancing.fnuGetLastCosigner(inuTypeId,
                                                                        inuIdentification);
      
        ut_trace.trace('Se obtiene el ultimo codeudor registrado para el cliente',
                       10);
      
      else
      
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                         'No tiene datos configurado el parametro MAX_DAYS');
      
      end if;
    
    else
    
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'No existe el parametro configurado MAX_DAYS');
    
    end if;
  
    ut_trace.trace('Fin LDC_CALCULACUPOBRILLA.getLastCosigner', 10);
  
  Exception
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  end getLastCosigner;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : GetSupplierFIHOSData
  Descripcion    : Obtiene los datos de los proveedores.
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  inuPackageId            Numero de la solicitud.
  
  
  Historia de Modificaciones
  Fecha         Autor               Modificacion
  10-10-2013    JCarmona.SAO219609  Se utiliza el CURSOR que obtiene el canal de venta
                                    del vendedor actual: cuGetunitBySeller.
  
  05-Sep-2013   jcastroSAO212991    Para la asignacion del valor a la variable oblDelivInPoint
                                    se corrige el campo usado de REQUI_APPROV_ANNULM a usar
                                    DELIV_IN_POINT que es el que correpsonde.
                                    Se incluye la validacion de que si para el Contratista
                                    asociado a la Unidad Operativa no se encuentra configuracion
                                    asociada en FICBS, se obtiene el Id del Contratista
                                    generico del parametro CONTRATISTA_CONFIG_DEFAU_FICBS
                                    y se busca para este la configuracion en FICBS que es
                                    la configuracion por defecto a ser tomada.
                                    Open Cali.
  
  ******************************************************************/

  PROCEDURE GetSupplierFIHOSData(inuSubscription     suscripc.susccodi%type,
                                 inuAddress          ab_address.address_id%type,
                                 osbSupplierName     out ge_contratista.nombre_contratista%type,
                                 onuSupplierId       out ge_contratista.id_contratista%type,
                                 osbPointSaleName    out or_operating_unit.name%type,
                                 onuPointSaleId      out or_operating_unit.operating_unit_id%type,
                                 oblTransferQuote    out boolean,
                                 oblCosigner         out boolean,
                                 oblConsignerGasProd out boolean,
                                 oblModiSalesChanel  out boolean,
                                 onuSalesChanel      out ld_suppli_settings.default_chan_sale%type,
                                 osbPromissoryType   out ld_suppli_settings.type_promiss_note%type,
                                 oblRequiApproAnnulm out boolean,
                                 oblRequiApproReturn out boolean,
                                 osbSaleNameReport   out ld_suppli_settings.sale_name_report%type,
                                 osbExeRulePostSale  out ld_suppli_settings.exe_rule_post_sale%type,
                                 osbPostLegProcess   out ld_suppli_settings.leg_process_orders%type,
                                 onuMinForDelivery   out ld_suppli_settings.min_for_delivery%type,
                                 oblDelivInPoint     out boolean,
                                 oblLegDelivOrdeAuto out boolean,
                                 osbTypePromissNote  out ld_suppli_settings.type_promiss_note%type) IS
  
    nuPersonId        number;
    rcPerson          dage_person.styGE_person;
    rcOperatingUnit   daor_operating_unit.styOR_operating_unit;
    tbSuppliSettings  dald_suppli_settings.tytbLD_suppli_settings;
    nuOperatingUnit   or_operating_unit.operating_unit_id%type;
    nuAvailableId     number;
    sbAvailable       varchar2(3200);
    nuSector          number;
    nuZona            number;
    nuError           ge_message.message_id%type;
    sbError           ge_message.description%type;
    nuValidate        number := 0;
    nuContraGeneFICBS ge_contratista.id_contratista%TYPE; -- Id del Contratista generico en FICBS
    boConfContExis    BOOLEAN; -- Configuracion para el Contratista existe en FICBS
  
    CURSOR cugetSuppliSettings(nuSupplierId in ld_suppli_settings.supplier_id%type) IS
      SELECT 1 nuProv
        FROM ld_suppli_settings
       WHERE supplier_id = nuSupplierId;
  
  BEGIN
    --{
    execute immediate 'ALTER SESSION SET NLS_DATE_FORMAT = ' ||
                      '''DD-MM-YYYY HH24:MI:SS''';
  
    /*Obtiene la persona conectada*/
    nuPersonId := GE_BOPersonal.fnuGetPersonId;
  
    open cuGetunitBySeller;
    fetch cuGetunitBySeller
      INTO nuOperatingUnit;
    close cuGetunitBySeller;
  
    if nuOperatingUnit IS not null then
    
      ut_trace.trace('Persona conectada: ' || nuPersonId || ' - unidad : ' ||
                     nuOperatingUnit,
                     10);
    
      dage_person.getRecord(nuPersonId, rcPerson);
    
      daor_operating_unit.getRecord(nuOperatingUnit, rcOperatingUnit);
    
      ut_trace.trace('Persona conectada: ' || nuOperatingUnit, 10);
    
      osbPointSaleName := rcOperatingUnit.name;
    
      onuPointSaleId := rcOperatingUnit.operating_unit_id;
    
      onuSupplierId := rcOperatingUnit.contractor_id;
    
      ut_trace.trace('Identificador del contratista de venta  ' ||
                     onuSupplierId);
    
      if onuSupplierId is not null then
      
        osbSupplierName := dage_contratista.fsbGetNombre_Contratista(rcOperatingUnit.contractor_id);
      
        -- Obtiene la configuracion del Contratista / Proveedor desde FICBS
      
        BEGIN
          --{
          boConfContExis := TRUE; -- Se asume que existe la configuracion para el Contratista en FICBS
        
          dald_suppli_settings.getRecords('ld_suppli_settings.supplier_id = ' ||
                                          onuSupplierId,
                                          tbSuppliSettings);
        
        EXCEPTION
          when ex.CONTROLLED_ERROR then
            -- No encontro configuracion en FICBS para el Contratista asociado a la Unidad Operativa
            boConfContExis := FALSE;
            ut_trace.trace('No existe configuracion en FICBS para el Contratista' ||
                           onuSupplierId ||
                           '. Se buscara la configuracion del Contratista generico en FICBS.');
            --}
        END;
      
        -- Valida si no pudo obtener la configuracion del Contratista / Proveedor desde FICBS
      
        IF (NOT boConfContExis) THEN
          --{
          -- Obtiene el Id del Contratista con que se busca la configuracion generica
          -- en FICBS en caso de que el Contratista asociado a la Unidad Operativa
          -- no este configurado explicitamente
          nuContraGeneFICBS := DALD_PARAMETER.fnuGetNumeric_Value('CONTRATISTA_CONFIG_DEFAU_FICBS');
          ut_trace.trace('Contratista generico en FICBS: ' ||
                         nuContraGeneFICBS);
        
          -- Obtiene la configuracion desde FICBS
        
          open cugetSuppliSettings(nuContraGeneFICBS);
          fetch cugetSuppliSettings
            INTO nuValidate;
          close cugetSuppliSettings;
        
          -- Valida si encontro configuracion en FICBS
        
          if (nvl(nuValidate, 0) <> 1) then
            --{
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'No existe configuracion en FICBS para el Contratista generico:' ||
                                             nuContraGeneFICBS);
            --}
          end if;
        
          -- Obtiene la configuracion desde FICBS para el Contratista generico
          dald_suppli_settings.getRecords('ld_suppli_settings.supplier_id = ' ||
                                          nuContraGeneFICBS,
                                          tbSuppliSettings);
          --}
        END IF;
      
        if (tbSuppliSettings(tbSuppliSettings.first)
           .allow_transf_quota = ld_boconstans.csbYesFlag) then
        
          oblTransferQuote := true;
        
        else
          oblTransferQuote := false;
        
        end if;
      
        if (tbSuppliSettings(tbSuppliSettings.first)
           .debtor_required = ld_boconstans.csbYesFlag) then
        
          oblCosigner := true;
        else
          oblCosigner := false;
        end if;
      
        if (tbSuppliSettings(tbSuppliSettings.first)
           .DEBTOR_PRODUCT_GAS = ld_boconstans.csbYesFlag) then
        
          oblConsignerGasProd := true;
        else
          oblConsignerGasProd := false;
        end if;
      
        if (tbSuppliSettings(tbSuppliSettings.first)
           .SEL_SALES_CHANNEL = ld_boconstans.csbYesFlag) then
        
          oblModiSalesChanel := true;
        else
          oblModiSalesChanel := false;
        end if;
      
        onuSalesChanel := tbSuppliSettings(tbSuppliSettings.first)
                          .default_chan_sale;
      
        osbPromissoryType := tbSuppliSettings(tbSuppliSettings.first)
                             .type_promiss_note;
      
        if (tbSuppliSettings(tbSuppliSettings.first)
           .requi_approv_annulm = ld_boconstans.csbYesFlag) then
        
          oblRequiApproAnnulm := true;
        
        else
          oblRequiApproAnnulm := false;
        
        end if;
      
        if (tbSuppliSettings(tbSuppliSettings.first)
           .requi_approv_return = ld_boconstans.csbYesFlag) then
        
          oblRequiApproReturn := true;
        else
        
          oblRequiApproReturn := false;
        end if;
      
        osbSaleNameReport := tbSuppliSettings(tbSuppliSettings.first)
                             .sale_name_report;
      
        osbExeRulePostSale := tbSuppliSettings(tbSuppliSettings.first)
                              .exe_rule_post_sale;
      
        osbPostLegProcess := tbSuppliSettings(tbSuppliSettings.first)
                             .leg_process_orders;
      
        onuMinForDelivery := tbSuppliSettings(tbSuppliSettings.first)
                             .min_for_delivery;
      
        if (tbSuppliSettings(tbSuppliSettings.first)
           .DELIV_IN_POINT = ld_boconstans.csbYesFlag) then
          -- jcastroSAO212991
          -- .requi_approv_annulm = ld_boconstans.csbYesFlag) then   -- jcastroSAO212991
        
          oblDelivInPoint := true;
        
        else
          oblDelivInPoint := false;
        
        end if;
      
        if (tbSuppliSettings(tbSuppliSettings.first)
           .leg_deliv_orde_auto = ld_boconstans.csbYesFlag) then
        
          oblLegDelivOrdeAuto := true;
        
        else
          oblLegDelivOrdeAuto := false;
        
        end if;
      
        osbTypePromissNote := tbSuppliSettings(tbSuppliSettings.first)
                              .type_promiss_note;
      
      else
      
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                         'La unidad operativa no posee un contratista asociado');
      
      end if;
    
    else
    
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El usuario conectado no posee un unidad operativa asociada');
    
    end if;
    --}
  END GetSupplierFIHOSData;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         :  getFIHOSInfo
  Descripcion    : Obtiene informacion para la ejecucion de FOHOS
  
  Autor          :  eramos
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuPackageId:        Identificador de la solicitud
  otbArtcile:          Tabla con articulos relacionados con la venta
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE getFIHOSInfo(inuSubscription     in suscripc.susccodi%type,
                         osbIdentType        out varchar2,
                         osbIdentification   out ge_subscriber.identification%type,
                         onuSubscriberId     out ge_subscriber.subscriber_id%type,
                         osbSubsName         out ge_subscriber.subscriber_name%type,
                         osbSubsLastName     out ge_subscriber.subs_last_name%type,
                         osbAddress          out ab_address.address_parsed%type,
                         onuAddress_Id       out ab_address.address_id%type,
                         onuGeoLocation      out ge_geogra_location.geograp_location_id%type,
                         osbFullPhone        out ge_subs_phone.full_phone_number%type,
                         osbCategory         out varchar2,
                         osbSubcategory      out varchar2,
                         onuCategory         out number,
                         onuSubcategory      out number,
                         onuRedBalance       out number,
                         onuAssignedQuote    out number,
                         onuUsedQuote        out number,
                         onuAvalibleQuote    out number,
                         osbSupplierName     out ge_contratista.nombre_contratista%type,
                         onuSupplierId       out ge_contratista.id_contratista%type,
                         osbPointSaleName    out or_operating_unit.name%type,
                         onuPointSaleId      out or_operating_unit.operating_unit_id%type,
                         oblTransferQuote    out boolean,
                         oblCosigner         out boolean,
                         oblConsignerGasProd out boolean,
                         oblModiSalesChanel  out boolean,
                         onuSalesChanel      out ld_suppli_settings.default_chan_sale%type,
                         osbPromissoryType   out ld_suppli_settings.type_promiss_note%type,
                         oblRequiApproAnnulm out boolean,
                         oblRequiApproReturn out boolean,
                         osbSaleNameReport   out ld_suppli_settings.sale_name_report%type,
                         osbExeRulePostSale  out ld_suppli_settings.exe_rule_post_sale%type,
                         osbPostLegProcess   out ld_suppli_settings.leg_process_orders%type,
                         onuMinForDelivery   out ld_suppli_settings.min_for_delivery%type,
                         oblDelivInPoint     out boolean,
                         oblLegDelivOrdeAuto out boolean,
                         osbTypePromissNote  out ld_suppli_settings.type_promiss_note%type,
                         onuInsuranceRate    out number,
                         odtDate_Birth       out ge_subs_general_data.date_birth%TYPE,
                         osbGender           out ge_subs_general_data.gender%TYPE,
                         odtPefeme           out perifact.pefafeem%TYPE,
                         osbValidateBill     OUT VARCHAR2) IS
  
    nuSesunuse servsusc.sesunuse%type;
    rcperifact perifact%Rowtype;
    ciclo      servsusc.sesucicl%TYPE;
  
  BEGIN
  
    /* Obtengo el producto del servicio gas del contrato*/
    nuSesunuse := Fnugetsesunuse(inuSubscription, null);
    if (nuSesunuse is null) then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El contrato no tiene un servicio de gas activo');
    end if;
  
    GetSubcriptionData(inuSubscription,
                       osbIdentType,
                       osbIdentification,
                       onuSubscriberId,
                       osbSubsName,
                       osbSubsLastName,
                       osbAddress,
                       onuAddress_Id,
                       onuGeoLocation,
                       osbFullPhone,
                       osbCategory,
                       osbSubcategory,
                       onuCategory,
                       onuSubcategory,
                       onuRedBalance,
                       onuAssignedQuote,
                       onuUsedQuote,
                       onuAvalibleQuote);
  
    GetSupplierFIHOSData(inuSubscription,
                         onuAddress_Id,
                         osbSupplierName,
                         onuSupplierId,
                         osbPointSaleName,
                         onuPointSaleId,
                         oblTransferQuote,
                         oblCosigner,
                         oblConsignerGasProd,
                         oblModiSalesChanel,
                         onuSalesChanel,
                         osbPromissoryType,
                         oblRequiApproAnnulm,
                         oblRequiApproReturn,
                         osbSaleNameReport,
                         osbExeRulePostSale,
                         osbPostLegProcess,
                         onuMinForDelivery,
                         oblDelivInPoint,
                         oblLegDelivOrdeAuto,
                         osbTypePromissNote);
  
    /* Obtengo el ciclo de facturacion  del servicio gas*/
  
    ciclo := pktblservsusc.fnuGetSesucicl(nuSesunuse);
  
    /* Obtengo el periodo de facturacion a partir del ciclo del producto gas*/
  
    pkbcperifact.getcurrperiodbycycle(ciclo, rcperifact);
  
    /* Se asigna la fecha de emision a la variable de salida  odtPefeme*/
  
    odtPefeme := rcperifact.pefafeem;
  
    odtDate_Birth := dage_subs_general_data.fdtGetDate_Birth(inuSubscriber_Id => onuSubscriberId,
                                                             inuRaiseError    => 0);
    osbGender     := dage_subs_general_data.fsbGetGender(inuSubscriber_Id => onuSubscriberId,
                                                         inuRaiseError    => 0);
  
    onuInsuranceRate := dald_parameter.fnuGetNumeric_Value('INSURANCE_RATE');
  
    osbValidateBill := dald_parameter.fsbGetValue_Chain('VALIDATE_BILL');
  
  END getFIHOSInfo;

  FUNCTION fnuSubshasExpirDebt(inuPackageId in mo_packages.package_id%type)
    RETURN Number IS
    nuCount     number := 0;
    nuValue     number := 0;
    nuExpirDebt number := 0;
    nuSuscripc  suscripc.susccodi%type;
  
    CURSOR cuGetBillPayment IS
      select count(1) FLAG_VALIDATE
        From ld_bill_pending_payment
       where package_id = inuPackageId
         and payment = 'Y';
  
  BEGIN
    ut_trace.trace('Inicio LDC_CALCULACUPOBRILLA.fnuSubshasExpirDebt ' ||
                   inuPackageId,
                   10);
  
    open cuGetBillPayment;
    fetch cuGetBillPayment
      INTO nuCount;
    close cuGetBillPayment;
  
    -- si cuando se registro no habian facturas vencidas no se validan ahora
    if (nuCount = 0) then
      return 0;
    END if;
  
    nuSuscripc := damo_packages.fnugetsubscription_pend_id(inuPackageId);
  
    nuExpirDebt := GC_BODEBTMANAGEMENT.fnuGetExpirDebtBySusc(nuSuscripc);
    ut_trace.trace('Deuda ' || nuExpirDebt, 10);
  
    if (nuExpirDebt > 0) then
      nuValue := 1;
    END if;
    ut_trace.trace('Fin LDC_CALCULACUPOBRILLA.fnuSubshasExpirDebt', 10);
  
    return nuValue;
  
  Exception
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuSubshasExpirDebt;

  FUNCTION availableQuota(inuSuscripc in suscripc.susccodi%type)
    RETURN Number IS
    nuAssignedQuote number := 0;
    nuUsedQuote     number := 0;
    nuAvalibleQuote number := 0;
  BEGIN
    ut_trace.trace('Inicio LDC_CALCULACUPOBRILLA.availableQuota ' ||
                   inuSuscripc,
                   10);
  
    if pktblsuscripc.fblExist(inuSuscripc) THEN
      LDC_CALCULACUPOBRILLA.AllocateTotalQuota(inuSuscripc,
                                               nuAssignedQuote);
      nuUsedQuote := LDC_CALCULACUPOBRILLA.fnuGetUsedQuote(inuSuscripc);
      IF (nuAssignedQuote >= nuUsedQuote) THEN
        nuAvalibleQuote := nuAssignedQuote - nuUsedQuote;
      ELSE
        nuAvalibleQuote := 0;
      END IF;
    END IF;
    ut_trace.trace('Fin LDC_CALCULACUPOBRILLA.availableQuota', 10);
    RETURN nuAvalibleQuote;
  
  Exception
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
    
  END availableQuota;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : UpdAditionalDataSaleFNB
  Descripcion    : Guarda datos adicionales de la venta, en este servicio se actualizara
                   la cuota aproximada mensual, valor aproximado del seguro y el valor total de la venta
  Autor          : Evelio Sanjuanelo
  Fecha          : 18/Julio/2013
  
  Parametros              Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  24-10-2013      jhagudelo.SAO221218 Se incluyo el parametro de entrada inutransfer para
                                      indica si hubo o no traslado de cupo(Y-N).
  ******************************************************************/
  PROCEDURE UpdAditionalDataSaleFNB(inuPackage_id ld_non_ba_fi_requ.non_ba_fi_requ_id%type,
                                    --Cuota aproximada mensual
                                    inuquota_Aprox_Month ld_non_ba_fi_requ.quota_aprox_month%type,
                                    --Cuota aproximada mensual del seguro
                                    inuvalue_aprox_insurance ld_non_ba_fi_requ.value_aprox_insurance%type,
                                    --Valor total de la venta
                                    inuvalue_total ld_non_ba_fi_requ.value_total%type,
                                    --Traslado de cupo(Y-N)
                                    inutransfer ld_non_ba_fi_requ.trasfer_quota%type) IS
  BEGIN
    update LD_NON_BA_FI_REQU l
       set l.Quota_Aprox_Month     = inuquota_Aprox_Month,
           l.value_aprox_insurance = inuvalue_aprox_insurance,
           l.value_total           = inuvalue_total,
           l.trasfer_quota         = inutransfer
     where l.non_ba_fi_requ_id = inuPackage_id;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END UpdAditionalDataSaleFNB;

  /***************************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Procedure   :   fnuGetVisitTypeByPackage
  Descripcion :   Retorna el Tipo de Visita dada la solicitud.
  
  Autor       :   Jorge Alejandro Carmona Duque
  Fecha       :   27-08-2013
  Parametros  :
      inuPackageId:    Identificador de la Solicitud.
  
  Retorno     : Tipo de Visita.
  
  Historia de Modificaciones
  Fecha      IDEntrega               Descripcion
  ==========  ======================= ========================================
  27-08-2013  JCarmona.SAO215223      Creacion.
  ***************************************************************************/
  FUNCTION fnuGetVisitTypeByPackage(inuPackageId in mo_packages.package_id%type)
    RETURN ld_sales_visit.visit_type_id%type IS
    nuVisitTypeId ld_sales_visit.visit_type_id%type;
  BEGIN
  
    UT_Trace.Trace('END LDC_CALCULACUPOBRILLA.fnuGetVisitTypeByPackage[' ||
                   inuPackageId || ']',
                   1);
  
    /* Obtiene el tipo de visita dada la solicitud*/
    nuVisitTypeId := LD_BCNONBANKFINANCING.fnuGetVisitTypeByPackage(inuPackageId);
  
    UT_Trace.Trace('END LDC_CALCULACUPOBRILLA.fnuGetVisitTypeByPackage', 1);
    return nuVisitTypeId;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuGetVisitTypeByPackage;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : validatedSolAnuDevPend
  Descripcion :   Valida si existen solicitudes de anulacion o devolucion asociadas
                  a una solicitud de venta registradas
  
  Autor       :   Erika Alejandra Montenegro Gaviria
  Fecha       :   30-08-2013
  
  Parametros       Descripcion
  ============     ===================
  
  Historia de Modificaciones
  Fecha            Autor                 Modificacion
  =========        =========             ====================
  26/08/2013       emontenegro.SAO212156    Creacion
  ******************************************************************/
  PROCEDURE validatedSolAnuDevPend(inuPackageSale in mo_packages.package_id%type) IS
    nuCont number;
  BEGIN
  
    /*Obtiene el numero de solicitudes de Anu/Dev que se encuentran registradas*/
    nuCont := ld_bcnonbankfinancing.fnuGetSolAnuDevPend(inuPackageSale);
    /*Se valida si tiene por lo menos una, no permite registrar una nueva solicitud
    de anulacion o devlucion*/
    if (nuCont > 0) then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'La solicitud de venta ya tiene una solicitud de
                                         Anulacion/Devolucion Registrada');
    END if;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END validatedSolAnuDevPend;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fsbValAvailability
  Descripcion :   Valida la disponibilidad para la fecha de venta
  
  Autor       :   Albeyro Echeverry Pineda
  Fecha       :   04-09-2013
  
  Parametros       Descripcion
  ============     ===================
  
  Historia de Modificaciones
  Fecha            Autor                 Modificacion
  =========        =========             ====================
  26/08/2013       AEcheverry.SAO212156    Creacion
  ******************************************************************/
  function fsbValAvailability(inuSubscription in suscripc.susccodi%type,
                              inuAddress      in ab_address.address_id%type,
                              idtSaleDate     in mo_packages.request_date%type)
    return varchar IS
  
    nuSector        number;
    nuZona          number := null;
    nuOperatingUnit number;
    nuDays          number;
    CURSOR cuGetAvailable(inuOperUnitId in OR_operating_unit.operating_unit_id%type) IS
      SELECT ld_available_unit.operating_zone_id
        FROM ld_available_unit
       WHERE trunc(idtSaleDate) between ld_available_unit.initial_date AND
             ld_available_unit.final_date
         AND ld_available_unit.operating_unit_id = inuOperUnitId
         AND rownum = 1;
  
  BEGIN
  
    open cuGetunitBySeller;
    fetch cuGetunitBySeller
      INTO nuOperatingUnit;
    close cuGetunitBySeller;
  
    open cuGetAvailable(nuOperatingUnit);
    fetch cuGetAvailable
      INTO nuZona;
    close cuGetAvailable;
  
    nuDays := nvl(dage_parameter.fsbgetvalue('CC_MAX_DAYS_REGISTER', 0), 0);
  
    if (trunc(sysdate - nuDays) > trunc(idtSaleDate)) then
      return 'La fecha de registro no puede ser menor a: ' || trunc(sysdate -
                                                                    nuDays);
    END if;
  
    ut_trace.trace('Identificador de direccion  [' || inuAddress ||
                   '], Identificador de la Zona  ' || nuZONA,
                   10);
  
    AB_BCAddress.getOperSectByAddress(inuAddress, nuSector);
  
    if (nuZona IS null) then
      nuZONA := ld_bcnonbankfinancing.fnuexistvalida_zona_asignada(nuOperatingUnit,
                                                                   inuSubscription,
                                                                   idtSaleDate);
    
      if nuZONA <= 0 then
        return 'La unidad operativa [' || nuOperatingUnit || '] no aplica para ventas por stand';
      else
        ut_trace.trace('La unidad operativa ' || nuOperatingUnit ||
                       ' aplica para ventas por stand',
                       10);
      end if;
    else
    
      if not
          LD_BCNONBANKFINANCING.FnuValidateZonaSectorOpera(nuSector, nuZONA) then
      
        ut_trace.trace('No existe disponibilidad de la unidad operativa para la ubicacion geografica');
      
        if ld_bcnonbankfinancing.fnuexistvalida_zona_asignada(nuOperatingUnit,
                                                              inuSubscription,
                                                              idtSaleDate) = 0 then
          return 'La unidad operativa no posee disponibilidad para la direccion del producto';
        
        else
          ut_trace.trace('Aplica para ventas por stand');
        end if;
      
      end if;
    
    END if;
  
    return 'Y';
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fsbValAvailability;

  /**********************************************************************
  Propiedad intelectual de OPEN International Systems
  Nombre
  Autor               Andres Hurtado Gutierrez.
  Fecha               9/5/2013 8:27:04 AM
  
  Descripcion         Retorna TRUE si el contratista del parametro es el exito
  
  Parametros
  Nombre              Descripcion
  inuContractorId     El codigo del contratista
  
  Historia de Modificaciones
  Fecha             Autor         Modificacion
  ***********************************************************************/
  FUNCTION fnuBoIsProvExito(inuContractorId ge_contratista.id_contratista%type)
    RETURN boolean IS
  BEGIN
    RETURN dald_parameter.fnuGetNumeric_Value('CODI_CUAD_EXITO', 0) = inuContractorId;
  END;

  /**********************************************************************
  Propiedad intelectual de OPEN International Systems
  Nombre
  Autor               Andres Hurtado Gutierrez.
  Fecha               9/5/2013 8:27:04 AM
  
  Descripcion         Retorna TRUE si el contratista del parametro es Olimpica
  
  Parametros
  Nombre              Descripcion
  inuContractorId     El codigo del contratista
  
  Historia de Modificaciones
  Fecha             Autor         Modificacion
  ***********************************************************************/
  FUNCTION fnuBoIsProvOlimpica(inuContractorId ge_contratista.id_contratista%type)
    RETURN boolean IS
  BEGIN
    RETURN dald_parameter.fnuGetNumeric_Value('CODI_CUAD_OLIMPICA', 0) = inuContractorId;
  END;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : RegisterExtraQuotaFNB
  Descripcion    : Registra el cupo extra utilizado en la venta.
  Autor          :
  Fecha          : 04/09/2013
  
  Parametros              Descripcion
  ============         ===================
  inuExtraQuota        Cupo extra
  inuSubscription      Contrato sobre el que se realiza la venta
  inuUsedQuota         Cupo utilizado
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  04-09-2013     emontenegro. SAO215832   Creacion.
  ******************************************************************/
  PROCEDURE RegisterExtraQuotaFNB(inuExtraQuota   ld_extra_quota.extra_quota_id%type,
                                  inuSubscription suscripc.susccodi%type,
                                  inuUsedQuota    ld_quota_historic.result%type) IS
  
    rcExtraQuotaFNB dald_extra_quota_fnb.styLD_EXTRA_QUOTA_FNB;
  
  BEGIN
  
    rcExtraQuotaFNB := ld_bcnonbankfinancing.frcGetExtraQuotaFNB(inuExtraQuota,
                                                                 inuSubscription);
  
    if rcExtraQuotaFNB.subscription_id is null then
      rcExtraQuotaFNB.extra_quota_id  := inuExtraQuota;
      rcExtraQuotaFNB.subscription_id := inuSubscription;
      rcExtraQuotaFNB.used_quota      := inuUsedQuota;
      dald_extra_quota_fnb.insRecord(rcExtraQuotaFNB);
    else
      rcExtraQuotaFNB.used_quota := rcExtraQuotaFNB.used_quota +
                                    inuUsedQuota;
      dald_extra_quota_fnb.updRecord(rcExtraQuotaFNB);
    end if;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END RegisterExtraQuotaFNB;

  PROCEDURE GetSubscriberInfo(inuTypeId           in ge_subscriber.subscriber_id%type,
                              inuIdentification   in ge_subscriber.identification%type,
                              orfCursorPromissory out constants.tyRefCursor) IS
  
    boExist boolean;
  
  begin
  
    ut_trace.trace('Inicia LDC_CALCULACUPOBRILLA.GetSubscriberInfo', 1);
  
    orfCursorPromissory := ld_bcnonbankfinancing.frcGetSubscriberInfo(inuTypeId,
                                                                      inuIdentification);
  
    ut_trace.trace('Fin LDC_CALCULACUPOBRILLA.GetSubscriberInfo', 1);
  
  Exception
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
    
  END GetSubscriberInfo;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : GetConsecutiveByReq
  Descripcion    :Obtiene el consecutivo (manual/digital) de una solicitud de
                  financiacion no bancaria
  
  Autor          :
  Fecha          : 11/07/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE GetConsecutiveByReq(inuRequestId   in ld_non_ba_fi_requ.non_ba_fi_requ_id%type,
                                onuConsecutive out ld_non_ba_fi_requ.manual_prom_note_cons%type) IS
  
    tbRequest dald_non_ba_fi_requ.styLD_non_ba_fi_requ;
  
  BEGIN
  
    ut_trace.trace('Inicio - LDC_CALCULACUPOBRILLA.GetConsecutiveByReq', 5);
  
    tbRequest := dald_non_ba_fi_requ.frcGetRecord(inuRequestId);
  
    onuConsecutive := tbRequest.manual_prom_note_cons;
  
    if (onuConsecutive IS null) then
      onuConsecutive := tbRequest.digital_prom_note_cons;
    END if;
  
    ut_trace.trace('Fin - LDC_CALCULACUPOBRILLA.GetConsecutiveByReq', 5);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetConsecutiveByReq;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuAllocateTotalQuota
  Descripcion    : Funcion que retorna el cupo real de un contrato
  
  Autor          :
  Fecha          : 12/10/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  12-oct-2013     AEcheverrySAO219857 <<Creacion>> Se  crea para utilizarlo en
                                      la sentencia de cupo simulado (sin uso de transacciones)
  ******************************************************************/
  FUNCTION fnuAllocateTotalQuota(inuSubscription suscripc.susccodi%type)
    return ld_credit_quota.quota_value%type IS
    nuTotal ld_credit_quota.quota_value%type;
  BEGIN
  
    AllocateTempQuota(inuSubscription, null, nuTotal);
  
    return nvl(nuTotal, 0);
  Exception
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuAllocateTotalQuota;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : fnuAllocateTotalQuota
  Descripcion    : Funcion que retorna el cupo real de un contrato, usado
                   para cupo parcial
  
  Autor          :
  Fecha          : 12/10/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  29-Oct-2013     LDiuza              Se  crea para utilizarlo en
                                      la financiacion no bacaria cuando aplica
                                      cupo parcial
  24-09-2014          llozada         Se modifica el llamado al parametro COD_POLICY_HISTORIC,
                                      en este parametro ahora se pueden modificar varias politicas,
                                      para esto se hace la validacion con la funcion fblValidatePartialQuota
  ******************************************************************/
  FUNCTION fnuAllocatQuotaZeroCons(inuSubscription suscripc.susccodi%type)
    RETURN ld_credit_quota.quota_value%type IS
    nuTotal       ld_credit_quota.quota_value%type;
    nuUsedQuota   ld_credit_quota.quota_value%type;
    nuQuotaPolicy ld_quota_assign_policy.quota_assign_policy_id%type;
  
    CURSOR cuPolicyPartialQuota IS
      SELECT column_value
        FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbGetValue_Chain('COD_POLICY_HISTORIC'),
                                                ','));
  BEGIN
    -- Se obtiene el id de la politica consumo cero, para que al evaluar el consumo no la tenga en cuenta
    --nuQuotaPolicy := dald_parameter.fnuGetNumeric_Value('COD_POLICY_HISTORIC');
    --24-09-2014 [Llozada]
    --24-09-2014 [Llozada RQ 1172]: Se envia -1 para indicar que es cupo parcial
    AllocateTempQuota(inuSubscription, -1, nuTotal);
  
    /*FOR rc IN cuPolicyPartialQuota LOOP
        AllocateTempQuota(inuSubscription, rc.column_value, nuTotal);
        ut_trace.trace('Cupo Total: '||nuTotal, 10);
    
        IF nuTotal IS NOT NULL THEN
            exit;
        END IF;
    END LOOP;*/
  
    nuUsedQuota := LDC_CALCULACUPOBRILLA.fnuGetUsedQuote(inuSubscription);
    ut_trace.trace('Cupo Usado: ' || nuUsedQuota, 10);
  
    nuTotal := nuTotal - nuUsedQuota;
  
    IF (nuTotal < 0) THEN
      nuTotal := 0;
    END IF;
    ut_trace.trace('Cupo Disponible: ' || nuTotal, 10);
  
    RETURN nvl(nuTotal, 0);
  
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      raise ex.CONTROLLED_ERROR;
    WHEN others THEN
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnuAllocatQuotaZeroCons;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : AllocateTempQuota (Copia de AllocateQuota)
  Descripcion    : Obtiene el cupo real similar a (AllocateQuota) sin manejo de transacciones
                  ni historicos, no registra en la base de datos
  
  Autor          :
  Fecha          : 12/10/2012
  
  Parametros              Descripcion
  ============         ===================
  inuSubscription: Identificador del contrato.
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  03-04-2014      AEcheverrySAO234429 Se modifica para quitar accesos inecesarios
                                      a suscripc y producto, se eliminan
                                      validaciones innecesarias.
  12-oct-2013     AEcheverrySAO219857 <<Creacion>> Se  crea para utilizarlo en el
                                      calculo de cupo simulado (sin uso de transacciones)
  ******************************************************************/
  PROCEDURE AllocateTempQuota(inuSubscription in suscripc.susccodi%type,
                              inuAssignPolicy in ld_quota_assign_policy.quota_assign_policy_id%type,
                              onuTotal        out ld_credit_quota.quota_value%type) IS
    -- parametros
    nuGasAddressId   ab_address.address_id%type;
    nuProduct        number;
    rcSubscription   suscripc%rowtype;
    nuGeogLoca       ge_geogra_location.geograp_location_id%type;
    sbParentLocation varchar2(2000);
    tbCreditQuota    dald_credit_quota.tytbLD_credit_quota;
    blPolicyResult   boolean;
    rcServsusc       servsusc%rowtype;
    tbManualQuota    dald_manual_quota.tytbLD_manual_quota;
    tbBlockQuota     dald_quota_block.tytbBlock;
    subscriberId     ge_subscriber.subscriber_id%type;
    nuCategory       Servsusc.Sesucate%type;
    nuSubcategory    Servsusc.Sesusuca%type;
    tbSesuServ       pktblservsusc.tySesuserv;
    tbSesuType       pktblservsusc.tySesunuse;
    nuServ           servsusc.sesuserv%type;
    nuSesunuse       servsusc.sesunuse%type;
    nuDifesape       diferido.difesape%type := 0;
    rcRollover       ld_bcnonbankfinancing.tytbLD_Rollover_quota;
    nuIndex          number;
    nuProductType    ld_rollover_quota.product_type_id%type;
    nuValue          ld_rollover_quota.value%type;
    sbQuota_option   ld_rollover_quota.Quota_option%type;
    nuTotal          ld_credit_quota.quota_value%type;
    nuQuotas_number  ld_rollover_quota.quotas_number%type;
    nuCont           number := 0;
    nuValidator      number := 0;
  
    nuDifenucu diferido.difenucu%type;
  
    rcQuotaHistoric   dald_quota_historic.styLD_quota_historic;
    tbPolicyHist      dald_policy_historic.tytbLD_policy_historic;
    nuquotavalue      ld_credit_quota.quota_value%type;
    rcAddress         daab_address.styAb_address;
    nuNeighborthoodId ab_address.neighborthood_id%type;
  
    nuLevelAsig   NUMBER := -1;
    nuTempAsig    NUMBER;
    nuTempTotal   NUMBER := -1;
    tbString      ut_string.TyTB_String;
    tbTempString  ut_string.TyTB_String;
    blAssigByArea boolean;
  
  BEGIN
  
    ut_trace.trace('Inicia LDC_CALCULACUPOBRILLA.AllocateTempQuota', 1);
    onuTotal     := cnuQuotaCero;
    nuQuotaTotal := cnuQuotaCero;
  
    /*Obtiene los datos del producto gas*/
    getGasProductData(inuSubscription, nuProduct, nuGasAddressId);
  
    dtMaxBreachDate := null;
  
    /*Valida si el contrato tiene producto gas*/
    ut_trace.trace('nuProduct: ' || nuProduct, 10);
  
    if nuProduct is not null then
    
      /*Obtiene los datos del suscritor retornando un tipo record*/
      rcSubscription := pktblsuscripc.frcgetrecord(inuSubscription);
    
      /*se obtiene el cliente para el proceso de cupo rollover*/
      subscriberId := rcSubscription.suscclie;
      /*Obtiene la ubicacion geografica a partir de la direccion del producto gas*/
      nuGeogLoca := daab_address.fnuGetGeograp_Location_Id(nuGasAddressId);
      /*Obtiene el record de los datos del sesunuse del servicio gas*/
      rcServsusc := pktblservsusc.frcGetRecord(nuProduct);
      /*Obtiene la subcategoria del servicio gas*/
      nuSubcategory := rcServsusc.Sesusuca;
      /*Obtiene la categoria del servicio gas*/
      nuCategory := rcServsusc.Sesucate;
    
      /* Se obtienen los datos de la direccion */
      rcAddress := daab_address.frcgetrcdata(rcSubscription.susciddi);
    
      nuNeighborthoodId := rcAddress.neighborthood_id;
    
      /* Valida si debe obtener la asignacion de cupo del barrio o de la localidad */
      IF (nuNeighborthoodId IS null OR
         nuNeighborthoodId = LD_BOConstans.cnuallrows) THEN
        /*Obtiene los padres de la ubicacion geografica*/
        ge_bogeogra_location.GetGeograpParents(nuGeogLoca,
                                               sbParentLocation);
      else
        /*Obtiene los padres de la ubicacion geografica*/
        ge_bogeogra_location.GetGeograpParents(nuNeighborthoodId,
                                               sbParentLocation);
      END IF;
    
      /*Obtiene la direccion parseada de la ubicacion geografica*/
      tbCreditQuota := LD_BCNONBANKFINANCING.ftbGetCreditQuote(rcServsusc.Sesucate,
                                                               rcServsusc.Sesusuca,
                                                               sbParentLocation);
    
      ------------------------------------------------------------------------------------
      /*Valida si tiene credito*/
      if (tbCreditQuota.count > 0) then
      
        /*Se valida el valor a evaluar. Si el proceso que se ejecuto anteriomente fue
        un bloqueo de cupo el valor a procesar sera cero, en caso contrario el que
        se encuentre almacenado en la tabla tbCreditQuota*/
        if nuswblockquota = ld_boconstans.cnuonenumber then
          nuquotavalue := ld_boconstans.cnuCero_Value;
        else
          nuquotavalue := tbCreditQuota(tbCreditQuota.first).quota_value;
        end if;
      
        /*Le asigna el valor que le corresponde por politica de cupo*/
        blPolicyResult := fblExcecutePolicy(tbCreditQuota(tbCreditQuota.first)
                                            .credit_quota_id,
                                            inuSubscription,
                                            nuquotavalue,
                                            inuAssignPolicy,
                                            rcQuotaHistoric,
                                            tbPolicyHist);
      else
        onuTotal := cnuQuotaCero;
      end if;
    
      /*Valida si el contrato tiene un cupo de politica definido*/
      if (blPolicyResult) then
        onuTotal := tbCreditQuota(tbCreditQuota.first).quota_value;
      
        /*Si el valor asignado por politica es mayor a cero se le asigna a la variable
        global valor final de cuota el valor de la politica*/
      
        if (onuTotal > nuQuotaTotal) then
          nuQuotaTotal := onuTotal;
        end if;
      
        onuTotal := nuQuotaTotal;
        /* Se le asigna una couta con valor cero*/
      else
        onuTotal := cnuQuotaCero;
        -- si no se evaluaron politicas -->NO SE DEBE ASIGNAR CUPO MANUAL
        if (tbPolicyHist.count < 1) then
          dtMaxBreachDate := TRUNC(SYSDATE);
        END if;
      end if;
    
      /* Valido que el cursor de cuota manual trae registros , asi verifico que
      el contrato tenga un cupo manual reciente. */
    
      /*Recorre las politicas para verificar la fecha m?xima de incumplimiento*/
      nuIndex := tbPolicyHist.first;
    
      while nuIndex is not null loop
      
        if tbPolicyHist(nuIndex).breach_date is not null then
        
          if (dtMaxBreachDate IS null) OR
             (dtMaxBreachDate < tbPolicyHist(nuIndex).breach_date) then
          
            dtMaxBreachDate := tbPolicyHist(nuIndex).breach_date;
          
          end if;
        
        end if;
      
        nuIndex := tbPolicyHist.next(nuIndex);
      end loop;
    
      /*Manejo para cupo manual*/
      tbManualQuota := LD_BCNONBANKFINANCING.FtbGetbestManualQuota(inuSubscription);
      /*Recorrido para asignacion de cuota manual */
      nuIndex := tbManualQuota.first;
    
      while nuIndex is not null loop
        if (nvl(dtMaxBreachDate, tbManualQuota(nuIndex).initial_date - 1) < tbManualQuota(nuIndex)
           .initial_date) then
        
          /* Verifico  si el valor de la cuota manual
          es mayor al que trae la variable global de cupo final, entonces
          se le asigna a la varible global la couta manual*/
          if (tbManualQuota(nuIndex).quota_value > nuQuotaTotal) then
            nuQuotaTotal := tbManualQuota(nuIndex).quota_value;
          end if;
        
          onuTotal := nuQuotaTotal;
        end if;
      
        nuIndex := tbManualQuota.next(nuIndex);
      
      end loop;
    
      /*Obtiene los bloqueos de cupo*/
      tbBlockQuota := LD_BCNONBANKFINANCING.FtbGetQuota_Block(inuSubscription);
    
      /* Trae el registro de bloqueo y desbloqueo mas reciente a partir del contrato*/
      if tbBlockQuota.count > 0 then
      
        /* Verifica que el contrato tenga cupo bloqueado */
        if (tbBlockQuota(tbBlockQuota.first) = 'Y') then
          nuQuotaTotal := cnuQuotaCero;
          onuTotal     := cnuQuotaCero;
          goto final;
        end if;
      
        nuQuotaTotal := onuTotal;
      else
        nuQuotaTotal := onuTotal;
      end if;
    
      /*Valida que el subscriber no sea not null*/
      if (subscriberId is not null) then
      
        /*Obtengo los tipos productos Brilla y brilla Promigas asociados al cliente*/
        tbSesuServ := ld_bcnonbankfinancing.FtbGetServBySubscr(subscriberId);
      
        /*Valida que el cliente por lo menos tenga un tipo producto asociado*/
        if tbSesuServ.count > 0 then
          /* Se obtiene la configuracion de asignacion de cupo llamando al cursor
          de calculo de rollover*/
          ld_bcnonbankfinancing.GetConfRolloverQuota(nuCategory,
                                                     nuSubcategory,
                                                     sbParentLocation,
                                                     rcRollover);
        
          nuIndex := rcRollover.FIRST;
          While nuIndex Is Not Null Loop
            /* Obtiene los datos de configuracion de rollover*/
            nuProductType := rcRollover(nuIndex).product_type_id;
          
            nuValue := rcRollover(nuIndex).value;
          
            sbQuota_option := rcRollover(nuIndex).quota_option;
          
            nuQuotas_number := rcRollover(nuIndex).quotas_number;
          
            /* Busca los servicios asociados al cliente y tipo de producto
            capturado de la configuracion*/
            tbSesuType := ld_bcnonbankfinancing.FtbGetServByProdTy(subscriberId,
                                                                   nuProductType);
            /* Recorro el tipo tabla para saber si el cliente tiene saldo pendiente
            por un producto*/
            if tbSesuType.count > 0 then
              nuCont := nuCont + 1;
              for i in tbSesuType.FIRST .. tbSesuType.LAST loop
                nuSesunuse := tbSesuType(i);
                /*Se llama al servicio que valida si el producto tiene deuda*/
                nuDifesape := nuDifesape +
                              pkdeferredmgr.fnugetdeferredbalservice(nuSesunuse);
              end loop;
            else
              nuCont := 0;
            end if;
          
            nuIndex := rcRollover.NEXT(nuIndex);
          
          End Loop;
        
          /* Valida si por lo menos el cliente tiene algun producto asociado al tipo de producto
          traido de la configuracion de rollover*/
          if (nuCont > 0) then
          
            if (nuDifesape > 0) then
            
              /*Hallo el numero de cuotas pendientes*/
              /* Busca los servicios asociados al cliente y al tipo de producto
              capturado de la configuracion*/
              nuIndex := rcRollover.FIRST;
            
              While nuIndex Is Not Null Loop
                nuValidator   := 0;
                nuProductType := rcRollover(nuIndex).product_type_id;
              
                sbQuota_option := rcRollover(nuIndex).quota_option;
              
                nuQuotas_number := rcRollover(nuIndex).quotas_number;
              
                tbSesuType := ld_bcnonbankfinancing.FtbGetServByProdTy(subscriberId,
                                                                       nuProductType);
              
                /* Recorro el tipo tabla para saber si el cliente tiene saldo pendiente
                por un producto*/
                if tbSesuType.count > 0 then
                  /*Recorre los productos del tipo de producto configurado en cupo rollover,
                  y valida por cada uno el numero de cuotas pendientes*/
                  for i in tbSesuType.FIRST .. tbSesuType.LAST loop
                    nuSesunuse := tbSesuType(i);
                  
                    /*Este retorna, el numero de cuotas pendientes de un diferido , si existen varios retornara el mayor numero de cuotas de todos los diferidos */
                    nuDifenucu := ld_bcnonbankfinancing.fnuGetQuotaLast(nuSesunuse,
                                                                        sbTypeDeferWarr);
                  
                    /*Se verifica que si el numero de cuotas pendientes es mayor a el numero de quotas
                    que viene por configuracion */
                    if (nuDifenucu > nuQuotas_number) then
                      --incrementa por cada servicio que no cumpla con las cuotas configuradas.
                      nuValidator := nuValidator + 1;
                    
                    end if;
                  end loop;
                end if;
              
                /*Si el contador de servicios con cuotas mayor o igual al numero de cuotas configuradas, es igual
                al numero de servicios por tipo de producto, no cumple con el cupo rollover, si por lo menos uno
                cumple asigna el valor del cupo rollover */
                if (nuValidator = tbSesuType.count) then
                  nuValidator := 0;
                else
                  ut_string.extstring(sbParentLocation, ',', tbTempString);
                
                  if (tbTempString.COUNT > 0) then
                    for i in tbTempString.FIRST .. tbTempString.LAST loop
                      tbString(tbTempString(i)) := tbTempString(i);
                    END loop;
                  END if;
                
                  if (tbString.exists(nvl(rcRollover(nuIndex)
                                          .geograp_location_id,
                                          -1))) then
                  
                    nuTempTotal := fnuGetValueByRoll(rcRollover(nuIndex)
                                                     .quota_option,
                                                     rcRollover(nuIndex)
                                                     .value,
                                                     onuTotal);
                  
                    nuTempAsig    := dage_geogra_location.fnugetgeog_loca_area_type(rcRollover(nuIndex)
                                                                                    .geograp_location_id) * 1000;
                    blAssigByArea := TRUE;
                  else
                    if (rcRollover(nuIndex).subcategory_id = nuSubcategory AND rcRollover(nuIndex)
                       .category_id = nuCategory) then
                    
                      nuTempTotal   := fnuGetValueByRoll(rcRollover(nuIndex)
                                                         .quota_option,
                                                         rcRollover(nuIndex)
                                                         .value,
                                                         onuTotal);
                      nuTempAsig    := 104;
                      blAssigByArea := FALSE;
                    else
                      if (rcRollover(nuIndex).category_id = nuCategory) then
                        nuTempTotal   := fnuGetValueByRoll(rcRollover(nuIndex)
                                                           .quota_option,
                                                           rcRollover(nuIndex)
                                                           .value,
                                                           onuTotal);
                        nuTempAsig    := 103;
                        blAssigByArea := FALSE;
                      else
                        nuTempTotal   := fnuGetValueByRoll(rcRollover(nuIndex)
                                                           .quota_option,
                                                           rcRollover(nuIndex)
                                                           .value,
                                                           onuTotal);
                        nuTempAsig    := 102;
                        blAssigByArea := FALSE;
                      END if;
                    END if;
                  END if;
                
                  if (nuLevelAsig = nuTempAsig) then
                    if (nuTotal < nuTempTotal) then
                      nuTotal := nuTempTotal;
                    END if;
                  END if;
                
                  if ((not blAssigByArea AND nuTempAsig > nuLevelAsig) OR
                     (blAssigByArea AND nuTempAsig > nuLevelAsig)) then
                    nuTotal     := nuTempTotal;
                    nuLevelAsig := nuTempAsig;
                  END if;
                
                end if;
                nuIndex := rcRollover.NEXT(nuIndex);
              
              end Loop;
            
              if (nuTotal > nuQuotaTotal) then
                nuQuotaTotal := nuTotal;
              END if;
            
              onuTotal := nuQuotaTotal;
            end if;
          end if;
        end if;
      end if;
    
    else
      onuTotal := cnuQuotaCero;
    end if;
    <<final>>
  
    ut_trace.trace('Finaliza LDC_CALCULACUPOBRILLA.AllocateTempQuota', 1);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END AllocateTempQuota;

  FUNCTION LockSubscription(inuSubscriptionID IN suscripc.susccodi%type)
    return boolean IS
    nuRequestResult INTEGER := 0;
  
    nuDEF_SUBSCRIPTION suscripc.susccodi%type := ge_boparameter.fnuGet('DEF_SUBSCRIPTION');
  BEGIN
    ut_trace.Trace('Inicia LDC_CALCULACUPOBRILLA.LockSubscription[' ||
                   inuSubscriptionID || ']',
                   1);
  
    -- Verifica si no es un contrato por defecto,
    -- Verifica si el contrato existe.
    IF (inuSubscriptionID IS NOT NULL) AND
       (inuSubscriptionID <> nuDEF_SUBSCRIPTION) THEN
    
      DECLARE
        sbLockHandle VARCHAR2(2000);
        sbLockName   VARCHAR2(100) := 'FIFAP_' || inuSubscriptionID;
      BEGIN
      
        ut_trace.trace('LockName: ' || sbLockName, 2);
        -- Genera un manejador de bloqueo para el contrato.
        EXECUTE IMMEDIATE 'DECLARE PRAGMA AUTONOMOUS_TRANSACTION; BEGIN dbms_lock.allocate_unique(:sbLockName,:sbLockHandle); END;'
          using sbLockName, out sbLockHandle;
      
        ut_trace.trace('LockHandle: ' || sbLockHandle, 2);
        /* Solicita el bloqueo del contrato, a traves del manejador de bloqueo.
          0 - success
          1 - timeout
          2 - deadlock
          3 - parameter error
          4 - already own lock specified by 'id' or 'lockhandle'
          5 - illegal lockhandle
        */
        nuRequestResult := dbms_lock.request(lockhandle        => sbLockHandle,
                                             timeout           => 0,
                                             release_on_commit => false);
      EXCEPTION
        when others then
          ut_trace.Trace('WARNING: No Bloqueo Contrato[' ||
                         inuSubscriptionID || ']',
                         2);
      END;
    
      ut_trace.Trace('LockRequestResult[' || nuRequestResult || ']', 2);
    
      -- Verifica si el contrato ya se encuentra bloqueado.
      IF (nuRequestResult IN (1, 2)) THEN
      
        ut_trace.Trace('Fin LDC_CALCULACUPOBRILLA.LockSubscription NOK', 1);
      
        -- Descripcion: El contrato [%s1] se encuentra en uso por otro usuario y/o proceso en curso.
        -- Causa: El contrato se encuentra bloqueado por otro usuario y/o proceso en curso.
        -- Accion: Seleccione otro contrato.
        return FALSE;
      
      END IF;
    
    END IF;
  
    ut_trace.Trace('Fin LDC_CALCULACUPOBRILLA.LockSubscription OK', 1);
  
    return TRUE;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR THEN
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END LockSubscription;

  PROCEDURE ReleaseSubscription(inuSubscriptionID IN suscripc.susccodi%type) IS
    nuRequestResult INTEGER := 0;
  
    nuDEF_SUBSCRIPTION suscripc.susccodi%type := ge_boparameter.fnuGet('DEF_SUBSCRIPTION');
  BEGIN
    ut_trace.Trace('Inicia LDC_CALCULACUPOBRILLA.ReleaseSubscription[' ||
                   inuSubscriptionID || ']',
                   1);
  
    -- Verifica si no es un contrato por defecto,
    -- Verifica si el contrato existe.
    IF (inuSubscriptionID IS NOT NULL) AND
       (inuSubscriptionID <> nuDEF_SUBSCRIPTION) THEN
    
      DECLARE
        sbLockHandle VARCHAR2(2000);
        sbLockName   VARCHAR2(100) := 'FIFAP_' || inuSubscriptionID;
      BEGIN
      
        ut_trace.trace('LockName: ' || sbLockName, 2);
        -- Genera un manejador de bloqueo para el contrato.
        EXECUTE IMMEDIATE 'DECLARE PRAGMA AUTONOMOUS_TRANSACTION; BEGIN dbms_lock.allocate_unique(:sbLockName,:sbLockHandle); END;'
          using sbLockName, out sbLockHandle;
      
        ut_trace.trace('LockHandle: ' || sbLockHandle, 2);
      
        nuRequestResult := dbms_lock.release(lockhandle => sbLockHandle);
      EXCEPTION
        when others then
          ut_trace.Trace('Error inesperado' || sqlerrm, 2);
      END;
    
      ut_trace.Trace('LockReleaseResult[' || nuRequestResult || ']', 2);
    
    END IF;
  
    ut_trace.Trace('Fin LDC_CALCULACUPOBRILLA.ReleaseSubscription OK', 1);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR THEN
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ReleaseSubscription;

  FUNCTION fnugetPackageByCons(inuConsecutive IN ld_non_ba_fi_requ.digital_prom_note_cons%type)
    RETURN mo_packages.package_id%type IS
    CURSOR cuPackageId(inuCons ld_non_ba_fi_requ.digital_prom_note_cons%type) IS
      SELECT non_ba_fi_requ_id
        FROM ld_non_ba_fi_requ
       WHERE trim(ld_non_ba_fi_requ.digital_prom_note_cons) = inuCons
          OR trim(ld_non_ba_fi_requ.manual_prom_note_cons) = inuCons;
  
    nuPackage mo_packages.package_id%type;
  BEGIN
    ut_trace.trace('Inicia LDC_CALCULACUPOBRILLA.fnugetPackageByCons', 5);
    -- Si esta abierto el CURSOR se cierra
    IF (cuPackageId%ISOPEN) THEN
      CLOSE cuPackageId;
    END IF;
  
    OPEN cuPackageId(inuConsecutive);
    FETCH cuPackageId
      INTO nuPackage;
    CLOSE cuPackageId;
  
    ut_trace.trace('Fin LDC_CALCULACUPOBRILLA.fnugetPackageByCons', 5);
    RETURN nuPackage;
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      raise ex.CONTROLLED_ERROR;
    WHEN others THEN
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnugetPackageByCons;

  FUNCTION fnugetConsByPackage(inuPackageId mo_packages.package_id%type)
    RETURN ld_non_ba_fi_requ.digital_prom_note_cons%type IS
    CURSOR cuGetConsecutive(inuPackId mo_packages.package_id%type) IS
      SELECT /*+INDEX(fnb PK_LD_NON_BA_FI_REQU)*/
       trim(nvl(fnb.manual_prom_note_cons, fnb.digital_prom_note_cons))
        FROM ld_non_ba_fi_requ fnb
       WHERE fnb.non_ba_fi_requ_id = inuPackId;
  
    nuConsecutive ld_non_ba_fi_requ.manual_prom_note_cons%type;
  BEGIN
    ut_trace.trace('Inicia LDC_CALCULACUPOBRILLA.fnugetConsByPackage', 5);
  
    -- Si esta abierto el CURSOR se cierra
    IF (cuGetConsecutive%ISOPEN) THEN
      CLOSE cuGetConsecutive;
    END IF;
  
    OPEN cuGetConsecutive(inuPackageId);
    FETCH cuGetConsecutive
      INTO nuConsecutive;
    CLOSE cuGetConsecutive;
  
    ut_trace.trace('Fin LDC_CALCULACUPOBRILLA.fnugetConsByPackage', 5);
    return nuConsecutive;
  
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      raise ex.CONTROLLED_ERROR;
    WHEN others THEN
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fnugetConsByPackage;

  /****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : ProcessQuotaByLoca
  Descripcion    : proceso para programar el calculo de quota por localidad
  Autor          : Albeyro Echeverry
  Fecha          : 05/12/2013
  
  Parametros              Descripcion
  ============         ===================
  
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  05-Dic-2013     AEcheverrySAO226231 creacion <<ProcessQuotaByLoca>>
  ******************************************************************/
  PROCEDURE ProcessQuotaByLoca(inuLocalidad in ge_geogra_location.geograp_location_id%type) IS
  
    tbSuscripc pktblsuscripc.tysusccodi;
    cnuServGas CONSTANT pr_product.product_type_id%TYPE := Dald_parameter.fnuGetNumeric_Value('COD_TIPO_SERV'); --7014
    nuSuscripc suscripc.susccodi%type;
    nuTotal    ld_credit_quota.quota_value%type;
  BEGIN
  
    tbSuscripc := ld_bcnonbankfinancing.frcgetsuscripc(cnuServGas,
                                                       null,
                                                       inuLocalidad);
  
    if tbSuscripc.count > 0 then
    
      for i in tbSuscripc.FIRST .. tbSuscripc.LAST loop
      
        if tbSuscripc.EXISTS(i) then
        
          nuSuscripc := tbSuscripc(i);
        
          LDC_CALCULACUPOBRILLA.AllocateQuota(nuSuscripc, nuTotal);
        end if;
      
      end loop;
    else
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'No se encontraron registros para procesar, Favor validar');
    end if;
  
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      raise ex.CONTROLLED_ERROR;
    WHEN others THEN
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ProcessQuotaByLoca;

  /****************************************************************
  Propiedad intelectual de Open International Systems (c).
  
  Unidad         : RegAditionalFNBInfo
  Descripcion    : Registra informacion adicional de venta FNB
  Autor          : Luis Arturo Diuza
  Fecha          : 18/12/2013
  
  Parametros              Descripcion
  ============         ===================
  inuPackageSale          Numero de solicitud FNB
  inCosigner_Subs_Id      Numero de contrato de codeudor
  inuAproxMonthInsurance  Valor aproximado cuota mensual seguro
  
  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  18-12-2013     LDiuza.SAO227806     Creacion
  ******************************************************************/
  PROCEDURE RegAditionalFNBInfo(inuPackageSale         IN mo_packages.package_id%type,
                                inCosigner_Subs_Id     IN suscripc.susccodi%type,
                                inuAproxMonthInsurance IN ld_aditional_fnb_info.aprox_month_insurance%type) IS
    rcAditionalInfo dald_aditional_fnb_info.styLD_ADITIONAL_FNB_INFO;
  BEGIN
    ut_trace.trace('INICIO LDC_CALCULACUPOBRILLA.RegAditionalFNBInfo', 5);
    rcAditionalInfo.non_ba_fi_requ_id      := inuPackageSale;
    rcAditionalInfo.cosigner_subscriber_id := inCosigner_Subs_Id;
    rcAditionalInfo.aprox_month_insurance  := inuAproxMonthInsurance;
  
    dald_aditional_fnb_info.insRecord(rcAditionalInfo);
    ut_trace.trace('FIN LDC_CALCULACUPOBRILLA.RegAditionalFNBInfo', 5);
  
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      raise ex.CONTROLLED_ERROR;
    WHEN others THEN
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END RegAditionalFNBInfo;

  /**************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  AnnulReqVoucherFNB
  Descripcion :  Anula un consecutivo digital en venta de financiacion no Bancaria
  
  Autor       :  Albeyro Echeverry P.
  Fecha       :  10-01-2014
                 inuVouchTyp      Tipo comprobante.
                 inuNumber        Consecutivo.
  
  Historia de Modificaciones
  Fecha        Autor              Modificacion
  =========    =========          ====================
  10-01-2013  AEcheverry.SAO229124    Creacion.
  ***************************************************************/
  PROCEDURE AnnulReqVoucherFNB(inuVouchTyp in tipocomp.ticocodi%type,
                               inuNumber   in fa_consdist.codiulnu%type) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
  
    UT_Trace.Trace('Inicia LDC_CALCULACUPOBRILLA.AnnulReqVoucherFNB ' ||
                   inuVouchTyp || '-' || inuNumber,
                   1);
    pkerrors.setapplication('CUSTOMER');
    pkConsecutiveMgr.changestsaleauthnumber(inuNumber,
                                            inuVouchTyp,
                                            fa_bchistcodi.fsbANULADO);
  
    --commit;
    UT_Trace.Trace('Fin LDC_CALCULACUPOBRILLA.AnnulReqVoucherFNB', 1);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when OTHERS then
      Errors.seterror;
      --rollback;;
  END AnnulReqVoucherFNB;

END LDC_CALCULACUPOBRILLA;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_CALCULACUPOBRILLA', 'ADM_PERSON'); 
END;
/
