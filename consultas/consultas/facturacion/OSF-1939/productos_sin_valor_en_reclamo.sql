--consulta base 4
select sesususc , sesunuse , sesuserv,pr.product_status_id ,sesuesco , sesuesfn , sesucicl , sesucate 
from servsusc s 
left join pr_product pr on product_id =sesunuse 
where sesucicl = 201 
and ( select count (distinct cucocodi )
      from cuencobr br
      where cuconuse=sesunuse 
      and br.cucosacu> 0)=0 