select *
from servsusc s1, pr_product pr 
 where product_id = sesunuse and pr.product_status_id=1 and  sesuserv = 7014 and sesuesco =1  
 and not exists
( select null  from cuencobr br, servsusc s2  where br.cuconuse = s2.sesunuse   and s1.sesususc = s2.sesususc and cucosacu >= 0 ) 
and not exists ( select null from diferido where difesusc = sesususc and difesape >0)
and rownum <= 5 and sesususc >= 11111111
