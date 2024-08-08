--validar con la orden agrupadora las individuales hay varias pero creo que esta lo resume
--validaciones
with base as
 (select o.order_id,
         a.activity_id,
         o.task_type_id,
         o.legalization_date,
         o.operating_unit_id,
         o.defined_contract_id,
         di.geograp_location_id,
         oi.items_id,
         oi.legal_item_amount,
         oi.value
         
    from open.or_order o
   inner join open.or_order_activity a
      on a.order_id = o.order_id
   inner join open.ab_address di
      on di.address_id = nvl(o.external_address_id, a.address_id)
   inner join open.or_order_items oi on oi.order_id=o.order_id and (oi.order_items_id = a.order_item_id or oi.order_activity_id= a.order_activity_id)
   where o.order_id = 305897979)

select base.*, o.order_id, a.activity_id,oi.items_id,
         oi.legal_item_amount,
         oi.value
  from base
 inner join open.or_order o
    on o.task_type_id = base.task_type_id
   and o.operating_unit_id = base.operating_unit_id
   and o.defined_contract_id = base.defined_contract_id
   and trunc(o.legalization_date) = trunc(base.legalization_date)
   and o.order_status_id=8
   and (o.saved_data_values is null or
       o.saved_data_values != 'ORDER_GROUPED')
 inner join open.or_order_activity a
    on o.order_id = a.order_id
   and a.activity_id = base.activity_id
 inner join open.ab_address di
    on di.address_id = nvl(o.external_address_id, a.address_id)
   and di.geograp_location_id = base.geograp_location_id
   inner join open.or_order_items oi on oi.order_id=o.order_id and (oi.order_items_id = a.order_item_id or oi.order_activity_id= a.order_activity_id) and oi.items_id=base.items_id;
