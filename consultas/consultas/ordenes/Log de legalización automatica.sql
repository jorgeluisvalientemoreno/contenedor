select *
from open.reportes r, open.repoinco ri
where r.repoapli='LEGAJLOC'
 and r.repofech>='17/05/2022'
 and ri.reinrepo=r.reponume
 and reinval1=199214949
