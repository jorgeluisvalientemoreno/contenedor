CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_UPDATE_GRACE_PERIOD IS
  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : LDC_UPDATE_GRACE_PERIOD
  DESCRIPCION    : PROCEDIMIENTO PARA ACTUALIZAR LAS FECHAS DEL VENCIMIENTO DEL PERIODO DE GRACIA
                   DE LOS DIFERIDOS ASOCIADOS A UN TRAMITE DE LIQUIDACION DE SINIESTRO, CUANDO LA OT
                   DE GESTION INTERNA POR TRAMITE DE SEGURO(10150) SE LEGALICE CON CAUSAL DE FALLO.
  AUTOR          : KATHERINE CIENFUEGOS - UTILIZADO EN PLUGIN
  NC             : 1403
  FECHA          : 27/08/2014

  PARAMETROS              DESCRIPCION
  ============         ===================

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  19-10-2017      Kbaquero CA200-593  Se modifica ya que se cre? una liquidaci?n de siniestros brilla
                                      para que en el momento que se este legalizando una solicitud de siniestros
                                      Brilla tenga en cuenta las tablas de este proceso
  15-12-2014      Llozada [NC 4230]   Se valida que el proceso NO se ejecute para Brilla Seguros
  27-08-2014      KCienfuegos.NC1403  Creacion
  29/04/2024      PACOSTA             OSF-2598: Se crea el objeto en el esquema adm_person 
  ******************************************************************/
  nuLiquiIndex     number;
  nuGracePerIndex  number;
  nuCausalId       ge_causal.causal_id%type;
  nuPackageId      mo_packages.package_id%type;
  nuOrderId        or_order.order_id%type;
  nuClassCausal    ge_causal.class_causal_id%type;
  nuGracPeriodId   cc_grace_period.grace_period_id%type;
  tbDetaiLiquid    dald_detail_liquidation.tytbld_detail_liquidation;
  tbGracePeriodDef dacc_grace_peri_defe.tytbcc_grace_peri_defe;
  nuLastDeferr     diferido.difecodi%type;
  nuProduct_id     pr_product.product_id%type;
  nupacktype       number;
  NUTYPEPACKPARA   number;

