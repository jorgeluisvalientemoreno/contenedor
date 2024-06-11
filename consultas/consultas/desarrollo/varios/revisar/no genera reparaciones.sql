select *
 from or_order_activity a , or_activ_defect d, mo_packages p, or_order o
 where a.order_activity_id=d.order_activity_id
   and p.package_id=a.package_id
   and p.motive_status_id=13
   and o.order_id=a.order_id
   and not exists(select null  from pr_certificate c  where c.product_id=a.product_id and c.estimated_end_date>=sysdate)
   and exists(select null from or_order o3, or_order_activity a3 where o3.task_type_id=10445 and o3.order_id=a3.order_id and a3.package_id=p.package_id and o3.order_status_id=5)
   and exists(select null
                from or_order_Activity a2, ge_items , or_order o2
               where a2.activity_id=items_id 
                  and use_='CR' 
                  and a2.product_id=a.product_id
                  and a2.order_id!=a.order_id
                  and o2.order_id=a2.order_id 
                  and o2.execution_final_date>o.execution_final_date)
 
 
