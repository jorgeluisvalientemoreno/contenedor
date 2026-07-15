select  ab_address.geograp_location_id "localidad" ,initcap ( ge_geogra_location.description) "descripcion"  ,servsusc.sesucicl  "ciclo"
from ab_address
left join  pr_product on pr_product.address_id = ab_address.address_id
left join servsusc on servsusc.sesunuse = pr_product.product_id
left join ge_geogra_location  on ab_address.geograp_location_id= ge_geogra_location.geograp_location_id
where /*ab_address.geograp_location_id= 33
and */servsusc.sesucico  in (7687,8488) 
group by  ab_address.geograp_location_id ,ge_geogra_location.description  ,servsusc.sesucicl 
order by geograp_location_id
