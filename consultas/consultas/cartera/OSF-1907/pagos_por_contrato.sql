--pagos_por_contrato
select *
from open.pagos  p
where p.pagosusc = 1152829
order by p.pagofepa desc
