select (select cucofact from cuencobr where cucocodi =cargcuco) "Factura",
       cargcuco "Cuenta de cobro",
       (select sesususc from servsusc where sesunuse = cargnuse) "Contrato", 
       cargnuse "Producto",
       cargconc || ' ' || initcap (concdesc)  as "Concepto",
       cargcaca || ' ' || initcap(cacadesc) " Causa",
       cargsign "Signo_cargo",
       cargpefa "Periodo_fact",
       cargvalo "Valor del cargo",
       cargdoso "Documento",
       cargfecr "Fecha_cargos",
       cargprog "Programa"
from cargos c
left join concepto t on  cargconc   = t.conccodi
left join servsusc on sesunuse = cargnuse 
left join causcarg on cacacodi = cargcaca
left join cupon on cuponume = cargcodo  
where sesususc = 66490843
and cargpefa =  103794
and sesuserv = 7053
and cargcaca in (15,51)