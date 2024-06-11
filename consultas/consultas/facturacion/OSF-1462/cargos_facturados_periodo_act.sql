select cargcuco,cucofact, cargnuse ,sesuserv , cargconc, cargcaca, concdesc , cargvalo,cargpefa,sesucicl 
from cargos
left join cuencobr on cucocodi = cargcuco 
left join servsusc on cargnuse = sesunuse 
left join concepto on cargconc = conccodi
where  cargpefa = 105240 and sesususc   = 1023068 and cargcaca in (15,51)  and sesuserv =7053
;
