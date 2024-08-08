      SELECT 'ACTA_S_F' TIPO, null product_id, 
             null acta, null  factura, null  fecha,
             a.id_orden orden, decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id) titr, ot.concept,
             sum(decode(it.items_id, 4001293, 0, a.valor_total)) Total,
             sum(decode(it.items_id, 4001293, a.valor_total)) Total_IVA,
             co.id_contratista contratista, ta.nombre_contratista nombre,
             null fec_lega, tt.clctclco,
             ro.saved_data_values
      FROM OPEN.ge_detalle_acta a, open.ge_acta ac, open.or_order ro, 
           open.or_task_type ot, open.ge_contratista ta, open.ge_contrato co, open.ge_items it, open.ic_clascott tt
      where  ac.id_acta   = a.id_acta
       and (ac.extern_pay_date is null or ac.extern_pay_date >='01/07/2020')
       and a.id_orden   = ro.order_id
       and a.valor_total != 0
       and ro.task_type_id !=  10336 -- Tipo de Trabajo Ajustes   
       and decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id) = tt.clcttitr
       and ro.legalization_date <'01/07/2020'
       and ro.created_date <'01/07/2020'  
       --and ro.order_id=178109823
       and tt.clctclco in (252,253)
       and decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id) = ot.task_type_id
       and ac.id_contrato = co.id_contrato
       and co.id_contratista = ta.id_contratista  and a.id_items = it.items_id
       AND (IT.item_classif_id NOT IN (8,21,23) or it.items_id = 4001293)
      Group by 'ACTA_S_F', null, null, null, a.id_orden,
               decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id), ot.concept, co.id_contratista,
               ta.nombre_contratista, null, tt.clctclco, null, ro.saved_data_values --trunc(ac.extern_pay_date)
      Union  -- Ajustes de ordenes de meses anteriores
      SELECT 'ACTA_S_F' TIPO, null  product_id,
             null acta, null factura, null  fecha,
             a.id_orden orden, decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id) titr, ot.concept,
             sum(decode(it.items_id, 4001293, 0, a.valor_total)) Total,
             sum(decode(it.items_id, 4001293, a.valor_total)) Total_IVA,
             co.id_contratista contratista, ta.nombre_contratista nombre,
             null fec_lega, tt.clctclco,
             ro.saved_data_values
      FROM OPEN.ge_detalle_acta a, open.ge_acta ac, open.or_order ro,
           open.ic_clascott tt, open.or_task_type ot, open.ge_contratista ta, open.ge_contrato co, open.ge_items it
      where ac.id_acta   = a.id_acta
       and (ac.extern_pay_date is null or ac.extern_pay_date >= '01/07/2020')
       and a.id_orden   = ro.order_id
       and a.valor_total != 0
       and ro.task_type_id =  10336 -- Tipo de Trabajo Ajustes
       and decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id) = tt.clcttitr
       and ro.legalization_date <'01/07/2020'
       and ro.created_date <'01/07/2020'
       and tt.clctclco in (252,253)
       and decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id) = ot.task_type_id
       and ac.id_contrato = co.id_contrato
       and co.id_contratista = ta.id_contratista  and a.id_items = it.items_id
      -- and ro.order_id=178109823
       AND (IT.item_classif_id NOT IN (8,21,23) or it.items_id = 4001293)
      Group by 'ACTA_S_F', null, null,  null, null, a.id_orden,
               decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id), ot.concept, co.id_contratista,
               ta.nombre_contratista, null, tt.clctclco, null, ro.saved_data_values --trunc(ac.extern_pay_date)

UNION

