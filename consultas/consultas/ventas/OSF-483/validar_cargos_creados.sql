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
where cargnuse = 503024
and cargfecr > '10/10/2022'
order by cargfecr desc