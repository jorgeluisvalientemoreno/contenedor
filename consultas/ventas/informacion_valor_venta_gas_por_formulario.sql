select gl.geo_loca_father_id || '-  ' || gl.display_description as Departamento, 
       pr.subscription_id  Contrato, 
       pr.product_id  Producto,
       n.package_id Solicitud, 
       n.order_id Orden, 
       value_comi Valor_Comision,
       sd.total_value Valor_total, 
       c.percentage Porcentaje_comision  
from open.mo_gas_sale_data  sd
inner join open.ldc_comm_aut_cont  n on sd.package_id = n.package_id
inner join open.mo_packages  p on p.package_id = sd.package_id
inner join open.mo_motive  m on m.package_id = sd.package_id
inner join open.pr_product  pr on m.product_id = pr.product_id
inner join open.ab_address di on di.address_id = p.address_id
inner join open.ge_geogra_location  gl on gl.geograp_location_id = di.geograp_location_id
inner join open.ldc_conf_comm_aut_cont  c on n.ldc_conf_comm_id = c.ldc_conf_comm_id