SELECT 'SIN_ACTA' TIPO, null product_id,
       null acta, null factura, null fecha, r.order_id orden,
       decode(r.task_type_id, 10336, r.real_task_type_id, r.task_type_id) titr, ot.concept,
       sum(decode(it.items_id, 4001293, 0, value)) Total,
       sum(decode(it.items_id, 4001293, value)) Total_IVA,
       decode(ut.contractor_id, null, ut.operating_unit_id, ut.contractor_id) contratista,
       (select co.nombre_contratista from OPEN.GE_CONTRATISTA co
         where co.id_contratista =  decode(ut.contractor_id, null, ut.operating_unit_id, ut.contractor_id)) nombre,
       null fec_lega, tt.clctclco,r.saved_data_values
  FROM open.or_order r, open.ic_clascott tt, open.or_order_items oi, open.or_task_type ot, open.ge_items it, OPEN.OR_OPERATING_UNIT ut
 where r.legalization_date <'01/07/2020'
   and r.created_date <'01/07/2020'
   and r.is_pending_liq    IN ('E','Y')
   and r.order_status_id   =  8
   and r.causal_id in (select g.causal_id from open.ge_causal g where g.causal_id = r.causal_id and g.class_causal_id = 1)
   and value               != 0
   and decode(r.task_type_id, 10336, r.real_task_type_id, r.task_type_id) = tt.clcttitr
   and tt.clctclco in (252,253)
   and r.order_id not in (select a.id_orden from OPEN.ge_detalle_Acta a where a.id_orden = r.order_id)
   and r.task_type_id = ot.task_type_id
   and oi.order_id    =  r.order_id
   and oi.items_id    = it.items_id
   and (it.item_classif_id != 23 or it.items_id = 4001293)
   and r.operating_unit_id = ut.operating_unit_id
   and ut.es_externa = 'Y'
   --and r.order_id=178109823
Group by 'SIN_ACTA',  null, null, null, r.order_id, decode(r.task_type_id, 10336, r.real_task_type_id, r.task_type_id),
         ot.concept, null, tt.clctclco, ut.contractor_id, ut.operating_unit_id, r.saved_data_values
UNION
SELECT 'SIN_ACTA' TIPO, null product_id, null acta, null factura, null fecha, oa.order_id orden,
       decode(oa.task_type_id, 10336, r.real_task_type_id,oa.task_type_id) titr, ot.concept,
       --nvl(SUM(oa.value_reference * cn.liquidation_sign),0) Total,
       sum(nvl(oa.value_reference * cn.liquidation_sign * nvl((select -1 from open.or_related_order where related_order_id=oa.order_id and RELA_ORDER_TYPE_ID=15),1),0)) Total,
       nvl(SUM(decode(it.items_id, 4001293, 0)),0) Total_IVA,
       decode(ut.contractor_id, null, ut.operating_unit_id, ut.contractor_id) contratista,
       (select co.nombre_contratista from OPEN.GE_CONTRATISTA co
         where co.id_contratista =  decode(ut.contractor_id, null, ut.operating_unit_id, ut.contractor_id)) nombre,
       null fec_lega, tt.clctclco,r.saved_data_values
  FROM open.or_order_activity oa, open.mo_packages m, open.or_order_items oi, open.or_order r, open.ic_clascott tt,
       open.or_task_type ot, open.ge_items it, OPEN.OR_OPERATING_UNIT ut, open.ct_item_novelty cn --, open.or_related_order ro
 where r.legalization_date <'01/07/2020'
   and r.created_date <'01/07/2020'
   and r.is_pending_liq    IN ('E','Y')
   and r.order_status_id   =  8
   and r.causal_id in (select g.causal_id from open.ge_causal g where g.causal_id = r.causal_id and g.class_causal_id = 1)
   and r.order_id          =  oa.order_id
   and oa.package_id       =  m.package_id(+)
   and oa.value_reference != 0
   and oi.order_id         =  oa.order_id
   and ((oa.order_item_id    =  oi.order_items_id and it.item_classif_id=2)or
       ((oa.order_Activity_id    =  oi.order_activity_id and it.item_classif_id!=2)))
   and cn.items_id         = oa.activity_id
   and decode(oa.task_type_id, 10336, r.real_task_type_id, oa.task_type_id) = tt.clcttitr
   and tt.clctclco  in (252,253)
   and oa.order_id not in (select a.id_orden from OPEN.ge_detalle_Acta a where a.id_orden = oa.order_id)
   and oa.task_type_id = ot.task_type_id
   and oi.items_id     = it.items_id
   and (it.item_classif_id != 23 or it.items_id = 4001293)
   and r.operating_unit_id = ut.operating_unit_id
   and ut.es_externa = 'Y'
   --and r.order_id=178109823
Group by 'SIN_ACTA', null, null, null, null, oa.order_id, decode(oa.task_type_id, 10336, r.real_task_type_id, oa.task_type_id),
         ot.concept, null, tt.clctclco, ut.contractor_id, ut.operating_unit_id, r.saved_data_values
