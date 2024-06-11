 -- productos suspendidos por VPM
  Select o.order_id, o.task_type_id, o.order_status_id,  o.legalization_date, round (sysdate  - legalization_date) dias_transcurridos, 
 f.product_id, f.emsscoem, f.fecha_vpm, f.fecha_proxima_vpm, p.product_status_id, ps.suspension_type_id,
 ps.active             Activa,
       p.suspen_ord_act_id   orden_susp,
       ps.aplication_date    Fecha_Aplicacion,
       a.task_type_id        tt_susp,
       a.activity_id         act_susp,
       i.description         desc_act_susp
From or_order  o
inner join or_order_activity a  on o.order_id = a.order_id 
inner join  pr_product  p  on a.product_id = p.product_id
inner join servsusc ss on p.product_id = ss.sesunuse
inner join ps_product_status ep on ep.product_status_id = p.product_status_id
left join ldc_vpm  f  on a.product_id = f.product_id
left join  pr_prod_suspension ps  on p.product_id = ps.product_id
inner join ps_product_status ep on ep.product_status_id = p.product_status_id
left join ge_items  i on i.items_id = a.activity_id
Where p.product_status_id = 2
And   ps.suspension_type_id = 106
And   ps.active = 'Y'
And   o.task_type_id in (11132,11186,11232)
And   o.order_status_id in (8) 
and   f.fecha_proxima_vpm < sysdate
And not exists
 (select null
          from or_order_activity aa, or_order  oo
          Where oo.order_id = aa.order_id 
          And   a.product_id = aa.product_id
          And   oo.task_type_id in (11188,11189,11056,11180,11056,11181,11026,11032,11188,11189,11056,11180,11056,11181,11026,11032,10444,10449,10450,10723,10795,10833,10834,10835,10836, 12457,12460,11026,11032,11056,11186,11187,11190,11188,11232,11234,11233,11189,11179,11180,10444,10449,10450,10723,10795,10833,10834,10835,10836, 12457,12460,11026,11032,11056,11186,11187,11190,11188,11232,11234,11233,11189,11179,11180,11177)
          And   oo.order_status_id in (0, 5, 6, 7,11 ,20))
 
