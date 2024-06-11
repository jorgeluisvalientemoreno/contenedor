select pp.product_id  producto, 
       pp.subscription_id  contrato, 
       pp.product_type_id  tipo_prod, 
       pp.product_status_id  estado_Producto, 
       ss.sesuesfn  estado_financiero, 
       ss.sesuesco  estado_corte, 
       ps.suspension_type_id  Tipo_Suspension, 
       ps.active  Activa, 
       ps.register_date  fecha_registro,
       ps.aplication_date  Fecha_Aplicacion, 
       ps.inactive_date  Fecha_Inactividad
from open.pr_product  pp
inner join open.pr_prod_suspension ps on pp.product_id = ps.product_id
inner join open.servsusc ss on pp.product_id = ss.sesunuse
where pp.product_type_id = 7014
and   ss.sesuesco = 3
and   pp.product_status_id = 2
and   pp.product_id = 1115621
and   ps.active = 'Y'
order by ps.aplication_date desc;