-- estado_solicitudes
select p.product_id,
      s.package_id  "# Solicitud",
       s.package_type_id || '-  ' || ts.description as "Tipo de solicitud",
       p.motive_status_id || '-  ' || e.description as "Estado Motivo",
       s.cust_care_reques_num  "Interaccion",
       s.reception_type_id || '-  ' || mr.description  "Medio de recepcion",
       s.request_date   "Fecha de registro",
       s.attention_date   "Fecha de atencion",
       p.annul_date,
       o.task_type_id || '-  ' || initcap(tt.description)  "Tipo de trabajo",
       o.order_id  "Orden",
       o.order_status_id || ' - ' || oe.description as "Estado orden",
       s.comment_
from open.mo_packages  s
left join open.mo_motive p on p.package_id = s.package_id
left join open.pr_product  pr on pr.product_id = p.product_id
left join open.ps_motive_status e on s.motive_status_id = e.motive_status_id
left join open.ps_package_type ts on ts.package_type_id = s.package_type_id
left join open.or_order_activity  a on a.package_id = s.package_id
left join open.or_order o on o.order_id = a.order_id
left join open.or_order_status oe on o.order_status_id = oe.order_status_id
left join open.or_task_type tt on tt.task_type_id = o.task_type_id
left join open.ge_reception_type  mr on mr.reception_type_id = s.reception_type_id
where s.package_id in (206933521, 206933522)
order by s.package_id asc;
