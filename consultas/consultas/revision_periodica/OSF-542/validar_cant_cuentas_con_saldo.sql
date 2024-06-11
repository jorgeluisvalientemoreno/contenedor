select cuconuse, 
       cucosacu, 
       cucovare,
       (nvl(cucosacu, 0) - nvl(cucovare, 0))saldo_pendiente
from open.cuencobr
where cuconuse = 14521279
and (nvl(cucosacu, 0) - nvl(cucovare, 0)) > 0
order by cucofeve desc ;