SELECT l.*
FROM open.LOG_LDC_PROCIERRAOTVISITACERTI l, open.or_order o
where num_order is not null
and o.order_id=num_order
and o.order_status_id!=8;

