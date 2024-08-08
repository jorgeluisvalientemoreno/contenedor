select p.product_id Producto, p.subscription_id Contrato, p.product_type_id Tipo_Producto, s.sesucicl Ciclo, 
s.sesuesco || '-  ' || ec.escodesc as Estado_Corte, ad.address Direccion, ip.multivivienda Multifamiliar,
gl.geo_loca_father_id || '-  ' || gl.display_description as Departamento
from pr_product  p
inner join ab_address  ad on ad.address_id = p.address_id
inner join ab_premise  ap on ap.premise_id = ad.estate_number
inner join ldc_info_predio ip on ip.premise_id = ap.premise_id
inner join ge_geogra_location  gl on gl.geograp_location_id = ad.geograp_location_id
inner join servsusc  s on s.sesunuse = p.product_id
inner join estacort  ec on ec.escocodi = s.sesuesco