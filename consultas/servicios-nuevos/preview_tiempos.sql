select product_id producto,
       package_id solicitud,
       activity_id,
       --description,
       request_date fecha_venta,
       attention_date atencion_solic,
       order_id orden, 
       
       created_Date fecha_creacion_ot,
       legalization_date fecha_legalizacion,
       execution_final_date fecha_ejecucion,
       tiempo_bloqueo,
       execution_final_date - created_Date tiempo_juan_felipe,
       execution_final_date - request_Date - nvl(tiempo_bloqueo,0) tiempo_con_fecha_venta
from (
select a.product_id,
       p.package_id,
       a.activity_id,
       i.description  Actividad,
       p.request_date,
       p.attention_date,
       o.order_id,
       o.created_Date,
       o.legalization_Date,
       o.execution_final_date,
       /*(select sum(c2.stat_chg_date-c.stat_chg_date)
       from open.or_order_stat_change c, open.or_order_activity a2, open.or_order o2 , open.or_order_stat_change c2
       where a2.order_id=o2.order_id
         and a2.package_id=a.package_id
         and a2.product_id=a.product_id
         and o2.task_type_id in (12150,12152,12153)
         and a2.activity_id in (4000051, 100002509)
         and c.order_id=o2.order_id
         and c.final_status_id=11
         and c.order_id=c2.order_id
         and c2.initial_status_id=11
        )*/
        (select sum(c2.stat_chg_date-c.stat_chg_date)
       from open.or_order_stat_change c, open.or_order_activity a2, open.or_order o2 , open.or_order_stat_change c2, open.or_related_order r, open.or_order o3
       where a2.order_id=o2.order_id
         and a2.package_id=a.package_id
         and a2.product_id=a.product_id
         and o2.task_type_id in (12150,12152,12153)
         and a2.activity_id in (4000051, 100002509)
         and c.order_id=o2.order_id
         and c.final_status_id=11
         and c.order_id=c2.order_id
         and c2.initial_status_id=11
         and r.related_order_id=o2.order_id
         and o3.order_id=r.order_id
         and o3.causal_id not in (9347 , 3604 )) tiempo_bloqueo
from open.mo_packages p, open.or_order_activity a, open.or_order o, open.ge_items  i
where package_type_id=271
  and p.package_id=a.package_id
  and a.order_id=o.order_id
  and a.activity_id = i.items_id
  and o.task_type_id in (12150,12152,12153)
  and o.order_status_id=8
  and legalization_Date>='01/01/2018'
  and legalization_Date<'31/12/2018'
  and causal_id=9944
  and a.activity_id in (4000051, 100002509)
 -- and a.product_id in (50895305) 
  )
  --and p.package_id=12782757"
