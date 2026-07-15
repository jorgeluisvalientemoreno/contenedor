select a.product_id,
       s.sesuplfa,
       ug.geograp_location_id,
       a.address_id,
       o.task_type_id,
       a.activity_id,
       t.description,
       a.package_id,
       o.order_id,
       o.order_status_id,
       ti.items_id,
       o.operating_unit_id,
       o.assigned_date,
       o.defined_contract_id,
       o.estimated_cost
  from or_order o
 inner join or_task_type t on o.task_type_id = t.task_type_id
  inner join or_order_activity a on a.order_id = o.order_id
  inner join servsusc  s  on s.sesunuse = a.product_id
  inner join ab_address  di  on di.address_id = o.external_address_id
  inner join ge_geogra_location  ug  on ug.geograp_location_id = di.geograp_location_id
  inner join or_task_types_items ti  on ti.task_type_id = o.task_type_id
 Where 1= 1
 and   o.order_status_id = 5
 and   o.operating_unit_id = 4639
 and ti.items_id in (10000089,100010659)
 and o.order_id = 336011450
 
 --10000089,100010218
 --100010659
 --10000089,10000096,10000228,10000245,10000368,10000577,10000729,10000860,10000946,10000988,10000995,10001088,10001217,10001253,10001292,10001497,10001858,10001972,10002055,10002501,10002823,10002825,10002826,10004232,10004271,10004297,10004344,10004367,10004997,10005019,10005082,10007791,10007792,10008472,10009008,10010550,10010816,10011399,10012056
 
--  and   s.sesuplfa not in (4,36, 41)
 
-- and o.task_type_id in (12153) 
/* and exists
   (select 1
   from open.or_ope_uni_item_bala b
   where b.operating_unit_id = o.operating_unit_id
   and  b.balance  > 0)
   order by o.created_date desc;

