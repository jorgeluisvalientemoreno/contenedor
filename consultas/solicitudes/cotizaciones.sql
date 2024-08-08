select CO.QUOTATION_ID, CO.PACKAGE_ID, CO.TOTAL_ITEMS_VALUE, co.total_disc_value, CO.TOTAL_TAX_VALUE, CO.INITIAL_PAYMENT,
 ITEM_COTIZA.ITEMS_ID, ITEM_COTIZA.UNIT_VALUE, ITEM_COTIZA.UNIT_TAX_VALUE,
 T.CONCEPT
from OPEN.CC_QUOTATION CO, OPEN.CC_QUOTATION_ITEM ITEM_COTIZA, OPEN.OR_TASK_TYPE T
WHERE PACKAGE_ID=12335097
  AND CO.QUOTATION_ID=ITEM_COTIZA.QUOTATION_ID
  AND T.TASK_TYPE_ID=ITEM_COTIZA.TASK_TYPE_ID;
  
select o.order_id, activity_id, legalization_date,class_causal_id, concept
from open.or_order_activity a, open.or_order o, open.ge_causal c, open.or_task_type t
where a.order_id=o.order_id
  and o.causal_id=c.causal_id
  and package_id=12335097
  and class_causal_id=1
  and t.task_type_id=o.task_type_id
  and activity_id in (select ITEM_COTIZA.ITEMS_ID
from OPEN.CC_QUOTATION CO, OPEN.CC_QUOTATION_ITEM ITEM_COTIZA
WHERE co.PACKAGE_ID=a.package_id
  AND CO.QUOTATION_ID=ITEM_COTIZA.QUOTATION_ID);





select *
from open.cc_quoted_work qw
where qw.quotation_id=19538 ;
select *
from open.cc_quotation q
where q.quotation_id=19538 ;
select *
from open.cc_quotation_item qi
where qi.quotation_id=19538 ;
select *
from open.cc_quot_financ_cond cc
where cc.quotation_id=19538 ;

select *
from open.ldc_cotizacion_comercial  co
where co.sol_cotizacion=183495386

select *
from OPEN.LDC_ITEMS_COTIZACION_COM  cm, open.ge_items i
where cm.id_cot_comercial=5547
  and cm.id_item=i.items_id;
