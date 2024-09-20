-- INGRESO SIN COSTO INTERNA
select cargnuse, cargconc--, sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, cargvalo*-1)) valor
  from open.cargos c, OPEN.CUENCOBR, OPEN.FACTURA, open.servsusc ss
 where cargnuse = sesunuse 
   and sesuserv = 7014
   and cargconc = 30
   and CARGCUCO = CUCOCODI      
   and factcodi = CUCOfact
   and FACTFEGE BETWEEN to_date('01/08/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')     
                    and to_date('31/08/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')    
   and cargtipr = 'A'    
   and cargsign NOT IN ('PA','AP','SA') 
   and cargcaca in (41,53) -- NOT IN (20,23,46,50,51,56,73)
   and cargsign = 'DB'
group by cargnuse, cargconc
MINUS
(select product_id, concept --, 68600
   from (
        -- Acta con Factura
        SELECT oa.product_id, ot.concept
          FROM OPEN.ge_detalle_acta a, OPEN.or_order_activity oa, OPEN.ge_acta ac, OPEN.or_order ro,
               OPEN.ic_clascott tt, OPEN.or_task_type ot, OPEN.ge_items it
          where ac.extern_pay_date >= '01-08-2015'
            and ac.extern_pay_date <= '31-08-2015 23:59:59'
            and ac.extern_invoice_num is not null
            and ac.id_acta    = a.id_acta
            and a.id_orden    = ro.order_id
            and ro.legalization_date >= '01-08-2015' and ro.legalization_date <= '31-08-2015 23:59:59'                 
            and a.id_orden    = oa.order_id
            and oa.order_id   = ro.order_id
            and oa.task_type_id = ro.task_type_id                 
            and a.valor_total != 0
            and decode(oa.task_type_id, 10336, ro.real_task_type_id, oa.task_type_id) = tt.clcttitr
            and tt.clctclco not in (311,246,303,252,253)
            and decode(oa.task_type_id, 10336, ro.real_task_type_id, oa.task_type_id) = ot.task_type_id
            and ot.concept = 30
            and a.id_items = it.items_id 
            and (it.item_classif_id != 23 or it.items_id = 4001293)
        Group by oa.product_id, ot.concept
        --
        UNION
        -- Acta sin Factura
        SELECT oa.product_id, ot.concept
          FROM OPEN.ge_detalle_acta a, open.or_order_activity oa, open.ge_acta ac, open.or_order ro,
               open.ic_clascott tt, open.or_task_type ot, open.ge_items it
         where (ac.extern_pay_date is null or ac.extern_pay_date > '31-08-2015 23:59:59') 
           and ac.id_acta   = a.id_acta
           and a.id_orden   = oa.order_id
           and a.valor_total != 0
           and decode(oa.task_type_id, 10336, ro.real_task_type_id, oa.task_type_id) = tt.clcttitr
           and oa.order_id = ro.order_id
           and ro.legalization_date >= '01-08-2015' and ro.legalization_date <= '31-08-2015 23:59:59'
           and oa.task_type_id = ro.task_type_id
           and tt.clctclco not in (311,246,303,252,253)
           and decode(oa.task_type_id, 10336, ro.real_task_type_id, oa.task_type_id) = ot.task_type_id
           and ot.concept = 30
           and a.id_items = it.items_id 
           and (it.item_classif_id != 23 or it.items_id = 4001293)
        Group by oa.product_id, ot.concept
        --
        UNION        
        -- Ordenes legalizadas sin Acta
        SELECT oa.product_id, ot.concept
          FROM open.or_order_activity oa, open.or_order_items oi, open.or_order r, open.ic_clascott tt,
               open.or_task_type ot, open.ge_items it, OPEN.OR_OPERATING_UNIT ut
         where r.legalization_date >= '01-08-2015' and r.legalization_date <= '31-08-2015 23:59:59'
           and r.order_status_id = 8
           and r.order_id = oa.order_id
           and r.task_type_id = oa.task_type_id
           and oa.order_id = oi.order_id
           and value != 0
           and decode(oa.task_type_id, 10336, r.real_task_type_id, oa.task_type_id) = tt.clcttitr
           and tt.clctclco not in (311,246,303,252,253)
           and oa.order_id not in (select a.id_orden from OPEN.ge_detalle_Acta a where a.id_orden = oa.order_id)
           and oa.task_type_id = ot.task_type_id
           and ot.concept = 30
           and oi.items_id    = it.items_id 
           and (it.item_classif_id != 23 or it.items_id = 4001293)
           and r.operating_unit_id = ut.operating_unit_id
        Group by oa.product_id, ot.concept
      )
/*where concept = 674*/)
