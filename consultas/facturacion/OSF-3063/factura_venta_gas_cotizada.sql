select distinct(cucofact ), cuconuse , m.package_id , m.package_type_id ,m.motive_status_id
from  cargos c
inner join cuencobr on cucocodi= cargcuco 
inner join mo_packages m on  'PP-'||m.package_id=c.cargdoso
where m.package_type_id = 100229
and  m.motive_status_id=14 