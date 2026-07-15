select * 
from pr_prod_suspension
where product_id = 10004212
for update

select *
from pr_comp_suspension
where component_id  in (3951888, 3951889)
for update
  

select *
from or_order_activity 
where product_id =  10004212
and order_id  = 228849990
for update

--Buscar componentes  
select c2.cmssidco  compomente, c2.cmsssesu   producto, c4.register_date  fecha_registro, c4.aplication_date aplicacion, c4.inactive_date Fecha_Inactivo,
c2.cmssescm  Estado_Componente, c3.description Desc_Estado_Componente,
c4.suspension_type_id  Tipo_Suspension, c4.active  Suspension_Activa
From compsesu  c2,
     ps_product_status c3,
     pr_comp_suspension c4
Where c2.cmssescm = c3.product_status_id
And   c2.cmssidco = c4.component_id
And  c2.cmsssesu = 10004212
