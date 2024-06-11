select ol.order_id, ol.order_status_id,ol.task_type_id,  og.order_id, og.created_date, a.package_id, a.instance_id
from open.or_related_order r, open.or_order og, open.or_order  ol, open.or_order_activity a
where rela_order_type_id=14
  and r.order_id=ol.order_id
  and r.related_order_id=og.order_id
  and og.created_date>='14/mar/2016'
  and ol.order_status_id!=8
  and a.order_id=ol.order_id
  --and a.package_id=40114360
  --and not exists(select null from open.or_order_activity a2 where a2.package_id=a.package_id and a2.instance_id=a.instance_id and status='R');
