CREATE OR REPLACE procedure adm_person.LDC_VAL_CAUS_APELACION is
  /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : LDC_VAL_CAUS_APELACION
    DESCRIPCION    : PROCEDIMIENTO PARA VALIDAR LA CAUSAL DE LEGALIZACION POR TRAMITE 100338
    AUTOR          : KATHERINE CIENFUEGOS - UTILIZADO EN PLUGIN
    FECHA          : 21/03/2019

    PARAMETROS              DESCRIPCION
    ============         ===================

    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    24/04/2024       PACOSTA           OSF-2596: Se crea el objeto en el esquema adm_person
  ******************************************************************/
  cnuPackType   mo_packages.package_type_id%type := 100338;
  nuCausalId    or_order.causal_id%type;
  nuPackageId   mo_packages.package_id%type;
  nuOrderId     or_order.order_id%type;
  nuPackType    mo_packages.package_type_id%type;
  sbPackTypDesc ps_package_type.description%type;
  sbCausDesc    ge_causal.description%type;

begin
  ut_trace.trace('INICIA - LDC_VAL_CAUS_APELACION', 10);

  /*Obtiene el id de la orden en la instancia*/
  nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder();

  ut_trace.trace('LDC_VAL_CAUS_APELACION-nuOrderId -->' || nuOrderId, 10);

  /*Obtiene el id de la causal de legalizacion*/
  nuCausalId := daor_order.fnugetcausal_id(nuOrderId);

  ut_trace.trace('LDC_VAL_CAUS_APELACION-nuCausalId -->' || nuCausalId, 10);

  /*Obtiene la descripcion de la causal*/
  sbCausDesc := dage_causal.fsbgetdescription(nuCausalid);

  ut_trace.trace('LDC_VAL_CAUS_APELACION-sbCausDesc -->' || sbCausDesc, 10);


  /*Obtiene el id de la solicitud de la actividad*/
  nuPackageId := ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                       'ORDER_ID',
                                                       'PACKAGE_ID',
                                                       nuOrderId);

  ut_trace.trace('LDC_VAL_CAUS_APELACION-nuPackageId -->' || nuPackageId,
                 10);

  /*Obtiene el id del tipo de tramite*/
  nuPackType := damo_packages.fnugetpackage_type_id(nuPackageId);

  ut_trace.trace('LDC_VAL_CAUS_APELACION-nuPackType -->' || nuPackType, 10);

  /*Obtiene la descripcion del tipo de tramite*/
  sbPackTypDesc := daps_package_type.fsbgetdescription(nuPackType);

  ut_trace.trace('LDC_VAL_CAUS_APELACION-sbPackTypDesc -->' ||sbPackTypDesc, 10);

  if nuPackType = cnuPackType then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'La causal ' || nuCausalId || ' (' ||
                                       initcap(sbCausDesc) ||
                                       ') no es permitida para el tramite: ' ||
                                       nuPackType || ' - ' ||
                                       initcap(sbPackTypDesc));
    raise ex.CONTROLLED_ERROR;
  end if;

  ut_trace.trace('FINALIZA - LDC_VAL_CAUS_APELACION', 10);

EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise;
  when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;

end LDC_VAL_CAUS_APELACION;
/
PROMPT Otorgando permisos de ejecucion a LDC_VAL_CAUS_APELACION
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_VAL_CAUS_APELACION', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LDC_VAL_CAUS_APELACION para reportes
GRANT EXECUTE ON adm_person.LDC_VAL_CAUS_APELACION TO rexereportes;
/
