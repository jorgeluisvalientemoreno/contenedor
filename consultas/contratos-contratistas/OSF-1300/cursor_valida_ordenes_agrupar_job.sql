with tasktypes as
(
 select  or_task_type.task_type_id
 from    or_task_type
 where   instr(',12626,12617,12626,10043,' /*','|| :isbtasktypesid||','*/, concat(',',concat(to_char(or_task_type.task_type_id),','))) != 0
 union
 select  or_task_types_items.task_type_id
 from    or_task_types_items
 where   or_task_types_items.items_id in (/*ge_boitemsconstants.cnureadingactivity*/ 102008, /*cm_boconstants.cnubil_activity_reading*/ 4294337)
)
select /*+ use_nl(orders or_order_activity or_order_items ab_address)
         index(or_order idx_or_order21)
         index(or_order_activity idx_or_order_activity_05)
         index(lectelme ix_lectelme03)
         index(or_order_items pk_or_order_items)
         index(ab_address pk_ab_address) */
     or_order.order_id,
     or_order.causal_id,
     or_order.task_type_id,
     or_order.saved_data_values,
     or_order.order_status_id,
     or_order.is_pending_liq,
     or_order.defined_contract_id,
     or_order.legalization_date,
     or_order.external_address_id,
     or_order.operating_unit_id,
     or_order_items.items_id,
     or_order_items.order_items_id,
     or_order_items.legal_item_amount,
     or_order_items.value,
     or_order_items.total_price,
     or_order_activity.activity_id,
     or_order_activity.order_activity_id,
     or_order_activity.value_reference,
     ab_address.geograp_location_id,
     ab_address.address_id
from or_order,
     tasktypes,
     ge_causal,
     or_order_items,
     ab_address,
     or_order_activity
where /*+ ubicaci?n: ct_bcreads.getorderstogroup sao424459 */
     or_order_activity.order_id = or_order.order_id
 and or_order_items.order_id = or_order.order_id
 and or_order_items.order_items_id = or_order_activity.order_item_id
 and ab_address.address_id = nvl(or_order_activity.address_id, or_order.external_address_id)
 and ge_causal.class_causal_id = /*or_boconstants.*/1 --:cnusuccesscausal
 and ge_causal.causal_id = or_order.causal_id
 and tasktypes.task_type_id = or_order.task_type_id
 and (or_order.saved_data_values is null or
      or_order.saved_data_values != /*ct_bcreads.csbgroupedtoken */'ORDER_GROUPED' )
 and or_order.order_status_id = /*or_boconstants.cnuorder_stat_closed */8 --
 and or_order.is_pending_liq = /*ge_boconstants.csbyes */'Y'
 and or_order.defined_contract_id = 8521 --:inucontractid
 and trunc(or_order.legalization_date) <= sysdate /*:idtmaxdate*/
 order by trunc(or_order.legalization_date)
