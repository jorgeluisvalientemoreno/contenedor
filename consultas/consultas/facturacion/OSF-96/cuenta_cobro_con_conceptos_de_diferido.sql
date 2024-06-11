select c.cargcuco  Cuenta_Cobro, 
       c.cargnuse  Producto, 
       c.cargconc || ' - ' || cp.concdesc as Concepto, 
       c.cargcaca || ' - ' || ca.cacadesc  Causa, 
       c.cargunid  Unidades, 
       c.cargvalo Valor, 
       p.pefaano  Ano, 
       p.pefames  Mes
from open.cargos  c
inner join open.concepto  cp on cp.conccodi = c.cargconc
inner join open.causcarg  ca on ca.cacacodi = c.cargcaca
inner join open.perifact  p on c.cargpefa = p.pefacodi
where c.cargnuse = 50040735
and c.cargcaca = 51
order by p.pefaano desc