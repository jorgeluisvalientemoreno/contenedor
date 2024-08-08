select 
dpttsesu,sum(case dpttsign when 'DB' then -dpttvano else dpttvano end) saldo
from ldc_deprtatt
where 1 = 1
and dpttconc = 130
and dpttsesu in (51988760,6128938,6138133,50557358)
group by  dpttsesu 
