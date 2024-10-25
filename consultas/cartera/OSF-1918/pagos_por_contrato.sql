--pagos_por_contrato
select p.pagosusc,
       s.sesunuse,
       p.pagoconc,
       p.pagosuba,
       p.pagobanc,
       p.pagofepa,
       p.pagovapa,
       p.pagofegr,
       p.pagousua
from open.pagos  p
 inner join servsusc  s  on p.pagosusc = s.sesususc
where s.sesunuse in (13000636)
order by p.pagofegr desc 





-->= '20/07/2024'



--for update

/*select *
from servsusc  ss
where ss.sesunuse in (8093482)

select *
from cargos  c
where c.cargnuse = 8093482
and   c.cargfecr >= '20/04/2024'
order by '20/04/2024' desc
for update*/
