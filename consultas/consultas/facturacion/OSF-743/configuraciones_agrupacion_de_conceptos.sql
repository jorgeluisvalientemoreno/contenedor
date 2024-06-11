select ldc_grupvifa.grupcodi , ldc_grupvifa.grupdesc , cogrcodi , concepto.concdesc 
from open.ldc_grupvifa  
inner join open.ldc_concgrvf  on ldc_grupvifa.grupcodi = ldc_concgrvf.grupcodi
left join concepto on cogrcodi = concepto.conccodi 
where  ldc_grupvifa.grupcodi = 21
and cogrcodi in ( 895, 936)  ;
