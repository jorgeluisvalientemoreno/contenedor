select (select cucofact from cuencobr where cucocodi =cargcuco) factura,
       (select sesususc from servsusc where sesunuse = cargnuse) contrato, 
       cargnuse,
       cargconc || ' ' || concdesc  as concepto,
       cargcaca || ' ' || cacadesc  causa,
       cargsign ,
       cargpefa ,
       cargvalo,
       cargdoso ,
       cargcodo, 
       cuponume,
       cupofech,
       cargunid,
       cargfecr,
       cargprog 
from cargos c
left join concepto t on  cargconc   = t.conccodi
left join servsusc on sesunuse = cargnuse 
left join causcarg on cacacodi = cargcaca
left join cupon on cuponume = cargcodo  
where sesususc = 48057957
and cargpefa =  101559
and sesuserv = 7055 
and cargconc in  (145) 
and cargdoso in ('DF-93843519','ID-93843519')