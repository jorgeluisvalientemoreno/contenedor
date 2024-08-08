select cuconuse, 
       cucosacu,
       (nvl(cucosacu, 0) - nvl(cucovare, 0))saldo_pendiente,
       cucovare,
       cucofeve,
       sysdate fecha_actual,
       round (sysdate  - cucofeve) dias_transcurridos 
from open.cuencobr
where cuconuse =1112085
and cucosacu > 0
order by cucofeve desc 