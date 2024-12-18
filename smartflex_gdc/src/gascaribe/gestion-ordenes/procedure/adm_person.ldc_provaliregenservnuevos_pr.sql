CREATE OR REPLACE PROCEDURE adm_person.ldc_provaliregenservnuevos_pr(pnuorderid or_order.order_id%type,pnucausalid or_order.causal_id%type,
nuerror OUT number,sberror OUT varchar2)
IS

     /*****************************************************************
    Propiedad intelectual de Gases del caribe.

    Unidad         : LDC_PROVALIREGENSERVNUEVOS_PR
    Descripcion    : Procedimiento Personalizado basadp en la logica el procedimientod
                     LDC_PROVALIREGENSERVNUEVOS pero con parametros para validar que si la causal
                     es de fallo y no existe regeneracion que detenga flujo, no se permita legalizar
                     (Aplica para Servicios Nuevos)

    Historia de Modificaciones
    Fecha             Autor               Modificacion
    ==========        ==================  ======================================
	25/11/2018        HORBATH             Creacion
    15/05/2024        Adrianavg           OSF-2673: Se migra del esquema OPEN al esquema ADM_PERSON
    ****************************************************************************/

    nuTryLegal      or_order_activity.legalize_try_times%type;
    nuOrderId       OR_order.order_id%type;
    nuActivityId    or_order_activity.activity_id%type;
    rcOrderAct      or_order_activity%rowtype;
    nuCausalId      ge_causal.causal_id%type;
    nuCausalClas    ge_causal.class_causal_id%type;
    nuCausalType    ge_causal.causal_type_id%type;
    nuCounter       number;
	SBMESSAGE       VARCHAR2(4000);
    nuCumplida    number;
    sbCaualesExl    open.ld_parameter.value_chain%type:=dald_parameter.fsbGetValue_Chain('CAUS_SERNUEV_EXCL_VALID_REGENE',null);

    -- CURSOR para obtener registro de Actividad de orden
    CURSOR  cuOrderActivity(nuOrderId OR_order.order_id%type)
    IS
        SELECT  *
        FROM    OR_order_activity a
        WHERE   order_id = nuOrderId
    and exists(select null from open.or_order_items oi where oi.order_items_id = a.order_item_id and legal_item_amount>=0)
        AND rownum = 1;

    -- CURSOR para obtener registros de regeneracion de actividades
    CURSOR  cuRegeneraOrder(
                            nuActivityId    OR_order_activity.activity_id%type,
                            nuCausalID      ge_causal.causal_id%type,
                            nuTryLegal      or_order_activity.legalize_try_times%type,
                            nuCumplida      or_regenera_activida.cumplida%type
                            )
    IS
        select sum(cantidad) from (
          SELECT  count(1) cantidad
              FROM    or_regenera_activida
              WHERE   actividad = nuActivityId
                AND id_causal = nuCausalID
                AND (try_legalize = nvl(nuTryLegal,0) or
                     try_legalize is null)
                and CUMPLIDA  = nuCumplida
               and actividad_wf = 'Y'
               and nuTryLegal is not null
              union
              SELECT  count(1) cantidad
                  FROM  or_regenera_activida
                  WHERE actividad = nuActivityId
                    AND id_causal = nuCausalID
                    AND (try_legalize is null)
                    and CUMPLIDA  = nuCumplida
                    and actividad_wf = 'Y'
                    and nuTryLegal is null);


BEGIN
    ut_trace.trace('INICIO LDC_PROVALIREGENSERVNUEVOS', 9);

    -- Obtener el identificador de la orden  que se encuentra en la instancia
    nuOrderId   :=pnuorderid;

    -- Obtener causal de legalizacion
    nuCausalId  :=  pnucausalid;

    -- Obtiene el registro en Actividad de Ordenes
    open  cuOrderActivity(nuOrderId);
    fetch cuOrderActivity INTO rcOrderAct;
    close cuOrderActivity;

    -- Obtiene el intento de legalizacion actual
    nuTryLegal := rcOrderAct.legalize_try_times;

    -- Obtiene Actividad asociada a la orden
    nuActivityId := rcOrderAct.activity_id;

    -- Si la clase de causal es "Fallo"
    nuCausalClas := dage_causal.fnugetclass_causal_id(nuCausalId);


    if nuCausalClas = 2 and (instr(sbCaualesExl,nuCausalId||',' ) = 0 or sbCaualesExl is null) then

        -- Verifica si existe configuracion de regeneracion para el intento y causal actual
        ut_trace.trace('sbCaualesExl', sbCaualesExl,10);
        ut_trace.trace('Validacion de Regeneracion......', 10);
        ut_trace.trace('Numero de la Orden:'||nuOrderId, 10);
        ut_trace.trace('Causal de Legalizacion:'||nuCausalId, 10);
        ut_trace.trace('Intento Actual:'||nuTryLegal, 10);
        ut_trace.trace('Actividad:'||nuActivityId, 10);

        nuCumplida := 0;


        open  cuRegeneraOrder(nuActivityId, nuCausalId, nuTryLegal, nuCumplida);
        fetch cuRegeneraOrder INTO nuCounter;
        close cuRegeneraOrder;

        -- Si no existe configuracion de regeneracion levanta error

        if nuCounter = 0 then
            sbMessage := 'No existe configuracion de regeneracion para la causal '||nuCausalId||' y la actividad '||nuActivityId;
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, sbMessage);
          raise ex.CONTROLLED_ERROR;
        END if;
    END if;

    ut_trace.trace('FIN LDC_PROVALIREGENSERVNUEVOS', 9);

	nuerror:=0;
    sberror:='OK';
EXCEPTION
    when ex.CONTROLLED_ERROR then
       nuerror   := 1;
       raise;

    when others then
	     nuerror   := 1;
		 SBMESSAGE :=SQLERRM;
		 sbERROR := 'Error ' || SUBSTR(SBMESSAGE,1,2000);

END LDC_PROVALIREGENSERVNUEVOS_PR;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PROVALIREGENSERVNUEVOS_PR
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROVALIREGENSERVNUEVOS_PR', 'ADM_PERSON'); 
END;
/
