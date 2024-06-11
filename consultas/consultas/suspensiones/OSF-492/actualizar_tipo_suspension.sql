--Actualizar tipo de suspensión
select *
from  open.pr_prod_suspension
where product_id = 10004212
for update ;

--Actualizar componentes de producto   
select *
from open.pr_comp_suspension
where component_id  in (3951888, 3951889)
for update ;

--Actualizar actividad y tipo de orden de suspension
select *
from open.or_order_activity
where product_id =  10004212
and order_id  = 228849990
for update; 
