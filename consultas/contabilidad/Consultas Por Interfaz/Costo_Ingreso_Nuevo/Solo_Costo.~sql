select tipo, product_id, orden, titr, concept, total, t.clctclco, i.clcodesc, contratista, nombre,
       (select 'CONECTADO' from open.hicaesco h 
         where h.hcecfech >= '01-07-2015' and h.hcecfech < '01-08-2015'
           and h.hcecnuse = product_id and h.hcececan = 96 and h.hcececac = 1) Estado
  from (
        SELECT 'ACTA_F' tipo, o.product_id, /*a.id_acta acta,*/ a.id_orden orden, o.task_type_id titr, ot.concept, 
               sum(a.valor_total) Total, co.id_contratista contratista, ta.nombre_contratista nombre
          FROM OPEN.ge_detalle_acta a, open.or_order_activity o, open.mo_packages m, open.ge_acta ac, open.ic_clascott tt,
               open.or_task_type ot, open.ge_contratista ta, open.ge_contrato co, open.ge_items it
         where ac.extern_pay_date >= '01-07-2015'
           and ac.extern_pay_date <  '01-08-2015'
           and ac.extern_invoice_num is not null
           and ac.id_acta   = a.id_acta
           and a.id_orden   = o.order_id
           and o.package_id = m.package_id
           and a.valor_total != 0
           and o.task_type_id = tt.clcttitr
           and tt.clctclco /*= 247 --*/not in (245,315,312,311,246,308,303)
           and o.task_type_id = ot.task_type_id
           and ac.id_contrato = co.id_contrato
           and co.id_contratista = ta.id_contratista  and a.id_items = it.items_id 
           and (it.item_classif_id != 23 or it.items_id = 4001293)
        Group by 'ACTA_F', o.product_id, /*a.id_acta,*/ a.id_orden, o.task_type_id, ot.concept, co.id_contratista, ta.nombre_contratista
        UNION ALL
        SELECT 'ACTA_N' tipo, o.product_id, /*null acta,*/ o.order_id orden, o.task_type_id titr, ot.concept, sum(value) Total,
               null contratista, null nombre
          FROM open.or_order_activity o, open.mo_packages m, open.or_order_items oi, open.or_order r, open.ic_clascott tt,
               open.or_task_type ot, open.ge_items it
         where r.legalization_date < '01-08-2015'
           and r.order_status_id = 8
           and r.order_id = o.order_id
           and o.package_id = m.package_id
           and o.order_id = oi.order_id
           and value != 0
           and o.task_type_id = tt.clcttitr
           and tt.clctclco /*= 247 --*/not in (245,315,312,311,246,308,303)   
           and o.order_id in (select a.id_orden from OPEN.ge_detalle_Acta a, open.ge_acta ac
                               where a.id_orden = o.order_id and a.id_acta = ac.id_acta 
                                 and (ac.extern_pay_date is null or ac.extern_pay_date > '31-07-2015 23:59:59'))
           and o.task_type_id = ot.task_type_id
           and oi.items_id    = it.items_id 
           and (it.item_classif_id != 23 or it.items_id = 4001293)
        Group by 'ACTA_N', o.product_id, /*null,*/ o.order_id, o.task_type_id, ot.concept, null, null
        UNION ALL
        SELECT 'S_ACTA' tipo, o.product_id, /*999999 acta,*/ o.order_id orden, o.task_type_id titr, ot.concept, 
               sum(value) Total, null contratista, null nombre
          FROM open.or_order_activity o, open.mo_packages m, open.or_order_items oi, open.or_order r, open.ic_clascott tt,
               open.or_task_type ot, open.ge_items it
         where r.legalization_date < '01-08-2015'
           and r.order_status_id = 8
           and r.order_id = o.order_id
           and o.package_id = m.package_id
           and o.order_id = oi.order_id
           and value != 0
           and o.task_type_id = tt.clcttitr
           and tt.clctclco /*= 247 --*/not in (245,315,312,311,246,308,303)   
           and o.order_id not in (select a.id_orden from OPEN.ge_detalle_Acta a where a.id_orden = o.order_id)
           and o.task_type_id = ot.task_type_id      
           and oi.items_id    = it.items_id 
           and (it.item_classif_id != 23 or it.items_id = 4001293)                                
        Group by 'S_ACTA', o.product_id, /*null,*/ o.order_id, o.task_type_id, ot.concept, null, null
        ), open.ic_clascott t, open.ic_clascont i
 where titr = t.clcttitr
   and t.clctclco = i.clcocodi
--order by product_id
