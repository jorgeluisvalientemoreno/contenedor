select g1.geo_loca_father_id  sbCodedepa ,ge.description,g1.geograp_location_id sbCodeLoca ,g1.description, 3749 as sbCodeaseg , sesususc , 9428 as sbCauseinc , trunc(sysdate) as sbDatevisi,
'prueba' as sbObservat , ge.identification as sbIdentase , (ge.subscriber_name||' '|| ge.subs_last_name)as sbNameaseg, 450 as nuCodePolyType,'SEGURO VIDA' as sbDescProd , 11606 as sbValuepri
from open.suscripc su
inner join open.servsusc on sesususc = susccodi
inner join open.pr_product on pr_product.product_id =  sesunuse
left join ge_subscriber ge on ge.subscriber_id= su.suscclie
left join open.ab_address  on ab_address.address_id = pr_product.address_id
left join open.ge_geogra_location g1  on g1.geograp_location_id  =ab_address.geograp_location_id --ciudad=localidad  
left join open.ge_geogra_location ge  on ge.geograp_location_id = g1.geo_loca_father_id 
where sesususc in (66692471,66540852,6131620,6134914,66824201,6126041,67494168,66725661,48051174,67392152,48010746,48136507,48159328,48072048,48234378,1191120,48159423)
group by g1.geo_loca_father_id   ,ge.description,g1.geograp_location_id  ,g1.description, sesususc ,
 ge.identification ,ge.subscriber_name, ge.subs_last_name



select * from LD_PRODUCT_LINE ;

where g1.geograp_location_id=55

select * from ld_policy_type , ge_contratista  ge  where contratista_id =ge.id_contratista and  product_line_id =131 ;
select * from LD_PRODUCT_LINE ;

select * from ld_policy_by_cred_quot
--sbCodedepa|sbCodeLoca|sbCodeaseg|sbSuscripc|sbCauseinc|sbDatevisi|sbObservat|sbIdentase|sbNameaseg|nuCodePolyType|sbDescProd|sbValuepri|sbPolicy|sbDateBirth

--- depato| ciudad 
------------
select sesususc , sesufein , sesunuse, sesuserv , product_status_id , sesucicl 
from servsusc 
inner join pr_product on sesunuse = product_id 
where sesususc in (66692471,66540852,6131620,6134914,66835826,66824201,6126041,67494168,66725661,48051174,67392152,48010746,48136507,48159328,48072048,48234378,1191120,48159423) 
and sesufein >='18/07/2024';

select * from ld_policy l where l.product_id in (
select sesunuse
from servsusc 
where sesususc in (66692471,66540852,6131620,6134914,66835826,66824201,6126041,67494168,66725661,48051174,67392152,48010746,48136507,48159328,48072048,48234378,1191120,48159423)and sesuserv=7053 ) 
and dt_in_policy ='02/07/2024';

select or_order_activity.subscription_id  "Contrato", 
       or_order_activity.product_id  "Producto", sesuserv,
       servsusc.sesucicl  "Ciclo", 
       or_order.order_id  "Orden", mo_packages.package_id,
       or_order.task_type_id ||' : '|| initcap(or_task_type.description)  "Tipo de trabajo",
       or_order_activity.activity_id ||' : '|| initcap(ge_items.description)  "Actividad", 
       or_order.order_status_id ||' : '|| or_order_status.description  "Estado",
       or_order.legalization_date   "Fecha de legalizacion",mo_packages.motive_status_id,
       or_order.created_date "Fecha de creacion" 
from open.or_order
left join open.or_order_activity on or_order_activity.order_id = or_order.order_id
left join open.or_task_type on or_task_type.task_type_id = or_order.task_type_id
left join open.ge_items on ge_items.items_id = or_order_activity.activity_id
left join open.or_order_status on or_order_status.order_status_id = or_order.order_status_id
left join open.mo_packages on mo_packages.package_id = or_order_activity.package_id
left join open.ps_package_type on ps_package_type.package_type_id = mo_packages.package_type_id
left join open.ps_motive_status on ps_motive_status.motive_status_id = mo_packages.motive_status_id
left join open.servsusc on servsusc.sesunuse = or_order_activity.product_id
where  sesususc in (66692471,66540852,6131620,6134914,66835826,66824201,6126041,67494168,66725661,48051174,67392152,48010746,48136507,48159328,48072048,48234378,1191120,48159423) and created_date >='16/07/2024'
 --and or_order.task_type_id in (11056, 11230, 11231, 11232, 11177 , 11178)
and or_order.order_status_id in (8)
order by sesususc ;

select product_id, i.order_id , i.items_id , i.value,i.total_price ,i.order_items_id ,or_task_type.task_type_id , charge_status
from or_order_items i 
inner join open.or_order on  or_order.order_id =i.order_id
inner join open.or_order_activity on or_order_activity.order_id = or_order.order_id and or_order.task_type_id=  or_order_activity.task_type_id
inner join open.or_task_type on or_task_type.task_type_id = or_order.task_type_id
where i.order_id in (323736919,323736918,323736917,323736878,323736877,323736879,323736865,323736866,323736867,323736869,323736870,323736871,323736899,323736898,323736897,323736890,323736891,323736889,323736910,323736911,323736909,323736901,323736902,323736903,323736907,323736905,323736906,323736923,323736924,323736922,323736913,323736914,323736915,323736862,323736863,323736861,323736858,323736857,323736859,323736885,323736887,323736886,323736874,323736875,323736873,323736894,323736895,323736893,323736882,323736881,323736883)
and or_task_type.task_type_id in (10210,10211);
