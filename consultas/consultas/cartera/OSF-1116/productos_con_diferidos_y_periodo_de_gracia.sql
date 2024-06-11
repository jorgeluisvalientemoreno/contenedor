select difesusc "contrato", count(distinct difenuse) "cant de productos"
from diferido
left join servsusc on sesususc = difesusc 
where difesape > 0
and sesuserv= 7014 
and exists (select null from ldc_contabdi l where l.contrato = difesusc)
and  exists ( select null from cargos where cargnuse = difenuse and cargconc in (31,130) and cargpefa= 103689 and cargcaca in (15,59))
group by difesusc
having count(distinct difenuse) > 1