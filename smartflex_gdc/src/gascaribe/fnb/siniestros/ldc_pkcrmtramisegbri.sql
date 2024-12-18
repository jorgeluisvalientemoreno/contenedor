CREATE OR REPLACE PACKAGE OPEN.LDC_PKCRMTRAMISEGBRI AS

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LDC_PKCRMTRAMISEGBRI
  Descripcion    : Paquete para el proceso de los siniestros de brilla

  Autor          : Karem Baquero
  Fecha          : 08/01/2017 ERS 200-593

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor         Modificacion
  =========     =========     ====================
  31/08/2022    EDMLAR          Se elimina la validacion del tiempo de gracias del plan de diferido en la forma LDCABRI
  02/03/2023    jcatuchemvm     OSF-892: Se ajusta procedimiento
                                  [PROCLEGGESINTRFALLO]
  05/07/2024    jcatuche        OSF-2724: se ajustan los siguientes métodos
                                    [LDCLDQS]
                                    [PROCGETLIQSINBRILLA]
                                    [LDCABRI]
  ******************************************************************/
  ------------------
  -- Constantes
  ------------------
  csbYes constant varchar2(1) := 'Y';
  csbNo  constant varchar2(1) := 'N';
  nunotacons notas.notacons%type := to_number(dald_parameter.fnuGetNumeric_Value('TIPO_DOCU_NOTA_SINIE_FNB', null)); --70
  -- Numero de la Nota Creada
  nuNota     notas.notanume%type;
  nuCausal   cargos.cargcaca%type := to_number(dald_parameter.fnuGetNumeric_Value('CAUSAL_CARGO_TRAMI_SINIE_FNB', null)); --87
  nuConcepto cargos.cargconc%type := to_number(dald_parameter.fnuGetNumeric_Value('CONCEPTO_NOTAS_CR_SINIE_FNB', null)); --145
  nuPrograma cargos.cargprog%type := 2014; -- programa de ajustes
  -- Concepto de ajuste
  nuConcAjuste concepto.conccodi%type;
  -- Fecha de generacion de las cuentas
  dtFechaGene     date;


  nuSeqLiquidation number; -- consecutivo de liquidacion
  -----------------------
  -- Variables
  -----------------------

  nuDepa cuencobr.cucodepa%type;
  nuLoca cuencobr.cucoloca%type;
  --------------------Variables a extraer

  -----------------------
  -- Elementos Packages
  -----------------------

  /*Tipo Record de los valores a insertar en el detalle de liquidacion de siniestros*/

  TYPE rcldDetLiqS IS RECORD(
    Codigo_Financiacion diferido.difecodi%type,
    nuFactura           factura.factcodi%type,
    Valor_facturado     factura.factvaap%type,
    valfact             diferido.difevatd%type,
    saldo_pen           cargos.cargvalo%type,
    ano                 number,
    mes                 number,
    fecha_Factura       cuencobr.cucofeve%type,
    Concepto            diferido.difeconc%type);

  TYPE tbdetliqs IS TABLE OF rcldDetLiqS;
  rfdelliqs tbdetliqs := tbdetliqs();

  /*Guardar la identificacion del asegurado*/
  PROCEDURE procsbidInsured(inuIdInsured in ge_subscriber.subscriber_id%type,
                            inupack      in mo_packages.package_id%type);

  /*Obtener el nombre del asegurado*/
  FUNCTION FsbNameInsured(inuIdInsured in ge_subscriber.subscriber_id%type)
    RETURN VARCHAR2;

  /* Creaci?n de la orden de Analisis de siniestros*/
  PROCEDURE PROCGENOTANASINI(inuPackage in mo_packages.package_id%type);

  /*Genera OT de envio de liquidacion a la aseguradora*/
  PROCEDURE PROCGENOTENVLIQ(inuPackage in mo_packages.package_id%type);
  /*Genera OT de gestion interna tramite de seguros brilla*/
  PROCEDURE PROCGENOTGESTINT(inuPackage in mo_packages.package_id%type);
  /*Proceso para obtener la informaci?n para la liquidaci?n de siniestros brilla*/
  PROCEDURE PROCGETINFOLIQU(inuPackage  in mo_packages.package_id%type,
                            dtfechsol   out mo_packages.request_date%type,
                            nuproduct   out pr_product.product_id%type,
                            nususc      out pr_product.subscription_id%type,
                            nuidenticli out ge_subscriber.identification%type,
                            sbnamecli   out ge_subscriber.subscriber_name%type,
                            dtfechsini  out mo_packages.request_date%type);
  /*Registra el periodo de gracia por diferido*/
  PROCEDURE PROCREGISPERIGRACXDIFE(inuDIFECODI in LDC_LIQSINIBRIdet.DIFECODI%type,
                                   inucodper   in cc_grace_peri_defe.grace_period_id%type,
                                   dtfecini    in cc_grace_peri_defe.initial_date%type,
                                   dtfecfin    in cc_grace_peri_defe.end_date%type);
  /*Cancela el periodo de gracia por diferido*/
  PROCEDURE PROCANCELPERIGRACXDIFE(inuDIFECODI  in LDC_LIQSINIBRIdet.DIFECODI%type,
                                   inucodperdif in cc_grace_peri_defe.grace_period_id%type,
                                   inucodper    in cc_grace_peri_defe.grace_period_id%type,
                                   dtfecini     in cc_grace_peri_defe.initial_date%type);
  /*Inserta datos en la tabla de detalle de liquidaci?n*/
  PROCEDURE PROCinsertdet(inuLIQUIDATION_ID in LDC_LIQSINIBRIdet.Liquidation_Id%type,
                          inuPackage        in mo_packages.package_id%type,
                          inuFACTCODI       in LDC_LIQSINIBRIdet.Factcodi%type,
                          inuCUCOCODI       in LDC_LIQSINIBRIdet.Cucocodi%type,
                          inuANO            in LDC_LIQSINIBRIdet.ANO%type,
                          inuMES            in LDC_LIQSINIBRIdet.MES%type,
                          inuCONCCODI       in LDC_LIQSINIBRIdet.CONCCODI%type,
                          inuVALOR_FAC      in LDC_LIQSINIBRIdet.VALOR_FAC%type,
                          inuVALOR_REC      in LDC_LIQSINIBRIdet.VALOR_REC%type,
                          inuSALDO          in LDC_LIQSINIBRIdet.SALDO%type,
                          isbSTATUS         in LDC_LIQSINIBRIdet.STATUS%type,
                          inuDIFECODI       in LDC_LIQSINIBRIdet.DIFECODI%type);

  /*Proceso de de legalizacion de la orden*/

  PROCEDURE PROCLEgalizaOTENvioAseg(inuorden  or_order.order_id%type,
                                    inucausal or_order.causal_id%type,
                                    sbmnes    varchar2);
  /*Valida la solicitud si es de siniestros brilla*/
  FUNCTION FnuValidatePackage(inuPackage mo_packages.package_id%type)

   RETURN NUMBER;
  /*Valida si un contrato ya tiene una liquidacion registrada*/
  FUNCTION FnuSuscByLiq(inuSuscripc  suscripc.susccodi%type,
                        inuproductid in pr_product.product_id%type)
    RETURN NUMBER;

  /*Obtiene el consecutivo del periodo de gracia por diferido*/
  FUNCTION Fnuconsperigracdif(inudife diferido.difecodi%type)

   RETURN NUMBER;

  /*Consulta de datos para la generacion de la liquidacion de siniestros*/
  FUNCTION FRFPROCFACTCC(dtSynesterDat LDC_LIQSINIBRI.FEHA_SINIESTRO%TYPE,
                         dtSOLIDate    LDC_LIQSINIBRI.FECHA_REGISTRO%TYPE,
                         nuSuscripc    Ld_Liquidation.Subscription_Id%type,
                         nuproductid   LDC_LIQSINIBRI.PRODUCT_ID%type)

   RETURN pkConstante.tyRefCursor;

  /*Consulta de datos para la generacion de la liquidacion de siniestros*/
  FUNCTION PROCFACTCC RETURN pkConstante.tyRefCursor;

  /*Realiza el proceso del PB LDCLDQS*/
  PROCEDURE LDCLDQS(isbpack         IN VARCHAR2,
                    inuCurrent      IN NUMBER,
                    inuTotal        IN NUMBER,
                    onuErrorCode    OUT NUMBER,
                    osbErrorMessage OUT VARCHAR2);
  /*Consulta de datos para la apribaci?n de la liquidacion de siniestros*/
  FUNCTION PROCGETLIQSINBRILLA

   RETURN pkConstante.tyRefCursor;
  /*Crea notas creditos*/
  PROCEDURE GenerateBillingNote(nuSuscripcion number,
                                nuServsusc    number,
                                nuCuenta      number,
                                nuValor       number, -- CC Nro
                                onunotanume   out number);

  /*Actualiza la cartera*/
  PROCEDURE UpdateAccoRec(nuCuenta number);

  /*Realiza el proceso del PB LDCABRI*/
  PROCEDURE LDCABRI(isbpack         IN VARCHAR2,
                    inuCurrent      IN NUMBER,
                    inuTotal        IN NUMBER,
                    onuErrorCode    OUT NUMBER,
                    osbErrorMessage OUT VARCHAR2);

  PROCEDURE PROCLEGGESINTREXITO(nuPackage in mo_packages.package_id%type);
  PROCEDURE PROCLEGGESINTRFALLO(nuPackage in mo_packages.package_id%type);
  PROCEDURE PROCLEGENVIOLIQEXITO(inuPackage in mo_packages.package_id%type,
                                 nuSuscripc IN suscripc.susccodi%type);

END LDC_PKCRMTRAMISEGBRI;

