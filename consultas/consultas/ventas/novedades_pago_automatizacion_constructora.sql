select n.ldc_comm_id  Id_Registro, 
       n.ldc_conf_comm_id  Id_Configuracion, 
       n.package_id  Solicitud, 
       pr.product_id Producto,
       gl.geo_loca_father_id || '-  ' || gl.display_description as Departamento, 
       n.value_comi  Valor_Comision, 
       n.order_id  Orden, 
       value_reference  Valor_Orden, 
       n.generate_date  Fecha_Liquidacion 
from open.ldc_comm_aut_cont  n
inner join open.mo_packages  p on p.package_id = n.package_id
inner join open.mo_motive  m on m.package_id = n.package_id
inner join open.pr_product  pr on m.product_id = pr.product_id
inner join open.ab_address di on di.address_id = p.address_id
inner join open.ge_geogra_location  gl on gl.geograp_location_id = di.geograp_location_id
inner join open.or_order_activity  oa on oa.order_id = n.order_id