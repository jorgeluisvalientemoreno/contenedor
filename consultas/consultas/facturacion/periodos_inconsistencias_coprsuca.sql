select category_id, 
       subcategory_id,
       a.geograp_location_id, 
       pefaano, 
       pefames, 
       cosspefa
from open.conssesu
inner join open.pr_product p on product_id = cosssesu
inner join open.ab_address a on p.address_id = a.address_id
inner join open.perifact on  cosspefa = pefacodi
inner join open.procejec pj on pj.prejcope = pefacodi
where  prejprog = 'FGCC'
and not exists (select 'x' 
                from coprsuca 
                where cpsccate = category_id 
                and cpscsuca = subcategory_id 
                and cpscubge = a.geograp_location_id 
                and cpscanco = pefaano
                and cpscmeco = pefames)
group by category_id, subcategory_id, a.geograp_location_id, pefaano, pefames, cosspefa
order by pefaano desc


