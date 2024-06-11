select cuconuse  Producto, sum (cucovare)  Valor_Reclamo
from open.cuencobr
where cuconuse = 50732225
group by cuconuse