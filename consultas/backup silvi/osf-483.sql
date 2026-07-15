select cargcuco,
       cargnuse ,
       cargconc ,
       concdesc ,
       cargcaca , 
       cargsign , 
       cargvalo , 
       cargpefa ,
        cargfecr 
from open.cargos 
left join open.concepto on conccodi = cargconc 
where cargnuse = 330372
and cargfecr > '11/10/2022'
order by cargfecr desc

--and cargconc in (840)
