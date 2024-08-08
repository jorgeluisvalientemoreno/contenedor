select *
from procejec  p
where p.prejprog in ('FGCA', 'FGCC', 'FGFC')
and   p.prejcope = 101942
order by p.prejfech desc
