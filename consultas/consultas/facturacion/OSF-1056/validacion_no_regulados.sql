select subscription_id "Contrato",
       product_id "Product",
       sesucate "Categoria",
       sesusuca "Sub-Categoria",
       sesucate || ' - ' || Initcap(su.sucadesc) "Categoria",
       p.product_type_id "Tipo de producto",
       product_status_id "Estado",
       a.geograp_location_id || ' - ' || initcap (ge.description) "Localidad",
       a.address "Direccion"
from pr_product p
left join ab_address a on p.address_id = a.address_id
left join ge_geogra_location ge on ge.geograp_location_id = a.geograp_location_id
left join servsusc s on sesunuse = product_id 
left join subcateg su on sucacate = sesucate and su.sucacodi= sesusuca
where subscription_id = 67323008
and product_type_id not in( 3,6121);