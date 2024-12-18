CREATE OR REPLACE procedure ADM_PERSON.LDC_VALIDAITEMTITR is
  /*****************************************************************


    Unidad         : LDC_VALIDAITEMTITR
    Descripcion    : Procedimiento que valida que no se legalicen items no asociados al tipo de trabajo.

    Autor          : dsaltarin
    Fecha          : 02/12/2020
    Caso           : 614

    Fecha             Autor              Modificacion
    =========       =========            ====================
    24/04/2024       PACOSTA             OSF-2596: Se retita el llamado al esquema OPEN (open.)                                   
                                           Se crea el objeto en el esquema adm_person
  ******************************************************************/
  
  nuOrderId         or_order.order_id%type;
  nuCausalId        ge_causal.causal_id%type;
  nuClassCausalId   ge_causal.class_causal_id%type;
  nuTaskTypeId      or_task_type.task_type_id%type;
  nuCantidaItem     number;
  sbMensaje         varchar2(4000);

  cursor cuItemOrden is
  select oi.items_id, i.description
  from or_order_items oi, ge_items i
  where oi.order_id = nuOrderId
    and oi.legal_item_amount>0
    and oi.items_id=i.items_id
    and not exists(select null
                     from or_task_types_items ti
                   where ti.task_type_id=nuTaskTypeId and ti.items_id=oi.items_id);
begin
       --Obtener orden de la instancia
  nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
  ut_trace.trace('Ejecucion prTemporalCharge  => nuOrderId => ' ||
                 nuOrderId,
                 10);

  nuCausalId := daor_order.fnugetcausal_id(nuOrderId);
  ut_trace.trace('Ejecucion prTemporalCharge  => nuCausalId => ' ||
                 nuCausalId,
                 10);

  nuClassCausalId := dage_causal.fnugetclass_causal_id(nuCausalId);
  ut_trace.trace('Ejecucion prTemporalCharge  => nuClassCausalId => ' ||
                 nuClassCausalId,
                 10);

  nuTaskTypeId := daor_order.fnugettask_type_id(nuOrderId);
  ut_trace.trace('Ejecucion prTemporalCharge  => nuTaskTypeId => ' ||
                 nuTaskTypeId,
                 10);

  if nuClassCausalId = 1 then
     sbMensaje := null;
     for reg in cuItemOrden loop
       if sbMensaje is null then
          sbMensaje := reg.items_id||'-'||reg.description;
       else
         sbMensaje := sbMensaje||','||reg.items_id||'-'||reg.description;
       end if;
     end loop;
     if sbMensaje is not null then
       sbMensaje :='Se estan legalizando items no asociados al titr: '||nuTaskTypeId||' :'||sbMensaje;
       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                        sbMensaje);
       raise ex.CONTROLLED_ERROR;
     end if;
  end if;
EXCEPTION
 when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
 when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
end;
/
PROMPT Otorgando permisos de ejecucion a LDC_VALIDAITEMTITR
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_VALIDAITEMTITR', 'ADM_PERSON');
END;
/