/


  CREATE OR REPLACE PACKAGE BODY "OPEN"."LDC_PKCRMTRAMISEGBRI" AS
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LDC_PKREGMASREVPERI
  Descripcion    : Paquete para el PB LDCREVPM el cual procesa masivamente las solicitudes
                   de revision periodiocas
  Autor          : Karem Baquero
  Fecha          : 13/09/2016 ERS 200-593

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor         Modificacion
  =========     =========     ====================
  31/08/2022    EDMLAR        Se elimina la validacion del plan de diferido en el proceso de la forma LDCABRI

  ******************************************************************/

  ------------------
  -- Constantes
  ------------------
  -- Esta constante se debe modificar cada vez que se entregue el
  -- paquete con un SAO
  csbVersion CONSTANT VARCHAR2(250) := 'CA200593';

  -----------------------
  -- Variables
  -----------------------
  sbErrMsg varchar2(2000); -- Mensajes de Error

  --Variables de valores de cartera actualizados despues de realizar
  -- una actualizacion
  nuCart_ValorCta cuencobr.cucovato%type; -- Valor cuenta
  nuCart_AbonoCta cuencobr.cucovaab%type; -- Abonos cuenta
  nuCart_SaldoCta cuencobr.cucosacu%type; -- Saldo cuenta
  -- Numero del estado de cuenta current
  nuEstadoCuenta factura.factcodi%type;
  nuCuenta       cuencobr.cucocodi%type;
 -- dtfechperigrace date := null; -- fecha final del periodo de gracia

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FsbNameInsured
    Descripcion    : Retorna el nombre del asegurado a partir de la identificaci?n

    Autor          : AACuna
    Fecha          : 25/09/2017  Caso 200-593

    Parametros         Descripci?n
    ============   ===================
      isbIdInsured    :Identificaci?n del asegurado

    Historia de Modificaciones
    Fecha            Autor       Modificaci?n
    =========      =========  ====================

  ******************************************************************/

  PROCEDURE procsbidInsured(inuIdInsured in ge_subscriber.subscriber_id%type,
                            inupack      in mo_packages.package_id%type) IS

    nuidenticli ge_subscriber.identification%type;

  BEGIN

    ut_trace.Trace('INICIO: LDC_PKCRMTRAMISEGBRI.procsbidInsured', 10);

    nuidenticli := dage_subscriber.fsbgetidentification(inuIdInsured);

    if nuidenticli is not null then
      update ldc_liqsinibri l
         set l.identification_id = nuidenticli
       where l.package_id = inupack;

      commit;
    end if;

    ut_trace.Trace('FIN: LDC_PKCRMTRAMISEGBRI.procsbidInsured', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;

    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END procsbidInsured;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FsbNameInsured
    Descripcion    : Retorna el nombre del asegurado a partir de la identificaci?n

    Autor          : AACuna
    Fecha          : 25/09/2017  Caso 200-593

    Parametros         Descripci?n
    ============   ===================
      isbIdInsured    :Identificaci?n del asegurado

    Historia de Modificaciones
    Fecha            Autor       Modificaci?n
    =========      =========  ====================

  ******************************************************************/

  FUNCTION FsbNameInsured(inuIdInsured in ge_subscriber.subscriber_id%type)

   RETURN VARCHAR2 IS

    RESULT VARCHAR2(1000);

  BEGIN

    ut_trace.Trace('INICIO: LDC_PKCRMTRAMISEGBRI.FsbNameInsured', 10);

    SELECT distinct ge.subscriber_name || ' ' || ge.subs_last_name
      INTO RESULT
      FROM ge_subscriber ge
     WHERE ge.subscriber_id = inuIdInsured;

    Return(RESULT);

    ut_trace.Trace('FIN: LDC_PKCRMTRAMISEGBRI.FsbNameInsured', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      return '';
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END FsbNameInsured;

  --********************************************************************************************
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCGENOTENVLIQ
  Descripcion    : Objeto para la generacion de la orden de envio de liquidacion a la aseguradora
                  desde el flujo registro de siniestros brilla
  Autor          : Karem Baquero - JmGestionInformatica
  Fecha          : 12/01/2017

  Parametros         Descripcion
  ============  ===================
  inuPackage:    Numero del paquete


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  24/06/2017  KBaquero C200-593    Creacion
  ******************************************************************/

  PROCEDURE PROCGENOTANASINI(inuPackage in mo_packages.package_id%type) IS

    nuOrderId         number;
    nuOrderActivityId number;
    nuOrdervis        number;
    rcMoPackage       damo_packages.styMO_packages;
    nuMotive          number;
    product_id        number;
    suscription_id    suscripc.susccodi%type;
    --onuerrorcode      number;
    --osberrormessage   varchar2(2000);

  BEGIN

    ut_trace.Trace('INICIO LDC_PKCRMTRAMISEGBRI.PROCGENOTANASINI', 10);

    damo_packages.getRecord(inupackage, rcMopackage);

    nuMotive := mo_bopackages.fnuGetInitialMotive(inupackage);

    product_id     := mo_bomotive.fnugetproductid(nuMotive);
    suscription_id := mo_bomotive.fnugetsubscription(nuMotive);

    /* Se crea la orden de visita tecnica */
    nuOrderId         := null;
    nuOrderActivityId := null;
    nuOrdervis        := to_number(DALD_PARAMETER.fnuGetNumeric_Value('COD_ACT_ANALISIS_SINIES'));

    if nuOrdervis is not null then

      or_boorderactivities.CreateActivity(nuOrdervis,
                                          inuPackage,
                                          nuMotive,
                                          null,
                                          null,
                                          rcMoPackage.Address_id,
                                          null,
                                          null,
                                          suscription_id,
                                          product_id,
                                          null,
                                          null,
                                          null,
                                          null,
                                          'Orden de An?lisis de siniestros',
                                          null,
                                          null,
                                          nuOrderId,
                                          nuOrderActivityId,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null);

      /*     Se actualiza la orden generada a la tabla de LDC_LIQSINIBRI, para colocarle la orden de an?lisis*/
      update LDC_LIQSINIBRI l
         set l.ot_envio_aseguradora = nuOrderId
       where l.package_id = inuPackage;

    else
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El parametro COD_ACT_ANALISIS_SINIES no se encuentra o est?
                                                 mal configurado');
    end if;

    ut_trace.Trace('FIN LDC_PKCRMTRAMISEGBRI.PROCGENOTANASINI', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end PROCGENOTANASINI;

  --********************************************************************************************
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCGENOTENVLIQ
  Descripcion    : Objeto para la generacion de la orden de envio de liquidacion a la aseguradora
                  desde el flujo registro de siniestros brilla
  Autor          : Karem Baquero - JmGestionInformatica
  Fecha          : 12/01/2017

  Parametros         Descripcion
  ============  ===================
  inuPackage:    Numero del paquete


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  12/01/2017  KBaquero C200-593    Creacion
  ******************************************************************/

  PROCEDURE PROCGENOTENVLIQ(inuPackage in mo_packages.package_id%type) IS

    nuOrderId         number;
    nuOrderActivityId number;
    nuOrdervis        number;
    rcMoPackage       damo_packages.styMO_packages;
    nuMotive          number;
    product_id        number;
    suscription_id    suscripc.susccodi%type;

  BEGIN

    ut_trace.Trace('INICIO LDC_PKCRMTRAMISEGBRI.PROCGENOTENVLIQ', 10);

    damo_packages.getRecord(inupackage, rcMopackage);

    nuMotive := mo_bopackages.fnuGetInitialMotive(inupackage);

    product_id     := mo_bomotive.fnugetproductid(nuMotive);
    suscription_id := mo_bomotive.fnugetsubscription(nuMotive);

    /* Se crea la orden de visita tecnica */
    nuOrderId         := null;
    nuOrderActivityId := null;
    nuOrdervis        := to_number(DALD_PARAMETER.fnuGetNumeric_Value('COD_ACT_ENVIAR_LIQASEG'));

    if nuOrdervis is not null then

      or_boorderactivities.CreateActivity(nuOrdervis,
                                          inuPackage,
                                          nuMotive,
                                          null,
                                          null,
                                          rcMoPackage.Address_id,
                                          null,
                                          null,
                                          suscription_id,
                                          product_id,
                                          null,
                                          null,
                                          null,
                                          null,
                                          'Orden de Envio de liquidacion siniestros a la aseguradora',
                                          null,
                                          null,
                                          nuOrderId,
                                          nuOrderActivityId,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null);

      /*Se actualiza la orden generada a la tabla de LDC_LIQSINIBRIDET*/
      update LDC_LIQSINIBRI l
         set l.ot_tramite_inter = nuOrderId
       where l.package_id = inuPackage;

    else
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El parametro COD_ACT_GESTINT_TRAMSEG no se encuentra o est?
                                                 mal configurado');
    end if;

    ut_trace.Trace('FIN LDC_PKCRMTRAMISEGBRI.PROCGENOTENVLIQ', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end PROCGENOTENVLIQ;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCGENOTGESTINT
  Descripcion    : Objeto para la generacion de la orden de envio de liquidacion a la aseguradora
                  desde el flujo registro de siniestros brilla
  Autor          : Karem Baquero - JmGestionInformatica
  Fecha          : 13/01/2017

  Parametros         Descripcion
  ============  ===================
  inuPackage:    Numero del paquete


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  13/01/2017  KBaquero C200-593    Creacion
  ******************************************************************/

  PROCEDURE PROCGENOTGESTINT(inuPackage in mo_packages.package_id%type) IS

    nuOrderId         number;
    nuOrderActivityId number;
    nuOrdervis        number;
    rcMoPackage       damo_packages.styMO_packages;
    nuMotive          number;
    product_id        number;
    suscription_id    suscripc.susccodi%type;

  BEGIN

    ut_trace.Trace('INICIO LDC_PKCRMTRAMISEGBRI.PROCGENOTGESTINT  ', 10);

    damo_packages.getRecord(inupackage, rcMopackage);

    nuMotive := mo_bopackages.fnuGetInitialMotive(inupackage);

    product_id     := mo_bomotive.fnugetproductid(nuMotive);
    suscription_id := mo_bomotive.fnugetsubscription(nuMotive);

    /* Se crea la orden de visita tecnica */
    nuOrderId         := null;
    nuOrderActivityId := null;
    nuOrdervis        := to_number(DALD_PARAMETER.fnuGetNumeric_Value('COD_ACT_GESTINT_TRAMSEG'));

    if nuOrdervis is not null then

      or_boorderactivities.CreateActivity(nuOrdervis,
                                          inuPackage,
                                          nuMotive,
                                          null,
                                          null,
                                          rcMoPackage.Address_id,
                                          null,
                                          null,
                                          suscription_id,
                                          product_id,
                                          null,
                                          null,
                                          null,
                                          null,
                                          'Orden de Gestion Interna de liquidacion de siniestros',
                                          null,
                                          null,
                                          nuOrderId,
                                          nuOrderActivityId,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null);

      /* \*Se actualiza la orden generada a la tabla de LDC_LIQSINIBRIDET*\
      update LDC_LIQSINIBRI l
         set l.ot_tramite_inter = nuOrderId
       where l.package_id = inuPackage;*/

    else
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El parametro COD_ACT_GESTINT_TRAMSEG no se encuentra o est?
                                                 mal configurado');
    end if;

    ut_trace.Trace('FIN LDC_PKCRMTRAMISEGBRI.PROCGENOTGESTINT  ', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end PROCGENOTGESTINT;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCGETINFOLIQU
  Descripcion    : Objeto para obtener los datos para el proceso de la
                 liquidacion de siniestro brilla registro de siniestros brilla
  Autor          : Karem Baquero - JmGestionInformatica
  Fecha          : 17/01/2017

  Parametros         Descripcion
  ============  ===================
  inuPackage:    Numero del paquete


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  17/01/2017  KBaquero C200-593    Creacion
  ******************************************************************/

  PROCEDURE PROCGETINFOLIQU(inuPackage  in mo_packages.package_id%type,
                            dtfechsol   out mo_packages.request_date%type,
                            nuproduct   out pr_product.product_id%type,
                            nususc      out pr_product.subscription_id%type,
                            nuidenticli out ge_subscriber.identification%type,
                            sbnamecli   out ge_subscriber.subscriber_name%type,
                            dtfechsini  out mo_packages.request_date%type) IS

    /*  rcMopackage  damo_packages.styMO_packages;*/
    nuclient mo_packages.subscriber_id%type;
    /* sbnamecliape ge_subscriber.subscriber_name%type;
    sbnameclinom ge_subscriber.subscriber_name%type;*/

    cursor cuinfoaseg is
      SELECT l.suscription_id,
             l.product_id,
             l.fecha_registro,
             l.feha_siniestro,
             (select s.identification
                from ge_subscriber s
               where s.subscriber_id = l.insured_id) Identificacion,
             l.insured_id,
             l.insured_name
        FROM LDC_LIQSINIBRI l
       WHERE l.package_id = inuPackage;

  begin
    ut_trace.Trace('FIN LDC_PKCRMTRAMISEGBRI.PROCGETINFOLIQU  ', 10);

    open cuinfoaseg;
    fetch cuinfoaseg
      into nususc,
           nuproduct,
           dtfechsol,
           dtfechsini,
           nuidenticli,
           nuclient,
           sbnamecli;
    close cuinfoaseg;

    procsbidInsured(nuclient, inuPackage);

    ut_trace.Trace('FIN LDC_PKCRMTRAMISEGBRI.PROCGETINFOLIQU  ', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end PROCGETINFOLIQU;

  --********************************************************************************************
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCinsertdet
  Descripcion    : Objeto para la insercci?n de los registros en la tabla de detalle de la liquidaci?n
  Autor          : Karem Baquero - JmGestionInformatica
  Fecha          : 23/06/2017

  Parametros         Descripcion
  ============  ===================
  inuPackage:    Numero del paquete


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  23/06/2017  KBaquero C200-593    Creacion
  ******************************************************************/

  PROCEDURE PROCinsertdet(inuLIQUIDATION_ID in LDC_LIQSINIBRIdet.Liquidation_Id%type,
                          inuPackage        in mo_packages.package_id%type,
                          inuFACTCODI       in LDC_LIQSINIBRIdet.Factcodi%type,
                          inuCUCOCODI       in LDC_LIQSINIBRIdet.Cucocodi%type,
                          inuANO            in LDC_LIQSINIBRIdet.ANO%type,
                          inuMES            in LDC_LIQSINIBRIdet.MES%type,
                          inuCONCCODI       in LDC_LIQSINIBRIdet.CONCCODI%type,
                          inuVALOR_FAC      in LDC_LIQSINIBRIdet.VALOR_FAC%type,
                          inuVALOR_REC      in LDC_LIQSINIBRIdet.VALOR_REC%type,
                          inuSALDO          in LDC_LIQSINIBRIdet.SALDO%type,
                          isbSTATUS         in LDC_LIQSINIBRIdet.STATUS%type,
                          inuDIFECODI       in LDC_LIQSINIBRIdet.DIFECODI%type) IS

    nuseq number;

  BEGIN

    ut_trace.Trace('INICIO LDC_PKCRMTRAMISEGBRI.PROCinsertdet', 10);

    select LDC_SEQLIQSINIBRIDET.nextval into nuseq from dual;

    /*INSERT A LA TABLA DE DETALLE  LDC_LIQSINIBRIdet */
    insert into LDC_LIQSINIBRIdet
      (LIQSINIBRIDET_ID,
       LIQUIDATION_ID,
       PACKAGE_ID,
       FACTCODI,
       CUCOCODI,
       ANO,
       MES,
       CONCCODI,
       VALOR_FAC,
       VALOR_REC,
       SALDO,
       STATUS,
       DIFECODI)
    values
      (nuseq,
       inuLIQUIDATION_ID,
       inuPackage,
       inuFACTCODI,
       inuCUCOCODI,
       inuANO,
       inuMES,
       inuCONCCODI,
       inuVALOR_FAC,
       inuVALOR_REC,
       inuSALDO,
       isbSTATUS,
       inuDIFECODI);
    ut_trace.Trace('FIN LDC_PKCRMTRAMISEGBRI.PROCinsertdet', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end PROCinsertdet;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCREGISPERIGRACXDIFE
  Descripcion    : Objeto para registro del periodo de gracia por diferidos

  Autor          : Karem Baquero - JmGestionInformatica
  Fecha          :  18/10/2017

  Parametros         Descripcion
  ============  ===================
  inuPackage:    Numero del paquete


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  18/10/2017  KBaquero C200-593    Creacion
  ******************************************************************/

  PROCEDURE PROCREGISPERIGRACXDIFE(inuDIFECODI in LDC_LIQSINIBRIdet.DIFECODI%type,
                                   inucodper   in cc_grace_peri_defe.grace_period_id%type,
                                   dtfecini    in cc_grace_peri_defe.initial_date%type,
                                   dtfecfin    in cc_grace_peri_defe.end_date%type) IS

    NUPERSONID number;
    CSBFIRPG CONSTANT VARCHAR2(7) := 'FIRPG';
    RCGRACEPERIOD DACC_GRACE_PERIOD.STYCC_GRACE_PERIOD;
    CNUNULL_ATTRIBUTE     CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 119562;
    CSBCLAIMGRACEPERIOD   CONSTANT VARCHAR2(100) := 'PERI_GRACIA_RECL_DIF';
    CNUGRACE_PERI_INVAL   CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901365;
    CNUENDDAT_MIN_INITDAT CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901360;
    CNUMINOR_SYSDATE      CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901359;
    NUDIFFERENCEDAYS NUMBER;
    CNUGRACE_DAYS CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901364;
    RCPROGRAM PROCESOS%ROWTYPE;

  BEGIN

    ut_trace.Trace('INICIO LDC_PKCRMTRAMISEGBRI.PROCREGISPERIGRACXDIFE',
                   10);

    NUPERSONID := GE_BOPERSONAL.FNUGETPERSONID;

    IF (inucodper IS NULL) THEN
      ERRORS.SETERROR(CNUNULL_ATTRIBUTE,
                      'Identificador del Periodo de Gracia');
      RAISE EX.CONTROLLED_ERROR;
    END IF;

    RCGRACEPERIOD := DACC_GRACE_PERIOD.FRCGETRECORD(inucodper);

    IF (inucodper = GE_BOPARAMETER.FNUVALORNUMERICO(CSBCLAIMGRACEPERIOD)) THEN
      ERRORS.SETERROR(CNUGRACE_PERI_INVAL, inucodper);
      RAISE EX.CONTROLLED_ERROR;
    END IF;

    IF (dtfecini IS NULL) THEN
      ERRORS.SETERROR(CNUNULL_ATTRIBUTE, 'Fecha Inicial Periodo de Gracia');
      RAISE EX.CONTROLLED_ERROR;
    END IF;

    IF (dtfecfin IS NULL) THEN
      ERRORS.SETERROR(CNUNULL_ATTRIBUTE, 'Fecha Final Periodo de Gracia');
      RAISE EX.CONTROLLED_ERROR;
    END IF;

    IF (TRUNC(dtfecini) < TRUNC(SYSDATE)) THEN
      ERRORS.SETERROR(CNUMINOR_SYSDATE);
      RAISE EX.CONTROLLED_ERROR;
    END IF;

    IF (TRUNC(dtfecfin) < TRUNC(dtfecini)) THEN
      ERRORS.SETERROR(CNUENDDAT_MIN_INITDAT);
      RAISE EX.CONTROLLED_ERROR;
    END IF;

    RCPROGRAM := GE_BCPROCESOS.FRCPROGRAMA(CSBFIRPG);

    NUDIFFERENCEDAYS := (TRUNC(dtfecfin) - TRUNC(dtfecini)) + 1;

    IF (NUDIFFERENCEDAYS < RCGRACEPERIOD.MIN_GRACE_DAYS) OR
       (NUDIFFERENCEDAYS > RCGRACEPERIOD.MAX_GRACE_DAYS) THEN
      ERRORS.SETERROR(CNUGRACE_DAYS,
                      NUDIFFERENCEDAYS || '|' ||
                      RCGRACEPERIOD.GRACE_PERIOD_ID);
      RAISE EX.CONTROLLED_ERROR;
    END IF;

    insert into CC_GRACE_PERI_DEFE
      (Grace_peri_defe_id,
       Grace_period_id,
       Deferred_id,
       initial_date,
       end_date,
       program,
       person_id)
    values
      (seq_cc_grace_peri_d_185489.nextval,
       inucodper,
       inuDIFECODI,
       dtfecini,
       dtfecfin,
       RCPROGRAM.PROCCONS,
       NUPERSONID);

    ut_trace.Trace('FIN LDC_PKCRMTRAMISEGBRI.PROCREGISPERIGRACXDIFE', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end PROCREGISPERIGRACXDIFE;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCANCELPERIGRACXDIFE
  Descripcion    : Objeto para La cancelaci?n del periodo de gracia por diferidos
                   registrados por siniestros brilla

  Autor          : Karem Baquero - JmGestionInformatica
  Fecha          :  19/10/2017

  Parametros         Descripcion
  ============  ===================
  inuPackage:    Numero del paquete


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  18/10/2017  KBaquero C200-593    Creacion
  ******************************************************************/

  PROCEDURE PROCANCELPERIGRACXDIFE(inuDIFECODI  in LDC_LIQSINIBRIdet.DIFECODI%type,
                                   inucodperdif in cc_grace_peri_defe.grace_period_id%type,
                                   inucodper    in cc_grace_peri_defe.grace_period_id%type,
                                   dtfecini     in cc_grace_peri_defe.initial_date%type) IS

    NUPERSONID number;
    CSBFIRPG CONSTANT VARCHAR2(7) := 'FIRPG';
    RCGRACEPERIOD DACC_GRACE_PERIOD.STYCC_GRACE_PERIOD;
    CNUNULL_ATTRIBUTE CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 119562;

    RCPROGRAM PROCESOS%ROWTYPE;
    dtfecfin  cc_grace_peri_defe.end_date%type := sysdate;

  BEGIN

    ut_trace.Trace('INICIO LDC_PKCRMTRAMISEGBRI.PROCANCELPERIGRACXDIFE',
                   10);

    NUPERSONID := GE_BOPERSONAL.FNUGETPERSONID;

    IF (inucodper IS NULL) THEN
      ERRORS.SETERROR(CNUNULL_ATTRIBUTE,
                      'Identificador del Periodo de Gracia');
      RAISE EX.CONTROLLED_ERROR;
    END IF;

    RCGRACEPERIOD := DACC_GRACE_PERIOD.FRCGETRECORD(inucodper);

    IF (dtfecini IS NULL) THEN
      ERRORS.SETERROR(CNUNULL_ATTRIBUTE, 'Fecha Inicial Periodo de Gracia');
      RAISE EX.CONTROLLED_ERROR;
    END IF;

    RCPROGRAM := GE_BCPROCESOS.FRCPROGRAMA(CSBFIRPG);

    dacc_grace_peri_defe.updinitial_date(inucodperdif, dtfecini);
    dacc_grace_peri_defe.updend_date(inucodperdif, dtfecfin);

    ut_trace.Trace('FIN LDC_PKCRMTRAMISEGBRI.PROCANCELPERIGRACXDIFE', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end PROCANCELPERIGRACXDIFE;

  --********************************************************************************************
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCLEgalizaOTENvioAseg
  Descripcion    : Objeto para la legalizacion de las ordenes
  Autor          : Karem Baquero - JmGestionInformatica
  Fecha          : 29/06/2017

  Parametros         Descripcion
  ============  ===================
  inuorden:    Numero de la orden


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  29/06/2017  KBaquero C200-593    Creacion
  ******************************************************************/

  PROCEDURE PROCLEgalizaOTENvioAseg(inuorden  or_order.order_id%type,
                                    inucausal or_order.causal_id%type,
                                    sbmnes    varchar2) IS

    nuError    number;
    sbMessage  varchar2(2000);
    nuUnitOper number;
    rcOrder    daor_order.styor_order;
    nuOrdervis number;
    nuactivity number;
    nutiptrab  number;

  BEGIN

    ut_trace.Trace('INICIO LDC_PKCRMTRAMISEGBRI.PROCLEgalizaOTENvioAseg',
                   10);

    nuUnitOper := to_number(DALD_PARAMETER.fnuGetNumeric_Value('COD_UNITOP_TRAMSEG'));

    /*Se asigna la orden a la unidad operativa asociada al tipo de poliza*/

    rcOrder := Daor_Order.Frcgetrecord(inuorden);
    ut_trace.Trace('Orden ' || inuorden, 10);

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

    if rcOrder.order_status_id = 5 then
      --else
      ut_trace.Trace('Legalizar la Orden ' || inuorden, 10);
      /* Se legaliza las ordenes de tramite de siniestro brilla*/
      os_legalizeorderallactivities(inuorden,
                                    inucausal, --or_boconstants.cnuSuccesCausal,
                                    LD_BOUtilFlow.fnuGetPersonToLegal(nuUnitOper), --ge_bopersonal.fnugetpersonid,
                                    sysdate,
                                    sysdate,
                                    sbmnes, --'Legalizacion de la orden de envio de liquidacion aseguradora',
                                    null,
                                    nuError,
                                    sbMessage);

      if (nuError <> 0) then
        gw_boerrors.checkerror(nuError, sbMessage);

      end if;

    end if;
    /*Valida si la orden de liquidacion ya se encuentra legalizada, para que no se permita*/
    /*  if rcOrder.order_status_id = 8 then
       nuOrdervis        := to_number(DALD_PARAMETER.fnuGetNumeric_Value('COD_ACT_ANALISIS_SINIES'));
       nutiptrab := daor_order.FNUGETTASK_TYPE_ID(inuorden);

       begin
         select oa.activity_id  into nuactivity
         from or_order_activity oa
         where oa.order_id=inuorden and oa.task_type_id=nutiptrab;
          EXCEPTION
    when ex.CONTROLLED_ERROR then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
         end;

       if nuOrdervis = nuactivity then

         sbMessage:='Esta Orden: '|| inuorden || 'ya se encuentra legalizada';
           gw_boerrors.checkerror(ld_boconstans.cnugeneric_error, sbMessage);

       end if;

     end if;*/
    ut_trace.Trace('FIN LDC_PKCRMTRAMISEGBRI.PROCLEgalizaOTENvioAseg', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end PROCLEgalizaOTENvioAseg;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FnuValidatePackage
  Descripcion    : Busca solicitudes
  Autor          : Kbaquero
  Fecha          : 17/01/2017 Caso 200-593

  Parametros         Descripcion
  ============   ===================


  Historia de Modificaciones
  Fecha            Autor            Modificacion
  =========      =========          ====================

  ******************************************************************/

  FUNCTION FnuValidatePackage(inuPackage mo_packages.package_id%type)

   RETURN NUMBER

   IS

    nuResult      boolean;
    nuResultd     number;
    rcMopackage   damo_packages.styMO_packages;
    cnuMotPackage ld_parameter.numeric_value%type; --  Parametro del numero de estado del paquete

  BEGIN

    ut_trace.Trace('INICIO LDC_PKCRMTRAMISEGBRI.FnuValidatePackage', 10);

    if (dald_parameter.fblexist(LD_BOConstans.cnuMotPackage)) then

      cnuMotPackage := 13;

      if ((nvl(cnuMotPackage, LD_BOConstans.cnuCero) <>
         LD_BOConstans.cnuCero)) then

        nuResult := damo_packages.fblExist(inuPackage);

        if (nuResult = true) then
          damo_packages.getRecord(inuPackage, rcMopackage);
          if ((rcMopackage.tag_name =
             'P_REGISTRO_DE_SINIESTROS_BRILLA_100299') and
             (rcMopackage.motive_status_id = cnuMotPackage)) then

            nuResultd := 1;

          else

            nuResultd := 0;

          end if;

        else

          nuResultd := 0;

        end if;

        Return(nuResultd);
      end if;

    end if;

    ut_trace.Trace('INICIO LDC_PKCRMTRAMISEGBRI.FnuValidatePackage', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      return 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END FnuValidatePackage;

  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Fnuconsperigracdif
    Descripcion    : Retorna si el consecutivo del perido de gracia por diferido

    Autor          : Kbaquero
    Fecha          : 30/06/2017 caso 200-593

    Parametros         Descripci?n
    ============   ===================
    inudife      :N?mero del diferido

    Historia de Modificaciones
    Fecha            Autor                    Modificaci?n
    =========      =========                ====================

  ******************************************************************/

  FUNCTION Fnuconsperigracdif(inudife diferido.difecodi%type)

   RETURN NUMBER

   IS

    nuValue       number;
    nuGracePeriod number;

  BEGIN
    ut_trace.Trace('INICIO: LDC_PKCRMTRAMISEGBRI.Fnuconsperigracdif', 10);

    /*proceso del periodo de gracia*/
    nuGracePeriod := to_number(dald_parameter.fnuGetNumeric_Value('CODIGO_PERIOD_GRACIA_SINIES_BR'));

    select MAX(f.grace_peri_defe_id)
      into nuValue
      from cc_grace_peri_defe f
     where f.deferred_id = inudife
       and f.grace_period_id = nuGracePeriod --1021355
    /*and f.end_date > sysdate*/
    ;

    Return(nuValue);

    ut_trace.Trace('FIN: LDC_PKCRMTRAMISEGBRI.Fnuconsperigracdif', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      return 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END Fnuconsperigracdif;
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : FnuSuscByLiq
    Descripcion    : Retorna si un contrato tiene una liquidaci?n registrada

    Autor          : Kbaquero
    Fecha          : 16/01/2017 caso 200-593

    Parametros         Descripci?n
    ============   ===================
    inuSuscripc    :N?mero del contrato

    Historia de Modificaciones
    Fecha            Autor                    Modificaci?n
    =========      =========                ====================

  ******************************************************************/

  FUNCTION FnuSuscByLiq(inuSuscripc  suscripc.susccodi%type,
                        inuproductid in pr_product.product_id%type)

   RETURN NUMBER

   IS

    nuValue number;

  BEGIN
    ut_trace.Trace('INICIO: Ld_BcLiquidation.FnuSuscByLiq', 10);

    SELECT /*+ IDX_LIQUIDATION_4 */
     count(l.liquidation_id)
      INTO nuValue
      FROM LDC_LIQSINIBRI l, mo_packages p
     WHERE l.suscription_id = inuSuscripc
       AND l.product_id = inuproductid
       AND l.status = any('R', 'A')
       AND l.package_id = p.package_id
       AND p.motive_status_id =
           open.DALD_parameter.fnuGetNumeric_Value('ESTADO_SOL_REGISTRADA');

    Return(nuValue);

    ut_trace.Trace('FIN: Ld_BcLiquidation.FnuSuscByLiq', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when no_data_found then
      return 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END FnuSuscByLiq;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCFACTCC
  Descripcion    : Realiza la busqueda de las facturas cuentas y diferidos pendientes y cancelados entre
                   la fecha del siniestro y la fecha de hoy para el PB LDCLDQS.
  Autor          : Kbaquero
  Fecha          : 23/06/2017 Caso 200-593

  Parametros         Descripcion
  ============   ===================
  inuPackage:      Numero del paquete

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  FUNCTION PROCFACTCC

   RETURN pkConstante.tyRefCursor

   IS

    nuSuscripc     Ld_Liquidation.Subscription_Id%type;
    nuPackage      Ld_Liquidation.liqui_package_id%type;
    dtSynesterDate Ld_Liquidation.Loss_Date%type;
    nuValidate     number;

    rfcursor pkConstante.tyRefCursor;

    nuproductid LDC_LIQSINIBRI.PRODUCT_ID%type;

  BEGIN

    ut_trace.Trace('INICIO LDC_PKCRMTRAMISEGBRI.PROCFACTCC', 10);

    nuPackage := ge_boInstanceControl.fsbGetFieldValue('LDC_LIQSINIBRI',
                                                       'PACKAGE_ID');

    /*obtener los valores ingresados en la aplicacion PB LDCLDQS*/
    dtSynesterDate := ge_boInstanceControl.fsbGetFieldValue('LDC_LIQSINIBRI',
                                                            'FEHA_SINIESTRO');

    if (dtSynesterDate is null) then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El campo fecha de siniestro es obligatorio');
    end if;

    nuproductid := ge_boInstanceControl.fsbGetFieldValue('LDC_LIQSINIBRI',
                                                         'PRODUCT_ID');

    nuSuscripc := ge_boInstanceControl.fsbGetFieldValue('LDC_LIQSINIBRI',
                                                        'SUSCRIPTION_ID');

    if nuSuscripc is not null then

      nuValidate := LDC_PKCRMTRAMISEGBRI.FnuSuscByLiq(nuSuscripc,
                                                      nuproductid);

      if (nuValidate = 0) then

        OPEN rfcursor FOR

          SELECT 'D' || to_char(difecodi) Codigo_Financiacion,
                 0 Factura,
                 0 Valor_facturado,
                 --  to_char(difefein, 'mm') mes,
                 -- to_char(difefein, 'YYYY') ano,
                 difefein fecha_Factura,
                 difesape Saldo_Pendiente,
                 difeconc Concepto
            FROM diferido
           WHERE difenuse = nuproductid --621829
             AND difesusc = nuSuscripc

             AND difesape > 0
             AND difecodi not in
                 (SELECT 1
                    FROM LDC_LIQSINIBRIDET l
                   where l.difecodi = difecodi
                     AND status in ('R', 'A'))

          UNION ALL
          SELECT 'C' || cucocodi,
                 cucofact,
                 cucovato,
                 --   to_char(p.pefafimo, 'mm') mes,
                 -- to_char(p.pefafimo, 'YYYY') ano,
                 f.factfege fecha_Factura,
                 nvl((cucosacu), 0),
                 0

            FROM factura f, perifact p, cuencobr c
           WHERE cuconuse = nuproductid --621829
             and factsusc = nuSuscripc
             AND f.factpefa = p.pefacodi
             AND trunc(f.factfege) >= /*to_date('25/06/2014', 'dd/mm/yyyy')*/
                 trunc(dtSynesterDate)
             AND trunc(f.factfege) <= /*to_date('25/06/2015', 'dd/mm/yyyy') --*/
                 trunc(sysdate)
             AND c.cucofact = f.factcodi
             AND cucocodi not in
                 (SELECT 1
                    FROM LDC_LIQSINIBRIDET l
                   where l.cucocodi = cucocodi
                     AND status in ('R', 'A'))

           order by fecha_Factura desc;

        Return(rfcursor);

      else

        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                         'El contrato con el producto registrado ya tiene una liquidacion ingresada pendiente');

      end if;

    end if;

    ut_trace.Trace('FIN LDC_PKCRMTRAMISEGBRI.PROCFACTCC', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END PROCFACTCC;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : FRFPROCFACTCC
  Descripcion    : Realiza la busqueda de  diferidos pendientes y cancelados entre
                   la fecha del siniestro y la fecha de la solicitud del siniestros.
  Autor          : Kbaquero
  Fecha          : 17/01/2017 CASO 200-593

  Parametros         Descripcion
  ============   ===================
  inuPackage:      Numero del paquete

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/

  FUNCTION FRFPROCFACTCC(dtSynesterDat LDC_LIQSINIBRI.FEHA_SINIESTRO%TYPE,
                         dtSOLIDate    LDC_LIQSINIBRI.FECHA_REGISTRO%TYPE,
                         nuSuscripc    Ld_Liquidation.Subscription_Id%type,
                         nuproductid   LDC_LIQSINIBRI.PRODUCT_ID%type)

   RETURN pkConstante.tyRefCursor IS

    rfcursor pkConstante.tyRefCursor;

  BEGIN

    ut_trace.Trace('INICIO LDC_PKCRMTRAMISEGBRI.FRFPROCFACTCC', 10);

    OPEN rfcursor FOR

      SELECT difecodi Codigo_Financiacion,
             0        Factura,
             0        Valor_facturado,
             -- to_char(difefein, 'mm') mes,
             --to_char(difefein, 'YYYY') ano,
             difefein fecha,
             difesape Saldo_Pendiente,
             difeconc Concepto,
             0        Valor_Corriente
        FROM diferido
       WHERE difenuse = nuproductid --621829
         AND difesusc = nuSuscripc
         AND difesape > 0
         AND difecodi not in (SELECT 1
                                FROM LDC_LIQSINIBRIDET l
                               where l.difecodi = difecodi
                                 AND status in ('R', 'A'))
      UNION ALL
      SELECT cucocodi,
             cucofact,
             cucovato,
             -- to_char(p.pefafimo, 'mm') mes,
             -- to_char(p.pefafimo, 'YYYY') ano,
             f.factfege,
             0,
             0,
             nvl(SUM(cucosacu), 0) Valor_Corriente

        FROM factura f, perifact p, cuencobr c, cargos ca
       WHERE cuconuse = nuproductid --621829
         and factsusc = nuSuscripc
         AND f.factpefa = p.pefacodi
         AND ca.cargpefa = p.pefacodi
         AND c.cucocodi = ca.cargcuco
         AND trunc(f.factfege) >= /*to_date('25/06/2014', 'dd/mm/yyyy')*/
             trunc(dtSynesterDat)
         AND trunc(f.factfege) <= /*to_date('25/06/2015', 'dd/mm/yyyy') --*/
             trunc(dtSOLIDate)
         AND c.cucofact = f.factcodi
         AND cucocodi not in (SELECT 1
                                FROM LDC_LIQSINIBRIDET l
                               where l.cucocodi = cucocodi
                                 AND status in ('R', 'A'))
       group by cucocodi, cucofact, cucovaab, cucovafa, pefafimo;

    Return(rfcursor);

    ut_trace.Trace('FIN LDC_PKCRMTRAMISEGBRI.FRFPROCFACTCC', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END FRFPROCFACTCC;

  --********************************************************************************************

  PROCEDURE LDCLDQS(isbpack         IN VARCHAR2,
                    inuCurrent      IN NUMBER,
                    inuTotal        IN NUMBER,
                    onuErrorCode    OUT NUMBER,
                    osbErrorMessage OUT VARCHAR2) IS
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : LDCLDQS
    Descripcion    : Procedimiento llamado por el PB LDCLDQS liquidacion de siniestros brilla
    Autor          : Karem Baquero
    Fecha          : 12/01/2017 ERS 200-593

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    05/07/2024    jcatuche                  OSF-2724: Se agrega validación de siniestro liquidado al procesar el primer registro con el objetivo de
                                            disminuir la probabilidad de registrar duplicar liquidaciónes, además se añade validación de la orden a procesar, 
                                            evita que se procese la forma antes de que la orden por el flujo haya sido creada
	19/05/2021    HORBATH					Caso: 698. Se agrega rolback en las execpciones y se agrega bloque de excepciones generales
	29/12/2021    HORBATH					Caso: 880: Se modifica eliminar la validaci¿¿n del tiempo de gracia del plan de diferido

    ******************************************************************/

    --rcDetailLiquidation dald_detail_liquidation.styLD_detail_liquidation;
    nuPackage    ge_boInstanceControl.stysbValue;
    nuSuscripc   ge_boInstanceControl.stysbValue;
    nuInsured_Id ge_boInstanceControl.stysbValue;

    nuApplication_Cause_Id ge_boInstanceControl.stysbValue;

    nuLossDate ge_boInstanceControl.stysbValue;
    nuProduct  ge_boInstanceControl.stysbValue;

    rcMopackage damo_packages.styMO_packages;

    rcDeffered diferido%rowtype;

    nuDeffered varchar2(2000); --diferido.difecodi%type;

    --nuCucovato cuencobr.cucovato%type;
    nuUser ge_person.person_id%type;

    nuValueLiqRel NUMBER;
    --nuError          number;
    --sbMessage        varchar2(2000);
    nuOrderId   number;
    nudifepldi  diferido.difepldi%type;
    nucumaxpldi plandife.pldicuma%type;
    nucuminpldi plandife.pldicumi%type;
    --onucantdetl    ld_liquidation.liquidation_id%type;
    nuGracePeriod  ld_parameter.numeric_value%type;
    nutiemperigrac ld_parameter.numeric_value%type;
    nutiemperigra  float;
    vdate          date;
    nuclass        number;
    nuValidate     number;

    sbident varchar2(2);
    nucuent number;
    sbmens  varchar2(2000);
	sbmensa varchar2(4000);

    /*Cursor para obtener la orden de envio a la aseguradora*/
    cursor cuinfotaseg(inuPackage number) is
      SELECT l.ot_envio_aseguradora
        FROM LDC_LIQSINIBRI l
       WHERE l.package_id = inuPackage;

    /*cusor para obtener los datos de la cuenta de cobro y las facturas*/
    cursor cudatcuencobr(inucobr number) is
      SELECT cucocodi,
             cucofact,
             cucovafa,
             to_char(factfege, 'mm') mes,
             to_char(factfege, 'YYYY') ano,
             factfege fecha_Factura,
             nvl(cucovato, 0) cucovato,
             nvl((cucosacu), 0) cucosacu
        FROM factura f, cuencobr c
       WHERE cucocodi = inucobr --1041995648--nucucodi
         AND c.cucofact = f.factcodi
       order by fecha_Factura desc;

    c_cuencob cudatcuencobr%rowtype;

  BEGIN

    ut_trace.Trace('INICIO: LDC_PKCRMTRAMISEGBRI.LDCLDQS', 10);

    --  nuCucovato := 0;
    --  nuUser := GE_BOPersonal.fnuGetPersonId;

    nuPackage := ge_boInstanceControl.fsbGetFieldValue('LDC_LIQSINIBRI',
                                                       'PACKAGE_ID');

    nuSuscripc := ge_boInstanceControl.fsbGetFieldValue('LDC_LIQSINIBRI',
                                                        'SUSCRIPTION_ID');

    nuInsured_Id := ge_boInstanceControl.fsbGetFieldValue('LDC_LIQSINIBRI',
                                                          'INSURED_ID');

    nuApplication_Cause_Id := ge_boInstanceControl.fsbGetFieldValue('LDC_LIQSINIBRI',
                                                                    'CAUS_LEG_ENVI_ASEG');

    nuProduct := ge_boInstanceControl.fsbGetFieldValue('LDC_LIQSINIBRI',
                                                       'PRODUCT_ID');

    nuLossDate := ge_boInstanceControl.fsbGetFieldValue('LDC_LIQSINIBRI',
                                                        'FEHA_SINIESTRO');

    /*  nuPackage:=72548481;

    nuSuscripc:=30000225;

    nuInsured_Id:=22649490;
    nuApplication_Cause_Id:=3337;
    nuProduct:=50750366;
    nuLossDate:=to_date('31/12/2017','dd/mm/yyyy');*/

    if (nuPackage is null) then
		rollback; -- 698
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El campo solicitud es obligatorio');
    end if;

    if (nuSuscripc is null) then
		rollback; -- 698
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El campo contrato es obligatorio para procesar');
      /* else
       nuValidate := LDC_PKCRMTRAMISEGBRI.FnuSuscByLiq(nuSuscripc,nuProduct);

      if (nuValidate <> 0) then
         ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El contrato con el producto registrado ya tiene una liquidacion ingresada pendiente');
        end if;   */
    end if;

    if (nuApplication_Cause_Id is null) then
		rollback; -- 698
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El campo causa de legalizacion es obligatorio para el procesar');
    end if;

    if (nuLossDate is null) then
		rollback;-- 698
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El campo fecha de siniestro es obligatorio');

    else

      damo_packages.getRecord(nuPackage, rcMopackage);

      nuclass := dage_causal.fnugetclass_causal_id(nuApplication_Cause_Id);
      sbmens  := 'Legalizacion de la orden de revisi?n de documentos aseguradora';

      open cuinfotaseg(nuPackage);
      fetch cuinfotaseg
        into nuOrderId;
      close cuinfotaseg;
      
      if nuOrderId is null then
        rollback;
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'No existe orden para análisis de siniestro, por favor verifique el flujo');
      end if;

      if nuclass = 1 then

        if (inuCurrent = 1) then

          nuValueLiqRel := 0;
          nuValidate := LDC_PKCRMTRAMISEGBRI.FnuSuscByLiq(nuSuscripc,nuProduct);

          if (nuValidate <> 0) then
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El contrato con el producto registrado ya tiene una liquidacion ingresada pendiente');
          end if;

          select GE_BOPersonal.fnuGetPersonId into nuUser from dual;

          select LDC_SEQLIQSINIBRI.nextval into nuSeqLiquidation from dual;

          update LDC_LIQSINIBRI l
             set l.creation_date    = sysdate,
                 l.status           = 'R',
                 l.user_liquidation = nuUser,
                 l.liquidation_id   = nuSeqLiquidation
           where l.package_id = nuPackage;

        end if;

        nuDeffered := isbpack;

        select substr(nuDeffered /*'C1041995648'*/, 1, 1),
               substr(nuDeffered /*'C1041995648'*/,
                      2,
                      length(nuDeffered /*'C1041995648'*/))
          into sbident, nucuent
          from dual;

        ut_trace.Trace('nucuent ' || nucuent, 10);
        --nuSeqLiq := nuSeqLiquidation;

        if sbident = 'C' then

          open cudatcuencobr(nucuent);
          fetch cudatcuencobr
            into c_cuencob;
          close cudatcuencobr;

          PROCinsertdet(nuSeqLiquidation,
                        nuPackage,
                        c_cuencob.cucofact, --inuFACTCODI       in LDC_LIQSINIBRIdet.Factcodi%type,
                        nucuent, --c_cuencobinuCUCOCODI       in LDC_LIQSINIBRIdet.Cucocodi%type,
                        c_cuencob.ano, --inuANO            in LDC_LIQSINIBRIdet.ANO%type,
                        c_cuencob.mes, --inuMES            in LDC_LIQSINIBRIdet.MES%type,
                        null, --c_cuencobinuCONCCODI       in LDC_LIQSINIBRIdet.CONCCODI%type,
                        c_cuencob.cucovato, --inuVALOR_FAC      in LDC_LIQSINIBRIdet.VALOR_FAC%type,
                        c_cuencob.cucovato, --inuVALOR_REC      in LDC_LIQSINIBRIdet.VALOR_REC%type,
                        c_cuencob.cucosacu,
                        'R', --c_cuencobinuSTATUS         in LDC_LIQSINIBRIdet.STATUS%type,
                        null --c_cuencobinuDIFECODI       in LDC_LIQSINIBRIdet.DIFECODI%type
                        );

          nuValueLiqRel := nuValueLiqRel + c_cuencob.cucovato;

          /*Se actualiza el valor en reclamo*/
          update cuencobr c
             set c.cucovare = c_cuencob.cucovato
           where c.cucocodi = c_cuencob.cucocodi;

        else

          rcDeffered := pktbldiferido.frcGetRecord(nucuent);

          PROCinsertdet(nuSeqLiquidation,
                        nuPackage,
                        null, --c_cuencob.cucofact,
                        null, --nucuent,
                        to_char(rcDeffered.Difefein, 'YYYY'),
                        to_char(rcDeffered.Difefein, 'mm'),
                        rcDeffered.Difeconc,
                        null,
                        rcDeffered.Difesape,
                        rcDeffered.Difesape,
                        'R',
                        nucuent);

          nuValueLiqRel := nuValueLiqRel + rcDeffered.Difesape;

          /*proceso del periodo de gracia*/
          nuGracePeriod := to_number(dald_parameter.fnuGetNumeric_Value('CODIGO_PERIOD_GRACIA_SINIES_BR'));

          if ((nvl(nuGracePeriod, LD_BOConstans.cnuCero) <>  LD_BOConstans.cnuCero)) then

				     nudifepldi := pktbldiferido.fnuGetDifepldi(nucuent);

				     /*Valores m?ximos y minimos del plan de diferidos*/
				     nucumaxpldi := pktblplandife.fnuGetPldicuma(nudifepldi);
				     nucuminpldi := pktblplandife.fnuGetPldicumi(nudifepldi);
				     /*Se obtiene el numero m?ximo de cuotas a cancelar del diferido*/
				     nutiemperigrac := dacc_grace_period.fnuGetMax_Grace_Days(nuGracePeriod);
				     nutiemperigra  := nutiemperigrac / 30;

				     /*Fecha de incio de la vigencia*/
				     vdate := sysdate + nutiemperigrac - 1;

			       LDC_PKCRMTRAMISEGBRI.PROCREGISPERIGRACXDIFE(nucuent,
						     									                       nuGracePeriod,
																                         sysdate,
																                         vdate);

				     pktbldiferido.upddifeenre(nucuent, 'Y');

          end if;

        end if;

        ut_trace.Trace('nuDeffered ' || nuDeffered, 10);

        if (inuCurrent = inuTotal) then

          update LDC_LIQSINIBRI l
             set l.valor_totarec      = nuValueLiqRel,
                 l.caus_leg_envi_aseg = nuApplication_Cause_Id
           where l.package_id = nuPackage;

          PROCLEgalizaOTENvioAseg(nuOrderId,
                                  nuApplication_Cause_Id,
                                  sbmens);

        end if;

      else

        PROCLEgalizaOTENvioAseg(nuOrderId, nuApplication_Cause_Id, sbmens);

      end if;

    end if;

    UT_TRACE.TRACE('**************** Fin LDC_PKCRMTRAMISEGBRI.LDCLDQS    ',
                   10);

EXCEPTION
    when ex.CONTROLLED_ERROR then
		ROLLBACK;
        RAISE Ex.CONTROLLED_ERROR;
    when others then
		ROLLBACK;
        Errors.setError;
        RAISE ex.controlled_error;

  END LDCLDQS;

  --********************************************************************************************

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROCGETLIQSINBRILLA
  Descripcion    : Busca la liquidaci?n del contrato o la solictud ingreasada
  Autor          : Kbaquero
  Fecha          :  30/06/2017 ERS 200-593

  Parametros         Descripcion
  ============   ===================
  inuPackage:      Numero del paquete

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  05/07/2024    jcatuche    OSF-2724: Se corrige error que impide el filtrado de la información mediante el consecutivo de la liquidación
  ******************************************************************/

  FUNCTION PROCGETLIQSINBRILLA

   RETURN pkConstante.tyRefCursor

   IS

    nuSuscripc    Ld_Liquidation.Subscription_Id%type;
    nuPackage     Ld_Liquidation.liqui_package_id%type;
    nuliquidation Ld_Liquidation.LIQUIDATION_ID%type;
    sbquery       varchar2(4000);
    sbquerydet    varchar2(4000);
    rfcursor      pkConstante.tyRefCursor;

  BEGIN

    ut_trace.Trace('INICIO LDC_PKCRMTRAMISEGBRI.PROCGETLIQSINBRILLA ', 10);

    /*obtener los valores ingresados en la aplicacion PB LDDEA*/
    nuliquidation := ge_boInstanceControl.fsbGetFieldValue('LDC_LIQSINIBRI',
                                                           'LIQUIDATION_ID');
    nuPackage     := ge_boInstanceControl.fsbGetFieldValue('LDC_LIQSINIBRI',
                                                           'PACKAGE_ID');

    nuSuscripc := ge_boInstanceControl.fsbGetFieldValue('LDC_LIQSINIBRI',
                                                        'SUSCRIPTION_ID');

    /* nuPackage:=15653067;

    nuSuscripc:=100223;*/

    sbquery := ' select  decode(nvl(t.cucocodi,0),0,''D''||t.difecodi,''C''||t.cucocodi) "Cuenta_cobro",
         nvl(t.factcodi,0) "Factura",
        t.ano "Ano",
        t.mes "Mes",
        t.valor_fac "Valor_Fac",
        t.valor_rec  "Valor_Rec",
        t.status  "Estado"
   from LDC_LIQSINIBRI l, LDC_LIQSINIBRIDET t
  where l.package_id = t.package_id
   and t.status  = ''R''
    and l.package_id =' || nuPackage ||
               ' and l.package_id  in (select m.package_id from mo_packages m where m.package_id=l.package_id  and m.motive_status_id=13)
    and l.suscription_id =' || nuSuscripc;

    if nuLiquidation is not null then
      sbquerydet := sbquerydet || ' AND t.liquidation_id = ' ||
                    nuLiquidation;

    end if;

    ut_trace.Trace('init query', 5);

    sbquery := sbquery || sbquerydet;

    ut_trace.Trace('sbquery ' || sbquery, 5);

    OPEN rfcursor FOR sbquery;

    Return(rfcursor);

    ut_trace.Trace('FIN LDC_PKCRMTRAMISEGBRI.PROCGETLIQSINBRILLA ', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END PROCGETLIQSINBRILLA;

  --*******************************************************************************************
  PROCEDURE GenerateBillingNote(nuSuscripcion number,
                                nuServsusc    number,
                                nuCuenta      number, -- CC Nro
                                nuValor       number, --nunotacons number,  -- 70
                                onunotanume   out number) IS

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : GenerateBillingNote
    Descripcion    : Procedimiento para generar las notas creditos cuando se legaliza con exito la
                     orden de tramite interno
                    liquidacion de siniestros brilla
    Autor          : Karem Baquero
    Fecha          : 30/06/2017 ERS 200-593

    Metodos

    Nombre         :
    Parametros     Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================

    ******************************************************************/
    nunotanume notas.notanume%type;

  BEGIN

    FA_BOBillingNotes.SetUpdateDataBaseFlag;
    pkerrors.setapplication(cc_boconstants.csbCUSTOMERCARE);
    pkBillingNoteMgr.CreateBillingNote(nuServsusc,
                                       nuCuenta, -- CC Nro
                                       nunotacons, -- 70
                                       UT_Date.fdtSysdate,
                                       'NOTA CREADA POR EL TRAMITE DE SINIESTRO BRILLA',
                                       pkBillConst.csbTOKEN_NOTA_CREDITO,
                                       nunotanume -- salida
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
                                     pkBillConst.csbTOKEN_NOTA_CREDITO ||
                                     nunotanume, --documento soporte
                                     pkBillConst.CREDITO, --signo
                                     pkConstante.SI, --ajusta cuenta
                                     null, --documento nota
                                     pkconstante.SI, --saldo a favor
                                     FALSE); --registra en aprobacion

    pkErrors.Push('pkGenerateInvoice.GenerateBillNote');

    -- Se asigna numero de nota a variable de paquete
    nuNota := nunotanume;

    --PK_FC_GRABALOG.pro_fc_grabalog('PRUNOTAS','CARGO DE NOTA CREADA: ' || nunotanume);

    pkErrors.Pop;

  EXCEPTION
    WHEN OTHERS THEN
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
  END GenerateBillingNote;

  --********************************************************************************************
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : UpdateAccoRec
  Descripcion    : Procedimiento Para actualizar la cuenta de cobro
  Autor          : Karem Baquero
  Fecha          : 30/06/2017 ERS 200-593

  Metodos

  Nombre         :
  Parametros     Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor                   Modificacion
  =========     =========               ====================

  ******************************************************************/

  PROCEDURE UpdateAccoRec(nuCuenta number) IS
  BEGIN
    --{

    pkErrors.Push('pkGenerateInvoice.UpdateAccoRec');

    -- Actualiza la cartera
    pkUpdAccoReceiv.UpdateData;

    -- Obtiene valores de la cuenta de cobro
    pkUpdAccoReceiv.GetAccountData(nuCuenta,
                                   nuCart_ValorCta,
                                   nuCart_AbonoCta,
                                   nuCart_SaldoCta);

    pkErrors.Pop;

  EXCEPTION
    when LOGIN_DENIED then
      pkErrors.Pop;
      raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
      pkErrors.Pop;
      raise pkConstante.exERROR_LEVEL2;

    when OTHERS then
      pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
      pkErrors.Pop;
      raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);

    --}
  END UpdateAccoRec;

  /*****************************************************************/

  PROCEDURE LDCABRI(isbpack         IN VARCHAR2,
                    inuCurrent      IN NUMBER,
                    inuTotal        IN NUMBER,
                    onuErrorCode    OUT NUMBER,
                    osbErrorMessage OUT VARCHAR2) IS
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : LDCABRI
    Descripcion    : Procedimiento llamado por el PB LDCAPSBI Aprobaci?n de la
                    liquidacion de siniestros brilla
    Autor          : Karem Baquero
    Fecha          : 30/06/2017 ERS 200-593

    Metodos

    Nombre         :
    Parametros     Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha         Autor         Modificacion
    =========     =========     ====================
    05/07/2024    jcatuche      OSF-2724: Se además se añade validación de la orden a procesar, 
                                evita que se procese la forma antes de que la orden por el flujo haya sido creada
    31/08/2022    EDMLAR        Se elimina la validacion del tiempo de gracias del plan de diferido
    ******************************************************************/

    nuPackage              ge_boInstanceControl.stysbValue;
    nuSuscripc             ge_boInstanceControl.stysbValue;
    nuApplication_Cause_Id ge_boInstanceControl.stysbValue;
    nuclass                number;
    nuOrderId              number;
    nuGracePeriod          number;
    nuperigrac             number;
    nuDeffered             varchar2(2000);

    nudifepldi  diferido.difepldi%type;
    nucumaxpldi plandife.pldicuma%type;

    nucuminpldi    plandife.pldicumi%type;
    nutiemperigrac ld_parameter.numeric_value%type;
    nutiemperigra  float;

    vinidate date;
    nuUser   number;
    sbmens   varchar2(2000);
    --onunotanume number;
    sbident varchar2(2);
    --rccuencob     pktblcuencobr.styCuencobr;
    nucuent number;

    /*Cursor para obtener la orden de envio a la aseguradora*/
    cursor cuinfotaseg(inuPackage number) is
      SELECT l.ot_tramite_inter
        FROM LDC_LIQSINIBRI l
       WHERE l.package_id = inuPackage;

    /*cursor para obtener la informaci?n de la liquidaci?n y su detalle*/
    cursor culiquisini(inuPackage number, nuSuscripc number) is
      select t.factcodi,
             t.cucocodi,
             t.difecodi,
             t.ano,
             t.mes,
             t.valor_fac,
             t.valor_rec,
             t.status,
             l.product_id
        from LDC_LIQSINIBRI l, LDC_LIQSINIBRIDET t
       where l.package_id = t.package_id
            -- and t.liquidation_id = l.liquidation_id
         and l.package_id = nuPackage
         and l.suscription_id = nuSuscripc;

  BEGIN

    UT_TRACE.TRACE('**************** Inicio LDC_PKCRMTRAMISEGBRI.LDCABRI     ',
                   10);

    nuPackage := ge_boInstanceControl.fsbGetFieldValue('LDC_LIQSINIBRI',
                                                       'PACKAGE_ID');

    nuSuscripc := ge_boInstanceControl.fsbGetFieldValue('LDC_LIQSINIBRI',
                                                        'SUSCRIPTION_ID');

    nuApplication_Cause_Id := ge_boInstanceControl.fsbGetFieldValue('LDC_LIQSINIBRI',
                                                                    'CAUS_LEG_ENVI_ASEG');

    /*  nuPackage := 15661773;

    nuSuscripc := 100549;

    nuApplication_Cause_Id := 9445;*/

    if (nuPackage is null) then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El campo solicitud es obligatorio');
    end if;

    if (nuSuscripc is null) then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El campo contrato es obligatorio para procesar');
    end if;

    if (nuApplication_Cause_Id is null) then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El campo causa de legalizacion es obligatorio para el procesar');
    else

      nuclass := dage_causal.fnugetclass_causal_id(nuApplication_Cause_Id);
      sbmens  := 'Legalizacion de la orden de envio a la aseguradora liquidacion siniestros Brilla';

      open cuinfotaseg(nuPackage);
      fetch cuinfotaseg
        into nuOrderId;
      close cuinfotaseg;
      
      if nuOrderId is null then
        rollback;
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'No existe orden para envío liquidación de siniestro, por favor verifique el flujo');
      end if;

      select GE_BOPersonal.fnuGetPersonId into nuUser from dual;

      nuDeffered := isbpack;

      if nuclass = 1 then

        select substr(nuDeffered /*'C1041995648'*/, 1, 1),
               substr(nuDeffered /*'C1041995648'*/,
                      2,
                      length(nuDeffered /*'C1041995648'*/))
          into sbident, nucuent
          from dual;

        ut_trace.Trace('nucuent ' || nucuent, 10);
        --nuSeqLiq := nuSeqLiquidation;

        if sbident = 'C' then

          update LDC_LIQSINIBRIDET c
             set c.status = 'A' --c_cuencob.cucovato
           where package_id = nuPackage
             and c.cucocodi = nucuent;

        else
          update LDC_LIQSINIBRIDET c
             set c.status = 'A' --c_cuencob.cucovato
           where package_id = nuPackage
             and c.difecodi = nucuent;

        end if;

        if (inuCurrent = 1) then

          update LDC_LIQSINIBRI c
             set c.status      = 'A',
                 user_aprobe   = nuUser,
                 approval_date = sysdate --c_cuencob.cucovato
           where package_id = nuPackage;

          PROCLEgalizaOTENvioAseg(nuOrderId,
                                  nuApplication_Cause_Id,
                                  sbmens);

        end if;

      else

        for rgliqu in culiquisini(nuPackage, nuSuscripc) loop

          if rgliqu.cucocodi is not null then
            /*Se actualiza el valor en reclamo*/
            update cuencobr c
               set c.cucovare = LD_BOConstans.cnuCero --c_cuencob.cucovato
             where c.cucocodi = rgliqu.cucocodi;

          else

            /*proceso del periodo de gracia*/
            nuGracePeriod := to_number(dald_parameter.fnuGetNumeric_Value('CODIGO_PERIOD_GRACIA_SINIES_BR'));

            if ((nvl(nuGracePeriod, LD_BOConstans.cnuCero) <>
               LD_BOConstans.cnuCero)) then
              --              rgliqu.difecodi
              nudifepldi := pktbldiferido.fnuGetDifepldi(rgliqu.difecodi);

              /*Valores m?ximos y minimos del plan de diferidos*/
              nucumaxpldi := pktblplandife.fnuGetPldicuma(nudifepldi);
              nucuminpldi := pktblplandife.fnuGetPldicumi(nudifepldi);
              /*Se obtiene el numero m?ximo de cuotas a cancelar del diferido*/
              nutiemperigrac := dacc_grace_period.fnuGetMax_Grace_Days(nuGracePeriod);
              nutiemperigra  := nutiemperigrac / 30;

              /*Fecha de incio de la vigencia*/
              --  vdate := sysdate + nutiemperigrac - 1;
              nuperigrac := LDC_PKCRMTRAMISEGBRI.Fnuconsperigracdif(rgliqu.difecodi);

              vinidate := dacc_grace_peri_defe.fdtgetinitial_date(nuperigrac /*472500*/);
              -- vdate    := dacc_grace_peri_defe.fdtgetend_date(nuperigrac /*472500*/);

              LDC_PKCRMTRAMISEGBRI.PROCANCELPERIGRACXDIFE(rgliqu.difecodi,
                                                          nuperigrac,
                                                          nuGracePeriod,
                                                          vinidate);

              pktbldiferido.upddifeenre(rgliqu.difecodi, 'N');

            end if;
          end if;

        end loop;

        update LDC_LIQSINIBRIDET c
           set c.status = 'N' --c_cuencob.cucovato
         where package_id = nuPackage;

        update LDC_LIQSINIBRI c
           set c.status      = 'N',
               user_aprobe   = nuUser,
               approval_date = sysdate --c_cuencob.cucovato
         where package_id = nuPackage;

        if (inuCurrent = inuTotal) then

          PROCLEgalizaOTENvioAseg(nuOrderId,
                                  nuApplication_Cause_Id,
                                  sbmens);

        end if;

      end if;

    end if;

    PROCLEGENVIOLIQEXITO(nuPackage, nuSuscripc);

    UT_TRACE.TRACE('**************** Fin LDC_PKCRMTRAMISEGBRI.LDCABRI    ',
                   10);

  END LDCABRI;

  PROCEDURE PROCLEGGESINTREXITO(nuPackage in mo_packages.package_id%type) IS
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : PROCLEGGESINTREXITO
    Descripcion    : Este proceso realiza la generaci?n de notas, cuando la causal de
                    legalizaicon de la orden de gestion interna es legalizada con exito
                    liquidacion de siniestros brilla
    Autor          : Karem Baquero
    Fecha          : 21/10/2017 ERS 200-593

    Metodos

    Nombre         :
    Parametros     Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    29/12/2021    HORBATH					Caso: 880: Se modifica eliminar la validaci¿¿n del tiempo de gracia del plan de diferido
    ******************************************************************/

    nuOrderId     number;
    nuGracePeriod number;
    nuperigrac    number;

    nudifepldi  diferido.difepldi%type;
    nucumaxpldi plandife.pldicuma%type;

    nucuminpldi    plandife.pldicumi%type;
    nutiemperigrac ld_parameter.numeric_value%type;
    nutiemperigra  float;
    blabono        boolean := FALSE;
    blsavepoint    boolean := FALSE;
    blprocesind    boolean := FALSE;

    vinidate date;
    --vdate       date;
    nuUser         number;
    sbmens         varchar2(2000);
    onunotanume    number;
    sbprograma     varchar2(20) := 'NOTESREG';
    nuErrorCode    NUMBER;
    sbErrorMessage VARCHAR2(4000);

    /*cursor para obtener la informaci?n de la liquidaci?n y su detalle*/
    cursor culiquisini(inuPackage number) is
      select t.factcodi,
             t.cucocodi,
             t.difecodi,
             t.ano,
             t.mes,
             t.valor_fac,
             t.valor_rec,
             t.status,
             l.product_id,
             l.suscription_id
        from LDC_LIQSINIBRI l, LDC_LIQSINIBRIDET t
       where l.package_id = t.package_id
            -- and t.liquidation_id = l.liquidation_id
         and l.package_id = nuPackage
      /* and l.suscription_id = nuSuscripc*/
      ;

  BEGIN

    UT_TRACE.TRACE('**************** Inicio LDC_PKCRMTRAMISEGBRI.PROCLEGGESINTREXITO     ',
                   10);

    select GE_BOPersonal.fnuGetPersonId into nuUser from dual;

    /*proceso del periodo de gracia*/
    nuGracePeriod := to_number(dald_parameter.fnuGetNumeric_Value('CODIGO_PERIOD_GRACIA_SINIES_BR'));

    if ((nvl(nuGracePeriod, LD_BOConstans.cnuCero) <> LD_BOConstans.cnuCero)) then

      for rgliqu in culiquisini(nuPackage /*, nuSuscripc*/) loop
        if rgliqu.status = 'A' then
          if rgliqu.cucocodi is not null then
            /*Creaci?n de la notas credito*/
            GenerateBillingNote(rgliqu.suscription_id, --nuSuscripc,
                                rgliqu.product_id,
                                rgliqu.cucocodi, -- CC Nro
                                rgliqu.valor_rec,
                                onunotanume);
            /*Actualiza la cartera*/
            UpdateAccoRec(rgliqu.cucocodi);

            update cuencobr c
               set c.cucovare = LD_BOConstans.cnuCero --c_cuencob.cucovato
             where c.cucocodi = rgliqu.cucocodi;
          else
            -- Traslada diferido a pmes
            pkTransDefToCurrDebt.Transferdebt(rgliqu.product_id,
                                              rgliqu.difecodi,
                                              rgliqu.valor_rec,
                                              sbprograma, -- input
                                              nuestadocuenta,
                                              nucuenta,
                                              nuerrorcode,
                                              sberrormessage, -- output
                                              blabono,
                                              blsavepoint,
                                              blprocesind); -- input

            if nuerrorcode = 0 then
              /*Creaci?n de la notas credito*/
              GenerateBillingNote(rgliqu.suscription_id, --nuSuscripc,
                                  rgliqu.product_id,
                                  nucuenta, -- CC Nro
                                  rgliqu.valor_rec,
                                  onunotanume);
              /*Actualiza la cartera*/
              UpdateAccoRec(rgliqu.cucocodi);

              nudifepldi := pktbldiferido.fnuGetDifepldi(rgliqu.difecodi);

              /*Valores m?ximos y minimos del plan de diferidos*/
              nucumaxpldi := pktblplandife.fnuGetPldicuma(nudifepldi);
              nucuminpldi := pktblplandife.fnuGetPldicumi(nudifepldi);
              /*Se obtiene el numero m?ximo de cuotas a cancelar del diferido*/
              nutiemperigrac := dacc_grace_period.fnuGetMax_Grace_Days(nuGracePeriod);
              nutiemperigra  := nutiemperigrac / 30;
				if  fblaplicaentregaxcaso('0000880')= false then

					/*Condicional para que el tiempo de gracia se encuentre dentro del plan de diferidos*/
					if nucumaxpldi >= nutiemperigra and
						nutiemperigra >= nucuminpldi then

						/*Fecha de incio de la vigencia*/
						--  vdate := sysdate + nutiemperigrac - 1;
						nuperigrac := LDC_PKCRMTRAMISEGBRI.Fnuconsperigracdif(rgliqu.difecodi);

						vinidate := dacc_grace_peri_defe.fdtgetinitial_date(nuperigrac /*472500*/);
						-- vdate    := dacc_grace_peri_defe.fdtgetend_date(nuperigrac /*472500*/);

						LDC_PKCRMTRAMISEGBRI.PROCANCELPERIGRACXDIFE(rgliqu.difecodi,
																nuperigrac,
																nuGracePeriod,
																vinidate);

						pktbldiferido.upddifeenre(rgliqu.difecodi, 'N');
						else
						ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_ValMess,
													 'El n?mero de d?as se encuentra fuera del rango del plan diferido');

					end if;

				else

					/*Fecha de incio de la vigencia*/
					--  vdate := sysdate + nutiemperigrac - 1;
					nuperigrac := LDC_PKCRMTRAMISEGBRI.Fnuconsperigracdif(rgliqu.difecodi);

					vinidate := dacc_grace_peri_defe.fdtgetinitial_date(nuperigrac /*472500*/);
					-- vdate    := dacc_grace_peri_defe.fdtgetend_date(nuperigrac /*472500*/);

					LDC_PKCRMTRAMISEGBRI.PROCANCELPERIGRACXDIFE(rgliqu.difecodi,
																nuperigrac,
																nuGracePeriod,
																vinidate);

					pktbldiferido.upddifeenre(rgliqu.difecodi, 'N');

				end if;


            end if;

          end if;

        end if;
      end loop;
    else
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_ValMess,
                                       'El parametro del consecutivo del periodo de gracia debe estar configurado');

    end if;

    UT_TRACE.TRACE('**************** Fin LDC_PKCRMTRAMISEGBRI.PROCLEGGESINTREXITO    ',
                   10);

  END PROCLEGGESINTREXITO;

  PROCEDURE PROCLEGENVIOLIQEXITO(inuPackage in mo_packages.package_id%type,
                                 nuSuscripc IN suscripc.susccodi%type) IS
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : PROCLEGENVIOLIQEXITO
    Descripcion    : Este proceso realiza la generaci?n de notas, cuando la causal de
                    legalizaicon de la orden de gestion interna es legalizada con exito
                    liquidacion de siniestros brilla
    Autor          : Karem Baquero
    Fecha          : 21/10/2017 ERS 200-593

    Metodos

    Nombre         :
    Parametros     Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================

    ******************************************************************/

    --nuOrderId     number;
    nuGracePeriod number;
    nuperigrac    number;

    nudifepldi  diferido.difepldi%type;
    nucumaxpldi plandife.pldicuma%type;

    nucuminpldi    plandife.pldicumi%type;
    nutiemperigrac ld_parameter.numeric_value%type;
    nutiemperigra  float;
    blabono        boolean := FALSE;
    blsavepoint    boolean := FALSE;
    blprocesind    boolean := FALSE;

    vinidate date;
    vdate    date;
    nuUser   number;
    --sbmens         varchar2(2000);
    onunotanume    number;
    sbprograma     varchar2(20) := 'NOTESREG';
    nuErrorCode    NUMBER;
    sbErrorMessage VARCHAR2(4000);

    nugradifperi number;

    /*cursor para obtener la informaci?n de la liquidaci?n y su detalle*/
    cursor culiquisini /*(inuPackage number)*/
    is
      select t.factcodi,
             t.cucocodi,
             t.difecodi,
             t.ano,
             t.mes,
             t.valor_fac,
             t.valor_rec,
             t.status,
             l.product_id,
             l.suscription_id,
             l.creation_date
        from LDC_LIQSINIBRI l, LDC_LIQSINIBRIDET t
       where l.package_id = t.package_id
            -- and t.liquidation_id = l.liquidation_id
         and l.package_id = inuPackage
         and l.suscription_id = nuSuscripc;

  BEGIN

    UT_TRACE.TRACE('**************** Inicio LDC_PKCRMTRAMISEGBRI.PROCLEGENVIOLIQEXITO     ',
                   10);

    /*proceso para descargar los valores en reclamo y de los diferidos que no se aprueban*/
    for rgliqu in culiquisini /*(nuPackage, nuSuscripc)*/
     loop

      if rgliqu.status <> 'A' then

        if rgliqu.cucocodi is not null then
          /*Se actualiza el valor en reclamo*/
          update cuencobr c
             set c.cucovare = LD_BOConstans.cnuCero --c_cuencob.cucovato
           where c.cucocodi = rgliqu.cucocodi;

          update LDC_LIQSINIBRIDET c
             set c.status = 'N' --c_cuencob.cucovato
           where package_id = inuPackage
             and c.cucocodi = rgliqu.cucocodi;

        else

          /*proceso del periodo de gracia*/
          nuGracePeriod := to_number(dald_parameter.fnuGetNumeric_Value('CODIGO_PERIOD_GRACIA_SINIES_BR'));

          if ((nvl(nuGracePeriod, LD_BOConstans.cnuCero) <>
             LD_BOConstans.cnuCero)) then
            --              rgliqu.difecodi
            nudifepldi := pktbldiferido.fnuGetDifepldi(rgliqu.difecodi);

            /*Valores m?ximos y minimos del plan de diferidos*/
            nucumaxpldi := pktblplandife.fnuGetPldicuma(nudifepldi);
            nucuminpldi := pktblplandife.fnuGetPldicumi(nudifepldi);
            /*Se obtiene el numero m?ximo de cuotas a cancelar del diferido*/
            nutiemperigrac := dacc_grace_period.fnuGetMax_Grace_Days(nuGracePeriod);
            nutiemperigra  := nutiemperigrac / 30;

            /*Fecha de incio de la vigencia*/
             --  vdate := sysdate + nutiemperigrac - 1;
            nuperigrac := LDC_PKCRMTRAMISEGBRI.Fnuconsperigracdif(rgliqu.difecodi);

            vinidate := dacc_grace_peri_defe.fdtgetinitial_date(nuperigrac /*472500*/);
            -- vdate    := dacc_grace_peri_defe.fdtgetend_date(nuperigrac /*472500*/);

            LDC_PKCRMTRAMISEGBRI.PROCANCELPERIGRACXDIFE(rgliqu.difecodi,
                                                        nuperigrac,
                                                        nuGracePeriod,
                                                        vinidate);

            pktbldiferido.upddifeenre(rgliqu.difecodi, 'N');

            update LDC_LIQSINIBRIDET c
               set c.status = 'N' --c_cuencob.cucovato
             where package_id = inuPackage
               and c.difecodi = rgliqu.difecodi;

          end if;
        end if;

      else

        if rgliqu.cucocodi is not null then
          /*Se actualiza el valor en reclamo*/
          update cuencobr c
             set c.cucovare = rgliqu.valor_rec
           where c.cucocodi = rgliqu.cucocodi;
        else
          /*proceso del periodo de gracia*/
          nuGracePeriod := to_number(dald_parameter.fnuGetNumeric_Value('CODIGO_PERIOD_GRACIA_SINIES_BR'));

          if ((nvl(nuGracePeriod, LD_BOConstans.cnuCero) <>
             LD_BOConstans.cnuCero)) then

            nudifepldi := pktbldiferido.fnuGetDifepldi(rgliqu.difecodi);

            /*Valores m?ximos y minimos del plan de diferidos*/
            nucumaxpldi := pktblplandife.fnuGetPldicuma(nudifepldi);
            nucuminpldi := pktblplandife.fnuGetPldicumi(nudifepldi);
            /*Se obtiene el numero m?ximo de cuotas a cancelar del diferido*/
            nutiemperigrac := dacc_grace_period.fnuGetMax_Grace_Days(nuGracePeriod);
            nutiemperigra  := nutiemperigrac / 30;

            /*Fecha de final de la vigencia*/
            vdate := rgliqu.creation_date  + nutiemperigrac - 1;--sysdate + nutiemperigrac - 1;

            begin
              select max(d.grace_peri_defe_id)
                into nugradifperi
                from cc_grace_peri_defe d
               where d.deferred_id = rgliqu.difecodi
                 and d.grace_period_id = nuGracePeriod;
            EXCEPTION
              when ex.CONTROLLED_ERROR then
                raise ex.CONTROLLED_ERROR;
              when others then
                Errors.setError;
                raise ex.CONTROLLED_ERROR;
            end;

            dacc_grace_peri_defe.updend_date(nugradifperi,
                                             vdate);
            pktbldiferido.upddifeenre(rgliqu.difecodi, 'Y');

          end if;

        end if;

      end if;
    end loop;

    UT_TRACE.TRACE('**************** Fin LDC_PKCRMTRAMISEGBRI.PROCLEGENVIOLIQEXITO    ',
                   10);

  END PROCLEGENVIOLIQEXITO;

  PROCEDURE PROCLEGGESINTRFALLO(nuPackage mo_packages.package_id%type) IS
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : PROCLEGGESINTRFALLO
    Descripcion    : Procedimiento llamado por el PB LDCAPSBI Aprobaci?n de la
                    liquidacion de siniestros brilla
    Autor          : Karem Baquero
    Fecha          : 21/10/2017 ERS 200-593

    Metodos

    Nombre         :
    Parametros     Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    03/20/2023    jcatuchemvm             OSF-892: Se elimina validacion de
                                          Condicional para que el tiempo de gracia se encuentre dentro del plan de diferidos.
                                          Desmantelamiento de validaciones que ya no aplican en la operacion. Ref Edmundo Lara
    ******************************************************************/

    nuGracePeriod number;
    nuperigrac    number;

    vinidate date;
    --vdate       date;
    nuUser number;
    --onunotanume number;

    /*cursor para obtener la informaci?n de la liquidaci?n y su detalle*/
    cursor culiquisini is
      select t.factcodi,
             t.cucocodi,
             t.difecodi,
             t.ano,
             t.mes,
             t.valor_fac,
             t.valor_rec,
             t.status,
             l.product_id
        from LDC_LIQSINIBRI l, LDC_LIQSINIBRIDET t
       where l.package_id = t.package_id
            -- and t.liquidation_id = l.liquidation_id
         and l.package_id = nuPackage
      /*and l.suscription_id = nuSuscripc*/
      ;

  BEGIN

    UT_TRACE.TRACE('**************** Inicio LDC_PKCRMTRAMISEGBRI.PROCLEGGESINTRFALLO     ',
                   10);

    select GE_BOPersonal.fnuGetPersonId into nuUser from dual;

    for rgliqu in culiquisini loop

      if rgliqu.cucocodi is not null then
        /*Se actualiza el valor en reclamo*/
        update cuencobr c
           set c.cucovare = LD_BOConstans.cnuCero --c_cuencob.cucovato
         where c.cucocodi = rgliqu.cucocodi;

      else

        /*proceso del periodo de gracia*/
        nuGracePeriod := to_number(dald_parameter.fnuGetNumeric_Value('CODIGO_PERIOD_GRACIA_SINIES_BR'));

        if ((nvl(nuGracePeriod, LD_BOConstans.cnuCero) <>
           LD_BOConstans.cnuCero)) then
            
          nuperigrac := LDC_PKCRMTRAMISEGBRI.Fnuconsperigracdif(rgliqu.difecodi);

          vinidate := dacc_grace_peri_defe.fdtgetinitial_date(nuperigrac /*472500*/);
          -- vdate    := dacc_grace_peri_defe.fdtgetend_date(nuperigrac /*472500*/);

          LDC_PKCRMTRAMISEGBRI.PROCANCELPERIGRACXDIFE(rgliqu.difecodi,
                                                        nuperigrac,
                                                        nuGracePeriod,
                                                        vinidate);

          pktbldiferido.upddifeenre(rgliqu.difecodi, 'N');
          
        end if;
      end if;

    end loop;

    UT_TRACE.TRACE('**************** Fin LDC_PKCRMTRAMISEGBRI.PROCLEGGESINTRFALLO    ',
                   10);

  END PROCLEGGESINTRFALLO;

END LDC_PKCRMTRAMISEGBRI;

/