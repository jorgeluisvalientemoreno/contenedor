select p.product_id Producto,
       p.subscription_id Contrato,
       p.product_type_id Tipo_Producto,
       s.sesucicl Ciclo,
       s.sesuesco || '-  ' || ec.escodesc as Estado_Corte,
       ad.address Direccion,
       ip.multivivienda Multifamiliar,
       gl.geo_loca_father_id || '-  ' || gl.display_description as Departamento
  from open.pr_product p
 inner join open.ab_address ad
    on ad.address_id = p.address_id
 inner join open.ab_premise ap
    on ap.premise_id = ad.estate_number
 inner join open.ldc_info_predio ip
    on ip.premise_id = ap.premise_id
 inner join open.ge_geogra_location gl
    on gl.geograp_location_id = ad.geograp_location_id
 inner join open.servsusc s
    on s.sesunuse = p.product_id
 inner join open.estacort ec
    on ec.escocodi = s.sesuesco
 where p.subscription_id = 67263594;
select a.*, rowid
  from OPEN.LDC_INFO_PREDIO a
 where a.multivivienda = 19739;

select p.product_id||',' Producto,
       p.subscription_id Contrato,
       p.product_type_id Tipo_Producto,
       s.sesucicl Ciclo,
       s.sesuesco || '-  ' || ec.escodesc as Estado_Corte,
       ad.address Direccion,
       ip.multivivienda Multifamiliar,
       gl.geo_loca_father_id || '-  ' || gl.display_description as Departamento
  from open.pr_product p
 inner join open.ab_address ad
    on ad.address_id = p.address_id
 inner join open.ab_premise ap
    on ap.premise_id = ad.estate_number
 inner join open.ldc_info_predio ip
    on ip.premise_id = ap.premise_id
 inner join open.ge_geogra_location gl
    on gl.geograp_location_id = ad.geograp_location_id
 inner join open.servsusc s
    on s.sesunuse = p.product_id
 inner join open.estacort ec
    on ec.escocodi = s.sesuesco
 where ip.multivivienda =19739
 and p.product_type_id = 7014 
 ;
