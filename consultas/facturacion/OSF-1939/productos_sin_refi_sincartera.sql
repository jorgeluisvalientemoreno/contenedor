--consulta base
select sesususc , sesunuse , sesuserv,pr.product_status_id ,sesuesco , sesuesfn , sesucicl , sesucate 
from servsusc s 
left join pr_product pr on product_id =sesunuse 
where sesucicl = 201
and not exists ( select null from
                 diferido d 
                 where difesape > 0 
                 and d.difesusc =sesususc
                 and difeprog ='GCNED')
and not exists ( select null from 
                 ldc_osf_sesucier t 
                 where t.nuano=2023 and numes=10  
                 and t.producto=sesunuse 
                 and t.edad_deuda >= 90) 
order by sesususc 