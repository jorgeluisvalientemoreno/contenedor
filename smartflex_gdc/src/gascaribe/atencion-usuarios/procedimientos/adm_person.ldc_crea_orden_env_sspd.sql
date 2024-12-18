CREATE OR REPLACE procedure ADM_PERSON.LDC_CREA_ORDEN_ENV_SSPD is
  /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : LDC_VAL_CAUS_APELACION
    DESCRIPCION    : PROCEDIMIENTO PARA ORDEN DE ENVIO A SSPD ACTIVIDAD (4295400)
                     ESTE TRABAJO QUEDA ASOCIADO AL SOLITUD DE INTERACCION
    AUTOR          : RONALD COLPAS - UTILIZADO EN PLUGIN
    FECHA          : 21/03/2019

    PARAMETROS              DESCRIPCION
    ============         ===================

    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
  ******************************************************************/

  cnuPackType   mo_packages.package_type_id%type := 100338;
  cnuActividad   or_order_activity.activity_id%type := 4295400;

  nuOrderActiv   or_order_activity.order_activity_id%type;
  nuPackageId    mo_packages.package_id%type;
  nuPackinter    mo_packages.package_id%type;
  nuOrderId      or_order.order_id%type;
  nuPackType     mo_packages.package_type_id%type;
  nuMotive       mo_motive.motive_id%type;
  nuAddress_id   mo_packages.address_id%type;
  suscription_id suscripc.susccodi%type;
  product_id     number;
  nuRest         number;

  cursor cuActividadSSPD(nuPack or_order_activity.package_id%type) is
    select count(1)
      from or_order_activity
     where package_id = nuPack
       and activity_id = cnuActividad;

begin
  ut_trace.trace('INICIA - LDC_CREA_ORDEN_ENV_SSPD', 10);

  /*Obtiene el id de la orden en la instancia*/
  nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder();
  ut_trace.trace('LDC_CREA_ORDEN_ENV_SSPD-nuOrderId -->' || nuOrderId,
                 10);

  /*Obtiene el id de la solicitud de la actividad*/
  nuPackageId := ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                       'ORDER_ID',
                                                       'PACKAGE_ID',
                                                       nuOrderId);
  ut_trace.trace('LDC_CREA_ORDEN_ENV_SSPD-nuPackageId -->' || nuPackageId, 10);

  /*Obtiene el id del tipo de tramite*/
  nuPackType := damo_packages.fnugetpackage_type_id(nuPackageId);
  ut_trace.trace('LDC_CREA_ORDEN_ENV_SSPD-nuPackType -->' ||nuPackType,10);

  --Si es el tramite 10038 Generamos la orden por medio de actividad 4295400
  if nuPackType = cnuPackType then

    nuAddress_id := damo_packages.fnugetaddress_id(nuPackageId);
    /*Obtiene el id de mo_motive*/
    nuMotive := mo_bopackages.fnuGetInitialMotive(nuPackageId);

    /*Obtiene el producto*/
    product_id := mo_bomotive.fnugetproductid(nuMotive);

    /*Contrato del motivo*/
    suscription_id := mo_bomotive.fnugetsubscription(nuMotive);

    nuMotive := null;

    --Validamos que la interaccion no tenga orden de actividad 4295400
    nuPackinter := to_number(damo_packages.fsbgetcust_care_reques_num(nuPackageId));
    ut_trace.trace('LDC_CREA_ORDEN_ENV_SSPD-nuPackinter -->' ||nuPackinter,10);

    --Validamos que la interaccion no tenga orden de envio a SSPD
    open cuActividadSSPD(nuPackinter);
    fetch cuActividadSSPD
      into nuRest;
    close cuActividadSSPD;

    if nuRest = 0 then

      --Consultamos motive_id de la interaccion
      nuMotive := ldc_boutilities.fsbgetvalorcampotabla('MO_MOTIVE',
                                                        'PACKAGE_ID',
                                                        'MOTIVE_ID',
                                                        nuPackinter);

      /* Se crea la orden de visita tecnica */
      nuOrderId    := null;
      nuOrderActiv := null;

      or_boorderactivities.CreateActivity(cnuActividad,
                                          nuPackinter,
                                          nuMotive,
                                          null,
                                          null,
                                          nuAddress_id,
                                          null,
                                          null,
                                          suscription_id,
                                          product_id,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          nuOrderId,
                                          nuOrderActiv,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null);
    end if;
  end if;

  ut_trace.trace('FINALIZA - LDC_CREA_ORDEN_ENV_SSPD', 10);

EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise;
  when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;

end LDC_CREA_ORDEN_ENV_SSPD;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_CREA_ORDEN_ENV_SSPD', 'ADM_PERSON');
END;
/

