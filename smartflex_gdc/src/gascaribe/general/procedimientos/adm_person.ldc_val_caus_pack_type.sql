CREATE OR REPLACE PROCEDURE adm_person.LDC_VAL_CAUS_PACK_TYPE IS

/*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : LDC_VAL_CAUS_PACK_TYPE
  DESCRIPCION    : PROCEDIMIENTO PARA VALIDAR LA CAUSAL DE LEGALIZACIÿN POR TRÝMITE
  AUTOR          : KATHERINE CIENFUEGOS - UTILIZADO EN PLUGIN
  RNP            : 142
  FECHA          : 10/06/2014

  PARAMETROS              DESCRIPCION
  ============         ===================

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  29/04/2024       PACOSTA            OSF-2598: Se crea el objeto en el esquema adm_person 
******************************************************************/

  nuResult                    number:=-1;
  nuCausalId                  or_order.causal_id%type;
  nuPackageId                 mo_packages.package_id%type;
  nuOrderId                   or_order.order_id%type;
  nuPackType                  mo_packages.package_type_id%type;
  sbPackTypDesc               ps_package_type.description%type;
  sbCausDesc                  ge_causal.description%type;

  cursor cuCausal is
    select count(1)
      from ldc_caus_pack_type
     where causal_id = nuCausalId;

  cursor cuCausPackType is
    select count(1)
      from ldc_caus_pack_type
     where causal_id = nuCausalId
       and package_type_id = nuPackType;



BEGIN


    ut_trace.trace('INICIA - LDC_VAL_CAUS_PACK_TYPE', 10);

    /*Obtiene el id de la orden en la instancia*/
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder();

    ut_trace.trace('LDC_VAL_CAUS_PACK_TYPE-nuOrderId -->'||nuOrderId, 10);

    /*Obtiene el id de la causal de legalización*/
    nuCausalId := daor_order.fnugetcausal_id(nuOrderId);

    ut_trace.trace('LDC_VAL_CAUS_PACK_TYPE-nuCausalId -->'||nuCausalId, 10);

    /*Obtiene la descripción de la causal*/
    sbCausDesc := dage_causal.fsbgetdescription(nuCausalid);

    ut_trace.trace('LDC_VAL_CAUS_PACK_TYPE-sbCausDesc -->'||sbCausDesc, 10);

    /*Obtiene el id de la solicitud de la actividad*/
    nuPackageId  := ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                                   'ORDER_ID',
                                                                 'PACKAGE_ID',
                                                                   nuOrderId);

    ut_trace.trace('LDC_VAL_CAUS_PACK_TYPE-nuPackageId -->'||nuPackageId, 10);

    /*Obtiene el id del tipo de trámite*/
    nuPackType := damo_packages.fnugetpackage_type_id(nuPackageId);

    ut_trace.trace('LDC_VAL_CAUS_PACK_TYPE-nuPackType -->'||nuPackType, 10);

    /*Obtiene la descripción del tipo de trámite*/
    sbPackTypDesc := daps_package_type.fsbgetdescription(nuPackType);

    ut_trace.trace('LDC_VAL_CAUS_PACK_TYPE-sbPackTypDesc -->'||sbPackTypDesc, 10);

      open  cuCausal;
      fetch cuCausal into nuResult;
      close cuCausal;
      ut_trace.trace('LDC_VAL_CAUS_PACK_TYPE-Resultado cuCausal -->'||nuResult, 10);

      /*Valida si la causal está configurada como exclusiva*/
      if nuResult > 0 then
        nuResult := -1;
        open cuCausPackType;
        fetch cuCausPackType into nuResult;
        close cuCausPackType;
        ut_trace.trace('LDC_VAL_CAUS_PACK_TYPE-Resultado cuCausPackType -->'||nuResult, 10);

        /*Valida si la causal está configurada para el tipo de trámite de la solicitud*/
        if nuResult = 0 then
           ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
           'La causal '||nuCausalId||' ('||initcap(sbCausDesc)||') no está configurada para el trámite: '||nuPackType||' - '||initcap(sbPackTypDesc));
           raise ex.CONTROLLED_ERROR;
        end if;
      end if;

    ut_trace.trace('FINALIZA - LDC_VAL_CAUS_PACK_TYPE', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

END LDC_VAL_CAUS_PACK_TYPE;
/
PROMPT Otorgando permisos de ejecucion a LDC_VAL_CAUS_PACK_TYPE
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_VAL_CAUS_PACK_TYPE', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LDC_VAL_CAUS_PACK_TYPE para reportes
GRANT EXECUTE ON adm_person.LDC_VAL_CAUS_PACK_TYPE TO rexereportes;
/