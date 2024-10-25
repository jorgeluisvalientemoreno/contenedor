--validar_cierre_producto
select *
from ic_cartcoco  c
where c.caccnuse in (1058785,1061866,1062663,1147674)
and   c.caccfege >= '27/08/2024'
order by c.caccfege desc
