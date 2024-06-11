select p.product_id  Producto, 
       p.subscription_id  Contrato, 
       p.product_type_id  Tipo_Producto, 
       p.category_id  Categoria,  
       gl.geo_loca_father_id || '-  ' || gl.display_description as Departamento
from open.pr_product  p
Inner join open.subcateg  cg on cg.sucacate = p.category_id
inner join open.cargos  c on c.cargnuse = p.product_id
inner join open.concepto  ct on ct.conccodi = c.cargconc
inner join open.ab_address di on di.address_id = p.address_id
inner join open.ge_geogra_location  gl on gl.geograp_location_id = di.geograp_location_id
where p.category_id = 1
and cg.sucacodi = 1
and gl.geo_loca_father_id = 3
and p.product_type_id = 7014
and c.cargconc = 196
group by p.product_id, p.subscription_id, p.product_type_id, p.category_id, p.subcategory_id, cg.sucadesc,
gl.geo_loca_father_id || '-  ' || gl.display_description;