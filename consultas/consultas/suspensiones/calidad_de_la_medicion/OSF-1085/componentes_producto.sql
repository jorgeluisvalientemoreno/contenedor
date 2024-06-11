select c2.cmssidco  compomente, 
       c2.cmsssesu   producto, 
       c4.register_date  fecha_registro, 
       c4.aplication_date aplicacion, 
       c4.inactive_date Fecha_Inactivo,
       c2.cmssescm  Estado_Componente, 
       c3.description Desc_Estado_Componente,
       c4.suspension_type_id  Tipo_Suspension, 
       c4.active  Suspension_Activa
from open.compsesu  c2
inner join open.ps_product_status c3 on c2.cmssescm = c3.product_status_id
inner join open.pr_comp_suspension c4 on c2.cmssidco = c4.component_id
where c2.cmsssesu = 50069432
and   c4.active = 'Y'
