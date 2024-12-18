CREATE OR REPLACE PROCEDURE LDC_GEN_OT_INTERVE_VTA_EMPAQ IS

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : LDC_GEN_OT_INTERVE_VTA_EMPAQ
  DESCRIPCION    : PROCEDIMIENTO PARA GENERAR LA OT DE INTERVENTORIA CUANDO SE
                   LEGALICE LA OT DE INSTALACIÿN DE GASODOMÿ�STICO POR VENTA
                   EMPAQUETADA.
  AUTOR          : KCIENFUEGOS - UTILIZADO EN PLUGIN
  RNP            : 1808
  FECHA          : 23/10/2014

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
  nuSubscriberId              ge_subscriber.subscriber_id%type;
  nuCont                      number := 0;

  Cursor cu_Interv_Order is
     select count(1)
       from OR_ORDER O
      where O.SUBSCRIBER_ID = nuSubscriberId
        and O.ORDER_STATUS_ID IN (or_boconstants.cnuORDER_STAT_EXECUTED, or_boconstants.cnuORDER_STAT_CLOSED)
        and instr(dald_parameter.fsbGetValue_Chain('TIPOS_TRAB_INTERVENT'),
                  O.TASK_TYPE_ID) > 0;


BEGIN

    ut_trace.trace('INICIA - LDC_GEN_OT_INTERVE_VTA_EMPAQ', 10);

    /*Obtiene el id de la orden en la instancia*/
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder();

    ut_trace.trace('LDC_GEN_OT_INTERVE_VTA_EMPAQ-nuOrderId -->'||nuOrderId, 10);

    /*Obtiene el id de la causal de legalización*/
    nuCausalId := daor_order.fnugetcausal_id(nuOrderId);

    ut_trace.trace('LDC_GEN_OT_INTERVE_VTA_EMPAQ-nuCausalId -->'||nuCausalId, 10);

    /*Obtiene el id de la solicitud de venta*/
    nuPackageId  := ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                                   'ORDER_ID',
                                                                 'PACKAGE_ID',
                                                                   nuOrderId);

    ut_trace.trace('LDC_GEN_OT_INTERVE_VTA_EMPAQ-nuPackageId -->'||nuPackageId, 10);

    nuSubscriberId := damo_packages.fnugetsubscriber_id(nuPackageId);

    /*Obtiene el id de la actividad de la orden*/
    nuOrderActivId  := ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                             'ORDER_ID',
                                                             'ORDER_ACTIVITY_ID',
                                                             nuOrderId);
    /*Obtiene clasificación de la causal*/
    nuCausalClassId := dage_causal.fnugetclass_causal_id(nuCausalId);

    /*Si la causal de legalización exitosa, crea la orden de interventoría*/
    if nuCausalClassId = MO_BOCausal.Fnugetsuccess then

      /*Valida si existen órdenes de interventoría ejecutadas/legalizadas*/
      open cu_Interv_Order;
      fetch cu_Interv_Order into nuCont;
      close cu_Interv_Order;

      if nvl(nuCont,0) > ld_boconstans.cnuCero then
        nuActividInterv := dald_parameter.fnuGetNumeric_Value('ACT_TYPE_INTERVENT_VTA_EMP');

        /*Crea la orden de interventoría*/
        ld_boflowfnbpack.createReviewOrderActivity(nuActividInterv,
                                                   nuOrderIntervent,
                                                   nuOrderActivId,
                                                   nuPackageId,
                                                   'Orden de interventoría por venta empaquetada FNB',
                                                   nuNewOrderActivId);

        /*Se obtiene la unidad operativa configurada en el parámetro*/
        nuOperatUnitId := nvl(dald_parameter.fnuGetNumeric_Value('UT_INTERVENT_VTA_EMPAQ'),-1);

        /*Valida si existe la unidad operativa configurada*/
        if daor_operating_unit.fblexist(nuOperatUnitId) then

          /*Asigna la orden de interventoria a la unidad operativa*/
          or_boprocessorder.ProcessOrder(nuOrderIntervent,
                                         null,
                                         nuOperatUnitId,
                                         null,
                                         FALSE,
                                         NULL,
                                         NULL);
        else
             ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
             'La unidad operativa configurada en el parámetro UT_INTERVENT_VTA_EMPAQ, no existe. Por favor validar');
             raise ex.CONTROLLED_ERROR;
        end if;
      end if;
    end if;

    ut_trace.trace('FINALIZA - LDC_GEN_OT_INTERVE_VTA_EMPAQ', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

END LDC_GEN_OT_INTERVE_VTA_EMPAQ;
/
PROMPT OTORGA PERMISOS a REXEREPORTES sobre procedimiento LDC_GEN_OT_INTERVE_VTA_EMPAQ
GRANT EXECUTE ON LDC_GEN_OT_INTERVE_VTA_EMPAQ TO REXEREPORTES;
/