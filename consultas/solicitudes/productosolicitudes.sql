select pr.subscription_id Contrato,
       pr.product_id Producto,
       s.sesucicl Ciclo,
       pr.product_type_id Tipo_Producto,
       gl.geo_loca_father_id || '-  ' || gl.display_description as Departamento,
       pr.commercial_plan_id Plan_Comercial,
       min(p.request_date) Fecha_Registro_Solicitud
  from mo_packages p
 inner join mo_motive  m on p.package_id = m.package_id
 inner join pr_product  pr on m.product_id = pr.product_id
 inner join open.ab_address di on di.address_id=p.address_id
 inner join ge_geogra_location  gl on gl.geograp_location_id = di.geograp_location_id
 inner join servsusc  s on s.sesunuse = pr.product_id
 group by pr.subscription_id,
          pr.product_id,
          s.sesucicl,
          pr.product_type_id,
          gl.geo_loca_father_id || '-  ' || gl.display_description,
          pr.commercial_plan_id
