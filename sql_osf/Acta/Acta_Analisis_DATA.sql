select oo.order_id,
       oo.legalization_date,
       oo.causal_id,
       (select a.class_causal_id
          from OPEN.GE_CAUSAL a
         where a.causal_id = oo.causal_id) Clasificacion --oo.task_type_id -- 
  from open.or_order oo
 inner join open.ge_causal gc
    on gc.causal_id = oo.causal_id
--and class_causal_id = 1
 where oo.is_pending_liq = 'Y'
   and oo.defined_contract_id = 10861
   and (select count(1)
          from OPEN.CT_ORDER_CERTIFICA a
         where a.order_id = oo.order_id) = 0
   and (select count(1)
          from OPEN.CT_EXCLUDED_ORDER b
         where b.order_id = oo.order_id) = 0
--and oo.legalization_date < '01/07/2025'
--and oo.task_type_id in (12626,12617,12626,10043)
-- group by oo.task_type_id
 order by oo.legalization_date desc;
select gc.*, rowid from open.ge_contrato gc where gc.id_contrato = 10861;

SELECT *
  FROM OPEN.CT_TASKTYPE_CONTYPE
 WHERE 1 = 1
      --and CONTRACT_TYPE_ID = 910
   and TASK_TYPE_ID in (12626, 12617, 12626, 10043);

SELECT CT_TASKTYPE_CONTYPE.TASK_TYPE_ID
  FROM open.CT_TASKTYPE_CONTYPE
 WHERE CT_TASKTYPE_CONTYPE.CONTRACT_ID = 10861;

select pc.*
  from open.ct_conpla_con_type pc
 where pc.contract_type_id = 910;

select pc.* from open.ct_conpla_con_type pc where pc.contract_id = 10861;

select a.*, rowid
  from OPEN.CT_CONDITIONS_PLAN a
 where a.conditions_plan_id = 36;

select a.*, rowid
  from OPEN.CT_PROCESS_LOG a
 where 1 = 1
   and a.contract_id = 10861
   and a.break_date >= '30/06/2025'
 order by a.log_date desc;

select *
  from open.CT_CONDITIONS_BY_PLAN pc, open.ct_simple_condition s
 where pc.conditions_plan_id = 36
   and pc.items_id = s.items_id;

select * from open.ge_base_administra;

select oou.*
  from open.or_operating_unit oou
 where oou.operating_unit_id = 3210;

SELECT /*+ use_nl(orders or_order_activity or_order_items ab_address)
                                                     index(OR_ORDER IDX_OR_ORDER21)
                                                     index(OR_ORDER_ACTIVITY IDX_OR_ORDER_ACTIVITY_05)
                                                     index(LECTELME IX_LECTELME03)
                                                     index(OR_ORDER_ITEMS PK_OR_ORDER_ITEMS)
                                                     index(AB_ADDRESS PK_AB_ADDRESS) */
 OR_ORDER.ORDER_ID,
 OR_ORDER.CAUSAL_ID,
 OR_ORDER.TASK_TYPE_ID,
 OR_ORDER.SAVED_DATA_VALUES,
 OR_ORDER.ORDER_STATUS_ID,
 OR_ORDER.IS_PENDING_LIQ,
 OR_ORDER.DEFINED_CONTRACT_ID,
 OR_ORDER.LEGALIZATION_DATE,
 OR_ORDER.EXTERNAL_ADDRESS_ID,
 OR_ORDER.OPERATING_UNIT_ID,
 OR_ORDER_ITEMS.ITEMS_ID,
 OR_ORDER_ITEMS.ORDER_ITEMS_ID,
 OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT,
 OR_ORDER_ITEMS.VALUE,
 OR_ORDER_ITEMS.TOTAL_PRICE,
 OR_ORDER_ACTIVITY.ACTIVITY_ID,
 OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID,
 OR_ORDER_ACTIVITY.VALUE_REFERENCE,
 AB_ADDRESS.GEOGRAP_LOCATION_ID,
 AB_ADDRESS.ADDRESS_ID
  FROM open.OR_ORDER,
       --open.TASKTYPES,
       open.GE_CAUSAL,
       open.OR_ORDER_ITEMS,
       open.AB_ADDRESS,
       open.OR_ORDER_ACTIVITY
 WHERE /*+ Ubicaci�n: CT_BCReads.GetOrdersToGroup SAO424459 */
 OR_ORDER_ACTIVITY.ORDER_ID = OR_ORDER.ORDER_ID
 AND OR_ORDER_ITEMS.ORDER_ID = OR_ORDER.ORDER_ID
 AND OR_ORDER_ITEMS.ORDER_ITEMS_ID = OR_ORDER_ACTIVITY.ORDER_ITEM_ID
 AND AB_ADDRESS.ADDRESS_ID =
 NVL(OR_ORDER_ACTIVITY.ADDRESS_ID, OR_ORDER.EXTERNAL_ADDRESS_ID)
 AND GE_CAUSAL.CLASS_CAUSAL_ID = 1 -- OR_BOCONSTANTS.CNUSUCCESSCAUSAL
 AND GE_CAUSAL.CAUSAL_ID = OR_ORDER.CAUSAL_ID
--AND TASKTYPES.TASK_TYPE_ID = OR_ORDER.TASK_TYPE_ID
 AND (OR_ORDER.SAVED_DATA_VALUES IS NULL OR
 OR_ORDER.SAVED_DATA_VALUES != 'ORDER_GROUPED' --CT_BCREADS.CSBGROUPEDTOKEN
 )
 AND OR_ORDER.ORDER_STATUS_ID = 8 --OR_BOCONSTANTS.CNUORDER_STAT_CLOSED
 AND OR_ORDER.IS_PENDING_LIQ = 'Y' --GE_BOCONSTANTS.CSBYES
 AND OR_ORDER.DEFINED_CONTRACT_ID = 10861 --INUCONTRACTID
--AND TRUNC(OR_ORDER.LEGALIZATION_DATE) <= '30/06/2025' --IDTMAXDATE
 ORDER BY TRUNC(OR_ORDER.LEGALIZATION_DATE);

SELECT *
  FROM open.or_order o
 inner join open.ge_causal gc
    on gc.causal_id = o.causal_id
   and class_causal_id = 1
 WHERE o.order_status_id = 8
   AND o.defined_contract_id = 10861
   AND o.IS_PENDING_LIQ = 'Y'
   AND (o.SAVED_DATA_VALUES IS NULL OR
       o.SAVED_DATA_VALUES != 'ORDER_GROUPED' --CT_BCREADS.CSBGROUPEDTOKEN
       )
   AND TRUNC(o.LEGALIZATION_DATE) < '01/07/2025';