BEGIN

  ut_trace.trace('INICIA - LDC_UPDATE_GRACE_PERIOD', 10);

  /*Obtiene el id de la orden en la instancia*/
  nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder();

  nuProduct_id := ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                        'ORDER_ID',
                                                        'PRODUCT_ID',
                                                        nuOrderId);
  /*Obtiene el id de la solicitud de la actividad*/
  nuPackageId := ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                       'ORDER_ID',
                                                       'PACKAGE_ID',
                                                       nuOrderId);

  --15-12-2014 Llozada [NC 4230]: No se debe ejecutar el procedimiento para Seguros
  if (dapr_product.fnugetproduct_type_id(nuProduct_id) =
     dald_parameter.fnuGetNumeric_Value('COD_PRODUCT_TYPE')) then
    return;
  end if;

  ut_trace.trace('LDC_UPDATE_GRACE_PERIOD-nuOrderId -->' || nuOrderId, 10);

  /*Obtiene el id de la causal de legalizacion*/
  nuCausalId := daor_order.fnugetcausal_id(nuOrderId);

  ut_trace.trace('LDC_UPDATE_GRACE_PERIOD-nuCausalId -->' || nuCausalId,
                 10);

  /*Obtiene la clasificacion de la causal*/
  nuClassCausal := dage_causal.Fnugetclass_Causal_Id(nuCausalid);

  ut_trace.trace('LDC_UPDATE_GRACE_PERIOD-nuClassCausal -->' ||
                 nuClassCausal,
                 10);

  IF nuClassCausal = MO_BOCausal.fnuGetFail THEN

    ut_trace.trace('LDC_UPDATE_GRACE_PERIOD-nuPackageId -->' ||
                   nuPackageId,
                   10);

    IF nuPackageId IS NOT NULL THEN
      /*modificacion caso 200-593 Jm gestion Informatica*/
      nupacktype := damo_packages.fnugetpackage_type_id(nuPackageId);

      ut_trace.trace('LDC_UPDATE_GRACE_PERIOD-tipo de paquete -->' ||
                     nupacktype,
                     10);

      NUTYPEPACKPARA := DALD_PARAMETER.fnuGetNumeric_Value('COD_PACK_FNB_SINESTER');

      if nupacktype = NUTYPEPACKPARA then
        LDC_PKCRMTRAMISEGBRI.PROCLEGGESINTRFALLO(nuPackageId);

      else
        /*Se obtienen los detalles de la liquidacion*/
        dald_detail_liquidation.GetRecords(' PACKAGE_ID =' || nuPackageId ||
                                           ' ORDER BY LD_detail_liquidation.Financing_Code_Id',
                                           tbDetaiLiquid);
        nuGracPeriodId := DALD_PARAMETER.fnuGetNumeric_Value('COD_PERIODO_GRACIA_SINIESTRO');

        nuLiquiIndex := tbDetaiLiquid.FIRST;

        WHILE nuLiquiIndex IS NOT NULL LOOP
          ut_trace.trace('LDC_UPDATE_GRACE_PERIOD-detail_liquidation_id -->' || tbDetaiLiquid(nuLiquiIndex)
                         .detail_liquidation_id,
                         10);

          dbms_output.put_line('IDdetail->>' || tbDetaiLiquid(nuLiquiIndex)
                               .detail_liquidation_id);

          IF nvl(nuLastDeferr, 0) <> tbDetaiLiquid(nuLiquiIndex)
            .financing_code_id THEN
            /*Se obtienen los registros de los periodos de gracia*/
            dacc_grace_peri_defe.getrecords(' DEFERRED_ID =' || tbDetaiLiquid(nuLiquiIndex)
                                            .financing_code_id ||
                                            ' AND GRACE_PERIOD_ID =' ||
                                            nuGracPeriodId,
                                            tbGracePeriodDef);
            dbms_output.put_line('DeferredId->>' || tbDetaiLiquid(nuLiquiIndex)
                                 .financing_code_id);

            nuGracePerIndex := tbGracePeriodDef.FIRST;

            WHILE nuGracePerIndex IS NOT NULL LOOP
              dbms_output.put_line('GracePeriodId->>' || tbGracePeriodDef(nuGracePerIndex)
                                   .grace_peri_defe_id);
              tbGracePeriodDef(nuGracePerIndex).initial_date := ut_date.fdtsysdate - 2;
              tbGracePeriodDef(nuGracePerIndex).end_date := ut_date.fdtsysdate - 1;

              /*Se actualiza el registro los periodos de gracia, asociados a los diferidos*/
              dacc_grace_peri_defe.updrecord(tbGracePeriodDef(nuGracePerIndex));

              nuGracePerIndex := tbGracePeriodDef.NEXT(nuGracePerIndex);
            END LOOP;

          END IF;

          /*Asigna el diferido que se acaba de procesar*/
          nuLastDeferr := tbDetaiLiquid(nuLiquiIndex).financing_code_id;
          nuLiquiIndex := tbDetaiLiquid.NEXT(nuLiquiIndex);

        END LOOP;

      end if;
    END IF;
    /*Se agrega para legalizar la liquidacion de siniestros brilla si es de ?xito*/
  else

    nupacktype := damo_packages.fnugetpackage_type_id(nuPackageId);

    NUTYPEPACKPARA := DALD_PARAMETER.fnuGetNumeric_Value('COD_PACK_FNB_SINESTER');

    if nupacktype = NUTYPEPACKPARA then
      LDC_PKCRMTRAMISEGBRI.PROCLEGGESINTREXITO(nuPackageId);
    end if;

  END IF;

  ut_trace.trace('FINALIZA - LDC_UPDATE_GRACE_PERIOD', 10);

EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise;
  when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;

END LDC_UPDATE_GRACE_PERIOD;
/
PROMPT Otorgando permisos de ejecucion a LDC_UPDATE_GRACE_PERIOD
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_UPDATE_GRACE_PERIOD', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LDC_UPDATE_GRACE_PERIOD para reportes
GRANT EXECUTE ON adm_person.LDC_UPDATE_GRACE_PERIOD TO rexereportes;
/