create or replace PROCEDURE ADM_PERSON.LDC_PRGENERAOTNOTI IS
    /**************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P

    Funcion     : LDC_PRGENERAOTNOTI
    Descripcion : Procedimiento que crea genera orden de notificación de acuerdo
                 a lo configurado en la entidad LDC_OSF_OTNOTIFICACION. Ca 200-1871

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    25/05/2018          jbrito             caso 200-1956 Se modifico el llamado al api OS_CREATEORDERACTIVITIES par que en lugar del sysdate envie (sysdate + 1)
                                           Se modifico el llamado al api de asignación para en lugar del tercer parámetro donde se envía sysdate, enviar (sysdate+1)

   **************************************************************************/

 CURSOR cuProducto(nuorden NUMBER) IS
 SELECT product_id, subscription_id, ot.task_type_id,package_id, motive_id, at.subscriber_id,ot.operating_unit_id, nvl(at.address_id, ot.external_address_id) address_id,
        activity_id
     FROM open.or_order_activity at,open.or_order ot
    WHERE at.order_id = nuorden
      AND package_id IS NOT NULL
      AND at.order_id = ot.order_id
      --AND at.status!='F'
      AND rownum   = 1;

 CURSOR cuOTNotificacion(nuTitr open.or_task_type.task_type_id%type,
                         nuActi open.ge_items.items_id%type,
                         nuCaus open.ge_causal.causal_id%type) is
 select activity_dest, causal_dest
 from open.ldc_osf_otnotificacion n
 where n.titr_origen = nuTitr
   and n.activity_orig = nuActi
   and n.causal_id = nuCaus
 union
 select activity_dest, causal_dest
 from open.ldc_osf_otnotificacion n
 where n.titr_origen = nuTitr
   and n.activity_orig = nuActi
   and n.causal_id is null;

 CURSOR cuComentLega(nuOrden open.or_order.order_id%type) is
 select C.ORDER_COMMENT
   from open.or_order_comment c
  where c.order_id = nuOrden
    and c.legalize_comment = 'Y';

 CURSOR cuCadenaLega(nuOrden open.or_order.order_id%type,
                     nuCausal open.ge_causal.causal_id%type,
                     nuPerson open.ge_person.person_id%type,
                     sbComent open.or_order_comment.order_comment%type) is
 select o.order_id||'|'||nucausal||'|'||nuperson||'||'||a.order_activity_id ||'>'||decode(open.dage_causal.fnugetclass_causal_id(nucausal,null),1,1,0)||';comment0>>>;comment1>>>;comment2>>>;comment3>>>|||3;'||sbComent cadena_lega
   from open.or_order o, open.or_order_activity a
  where a.order_id=o.order_id
    and o.order_id = nuorden
    and a.status!='F';




 nuOrden  open.or_order.order_id%type;
 nuCausalId open.ge_causal.causal_id%type;
 dtExecInit open.or_order.exec_initial_date%type;
 dtExecFin  open.or_order.execution_final_date%type;
 numarca  open.ldc_marca_producto.suspension_type_id%type;
 numarcaantes     open.ldc_marca_producto.suspension_type_id%type;
 ionuorderid      open.or_order.order_id%type;
 nuPerson         open.ge_person.person_id%type;
 sbObserva        open.or_order_comment.order_comment%type;
 sbmensa          VARCHAR2(10000);
 rgProducto       cuProducto%rowtype;
 onuerrorcode     number;
 osberrormessage  varchar2(4000);


