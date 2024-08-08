select o.order_id,
       ot.task_type_id,
       ao.activity_id,
       t.description,
       ot.order_status_id,
       o.package_id,
       o.asignacion,
       o.asignado,
       o.ordeobse,
       o.ordefere,
       o.ordefebl,
       o.ordebloq
From ldc_order  o
inner join open.or_order  ot  on ot.order_id = o.order_id
inner join open.or_order_activity  ao  on ao.order_id = o.order_id
inner join open.or_task_type  t  on t.task_type_id = ot.task_type_id
where exists
(select null
        from open.ldc_package_type_oper_unit  uo
        where uo.items_id = ao.activity_id and uo.procesopre is null)
order by ot.created_date desc

