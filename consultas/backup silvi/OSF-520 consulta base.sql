select cargcuco,
       subscription_id,
       cargnuse,
       product_type_id,
       cargconc,
       cargcaca,
       cargsign,
       cargpefa,
       cargvalo,
       cargdoso,
       cargfecr 
from cargos c
inner join pr_product on product_id = cargnuse 
where cargcuco <> -1 
and cargvalo > 0 
and cargpefa in (99445)
--and subscription_id in (17176106) 
and (select count(distinct(d.difecofi))
     from open.diferido d
     where  d.difenuse = cargnuse
     and d.difeprog != 'GCNED'
     and d.difesape > 0)  > 0 
and (select count(distinct(d.difecofi))
     from open.diferido d
     where  d.difenuse = cargnuse
     and d.difeprog = 'GCNED'
     and d.difesape > 0)  > 0    
order by cargfecr desc   


/*select count(distinct(d.difecofi))
     from open.diferido d
     where  d.difenuse = cargnuse
     and d.difeconc in (193) 
     and d.difesape > 0) >1  
     
     98940,99336,99732,98408,98858,99254,99732 */
