select mo.subscription_id contrato,
       pr.product_id producto,
       pr.product_status_id || ' -' || ps.description estado_producto,
       m.package_id solicitud,
       m.package_type_id || ' -' || pt.description tipo_solicitud,
       m.motive_status_id || ' -' || pm.description estado_solicitud,
       m.request_date fecha_creacion
from mo_packages m
left join mo_motive mo on mo.package_id = m.package_id
left join ps_motive_status pm on pm.motive_status_id =  m.motive_status_id 
left join ps_package_type pt on pt.package_type_id = m.package_type_id
left join pr_product pr on pr.product_id = mo.product_id
left join ps_product_status ps on pr.product_status_id = ps.product_status_id
where m.package_type_id= 271
and m.motive_status_id= 13
and pr.product_status_id = 15 
and exists ( select null 
            from  or_order_activity a 
            left join or_order o on a.order_id = o.order_id 
            left join ge_causal ge on ge.causal_id = o.causal_id
            where mo.product_id= a.product_id
            and o.task_type_id in (12149,12151,12150,12152,12162)
            and o.order_status_id in (8)
            and ge.class_causal_id = 1 ) 
and rownum <= 5
order by request_date desc 