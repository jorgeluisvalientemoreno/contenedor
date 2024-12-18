create or replace PROCEDURE adm_person.ldc_prvisitafalllida IS
    /**************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P

    Funcion     : LDC_PRVISITAFALLLIDA
    Descripcion : Procedimiento que marca la cantidad de visitas fallidas de un tipo de trabajo. Ca 200-1871

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
   24/04/2024           Adrianavg          OSF-2597: Se migra del esquema OPEN al esquema ADM_PERSON    
   **************************************************************************/

 CURSOR cuProducto(nuorden NUMBER) IS
 SELECT product_id
     FROM or_order_activity at,open.or_order ot
    WHERE at.order_id = nuorden
      AND product_id IS NOT NULL
      AND at.order_id = ot.order_id
      AND rownum   = 1;

 nuOrden  open.or_order.order_id%type;
 nuCausalId       open.ge_causal.causal_id%type;
 nuClassCausal    open.ge_causal.class_causal_id%type;
 nuTitr           open.or_task_type.task_type_id%type;
 sbmensa          VARCHAR2(10000);
 rgProducto       cuProducto%rowtype;


BEGIN
 ut_trace.trace('Inicia LDC_PRVISITAFALLLIDA', 10);
 --Obtener el identificador de la orden  que se encuentra en la instancia
 nuorden       := or_bolegalizeorder.fnuGetCurrentOrder;
 ut_trace.trace('Numero de la Orden:'||nuorden, 10);

 nuTitr := daor_order.FNUGETTASK_TYPE_ID(nuorden, null);
 ut_trace.trace('nuTitr:'||nuTitr, 10);

 if nuTitr is null then
   sbmensa := 'Proceso termino con errores : '||'Error al obtener el tipo de trabajo de legalización de la orden: '||to_char(nuorden);
   ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
   RAISE ex.controlled_error;
 end if;

 nuCausalId := daor_order.fnugetcausal_id(nuorden, null);
 ut_trace.trace('nuCausalId => ' ||nuCausalId,10);

 if nuCausalId is null then
   sbmensa := 'Proceso termino con errores : '||'Error al obtener la cuasal de legalización de la orden: '||to_char(nuorden);
   ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
   RAISE ex.controlled_error;
 end if;

 nuClassCausal := dage_causal.fnugetclass_causal_id(nuCausalId, null);
 if nuClassCausal = 1 then
   return;
 elsif nuClassCausal = 2 then
   open cuProducto(nuorden);
   fetch cuProducto into rgProducto;
   if cuProducto%notfound then
      sbmensa := 'Proceso termino con errores : '||'El cursor cuProducto no arrojo datos con el # de orden'||to_char(nuorden);
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
      RAISE ex.controlled_error;
   end if;
   close cuProducto;
   ut_trace.trace('Producto:'||rgProducto.product_id, 10);

   update LDC_CANT_VISITA_FALLIDA
      set cantidad=nvl(cantidad,0)+1
    where product_id = rgProducto.product_id
      and task_type_id =  nuTitr;

   if SQL%NOTFOUND then
     insert into LDC_CANT_VISITA_FALLIDA(product_id, task_type_id, cantidad) values(rgProducto.product_id, nuTitr, 1);
   end if;

 end if;
 ut_trace.trace('Fin LDC_PRVISITAFALLLIDA', 10);
EXCEPTION
 WHEN ex.controlled_error THEN
  ut_trace.trace('Error LDC_PRVISITAFALLLIDA ex.controlled_error', 10);
  RAISE;
 WHEN OTHERS THEN
  ut_trace.trace('Error LDC_PRVISITAFALLLIDA OTHERS', 10);
  sbmensa := 'Proceso termino con Errores. '||SQLERRM;
  errors.seterror;
  RAISE ex.controlled_error;
END LDC_PRVISITAFALLLIDA;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento LDC_PRVISITAFALLLIDA
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRVISITAFALLLIDA', 'ADM_PERSON'); 
END;
/