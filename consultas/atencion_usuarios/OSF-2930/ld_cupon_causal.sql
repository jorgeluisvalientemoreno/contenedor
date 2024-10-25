--cupon
select *
from cupon c
where /*c.cuposusc = 1121240
and  */ c.cupofech >= '22/07/2024';

--cupon_causal
select *
from ld_cupon_causal cc
where cc.package_id = 213269190
order by cc.cuponume desc

