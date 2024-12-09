--validar_datos_del_predio
select p.product_id Producto, 
       p.subscription_id Contrato,
       ip.premise_id, 
       p.product_type_id Tipo_Producto, 
       s.sesucicl Ciclo, 
       s.sesuesco || '-  ' || ec.escodesc as Estado_Corte,
       s.sesuesfn,
       ip.predio_castigado,
       ad.address Direccion, 
       ip.multivivienda Multifamiliar,
       gl.geo_loca_father_id || '-  ' || gl.display_description as Departamento      
from open.pr_product  p
inner join open.ab_address  ad on ad.address_id = p.address_id
inner join open.ab_premise  ap on ap.premise_id = ad.estate_number
inner join open.ldc_info_predio ip on ip.premise_id = ap.premise_id
inner join open.ge_geogra_location  gl on gl.geograp_location_id = ad.geograp_location_id
inner join open.servsusc  s on s.sesunuse = p.product_id
inner join open.estacort  ec on ec.escocodi = s.sesuesco
where p.product_id in (38000956);


--update ldc_info_predio ip  set ip.predio_castigado = 'S' where ip.premise_id = 555490
