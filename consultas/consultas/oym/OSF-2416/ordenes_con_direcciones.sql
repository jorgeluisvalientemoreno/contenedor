--ordenes_con_direcciones
select a.subscription_id,
       a.product_id,
       o.order_id,
       o.task_type_id,
       tt.description desc_tipo_trabajo,
       o.order_status_id,
       l.description,
       o.external_address_id || ' - ' || di1.address Direccion_Orden,
       a.address_id || ' - ' || di2.address Direccion_Actividad,
       e.address_id || ' - ' || di3.address Direccion_Externa
  from or_order o
 inner join or_order_activity  a  on a.order_id = o.order_id
 inner join or_extern_systems_id  e on e.order_id = o.order_id
 inner join or_task_type  tt  on tt.task_type_id = o.task_type_id
 inner join ab_address  di1  on di1.address_id = o.external_address_id
 inner join ab_address  di2  on di2.address_id = a.address_id
 inner join ab_address  di3  on di3.address_id = e.address_id
 inner join ge_geogra_location  l  on l.geograp_location_id = di1.geograp_location_id
 where o.task_type_id in (12526,12528)
 and   o.order_status_id in (0,5)
 and o.order_id in (303079395,303079436,303079532,303079535)
