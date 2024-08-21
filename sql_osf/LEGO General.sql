--Anexo de acceso a la orden en LEGO
select a.order_id,
       a.agente_id || ' - ' || lal.description Agente,
       a.tecnico_unidad || ' - ' || gp.name_ Tecnico
  from OPEN.LDC_ANEXOLEGALIZA a
 inner join OPEN.LDC_AGENLEGO lal
    on lal.agente_id = a.agente_id
 inner join open.GE_PERSON gp
    on gp.person_id = a.tecnico_unidad
 where a.order_id = &v_order_id;

--Anexo de acceso a la orden en LEGO
select a.*, rowid
  from OPEN.LDC_ANEXOLEGALIZA a
 where a.order_id = &v_order_id;

--orden padre en LEGO
select lo.*, rowid
  from open.ldc_otlegalizar lo
 where lo.order_id = &v_order_id;
--Dato Adiciona orden padre
select loda.*, rowid
  from OPEN.LDC_OTDALEGALIZAR loda
 where loda.order_id = &v_order_id;
--Dato Adicional Actividad orden padre
select lodaactividad.*, rowid
  from OPEN.LDC_OTDATOACTIVIDAD lodaactividad
 where lodaactividad.order_id = &v_order_id;
--Item Orden Padre
select loi.*, rowid
  from OPEN.LDC_OTITEM loi
 where loi.order_id = &v_order_id;

---Ordenes adicionales
select LR.*, rowid
  FROM open.ldc_otadicional LR
 where LR.ORDER_ID = &v_order_id;
--Dato Adiciona orden adicional
select loada.*, rowid
  from OPEN.LDC_OTADICIONALDA loada
 where loada.ORDER_ID = &v_order_id;
--Dato Adicional Actividad orden adicional
select ldaaoa.*, rowid
  from OPEN.LDC_DATOACTIVIDADOTADICIONAL ldaaoa
 where ldaaoa.ORDER_ID = &v_order_id;
