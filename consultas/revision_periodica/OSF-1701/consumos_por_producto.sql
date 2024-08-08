--consumos_por_producto
select co.cosssesu "Producto",
       s.sesucate "Categoria",
       s.sesusuca "Subcategoria",
       co.cosspefa "Periodo_fact",
       co.cosspecs "Periodo_cons",
       s.sesucico "Ciclo",
       d.geograp_location_id || '-  ' || initcap(gl.display_description)  "Ciudad",
       co.cosscoca "Consumo",
       co.cossmecc  "Metodo",
       co.cossflli  "Flag_liq" ,
       co.cossidre "Id_regla",
       co.cosscavc "Regla_consumo",
       co.cossdico "Dias_consumo",
       co.cossfere "Fecha_consumo", cossfufa "funcion de calculo"
from open.conssesu co
left join open.servsusc  s on s.sesunuse =  co.cosssesu
left join open.pr_product  p on p.product_id =  co.cosssesu
left join open.ab_address d  on d.address_id = p.address_id
left join open.ge_geogra_location gl on gl.geograp_location_id = d.geograp_location_id
where co.cosssesu in (50303431)
and   co.cosspefa= 107378
order by co.cosssesu, cossfere desc
