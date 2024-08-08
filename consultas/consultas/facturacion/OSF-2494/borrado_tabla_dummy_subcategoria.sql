select * from ldc_coprsuca l where l.cpscubge=163 

create table ldc_coprsuca_sil (
cpsccons number(10), 
cpsccate number(2), 
cpscsuca number(2), 
cpscubge number(6), 
cpscanco number(4), 
cpscmeco number(2), 
cpscprod number(7), 
cpscprdi number(15,3), 
cpsccoto number(15,3)
)

insert into ldc_coprsuca_sil 
select *
from ldc_coprsuca l 
where l.cpscubge=163

DELETE FROM ldc_coprsuca  where cpscubge=163 