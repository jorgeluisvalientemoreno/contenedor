CREATE OR REPLACE PROCEDURE adm_person.LDC_PROVALIREGENSERVNUEVOS IS

  /*****************************************************************
    Propiedad intelectual de PETI.

    Unidad         : LDC_PROVALIREGENSERVNUEVOS
    Descripcion    : Procedimiento Personalizado basadp en la logica el procedimientod
                     LDC_BOValLastRegen para validar que si la causal
                     es de fallo y no existe regeneracion que detenga flujo, no se permita legalizar
                     (Aplica para Servicios Nuevos)

    Historia de Modificaciones
    Fecha             Autor               Modificacion
    ==========        ==================  ======================================
    25/04/2024        PACOSTA             OSF-2596: Se retita el llamado al esquema OPEN (open.)                                   
                                          Se crea el objeto en el esquema adm_person
    25/11/2018        horbath             llamado al procedimiento LDC_PROVALIREGENSERVNUEVOS_PARAMS
                                          pasandole la causal y la orden instanciada y del procedimiento original
                                          se quita la logica de este proc.    
    ****************************************************************************/

  nuTryLegal   or_order_activity.legalize_try_times%type;
  nuOrderId    OR_order.order_id%type;
  nuActivityId or_order_activity.activity_id%type;
  rcOrderAct   or_order_activity%rowtype;
  nuCausalId   ge_causal.causal_id%type;
  nuCausalClas ge_causal.class_causal_id%type;
  nuCausalType ge_causal.causal_type_id%type;
  nuCounter    number;
  sbMessage    varchar2(10000);
  nuCumplida   number;
  sbCaualesExl ld_parameter.value_chain%type := dald_parameter.fsbGetValue_Chain('CAUS_SERNUEV_EXCL_VALID_REGENE',
                                                                                      null);

  -- CURSOR para obtener registro de Actividad de orden
  CURSOR cuOrderActivity(nuOrderId OR_order.order_id%type) IS
    SELECT *
      FROM OR_order_activity a
     WHERE order_id = nuOrderId
       and exists (select null
              from or_order_items oi
             where oi.order_items_id = a.order_item_id
               and legal_item_amount >= 0)
       AND rownum = 1;

  -- CURSOR para obtener registros de regeneracion de actividades
  CURSOR cuRegeneraOrder(nuActivityId OR_order_activity.activity_id%type,
                         nuCausalID   ge_causal.causal_id%type,
                         nuTryLegal   or_order_activity.legalize_try_times%type,
                         nuCumplida   or_regenera_activida.cumplida%type) IS
    select sum(cantidad)
      from (SELECT count(1) cantidad
              FROM or_regenera_activida
             WHERE actividad = nuActivityId
               AND id_causal = nuCausalID
               AND (try_legalize = nvl(nuTryLegal, 0) or
                   try_legalize is null)
               and CUMPLIDA = nuCumplida
               and actividad_wf = 'Y'
               and nuTryLegal is not null
            union
            SELECT count(1) cantidad
              FROM or_regenera_activida
             WHERE actividad = nuActivityId
               AND id_causal = nuCausalID
               AND (try_legalize is null)
               and CUMPLIDA = nuCumplida
               and actividad_wf = 'Y'
               and nuTryLegal is null);

  nuerror number;

  ------------------------------
  -- CAMBIO 529 -->
  ------------------------------

  csbOSS_INV_0000529_1 varchar2(21) := 'OSS_INV_0000529_1';

  cursor cuCommercialPlan(nuOrdenValue or_order.order_id%type) is
    select p.commercial_plan_id
      from or_order_activity oa
     inner join pr_product p
        on p.product_id = oa.product_id
     where order_id = nuOrdenValue
       and rownum = 1;

  nuCommercialPlan pr_product.commercial_plan_id%type := 0;

  sbPlanesComerciales varchar2(2000);
  ------------------------------
  -- CAMBIO 529 <--
  ------------------------------

BEGIN
  ut_trace.trace('INICIO LDC_PROVALIREGENSERVNUEVOS', 9);

  -- Obtener el identificador de la orden  que se encuentra en la instancia
  nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;

  ------------------------------
  -- CAMBIO 529 -->
  ------------------------------

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

  end if;

  ------------------------------
  -- CAMBIO 529 <--
  ------------------------------

  -- Obtener causal de legalizacion
  nuCausalId := or_boorder.fnugetordercausal(nuOrderId);

  LDC_PROVALIREGENSERVNUEVOS_PR(NUORDERID, NUCAUSALID, nuerror, sbMessage);

  if nuerror <> 0 then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     sbMessage);
    raise ex.CONTROLLED_ERROR;
  end if;

  /*
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
              sbMessage := 'No existe configuracion de regeneracion para la causal seleccionada.';
              ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, sbMessage);
            raise ex.CONTROLLED_ERROR;
          END if;
      END if;
  */
  ut_trace.trace('FIN LDC_PROVALIREGENSERVNUEVOS', 9);

EXCEPTION

  when ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;

  when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;

END LDC_PROVALIREGENSERVNUEVOS;
/
PROMPT Otorgando permisos de ejecucion a LDC_PROVALIREGENSERVNUEVOS
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PROVALIREGENSERVNUEVOS', 'ADM_PERSON');
END;
/