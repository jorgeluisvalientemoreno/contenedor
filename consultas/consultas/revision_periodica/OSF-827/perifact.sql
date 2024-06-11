select *
from perifact p
where p.pefacicl = 521
and   p.pefaano >= 2022
order by p.pefafimo asc
for update
