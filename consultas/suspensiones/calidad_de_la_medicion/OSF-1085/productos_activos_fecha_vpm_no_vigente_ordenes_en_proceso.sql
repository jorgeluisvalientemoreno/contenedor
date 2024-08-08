--productos_activos_fecha_vpm_no_vigente_ordenes_en_proceso
Select f.product_id,
       o.order_id,
       o.task_type_id,
       t.description,
       o.order_status_id,
       f.fecha_vpm,
       trunc(o.legalization_date) fech_leg,
       to_char(trunc(sysdate - o.legalization_date)) dias_legalizada,
       f.emsscoem,
       trunc(f.fecha_proxima_vpm)  prox_vpm,
       p.product_status_id
  From or_order o
 inner join or_order_activity a on a.order_id  =  o.order_id
 inner join or_task_type t on t.task_type_id  =  o.task_type_id
 left join ldc_vpm  f on f.product_id = a.product_id
 left join pr_product  p on p.product_id = a.product_id
 left join ge_causal  c on c.causal_id = o.causal_id
 Where o.task_type_id in (11185, 11183, 11231)
   and o.order_status_id in (8)
   and p.product_status_id = 1
   and c.class_causal_id = 1
   and f.fecha_proxima_vpm < sysdate
   and exists
 (select null
          from or_order_activity aa, or_order oo
         Where oo.order_id = aa.order_id
           And a.product_id = aa.product_id
           And oo.task_type_id in (10444,10449,10450,10723,10795,10833,10834,10835,10836,12457,12460,11026,11032,11056,11186,11187,11190,11188,11232,11234,11233,11189)
           And oo.order_status_id in (0, 5, 7, 11))


and f.product_id in (50306486)
