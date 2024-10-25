--comparar_cargos
select *
from cargos  c
where c.cargnuse  in (1999601)
and   c.cargconc in (24,811)
and    cargcuco = 3060429894
order by cargsign desc, cargconc;

select *
from cargos  c
where c.cargnuse  in (50561675)
and   c.cargconc in (24,811)
and    cargcuco = 3040477732
order by cargsign desc, cargconc;


--buscar_cargos
select *
from cargos
where cargconc = 24
and   cargdoso like '%PP-%'
and   cargusua = 1
and   rownum <=10;

