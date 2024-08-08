select c.cargcuco  Cuenta_Cobro, 
       c.cargnuse  Producto, 
       c.cargconc || ' - ' || cp.concdesc as Concepto, 
       c.cargcaca || ' - ' || ca.cacadesc  Causa, 
       c.cargsign  Signo, 
       c.cargfecr  Fecha_Creacion, 
       c.cargvalo Valor, 
       c.cargprog || ' - ' || pc.procdesc  Programa
from open.cargos  c
inner join open.concepto  cp on cp.conccodi = c.cargconc
inner join open.causcarg  ca on ca.cacacodi = c.cargcaca
inner join open.procesos  pc on pc.proccons = c.cargprog 
where c.cargcuco = 1099580825