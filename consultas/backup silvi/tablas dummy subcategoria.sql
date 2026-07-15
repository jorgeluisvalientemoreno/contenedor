select *
from open.hicoprpm
where hicoprpm.hcppsesu  = 17022958
for update 

DELETE FROM hicoprpm where hcppsesu  = 50641341
update open.hicoprpm set hcppcopr = 0 where hcppsesu  = 50641341

create table hicoprpm_sil 
(hcppsesu number(10) , hcpptico number(4)  ,hcppcopr  number(15,3) , hcpppeco  number(15) ,hcppcons  number(10)  ) 

insert into hicoprpm
(hcppsesu  , hcpptico ,hcppcopr   , hcpppeco ,hcppcons  ) 
select *
from hicoprpm_sil
where hcppsesu  = 50641341

;
select *
from  hicoprpm_sil 
where hcppsesu  = 50559509


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
