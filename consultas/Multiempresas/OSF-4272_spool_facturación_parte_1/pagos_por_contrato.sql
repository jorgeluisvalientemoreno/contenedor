--pagos_por_contrato
select p.pagosusc,
       p.pagoconc,
       p.
       p.pagosuba,
       p.pagobanc,
       p.pagofepa,
       p.pagovapa,
       p.pagofegr,
       p.pagousua
from open.pagos  p
where p.pagosusc in (66400648,66400614,48179410,48179399,48179448,1124917,2189062,67118511,48179411)
 and p.pagofegr >= '02/07/2025'
order by p.pagofegr desc 


--66400648,66400614,48179410,48179399,1124917,2189062,67118511,48179448,67325536,48179448
