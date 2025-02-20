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
where s.sesunuse in (52989913)
order by p.pagofegr desc 


