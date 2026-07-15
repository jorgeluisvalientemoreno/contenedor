select *
from LDC_CONCGRVF
where grupcodi = 18
for update ;


select l.grupcodi , l.grupdesc , cogrcodi , concdesc 
from open.ldc_grupvifa  l
inner join open.ldc_concgrvf a on l.grupcodi = a.grupcodi
left join open.concepto on cogrcodi = conccodi 
where  l.grupcodi = 13
and*/ */cogrcodi in ( 895, 936)  ;
