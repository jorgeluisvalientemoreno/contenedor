select p.cosssesu Producto,sesucate Categoria, sesusuca Subcategoria, sesuesco EstadoCort, product_status_id EstadoProd,sesuesfn EstadoFinan,sesucicl Ciclo, 
       p.cosspecs,task_type_id ,
       p.cosscoca consumo_pl,
       p.cossmecc metodo_pl,
       p.cosscavc regla_pl,
       c.cosscoca consumo_qh,
       c.cossmecc metodo_qh,
       c.cosscavc regla_qh,
       c.cossfufa cossfufa_qh,
       c.cossfere cossfere_qh , i.consumo_actual , i.consumo_promedio, i.desviacion_poblacional, i.tipo_desviacion 
from infopl_654 p
inner join conssesu c on p.cosssesu= c.cosssesu and   c.cosspecs = 107349 and c.cossmecc != 4
inner join servsusc s on  c.cosssesu = sesunuse 
inner join open.pr_product pr on pr.product_id = sesunuse and pr.subscription_id = sesususc 
inner  join info_producto_desvpobl i on i.producto= sesunuse and i.periodo_consumo = p.cosspecs 
where p.cosspecs  =107349 and task_type_id= 12617 and c.cossfere >='12/04/2024'
order by p.cosssesu 
