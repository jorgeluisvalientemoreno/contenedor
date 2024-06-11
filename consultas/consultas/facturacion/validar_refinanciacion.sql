select count(distinct(d.difecofi))
from open.diferido d
where d.difeprog = 'GCNED'
and d.difesape > 0;