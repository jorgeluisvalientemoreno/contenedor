--ordenes_lectura
select a.product_id,
       sg.geograp_location_id,
       s.sesucate,
       s.sesucicl,
       sg.operating_sector_id,
       so.description,
       o.task_type_id,
       t.description,
       o.order_id,
       o.order_status_id,
       o.operating_unit_id,
       up.name,
       up.operating_zone_id,
       zo.description,
       o.created_date,
       o.assigned_date,
       eo.user_id,
       eo.terminal,
       o.legalization_date,
       us.order_id,
       us.package_id,
       us.asignacion,
       us.asignado,
       us.ordeobse,
       us.ordefere,
       us.ordefebl,
       us.ordebloq
  from or_order o
 inner join or_task_type t on o.task_type_id = t.task_type_id
  left join or_order_stat_change  eo  on eo.order_id =  o.order_id and eo.initial_status_id = 0 and eo.final_status_id = 5
  left join ldc_order  us  on us.order_id = o.order_id
  left join or_order_activity a on a.order_id = o.order_id
  left join  or_operating_unit up  on up.operating_unit_id = o.operating_unit_id
  left join pr_product  p  on p.product_id = a.product_id
  left join servsusc s on s.sesunuse = a.product_id
  left join ab_address  d  on  d.address_id = p.address_id
  left join ab_segments sg  on sg.segments_id = d.segment_id
  left join or_operating_sector  so  on so.operating_sector_id = sg.operating_sector_id
  left join or_operating_zone  zo  on zo.operating_zone_id = up.operating_zone_id
 Where o.task_type_id = 12617
   and o.order_status_id in (0,5,11)
   --and sg.operating_sector_id  in (748)
    and s.sesucicl = 5502
   /*and not exists
    (select null from conf_uo_usu_especiales  ue  where ue.ciclo =  s.sesucicl and ue.sector_operativo = sg.operating_sector_id)*/
 order by o.order_status_id desc 



   -- and o.created_date = '3/12/2024'
    --and sg.operating_sector_id  in (748/*691, 8479, 679, 644, 703*/)
