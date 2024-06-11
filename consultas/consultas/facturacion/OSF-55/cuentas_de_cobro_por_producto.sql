select c.cucocodi  Cuenta_Cobro,
       c.cuconuse  Producto, 
       c.cucovato  Valor_Total, 
       c.cucosacu  Saldo_Pendiente, 
       f.factprog || '-  ' || p.procdesc Programa, 
       f.factfege  Fecha_Generacion
from open.cuencobr  c
inner join open.factura  f on f.factcodi = c.cucofact 
inner join open.procesos  p on p.proccons = f.factprog
where c.cuconuse = 1569832
order by c.cucocodi desc