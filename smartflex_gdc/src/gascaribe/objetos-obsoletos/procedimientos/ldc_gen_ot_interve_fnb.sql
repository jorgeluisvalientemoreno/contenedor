CREATE OR REPLACE PROCEDURE LDC_GEN_OT_INTERVE_FNB IS

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : LDC_GEN_OT_INTERVE_FNB
  DESCRIPCION    : PROCEDIMIENTO PARA GENERAR LA OT DE INTERVENTORIA CUANDO SE
                   LEGALICE LA OT DE INSTALACIÿN DE GASODOMÿ�STICOS FNB.
  AUTOR          : KCIENFUEGOS - UTILIZADO EN PLUGIN
  RNP            : 1179
  FECHA          : 10/10/2014

  PARAMETROS              DESCRIPCION
  ============         ===================

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/
  nuCausalId                  or_order.causal_id%type;
  nuPackageId                 mo_packages.package_id%type;
  nuOrderId                   or_order.order_id%type;
  nuCausalClassId             ge_causal.class_causal_id%type;
  nuActividInterv             ge_items.items_id%type;
  nuOrderIntervent            or_order_activity.order_id%type;
  nuNewOrderActivId           or_order_activity.order_activity_id%type;
  nuOperatUnitId              or_operating_unit.operating_unit_id%type;
  nuOrderActivId              or_order_activity.order_activity_id%type;

BEGIN

    ut_trace.trace('INICIA - LDC_GEN_OT_INTERVE_FNB', 10);

    /*Obtiene el id de la orden en la instancia*/
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder();

    ut_trace.trace('LDC_GEN_OT_INTERVE_FNB-nuOrderId -->'||nuOrderId, 10);

    /*Obtiene el id de la causal de legalización*/
    nuCausalId := daor_order.fnugetcausal_id(nuOrderId);

    ut_trace.trace('LDC_GEN_OT_INTERVE_FNB-nuCausalId -->'||nuCausalId, 10);

    /*Obtiene el id de la solicitud de la actividad*/
    nuPackageId  := ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                                   'ORDER_ID',
                                                                 'PACKAGE_ID',
                                                                   nuOrderId);

    ut_trace.trace('LDC_GEN_OT_INTERVE_FNB-nuPackageId -->'||nuPackageId, 10);


    nuOrderActivId  := ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                             'ORDER_ID',
                                                             'ORDER_ACTIVITY_ID',
                                                             nuOrderId);
    /*Obtiene clasificación de la causal*/
    nuCausalClassId := dage_causal.fnugetclass_causal_id(nuCausalId);

    if nuCausalClassId = MO_BOCausal.Fnugetsuccess then

      nuActividInterv := dald_parameter.fnuGetNumeric_Value('ACT_TYPE_INTERVENT_FNB');

      /*Crea la orden de interventoría*/
      ld_boflowfnbpack.createReviewOrderActivity(nuActividInterv,
                                                 nuOrderIntervent,
                                                 nuOrderActivId,
                                                 nuPackageId,
                                                 'Registro de la orden de interventoría de instalación de gasodomésticos FNB',
                                                 nuNewOrderActivId);

      /*Se obtiene la unidad operativa de la venta*/
      nuOperatUnitId := damo_packages.fnugetoperating_unit_id(nuPackageId);

      /*Asigna la orden de interventoria a la unidad operativa*/
      or_boprocessorder.ProcessOrder(nuOrderIntervent,
                                     null,
                                     nuOperatUnitId,
                                     null,
                                     FALSE,
                                     NULL,
                                     NULL);
    end if;

    ut_trace.trace('FINALIZA - LDC_GEN_OT_INTERVE_FNB', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

END LDC_GEN_OT_INTERVE_FNB;
/
PROMPT OTORGA PERMISOS a REXEREPORTES sobre procedimiento LDC_GEN_OT_INTERVE_FNB
GRANT EXECUTE ON LDC_GEN_OT_INTERVE_FNB TO REXEREPORTES;
/