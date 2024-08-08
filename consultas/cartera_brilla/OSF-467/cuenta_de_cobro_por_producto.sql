select cucocodi  Cuenta_Cobro, 
       cuconuse  Producto, 
       cucosacu  Saldo_Pendiente, 
       cucovato  Valor_Total, 
       cucovaab  Valor_Abonado, 
       cucovare  Valor_Reclamo, 
       cucofeve  Fecha_Vencimiento
from open.cuencobr
where cuconuse = 52397800
order by cucofeve asc