BEGIN
 ut_trace.trace('Inicia LDC_PRGENERAOTNOTI', 10);
 --Obtener el identificador de la orden  que se encuentra en la instancia
 nuorden       := or_bolegalizeorder.fnuGetCurrentOrder;
 ut_trace.trace('Numero de la Orden:'||nuorden, 10);

 nuCausalId := daor_order.fnugetcausal_id(nuorden, null);
 ut_trace.trace('nuCausalId => ' ||nuCausalId,10);

 if nuCausalId is null then
   sbmensa := 'Proceso termino con errores : '||'Error al obtener la cuasal de legalización de la orden: '||to_char(nuorden);
   ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
   RAISE ex.controlled_error;
 end if;

 dtExecInit  := daor_order.FDTGETEXEC_INITIAL_DATE(nuorden,null);
 ut_trace.trace('dtExecInit => ' ||dtExecInit,10);

 dtExecFin   := daor_order.FDTGETEXECUTION_FINAL_DATE(nuorden, null);
 ut_trace.trace('dtExecFin => ' ||dtExecFin,10);

 begin
   select person_id
     into nuPerson
     from open.or_order_person
    where order_id = nuorden;
 exception
 when others then
      nuPerson :=null;
 end;
 ut_trace.trace('nuPerson => ' ||nuPerson,10);

 if nuPerson is null then
   sbmensa := 'Proceso termino con errores : '||'Error al obtener el tecnico de la orden: '||to_char(nuorden);
   ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
   RAISE ex.controlled_error;
 end if;

 open cuProducto(nuorden);
 fetch cuProducto into rgProducto;
 if cuProducto%notfound then
    sbmensa := 'Proceso termino con errores : '||'El cursor cuProducto no arrojo datos con el # de orden'||to_char(nuorden);
    ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
    RAISE ex.controlled_error;
 end if;
 close cuProducto;

 open cuComentLega(nuorden);
 fetch cuComentLega into sbObserva;
 close cuComentLega;

 for reg in cuOTNotificacion(rgProducto.task_type_id,rgProducto.activity_id, nuCausalId) loop
     OS_CREATEORDERACTIVITIES(reg.activity_dest,
                              rgProducto.address_id,
                              sysdate+1,
                              sbObserva,
                              0,
                              ionuorderid,
                              onuerrorcode,
                              osberrormessage);
     if onuErrorCode = 0 then
       update or_order_activity ooa
          set ooa.package_id      = rgProducto.package_id,
              ooa.motive_id       = rgProducto.motive_id,
              ooa.subscriber_id   = rgProducto.subscriber_id,
              ooa.subscription_id = rgProducto.subscription_id,
              ooa.product_id      = rgProducto.product_id
        where ooa.order_id = ionuorderid;
        ut_trace.trace('Orden generada:'|| ionuorderid, 10);

        OS_RELATED_ORDER(nuorden,
                         ionuorderid,
                         onuerrorcode,
                         osberrormessage);
        if onuErrorCode = 0 then
           os_assign_order(ionuorderid,
                           rgProducto.operating_unit_id,
                           sysdate+1,
                           sysdate,
                           onuerrorcode,
                           osberrormessage);
           if onuErrorCode = 0 then
             ut_trace.trace('Orden adicional asignada:'|| ionuorderid, 10);

             ldc_closeorder(ionuorderid, reg.causal_dest, nuPerson, rgProducto.operating_unit_id);
             os_addordercomment(ionuorderid, 3, sbObserva, onuerrorcode,sbmensa);
             if onuErrorCode != 0 then
               sbmensa := 'Proceso termino con errores : '||'Error al adicionar comentarios a  la orden de notificacion: '||to_char(nuorden) ||' '||osberrormessage;
               ge_boerrors.seterrorcodeargument(onuerrorcode,sbmensa);
               RAISE ex.controlled_error;
             end if;
             /*for reg2 in cuCadenaLega(ionuorderid, reg.causal_dest, nuPerson, sbObserva) loop
               ut_trace.trace('Cadena:'|| reg2.cadena_lega, 10);
               os_legalizeorders(reg2.cadena_lega,
                                 dtExecInit,
                                 dtExecFin,
                                 sysdate,
                                 onuerrorcode,
                                 osberrormessage);
               if  onuErrorCode = 0 then
                 ut_trace.trace('Orden adicional legalizada:'|| ionuorderid, 10);
               else
                 sbmensa := 'Proceso termino con errores : '||'Error al legalizar la orden: '||to_char(nuorden) ||' '||osberrormessage;
                 ge_boerrors.seterrorcodeargument(onuerrorcode,sbmensa);
                 RAISE ex.controlled_error;
               end if;
             end loop;*/
           else
             sbmensa := 'Proceso termino con errores : '||'Error al asignar la orden: '||to_char(nuorden) ||' '||osberrormessage;
             ge_boerrors.seterrorcodeargument(onuerrorcode,sbmensa);
             RAISE ex.controlled_error;
           end if;
        else
          sbmensa := 'Proceso termino con errores : '||'Error al relacionar orden adicional:'||' '||osberrormessage;
          ge_boerrors.seterrorcodeargument(onuerrorcode,sbmensa);
          RAISE ex.controlled_error;
        end if;
     else
          sbmensa := 'Proceso termino con errores : '||'Error al generar orden adicional:'||' '||osberrormessage;
          ge_boerrors.seterrorcodeargument(onuerrorcode,sbmensa);
          RAISE ex.controlled_error;
     end if;
 end loop;
 ut_trace.trace('Fin LDC_PRGENERAOTNOTI', 10);
EXCEPTION
 WHEN ex.controlled_error THEN
  ut_trace.trace('Error LDC_PRGENERAOTNOTI ex.controlled_error', 10);
  RAISE;
 WHEN OTHERS THEN
  ut_trace.trace('Error LDC_PRGENERAOTNOTI OTHERS', 10);
  sbmensa := 'Proceso termino con Errores. '||SQLERRM;
  errors.seterror;
  RAISE ex.controlled_error;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRGENERAOTNOTI', 'ADM_PERSON');
END;
/
