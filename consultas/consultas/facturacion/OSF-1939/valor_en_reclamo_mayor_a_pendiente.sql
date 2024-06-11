--consulta base 3
select sesususc , sesunuse , sesuserv,pr.product_status_id ,sesuesco , sesuesfn , sesucicl , sesucate 
from servsusc s 
left join pr_product pr on product_id =sesunuse 
where sesucicl = 201 
and exists ( select null 
      from cuencobr br
      where br.cuconuse=sesunuse 
      and br.cucosacu> 0
      and cucovare >cucosacu )-->=2 
and ( select count (distinct br1.cucocodi )
      from cuencobr br1
      where br1.cuconuse=sesunuse 
      and br1.cucosacu> 0)>=2 