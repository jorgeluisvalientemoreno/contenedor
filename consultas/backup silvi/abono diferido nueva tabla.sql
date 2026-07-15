select sesususc , sesunuse 
from servsusc 

select d.difesusc , difenuse , sesuserv , difecodi , difeconc , difesape , difefein , difefumo , difepldi 
from diferido d 
left join servsusc on sesususc = difesusc and sesunuse = difenuse 
where  difesusc in ( select contrato from  LDC_CONTABDI where  difesusc = contrato) 
and difesape > 0
and ( select (count (cargcuco) ) 
      from cargos 
      where cargnuse = difenuse
      and cargpefa= 102790 
      and cargconc in ( 31,130)
      and cargdoso not like '%pr-%') > 0 
and sesuserv = 7014      


select *
from ldc_osf_estaproc 
and proceso like '%PRGENERAABONDIFERIDO%'
order by p.fecha_inicial_ejec desc
