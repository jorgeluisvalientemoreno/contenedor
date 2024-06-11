select pr.product_id  Producto, 
       pr.subscription_id  Contrato, 
       pr.product_type_id  Tipo_Producto, 
       pr.product_status_id || '-  ' || ps.description  Estado_Producto, 
       s.sesuesco || '-  ' || escodesc  Estado_Corte, 
       s.sesuesfn  Estado_Financiero,  
       p.register_date  Fecha_Registro, 
       p.suspension_type_id || '-  ' || st.description  Marca, 
       p.active  Activa, 
       a.task_type_id || '-  ' || tt.description  Tipo_Trabajo
from open.pr_product  pr
inner join open.servsusc  s on s.sesunuse = pr.product_id
inner join open.ps_product_status  ps on ps.product_status_id = pr.product_status_id
inner join open.estacort  ec on ec.escocodi = s.sesuesco
inner join open.pr_prod_suspension  p on p.product_id = pr.product_id
inner join open.ge_suspension_type  st on st.suspension_type_id = p.suspension_type_id
inner join open.or_order_activity  a on a.product_id = pr.product_id
inner join open.or_task_type  tt on tt.task_type_id = a.task_type_id
where a.order_activity_id = pr.suspen_ord_act_id
and p.suspension_type_id in (101, 102, 103, 104)
and pr.product_status_id = 2
and s.sesuesco != 5
and s.sesuesfn != 'C'
and a.task_type_id in (12457, 11029)
and p.active = 'Y'
and exists (select null 
from open.ldc_plazos_cert  c
where c.id_producto = pr.product_id
and c.plazo_maximo < sysdate)
order by p.register_date desc;