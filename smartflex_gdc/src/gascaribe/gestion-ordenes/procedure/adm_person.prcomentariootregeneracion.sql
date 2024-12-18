create or replace procedure adm_person.prcomentariootregeneracion is
  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : prComentarioOtRegeneracion
  Descripcion    : Procedimiento que adiciona comentarios a la orden
                   regenerada a partir de la orden en legalizaci¿n

  Autor         :    dsaltarin@horbath.com
  Parametros         Descripcion
  ============  ===================

  Historial de Modificaciones
  ====================================================
  Autor                    Fecha         Descripci¿n
  socoro@horbath.com     18/02/2016     Se modifica b¿squeda por solicitud para
                                       atender el caso  CA 100-9326
  dsaltarin              23/06/2021    773: Se eliminan los cambios realizadas en el glpi 529.
									   Se agrega un comentario con la orden y fecha final de ejecucion
									   si el tipo de trabajo esta en el parametro LDC_TTCOMENT_FECHAEJE
  Adrianavg              19-04-2024		 OSF-2569: Se migra del esquema OPEN al esquema ADM_PERSON
  ****************************************************************/
  nuOrderId         or_order.order_id%type;
  nuCausalId        ge_causal.causal_id%type;
  nuClassCausalId   ge_causal.class_causal_id%type;
  nuTaskTypeId      or_task_type.task_type_id%type;
  nuOrderActivityId or_order_activity.order_activity_id%type;
  nuPackageId       mo_packages.package_id%type;
  nuClassCausalRef  ge_causal.class_causal_id%type := 1;
  isbOrderComme     varchar2(4000);

  nuCommentType number := 3; --general
  nuErrorCode   number;
  sbErrorMesse  varchar2(4000);

  cursor cuOrdenRegenerada( /*nuPackageId mo_packages.package_id%type,*/nuOrden or_order.order_id%type) is
    select o.order_id, o.task_type_id
      from or_related_order r, or_order_activity a, or_order o
     where r.related_order_id = a.order_id
       and r.order_id = nuOrden
          --and a.package_id=nuPackageId
       and a.order_id = o.order_id
       and o.order_status_id in (0, 5)
       and rela_order_type_id = 2;

  ------------------------------
  -- CAMBIO 529 -->
  ------------------------------

  csbOSS_INV_0000529_1 varchar2(21) := 'OSS_INV_0000529_1';

  cursor cuCommercialPlan(nuOrdenValue or_order.order_id%type) is
    select p.commercial_plan_id
      from open.or_order_activity oa
     inner join open.pr_product p
        on p.product_id = oa.product_id
     where order_id = nuOrdenValue
       and rownum = 1;

  nuCommercialPlan open.pr_product.commercial_plan_id%type := 0;

  sbPlanesComerciales varchar2(2000);
  ------------------------------
  -- CAMBIO 529 <--
  ------------------------------

  --773
  sbPara773  open.ld_parameter.value_chain%type:=open.dald_parameter.fsbgetvalue_chain('LDC_TTCOMENT_FECHAEJE', null)||';';
  dtFechaEje open.or_order.execution_final_date%type;
  nuTitr     open.or_order.task_type_id%type;



begin

  ut_trace.trace('Inicio prComentarioOtRegeneracion', 10);
  --Obtener orden de la instancia
  nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
  ut_trace.trace('Ejecucion prComentarioOtRegeneracion  => nuOrderId => ' ||
                 nuOrderId,
                 10);
  ------------------------------
  -- CAMBIO 529 -->
  ------------------------------
  /*
  if fblaplicaentrega(csbOSS_INV_0000529_1) then

    sbPlanesComerciales := dald_parameter.fsbgetvalue_chain('COD_COMMERCIAL_PLAN',
                                                            NULL);
    open cuCommercialPlan(nuOrderId);
    fetch cuCommercialPlan
      into nuCommercialPlan;
    close cuCommercialPlan;

    if (ldc_boutilities.fsbbuscatoken(sbPlanesComerciales,
                                      to_char(nuCommercialPlan),
                                      ',') = 'S') then
      dbms_output.put_line('Cambio 529: Omite validacion de PLUGIN para los planes comerciales (' ||
                           sbPlanesComerciales || ')');
      return;
    end if;

  end if;*/

  ------------------------------
  -- CAMBIO 529 <--
  ------------------------------

  if fblaplicaentregaxcaso('0000773') then
    nuTitr := open.daor_order.fnugettask_type_id(nuOrderId, null);
    ut_trace.trace('Ejecucion prComentarioOtRegeneracion  => nuTitr => ' ||
                   nuTitr,
                   10);
    dtFechaEje := open.daor_order.fdtgetexecution_final_date(nuOrderId, null);

  end if;


  nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(nuOrderId);
  ut_trace.trace('Ejecucion prComentarioOtRegeneracion  => nuOrderActivityId => ' ||
                 nuOrderActivityId,
                 10);
  /* nuPackageId := daor_order_activity.fnugetpackage_id(nuOrderActivityId);
  ut_trace.trace('Ejecucion prComentarioOtRegeneracion  => nuPackageId => ' ||
                  nuPackageId,
                  10);*/
  --obtener comentarios de la orden en legalizzaci¿n
  isbOrderComme := LDC_RETORNACOMENTOTLEGA(nuOrderId);
  for ordenes in cuOrdenRegenerada( /*nuPackageId,*/ nuOrderId) loop
    ut_trace.trace('Ejecucion prComentarioOtRegeneracion  Orden regenerada => ' ||
                   ordenes.order_id,
                   10);
    OS_ADDORDERCOMMENT(ordenes.order_id,
                       nuCommentType,
                       isbOrderComme,
                       nuErrorCode,
                       sbErrorMesse);
	if nuTitr is not null and  (instr(sbPara773, nuTitr||'|'||ordenes.task_type_id||';')>0 or  instr(sbPara773, nuTitr||'|-1;')>0) THEN
	   OS_ADDORDERCOMMENT(ordenes.order_id,
                       nuCommentType,
                       'Orden legalizada: '||nuOrderId||'. Fecha Ejecuci¿n :'||dtFechaEje,
                       nuErrorCode,
                       sbErrorMesse);
	end if;
  end loop;
  ut_trace.trace('Fin prComentarioOtRegeneracion', 10);
exception
  when ex.CONTROLLED_ERROR then
    gw_boerrors.checkerror(SQLCODE, SQLERRM);
    raise;
  when others then

    gw_boerrors.checkerror(SQLCODE, SQLERRM);
    raise ex.CONTROLLED_ERROR;
end PRCOMENTARIOOTREGENERACION;
/
PROMPT OTORGA PERMISOS ESQUEMA SOBRE PROCEDIMIENTO PRCOMENTARIOOTREGENERACION
BEGIN
    pkg_utilidades.prAplicarPermisos('PRCOMENTARIOOTREGENERACION', 'ADM_PERSON'); 
END;
/