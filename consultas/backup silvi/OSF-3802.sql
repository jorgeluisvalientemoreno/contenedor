select sesususc , c.*
from cargos c , servsusc ,cuencobr
where cargnuse = sesunuse
and cucocodi = cargcuco
and cargconc = 291 
and cucosacu>0 
and cargfecr >='01/01/2023'   --and sesususc = 67536751 
order by cargfecr desc
