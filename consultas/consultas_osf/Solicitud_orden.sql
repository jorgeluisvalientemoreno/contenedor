select /* use_nl (oo order_id) */
 ooa.order_id,
 ooa.activity_id || ' - ' ||
 (select gi.description
    from open.ge_items gi
   where gi.items_id = ooa.activity_id) Actividad,
 --open.dage_items.fsbgetdescription(ooa.activity_id) 
 ooa.task_type_id || ' - ' ||
 (select ott.description
    from open.or_task_type ott
   where ott.task_type_id = oo.task_type_id) Tipo_Trabajo,
 --open.daor_task_type.fsbgetdescription(ooa.task_type_id) 
 oo.causal_id || ' - ' ||
 (select gc.description
    from open.ge_causal gc
   where gc.causal_id = oo.causal_id) Causal_legalizacion,
 --open.dage_causal.fsbgetdescription(oo.causal_id, null) 
 oo.operating_unit_id || ' - ' ||
 (select oou.name
    from open.or_operating_unit oou
   where oou.operating_unit_id = oo.operating_unit_id) Unidad_Operativa,
 --open.daor_operating_unit.fsbgetname(oo.operating_unit_id, null) 
 mp.reception_type_id || ' - ' ||
 (select grt.description
    from open.ge_reception_type grt
   where grt.reception_type_id = mp.reception_type_id) Medio_Recepcion,
 oo.created_date Fecha_Creacion,
 oo.legalization_date Fecha_Legalizacion,
 mp.package_id,
 mp.package_type_id || ' - ' ||
 --open.daps_package_type.fsbgetdescription(mp.package_type_id) 
  (select ppt.package_type_id || ' - ' || ppt.description
     from open.ps_package_type ppt
    where ppt.package_type_id = mp.package_type_id) Tipo_Solicitud,
 mp.attention_date,
 mp.CONTACT_ID,
 mp.comment_,
 (select mm.motive_id
    from open.mo_motive mm
   where mm.package_id = mp.package_id) /*,
 a.order_comment,
 b.items_id,
 b.assigned_item_amount*/
  from open.Or_Order_Activity ooa
 inner join open.mo_packages mp
    on mp.package_id(+) = ooa.package_id
      --and mp.package_type_id = 100101
      --and mp.package_id = 192215758 --199639503
   --and ooa.product_id = 50678406
   and ooa.subscription_id = 1015965
 inner join open.or_order oo
    on oo.order_id = ooa.order_id
 inner join open.mo_motive mm
    on mm.package_id = mp.package_id
   and mm.subscription_id = ooa.subscription_id
/*  inner join open.or_order_items b
  on b.order_id = oo.order_id
left join open.or_order_comment a
  on a.order_id = oo.order_id*/
 order by oo.legalization_date desc;
