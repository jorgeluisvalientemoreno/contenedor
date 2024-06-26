      With base as(select 
    a.operating_unit_id,
    u.name, 
    u.es_externa EXTERNA,
    a.items_id, 
    i.description desc_item,
    i.item_classif_id clasificacion,
    a.balance, act.balance cant_act, inv.balance cant_inv,
    a.total_costs, act.total_costs cost_act, inv.total_costs cost_inv,
    A.TRANSIT_IN,
    A.TRANSIT_OUT,
    CASE WHEN (I.ITEMS_ID LIKE '4%' OR I.ITEMS_ID IN (10004070)) AND act.balance IS NULL AND inv.balance IS NULL THEN 'S1'
         WHEN (I.ITEMS_ID LIKE '4%' OR I.ITEMS_ID IN (10004070)) AND (act.balance IS NOT NULL AND inv.balance IS NOT NULL) THEN 'N1'
         WHEN es_externa ='Y' and  i.item_classif_id=21 and a.total_costs=0 and i.items_id not in (10004070) AND act.balance IS NULL AND inv.balance IS NULL THEN 'S2'
         WHEN es_externa ='Y' and  i.item_classif_id=21 and a.total_costs=0 and i.items_id not in (10004070) AND (act.balance IS NOT  NULL OR inv.balance IS NOT NULL) THEN 'S2'
         WHEN (I.ITEMS_ID in (10004070)) AND (A.BALANCE-NVL(ACT.BALANCE,0)-NVL(INV.BALANCE,0)=0) THEN 'S3'
         WHEN (I.ITEMS_ID in (10004070)) AND (A.BALANCE-NVL(ACT.BALANCE,0)-NVL(INV.BALANCE,0)!=0) THEN  'N3'
         WHEN (I.ITEM_CLASSIF_ID=3 AND (A.BALANCE-NVL(INV.BALANCE,0)=0)) THEN 'S6'  
         WHEN I.ITEM_CLASSIF_ID=3 AND (A.BALANCE-NVL(INV.BALANCE,0)!=0) THEN 'N6'
         WHEN (es_externa ='N' OR  i.item_classif_id!=21 ) AND (A.BALANCE-NVL(ACT.BALANCE,0)-NVL(INV.BALANCE,0)=0) AND A.TOTAL_COSTS!=0 THEN 'S4'
         WHEN (es_externa ='N' OR  i.item_classif_id!=21  ) AND (A.BALANCE-NVL(ACT.BALANCE,0)-NVL(INV.BALANCE,0)!=0) AND A.TOTAL_COSTS!=0 THEN 'N4' 
         WHEN (es_externa ='N' OR  i.item_classif_id!=21 ) AND ((A.BALANCE-NVL(ACT.BALANCE,0)-NVL(INV.BALANCE,0)=0) OR (ACT.BALANCE IS NULL AND INV.BALANCE IS NULL)) AND A.TOTAL_COSTS=0 THEN 'S5'
         WHEN (es_externa ='N' OR  i.item_classif_id!=21  ) AND (A.BALANCE-NVL(ACT.BALANCE,0)-NVL(INV.BALANCE,0)!=0) AND (ACT.BALANCE IS NOT NULL OR  INV.BALANCE IS NOT NULL) AND A.TOTAL_COSTS=0 THEN 'N5'   
         ELSE 'N'
    END CORRECTO
    from OPEN.OR_OPE_UNI_ITEM_BALA a
    inner join open.or_operating_unit u on a.operating_unit_id=u.operating_unit_id and u.operating_unit_id = 4247
    inner join open.ge_items i on i.items_id=a.items_id and a.items_id = 10004070
    left join open.ldc_act_ouib act on a.items_id=act.items_id and a.operating_unit_id=act.operating_unit_id
    left join open.ldc_inv_ouib inv on a.items_id=inv.items_id and a.operating_unit_id=inv.operating_unit_id
    where (
    a.balance!=nvl((inv.balance), 0)+ nvl((act.balance),0)
    or 
    a.total_costs!=nvl((inv.total_costs), 0)+ nvl((act.total_costs),0)
    )
   
)
select *
from base
where substr(correcto,1,1)='N'

    ;
