  select sesususc contrato,  c.cosssesu producto ,product_status_id estaprod ,sesucate categ, sesusuca estrato,sesuesco estacort,sesuesfn estafina,
       c.cosspefa perifact,
       c.cosspecs pericons,
       c.cosscoca  consumo,
       c.cossfere fecha ,
       c.cossidre ,
       c.cosscavc regla,
       c.cossmecc metodo,cossdico dias_open, hcppcopr  consprom_open,
       i.consumo_actual consumo_normalizado , i.consumo_promedio, i.desviacion_poblacional, i.tipo_desviacion
from open.conssesu c
inner join servsusc on sesunuse =cosssesu
inner join open.pr_product on product_id =  cosssesu
left join open.hicoprpm  on  hcppsesu = cosssesu and hcpppeco  in (110877)  and hcpptico = 1
inner  join info_producto_desvpobl i on i.producto= sesunuse and i.periodo_consumo = c.cosspecs 
where c.cosspecs in (111295)
 and cossmecc in (1,3)
 and cosscavc <> 9 and  cossfere >='05/07/2024' and i.estado='A'
 order by cosssesu , cossfere desc
 
 ; 
select sesususc contrato, c.cosssesu producto ,product_status_id estaprod ,sesucate categ, sesusuca estrato,sesuesco estacort,sesuesfn estafina,
       c.cosspefa perifact,
       c.cosspecs pericons,
       c.cosscoca consumo,
       c.cossfere fecha ,
       c.cossidre ,
       c.cosscavc regla,
       c.cossmecc metodo,cossdico dias_open , hcppcopr  consprom_open
from open.conssesu c
inner join open.servsusc on sesunuse =cosssesu
inner join open.pr_product on product_id = cosssesu
left join open.hicoprpm  on  hcppsesu = cosssesu and hcpppeco in (&sbpericonsant) and hcpptico = 1
where c.cosspecs in (&sbpericonsact)
and cossmecc in (1,3) 
and cosscavc <> 9 --and  cossfere >='05/07/2024' 
and not exists ( select null from  open.info_producto_desvpobl i where i.producto= sesunuse and i.periodo_consumo = c.cosspecs) 
order by cosssesu , cossfere desc
