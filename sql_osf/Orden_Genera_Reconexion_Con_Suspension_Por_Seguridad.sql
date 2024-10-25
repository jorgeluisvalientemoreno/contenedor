select pp.suspen_ord_act_id || ' - ' || ott.description Ultima_Actividad_Suspension,
       pp.product_status_id || ' - ' || pps.description Estado_producto
  from open.pr_product pp
  left join open.ps_product_status pps
    on pps.product_status_id = pp.product_status_id
  left join open.Or_Order_Activity ooa
    on ooa.order_activity_id = pp.suspen_ord_act_id
  left join open.Or_Order oo
    on oo.order_id = ooa.order_id
  left join open.or_task_type ott
    on ott.task_type_id = oo.task_type_id
 where pp.product_id = 14511667
   and pp.product_type_id = 7014;

select pps.prod_suspension_id,
       pps.product_id,
       pps.suspension_type_id || ' - ' || p.description,
       pps.register_date,
       pps.aplication_date,
       pps.inactive_date,
       pps.active,
       pps.connection_code
  from open.pr_prod_suspension pps
  left join open.ge_suspension_type p
    on p.suspension_type_id = pps.suspension_type_id
 where pps.product_id = 14511667;

select * from open.pr_component pc where pc.product_id = 14511667;

select *
  from open.pr_comp_suspension pcs
 where pcs.component_id in
       (select pc.component_id
          from open.pr_component pc
         where pc.product_id = 14511667);
