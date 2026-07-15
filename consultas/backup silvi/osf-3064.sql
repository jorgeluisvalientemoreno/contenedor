select distinct(cucofact ), cargfecr, cuconuse
from  cargos c
inner join cuencobr on cucocodi= cargcuco 
inner join mo_packages m on  'PP-'||m.package_id=c.cargdoso
where m.package_type_id= 100229
and  m.motive_status_id=14 
order by cargfecr desc
;

--select * from ps_package_type p where package_type_id = 100229

select c.*
from open.cargos c
inner join open.cuencobr on cargcuco = cucocodi
where cucofact = 2132345253 ;

select * from factura where factcodi= 2132345253

 --2132186194 ;
