select pr_product.product_id  "Producto",ab_address.address_id,
       case when pr_product.product_id is null then 'Sin ocupar'
            when pr_product.product_id is not null then 'Ocupado' end  "Predio ocupado",
       ab_address.geograp_location_id || '-  ' || initcap(ge_geogra_location.display_description)  "Ciudad",
       ab_address.neighborthood_id || '-  ' || initcap(gl.description)  "Barrio",
       ab_address.address_parsed  "Direccion",
       ab_address.estate_number  "Predio",
       ab_premise.premise_type_id ||'- '|| initcap(ab_premise_type.description)  "Tipo de predio",
       case when ab_address.is_urban = 'Y' then 'Si'
            when ab_address.is_urban = 'N' then 'N' end  "Es urbana", 
       case when ab_info_premise.is_ring = 'Y' then 'Si'
            when ab_info_premise.is_ring = 'N' then 'No' end  "Esta anillado", 
       ab_info_premise.level_risk ||'- '|| initcap(ldc_level_risk.descripcion_riesgo)  "Nivel de riesgo",
       case when ldc_level_risk.es_vendible = 'Y' then 'Si'
            when ldc_level_risk.es_vendible = 'N' then 'No' end  "Es factible",
       case when ldc_info_predio.pno = 0 then 'Sin fraude'
            when ldc_info_predio.pno is null then 'Sin fraude'
            when ldc_info_predio.pno = 1 then 'Con fraude' end  "Predio con fraude",
       ldc_info_predio.predio_castigado  "Castigado",
       ab_premise.category_ ||'- '|| initcap(categori.catedesc)  "Categoria", 
       ab_premise.subcategory_ ||'- '|| initcap(open.subcateg.sucadesc)  "Subcategoria",
       ab_segments.ciclcodi,
       ldc_info_predio.ldc_info_predio_id
from open.ab_address
left join open.ab_premise on ab_address.estate_number  = ab_premise.premise_id 
left join open.ab_info_premise on ab_info_premise.premise_id = ab_address.estate_number
left join open.ldc_info_predio on ldc_info_predio.premise_id = ab_info_premise.premise_id 
left join open.ge_geogra_location on ge_geogra_location.geograp_location_id = ab_address.geograp_location_id
left join ge_geogra_location  gl on gl.geograp_location_id = ab_address.neighborthood_id
left join open.ab_premise_type on ab_premise_type.premise_type_id = ab_premise.premise_type_id
left join open.categori on categori.catecodi = ab_premise.category_
left join open.subcateg on subcateg.sucacate = ab_premise.category_
left join open.ldc_level_risk on ldc_level_risk.nivel_riesgo = ab_info_premise.level_risk
left join open.pr_product on pr_product.address_id = ab_address.address_id
left join ab_segments  on ab_address.segment_id = ab_segments.segments_id
where subcateg.sucacodi = ab_premise.subcategory_
and (select count(1) from open.suscripc where suscripc.susciddi = ab_address.address_id) = 0
and ab_address.address not in ('KR MTTO CL MTTO - 0', 'RECAUDO PAGO NACIONAL', 'KR GENERICA CL GENERICA - 0')
and ab_premise.premise_type_id is not null 
and ab_info_premise.is_ring = 'Y'
and not exists(
select null from open.pr_product
where pr_product.address_id = ab_address.address_id
and pr_product.product_type_id in ('7055','7056'))
and ldc_info_predio.pno is null
and ldc_info_predio.predio_castigado = 'N'
and ldc_level_risk.es_vendible = 'Y'
and  pr_product.product_id is null
and ab_premise.category_ = 1
and ab_premise.subcategory_ = 1
and ab_segments.ciclcodi = 7524
and ab_premise.premise_type_id = 2
--and ab_address.address_id = 2029190;
