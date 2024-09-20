              Select  tipo, product_id, acta, factura, fecha, orden, titr, concept, sum(total) total, sum(total_iva) total_iva,
                      contratista, nombre, fec_lega, clctclco
              from  (
                SELECT 'ACTA_FRA' TIPO, oa.product_id, a.id_acta acta, ac.extern_invoice_num factura, 
                       trunc(ac.extern_pay_date) fecha, a.id_orden orden, 
                       decode(oa.task_type_id, 10336, ro.real_task_type_id, oa.task_type_id) titr, 
                       ot.concept, sum(decode(it.items_id, 4001293, 0, a.valor_total)) Total, 
                       sum(decode(it.items_id, 4001293, a.valor_total)) Total_IVA,
                       /*sum(a.valor_total) Total,*/ co.id_contratista contratista, ta.nombre_contratista nombre,
                       trunc(ro.legalization_date) fec_lega, tt.clctclco
                FROM OPEN.ge_detalle_acta a, open.or_order_activity oa, open.mo_packages m, open.ge_acta ac, open.or_order ro,
                     open.ic_clascott tt, open.or_task_type ot, open.ge_contratista ta, open.ge_contrato co, open.ge_items it
                where ac.extern_pay_date >= '01-09-2015'
                 and ac.extern_pay_date <=  '30-09-2015 23:59:59'
                 and ac.extern_invoice_num is not null
                 and ac.id_acta   = a.id_acta
                 and ac.id_acta   =  &acta
                 and a.id_orden = ro.order_id
                 and ro.legalization_date >= '01-09-2015' and ro.legalization_date <= '30-09-2015 23:59:59'                 
                 and a.id_orden   = oa.order_id
                 and oa.package_id = m.package_id(+)
                 and oa.order_id = ro.order_id
                 and oa.task_type_id = ro.task_type_id                 
                 and a.valor_total != 0
                 and decode(oa.task_type_id, 10336, ro.real_task_type_id, oa.task_type_id) = tt.clcttitr
                 and tt.clctclco in (259,309) -- not in (311,246,303,252,253)
                 and decode(oa.task_type_id, 10336, ro.real_task_type_id, oa.task_type_id) = ot.task_type_id
                 and ac.id_contrato = co.id_contrato
                 and co.id_contratista = ta.id_contratista  and a.id_items = it.items_id 
                 and (it.item_classif_id != 23 or it.items_id = 4001293)
                Group by 'ACTA_FRA', oa.product_id, a.id_acta, ac.extern_invoice_num, a.id_orden, ot.concept, co.id_contratista, 
                       decode(oa.task_type_id, 10336, ro.real_task_type_id, oa.task_type_id), ta.nombre_contratista, 
                       trunc(ro.legalization_date), tt.clctclco, trunc(ac.extern_pay_date)
                UNION -- Ajustes de ordenes de meses anteriores
                SELECT 'ACTA_FRA' TIPO, oa.product_id, a.id_acta acta, ac.extern_invoice_num factura, 
                       trunc(ac.extern_pay_date) fecha, a.id_orden orden, decode(oa.task_type_id, 10336, ro.real_task_type_id, 
                       oa.task_type_id) titr, ot.concept, sum(decode(it.items_id, 4001293, 0, a.valor_total)) Total, 
                       sum(decode(it.items_id, 4001293, a.valor_total)) Total_IVA,
                       co.id_contratista contratista, ta.nombre_contratista nombre,
                       trunc(ro.legalization_date) fec_lega, tt.clctclco
                 FROM OPEN.ge_detalle_acta a, open.or_order_activity oa, open.mo_packages m, open.ge_acta ac, open.or_order ro,
                      open.ic_clascott tt, open.or_task_type ot, open.ge_contratista ta, open.ge_contrato co, open.ge_items it
                where ac.extern_pay_date >= '01-09-2015'
                  and ac.extern_pay_date <= '30-09-2015 23:59:59'
                  and ac.id_acta      =  &acta
                  and ac.extern_invoice_num is not null
                  and ac.id_acta      =  a.id_acta
                  and a.id_orden      =  ro.order_id
                  and a.id_orden      =  oa.order_id
                  and oa.package_id   =  m.package_id(+)
                  and oa.order_id     =  ro.order_id
                  and oa.task_type_id =  ro.task_type_id                 
                  and a.valor_total   != 0
                  and oa.task_type_id =  10336 -- Tipo de Trabajo Ajustes
                  and ro.legalization_date < '01-09-2015'
                  and ro.created_date >= '01-09-2015' and ro.created_date <= '30-09-2015 23:59:59'   
                  and decode(oa.task_type_id, 10336, ro.real_task_type_id, oa.task_type_id) = tt.clcttitr
                  and tt.clctclco   in (259,309) --    not in (311,246,303,252,253)
                  and decode(oa.task_type_id, 10336, ro.real_task_type_id, oa.task_type_id) = ot.task_type_id
                  and ac.id_contrato    = co.id_contrato
                  and co.id_contratista = ta.id_contratista  and a.id_items = it.items_id 
                  and (it.item_classif_id != 23 or it.items_id = 4001293)
                Group by 'ACTA_FRA', oa.product_id, a.id_acta, ac.extern_invoice_num, a.id_orden, ot.concept, co.id_contratista, 
                      decode(oa.task_type_id, 10336, ro.real_task_type_id, oa.task_type_id), ta.nombre_contratista, 
                      trunc(ro.legalization_date), tt.clctclco, trunc(ac.extern_pay_date)
              )
              Group by tipo, product_id, acta, factura, fecha, orden, titr, concept, contratista, nombre, fec_lega, clctclco
