select conssesu.cosssesu "Producto",
       servsusc.sesucate "Categoria",
       servsusc.sesusuca "Subcategoria",
       conssesu.cosspefa "Periodo_fact",
       conssesu.cosspecs "Periodo_cons",
       servsusc.sesucico "Ciclo",
       ab_address.geograp_location_id || '-  ' || initcap(ge_geogra_location.display_description)  "Ciudad",
       conssesu.cosscoca "Consumo",
       conssesu.cossmecc  "Metodo",
       conssesu.cossflli  "Flag_liq" ,
       conssesu.cossidre "Id_regla",
       conssesu.cosscavc "Regla_consumo",
       conssesu.cossdico "Dias_consumo",
       conssesu.cossfere "Fecha_consumo", cossfufa "funcion de calculo"
from open.conssesu 
left join open.servsusc on servsusc.sesunuse =  conssesu.cosssesu
left join open.pr_product on pr_product.product_id =  conssesu.cosssesu
left join open.ab_address  on ab_address.address_id = pr_product.address_id
left join open.ge_geogra_location on ge_geogra_location.geograp_location_id = ab_address.geograp_location_id
where conssesu.cosssesu = 6096768
order by cossfere desc
