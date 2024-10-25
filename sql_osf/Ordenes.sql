--DATA Orden
/*
IdOrden,
NombreCliente,
Contrato,
Producto,
depto,
localidad,
from orden where tipo de trabajo 10764
*/
select distinct oo.order_id Orden,
                gs.subscriber_name || ' ' || gs.subs_last_name Cliente,
                ooa.subscription_id Contrato,
                ooa.product_id Producto,
                localidad_Orden.geograp_location_id || ' - ' ||
                localidad_Orden.description Localidad,
                departamento_Orden.geograp_location_id || ' - ' ||
                departamento_Orden.description Departamento
  from open.or_order_activity ooa
  left join open.or_order oo
    on oo.order_id = ooa.order_id
  left join open.ab_address DireccionOrden
    on DireccionOrden.address_id = ooa.address_id
  left join open.ge_geogra_location localidad_Orden
    on DireccionOrden.geograp_location_id =
       localidad_Orden.geograp_location_id
  left join open.ge_geogra_location departamento_Orden
    on departamento_Orden.geograp_location_id =
       localidad_Orden.geo_loca_father_id
  left join open.suscripc s
    on s.susccodi = ooa.subscription_id
  left join open.ge_subscriber gs
    on gs.subscriber_id = s.suscclie
 where oo.task_type_id in (10764);
