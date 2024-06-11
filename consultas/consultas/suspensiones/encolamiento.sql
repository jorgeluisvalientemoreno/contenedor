select *
from OPEN.LDC_ORDEASIGPROC r
where r.oraoproc='ENCOCARTRP'
  AND ORAPSOGE=184628886;
  
select *
from open.reportes r, open.repoinco ri
where r.reponume=ri.reinrepo
  and r.repoapli='ENCOCARTRP'
