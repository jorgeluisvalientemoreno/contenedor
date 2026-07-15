--notificaiones_tipos_de_trabajo
select nt.id_not_ti_tra,
       nt.id_tipo_trabajo,
       tt.description,
       nt.id_notificacion,
       n.description,
       n.xsl_template_id,
       x.description,
       nt.config_expression_id,
       nt.orders_per_page
from or_notif_tipo_traba nt
 inner join  ge_notification  n  on n.notification_id = nt.id_notificacion
 inner join  or_task_type  tt  on tt.task_type_id = nt.id_tipo_trabajo
 inner join  ge_xsl_template x  on x.xsl_template_id = n.xsl_template_id
where nt.id_notificacion = 100376
