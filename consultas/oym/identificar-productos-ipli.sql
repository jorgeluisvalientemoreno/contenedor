select gr.grupcodi,
       gr.grupdesc,
       gr.gruptamu,
       sum((select count(1) 
          from open.ab_address di
         inner join open.pr_product p on p.address_id=di.address_id and p.product_type_id=7014 and p.category_id = 1 and p.product_status_id=1
         where di.geograp_location_id=de.grloidlo 
           and di.address not like '%APT%' 
           and di.address not like '%CASA%' 
           and di.address not like '%PISO%'
           and di.address not like '%INT%'
           and not exists(select null
                            from open.or_order_activity oa1
                              ,open.ab_address ab1
                            where oa1.order_id > 65363139 -- primera orden creada
                              and oa1.activity_id = 4000892
                              and oa1.task_type_id = 12244
                              and ( oa1.comment_ like 'MEDIDOR: %' or oa1.comment_ like 'TOMA %' )
                              and ab1.geograp_location_id in ( di.geograp_location_id )
                              and ab1.address_id = oa1.address_id
                              and oa1.product_id = p.product_id ))) cantidad
        
from open.ldc_grupo gr
inner join open.ldc_grupo_localidad de on de.grupcodi=gr.grupcodi
--where gr.grupcodi=30
group by gr.grupcodi,
       gr.grupdesc,
       gr.gruptamu
