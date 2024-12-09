-- Diferencia productos facturables que se marcan con el parametro en null, pero no con el parametro con 3 meses
select *
from ldc_susp_autoreco_qh j
inner join pr_product  p on p.product_id = j.saresesu
inner join servsusc on sesunuse=j.saresesu
where not exists
(select null
from ldc_susp_autoreco j2
where j2.saresesu = j.saresesu)
--group by j.sareproc, sesuesco
