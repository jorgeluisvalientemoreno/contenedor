select (select cucofact from cuencobr where cucocodi =cargcuco) factura,
       (select sesususc from servsusc where sesunuse = cargnuse) contrato, 
       cargnuse,
       cargconc || ' ' || concdesc  as concepto,
       cargcaca || ' ' || cacadesc  causa,
       cargsign signo_cargo,
       cargpefa periodo_fact,
       cargvalo ,
       cargdoso documento,
       cargcodo, 
       cargunid,
       cargfecr fecha_cargos,
       cargprog programa
from cargos c
left join concepto t on  cargconc   = t.conccodi
left join servsusc on sesunuse = cargnuse 
left join causcarg on cacacodi = cargcaca
left join cupon on cuponume = cargcodo  
where sesususc = 66277800
and cargpefa =  103900
and sesuserv = 7055
and  cargdoso like '%DF%'
and cargconc in  (69,74,53,81,41,81) 

