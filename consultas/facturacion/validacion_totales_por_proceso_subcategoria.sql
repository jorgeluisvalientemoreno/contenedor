select sesucate "Categoria",
       sesusuca "Subcategoria",
       cosspefa "Periodo fact",
       ab_address.geograp_location_id "localidad" ,
       initcap ( ge_geogra_location.description) "descripcion",
       count(distinct(cosssesu)) "Cant Producto",
       sum(nvl(cosscoca, 0)) "Consumo total",
       round (( (sum(nvl(cosscoca, 0))/count(distinct cosssesu))/29 ), 4)  "Consumo promedio diario"
from open.conssesu   c1
inner join open.servsusc on servsusc.sesunuse = c1.cosssesu
left join  pr_product on pr_product.product_id = servsusc.sesunuse
left join ab_address on pr_product.address_id = ab_address.address_id
left join ge_geogra_location  on ab_address.geograp_location_id= ge_geogra_location.geograp_location_id
where cossflli='S'
and sesuesfn <> 'C'
AND (cosscons <> -2 OR cosscoca = 0 )
and exists ( select null
             from conssesu c2 
             where c2.cosssesu= c1.cosssesu
             and c2.cossmecc = 1
             and c2.cosspefa= c1.cosspefa
             and c2.cossfere =  (select max(cossfere)
                                 from open.conssesu c3
                                 where c3.cosssesu = c1.cosssesu
                                 and c3.cosspefa = c1.cosspefa) ) 
group by sesucate , sesusuca,cosspefa, ab_address.geograp_location_id , ge_geogra_location.description ;
