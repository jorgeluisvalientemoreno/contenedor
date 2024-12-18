CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PRBORRAVISITAFALLIDA IS
    /**************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P

    Funcion     : LDC_PRBORRAVISITAFALLIDA
    Descripcion : Procedimiento que elima de la tabla LDC_CANT_VISITA_FALLIDA el tipo de trabajo
                  cuando se legaliza con exito. Ca 200-1871

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    02/05/2024          PACOSTA            OSF-2638: Se crea el objeto en el esquema adm_person 
                                           Se retita el llamado al esquema OPEN (open.)      
   **************************************************************************/

 CURSOR cuProducto(nuorden NUMBER) IS
 SELECT product_id
     FROM or_order_activity at,or_order ot
    WHERE at.order_id = nuorden
      AND product_id IS NOT NULL
      AND at.order_id = ot.order_id
      AND rownum   = 1;

 nuOrden  or_order.order_id%type;
 nuCausalId       ge_causal.causal_id%type;
 nuClassCausal    ge_causal.class_causal_id%type;
 nuTitr           or_task_type.task_type_id%type;
 sbmensa          VARCHAR2(10000);
 rgProducto       cuProducto%rowtype;


BEGIN
 ut_trace.trace('Inicia LDC_PRBORRAVISITAFALLIDA', 10);
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
 if nuClassCausal = 2 then
   return;
 elsif nuClassCausal = 1 then
   open cuProducto(nuorden);
   fetch cuProducto into rgProducto;
   if cuProducto%notfound then
      sbmensa := 'Proceso termino con errores : '||'El cursor cuProducto no arrojo datos con el # de orden'||to_char(nuorden);
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
      RAISE ex.controlled_error;
   end if;
   close cuProducto;
   ut_trace.trace('Producto:'||rgProducto.product_id, 10);

   delete LDC_CANT_VISITA_FALLIDA
    where product_id = rgProducto.product_id
      and task_type_id =  nuTitr;

 end if;
 ut_trace.trace('Fin LDC_PRBORRAVISITAFALLIDA', 10);
EXCEPTION
 WHEN ex.controlled_error THEN
  ut_trace.trace('Error LDC_PRBORRAVISITAFALLIDA ex.controlled_error', 10);
  RAISE;
 WHEN OTHERS THEN
  ut_trace.trace('Error LDC_PRBORRAVISITAFALLIDA OTHERS', 10);
  sbmensa := 'Proceso termino con Errores. '||SQLERRM;
  errors.seterror;
  RAISE ex.controlled_error;
END;
/
PROMPT Otorgando permisos de ejecucion a LDC_PRBORRAVISITAFALLIDA
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PRBORRAVISITAFALLIDA', 'ADM_PERSON');
END;
/