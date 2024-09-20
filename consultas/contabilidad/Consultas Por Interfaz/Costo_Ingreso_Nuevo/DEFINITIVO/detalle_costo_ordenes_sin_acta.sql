SELECT 'SIN_ACTA' TIPO, oa.product_id, null acta, null factura, null fecha, oa.order_id orden, 
       decode(oa.task_type_id, 10336, r.real_task_type_id, oa.task_type_id) titr, ot.concept,
       sum(decode(it.items_id, 4001293, 0, value)) Total, 
       sum(decode(it.items_id, 4001293, value)) Total_IVA,
       /*sum(value) Total,*/ decode(ut.contractor_id, null, ut.operating_unit_id, ut.contractor_id) contratista, 
       (select co.nombre_contratista from OPEN.GE_CONTRATISTA co 
         where co.id_contratista =  decode(ut.contractor_id, null, ut.operating_unit_id, ut.contractor_id)) nombre, 
       trunc(r.legalization_date) fec_lega, tt.clctclco
  FROM open.or_order_activity oa, open.mo_packages m, open.or_order_items oi, open.or_order r, open.ic_clascott tt,
       open.or_task_type ot, open.ge_items it, OPEN.OR_OPERATING_UNIT ut
 where r.legalization_date <= '&FECHA_FINAL 23:59:59'
   and r.order_status_id = 8
   and r.order_id = oa.order_id
   and r.task_type_id = oa.task_type_id
   and oa.package_id = m.package_id(+)
   and oa.order_id = oi.order_id
   and value != 0
   and decode(oa.task_type_id, 10336, r.real_task_type_id, oa.task_type_id) = tt.clcttitr
   and tt.clctclco in (259, 309)
   and tt.clctclco not in (311,246,303,252,253)
   and oa.order_id not in (select a.id_orden from OPEN.ge_detalle_Acta a where a.id_orden = oa.order_id)
   and oa.task_type_id = ot.task_type_id      
   and oi.items_id    = it.items_id 
   and (it.item_classif_id != 23 or it.items_id = 4001293)
   and r.operating_unit_id = ut.operating_unit_id
Group by 'SIN_ACTA', oa.product_id, null, null, null, oa.order_id, decode(oa.task_type_id, 10336, r.real_task_type_id, oa.task_type_id),
         ot.concept, trunc(r.legalization_date), tt.clctclco, ut.contractor_id, ut.operating_unit_id
