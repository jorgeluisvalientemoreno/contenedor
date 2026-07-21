--Usuario LEGO
select su.mask Funcional,
       a.agente_id || ' - ' || lal.description AGENTE,
       a.person_id || ' - ' || gp.name_ FUNCIONARIO
  from OPEN.LDC_USUALEGO a
 inner join OPEN.ge_person gp
    on gp.person_id = A.PERSON_ID
 inner join OPEN.LDC_AGENLEGO lal
    on lal.agente_id = a.agente_id
 inner join open.sa_user su
    on su.user_id = gp.user_id
 where 1 = 1
   --and gp.person_id = 39330
   --and a.agente_id = 250
   --and su.mask in ('CONSBELL', 'CONSBELL2', 'CONSBELL3', 'CONSBELL4', 'CONSBELL5')
   and 1 = 1;

select a.*, rowid
  from OPEN.LDC_AGENLEGO a
 where 1 = 1
   --and a.agente_id = 18
   and 1 = 1;

--Anexo de acceso a la orden en LEGO
select a.order_id,
       a.agente_id || ' - ' || lal.description Agente,
       lol.fecha_registro Fecha_Registro
  from OPEN.LDC_ANEXOLEGALIZA a
 inner join OPEN.LDC_AGENLEGO lal
    on lal.agente_id = a.agente_id
 inner join open.ldc_otlegalizar lol
    on lol.order_id = a.order_id
 where 1 = 1
   and a.order_id in (&ORDEN);

--Anexo de acceso a la orden en LEGO
select a.*, rowid
  from OPEN.LDC_ANEXOLEGALIZA a
 where 1 = 1
   and a.order_id in (&ORDEN);

--orden padre en LEGO
select lo.*, rowid
  from open.ldc_otlegalizar lo
 where 1 = 1
   and lo.order_id in (&ORDEN)
   and upper(&ORDEN_PADRE) = 'S';

--orden padre en LEGO detalle
select lo.order_id Orden_Padre,
       lo.task_type_id || ' - ' || ott.description Tipo_Trabajo,
       lo.causal_id || ' - ' || gc.description Causal,
       lo.order_comment Comentario_Legalizacion,
       lo.exec_initial_date Fecha_Inicial_Ejecucion,
       lo.exec_final_date Fecha_Final_Ejecucion,
       lo.legalizado,
       lo.fecha_registro Fecha_Registro_LEGO,
       lo.mensaje_legalizado Mensaje_Post_Legalizacion
  from open.ldc_otlegalizar lo
 inner join open.or_task_type ott
    on lo.task_type_id = ott.task_type_id
 inner join open.ge_causal gc
    on lo.causal_id = gc.causal_id
 where 1 = 1
   and lo.order_id in (&ORDEN)
   and upper(&ORDEN_PADRE_DETALLE) = 'S';

--Anexo de acceso a la orden en LEGO con orden padre en LEGO
select *
  from OPEN.LDC_ANEXOLEGALIZA a, open.ldc_otlegalizar lo
 where 1 = 1
   and a.order_id = lo.order_id
   and a.agente_id = 259
   and lo.order_id in (&ORDEN);

--Orden por AGENTE
select lo.*
  from open.ldc_otlegalizar lo
 inner join OPEN.LDC_ANEXOLEGALIZA la
    on la.order_id = lo.order_id
 where 1 = 1
   and lo.legalizado = 'N'
   and la.agente_id = 18;

--Dato Adicional orden padre
select loda.*, rowid
  from OPEN.LDC_OTDALEGALIZAR loda
 where 1 = 1
   and loda.order_id in (&ORDEN)
   and upper(&DATO_ADICIONAL_PADRE) = 'S';

--Dato Adicional orden padre detalle
select loda.order_id Orden_Padre,
       loda.name_attribute Datos_Adicional,
       loda.value Valor,
       loda.task_type_id || ' - ' || ott.description Tipo_Trabajo,
       loda.causal_id || ' - ' || gc.description Causal
  from OPEN.LDC_OTDALEGALIZAR loda
 inner join open.or_task_type ott
    on loda.task_type_id = ott.task_type_id
 inner join open.ge_causal gc
    on loda.causal_id = gc.causal_id
 where 1 = 1
   and loda.order_id in (&ORDEN)
   and upper(&DATO_ADICIONAL_PADRE_DETALLE) = 'S';

--Dato Adicional Actividad orden padre
select lodaactividad.*, rowid
  from OPEN.LDC_OTDATOACTIVIDAD lodaactividad
 where 1 = 1
   and lodaactividad.order_id in (&ORDEN)
   and upper(&ACTIVIDAD_PADRE) = 'S';

--Item Orden Padre
select loi.*, rowid
  from OPEN.LDC_OTITEM loi
 where 1 = 1
   and loi.order_id in (&ORDEN)
   and upper(&ITEM_PADRE) = 'S';

---Item Orden Padre detalle
select loi.ORDER_ID Orden_Padre,
       loi.item || ' - ' || gim.description Item,
       loi.cantidad
  FROM OPEN.LDC_OTITEM loi
 inner join open.ge_items gim
    on gim.items_id = loi.item
 where 1 = 1
   and loi.ORDER_ID in (&ORDEN)
   and upper(&ITEM_PADRE_DETALLE) = 'S';

---Ordenes adicionales
select LR.*, rowid
  FROM open.ldc_otadicional LR
 where 1 = 1
   and LR.ORDER_ID in (&ORDEN)
   and upper(&TT_ADICIONAL) = 'S';

---Tipo Tabajo adicionales Orden Padre
select LR.ORDER_ID Orden_Padre,
       lr.task_type_id || ' - ' || ott.description Trabajo_Adicional,
       lr.causal_id || ' - ' || gc.description Causal,
       lr.actividad || ' - ' || gia.description Actividad_Adicional,
       lr.material || ' - ' || gim.description Material_Adicional
  FROM open.ldc_otadicional LR
 inner join open.ge_items gia
    on gia.items_id = lr.actividad
 inner join open.ge_items gim
    on gim.items_id = lr.material
 inner join open.or_task_type ott
    on lr.task_type_id = ott.task_type_id
 inner join open.ge_causal gc
    on lr.causal_id = gc.causal_id
 where 1 = 1
   and LR.ORDER_ID in (&ORDEN)
   and upper(&TT_ADICIONAL_DETALLE) = 'S';

--Dato Adicional orden adicional
select loada.*, rowid
  from OPEN.LDC_OTADICIONALDA loada
 where 1 = 1
   and loada.ORDER_ID in (&ORDEN);

--Dato Adicional Actividad orden adicional
select ldaaoa.*, rowid
  from OPEN.LDC_DATOACTIVIDADOTADICIONAL ldaaoa
 where 1 = 1
   and ldaaoa.ORDER_ID in (&ORDEN);
