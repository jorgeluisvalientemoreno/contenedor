-- Validaci�n productos por proceso
select a.sareproc, count (a.saresesu)
from ldc_susp_autoreco_sj  a
where a.sareproc = 7
group by a.sareproc
