select ldc_grupvifa.grupcodi , ldc_grupvifa.grupdesc , ldc_concgrvf.cogrcodi 
from open.ldc_grupvifa  
inner join open.ldc_concgrvf on ldc_grupvifa.grupcodi = ldc_concgrvf.grupcodi;
