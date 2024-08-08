select count(distinct(d.difecofi))
from open.diferido d
where d.difesusc = 66328617
and d.difeprog = 'GCNED'
and d.difesape > 0;