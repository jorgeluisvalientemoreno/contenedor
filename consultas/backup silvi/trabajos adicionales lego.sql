select *
from LDC_TIPOTRABADICLEGO
where tipotrablego_id = 11259
for update  ;

select *
from  LDC_TIPOTRABLEGO
where tipotrablego_id = 11259 ; 

select *  
from open.LDC_ITEM_UO_LR 
where unidad_operativa = 3615
and actividad = 4000039 
for update ; 

select *
from ge_list_unitary_cost
where 

Select *
From OPEN.GE_LIST_UNITARY_COST  l
where list_unitary_cost_id in (3812)
For Update;
