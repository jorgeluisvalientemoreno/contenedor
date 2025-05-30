--consumos_por_producto
select  
       distinct co.cosspefa "Periodo_fact",
       s.sesucico "Ciclo",
       co.cosspecs "Periodo_cons",
       co.cosssesu "Producto",
       co.cosscoca "Consumo",
       co.cossmecc  "Metodo",
       co.cossflli  "Flag_liq"
from open.conssesu co
left join open.servsusc  s on s.sesunuse =  co.cosssesu
left join open.pr_product  p on p.product_id =  co.cosssesu
left join open.ab_address d  on d.address_id = p.address_id
left join open.ge_geogra_location gl on gl.geograp_location_id = d.geograp_location_id
where co.cossmecc = 4 
and   co.cossflli = 'N'
and not exists (select 1 
             from procejec pf
             where pf.prejcope = co.cosspefa
              and pf.prejprog in ('FGCC')
           and pf.prejespr = 'T')
and rownum <= 10 
group by   co.cosssesu, co.cosspefa, co.cosspecs,  s.sesucico, co.cosscoca, co.cossmecc, co.cossflli
--order by co.cosssesu, cossfere desc
