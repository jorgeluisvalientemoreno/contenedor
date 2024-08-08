select c.cargcuco  Cuenta_Cobro, 
       c.cargnuse  Producto, 
       c.cargconc || ' - ' || cp.concdesc as Concepto, 
       c.cargcaca  Causa, 
       c.cargunid  Unidades, 
       c.cargvalo Valor, 
       p.pefaano  Ano, 
       p.pefames  Mes
from open.cargos  c
inner join open.concepto  cp on cp.conccodi = c.cargconc
inner join open.perifact  p on c.cargpefa = p.pefacodi
where c.cargnuse = 1131855
and c.cargconc in (31,196)
and c.cargcaca = 15
and c.cargunid > 20
order by p.pefaano desc