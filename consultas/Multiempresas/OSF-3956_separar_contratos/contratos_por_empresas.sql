--contratos_por_empresas
select ce.empresa, 
       l2.geograp_location_id, 
       l2.description,
       count (pr.subscription_id)  contratos_osf,
       count (ce.contrato)  contratos_multiempresa
from pr_product pr
 left outer join multiempresa.contrato  ce  on ce.contrato = pr.subscription_id
 left outer join ab_address d on d.address_id = pr.address_id
 left outer join ge_geogra_location  l on l.geograp_location_id = d.geograp_location_id
 left outer join ge_geogra_location  l2 on l2.geograp_location_id = l.geo_loca_father_id
 where pr.product_type_id != 3
  group by ce.empresa, l2.geograp_location_id, l2.description;
 
  
/*  select c.susccodi, me.empresa
  from suscripc  c
  left outer join multiempresa.contrato  me  on me.contrato = c.susccodi
  where exists (select null from pr_product  p  where p.subscription_id = c.susccodi and p.product_type_id = 7014)
  and not exists (select null from pr_product  p  where p.subscription_id = c.susccodi and p.product_type_id != 7014)*/
