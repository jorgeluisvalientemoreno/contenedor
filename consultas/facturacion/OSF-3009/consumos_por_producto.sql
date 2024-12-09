select conssesu.cosssesu "Producto", pr_product.product_status_id "Estado prod",
       servsusc.sesucate "Categoria",   
       servsusc.sesuesfn "Estado_fina" ,  
       conssesu.cosspecs "Periodo_cons",
       servsusc.sesucico "Ciclo",  
       conssesu.cosscoca "Consumo",
       conssesu.cossmecc  "Metodo",       
       conssesu.cossidre "Id_regla",
       conssesu.cosscavc "Regla_consumo",    
       conssesu.cossfere "Fecha_consumo", cossfufa "funcion de calculo",conssesu.cossflli  "Flag_liq" ,
      ab_address.geograp_location_id || '-  ' || initcap(ge_geogra_location.display_description)  "Ciudad",   conssesu.cossdico "Dias_consumo",
        conssesu.cosspefa "Periodo_fact",
       servsusc.sesusuca "Subcategoria"
from open.conssesu 
left join open.servsusc on servsusc.sesunuse =  conssesu.cosssesu
left join open.pr_product on pr_product.product_id =  conssesu.cosssesu
left join open.ab_address  on ab_address.address_id = pr_product.address_id
left join open.ge_geogra_location on ge_geogra_location.geograp_location_id = ab_address.geograp_location_id
where conssesu.cosssesu = 6076921
order by cossfere desc
