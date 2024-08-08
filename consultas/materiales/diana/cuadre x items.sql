with base as(
select 'SAP', to_number(dmititem) items_id, sum(dmitcant*decode(mmitnatu,'+',1,'-',-1,0)) cantidad, sum(dmitcant*dmitcoun*decode(mmitnatu,'+',1,'-',-1,0)) costo, 'N'
from open.ldci_intemmit, open.ldci_dmitmmit
where mmitnudo is not null
  and mmitdsap is not null 
  and mmitcodi=dmitmmit
  --and mmitfecr<'18/12/2018'
  --AND DMITITEM=10004590

group by dmititem
UNION
select 'VENTA', to_number(dmititem) items_id, sum(dmitcant*decode(mmitnatu,'+',1,'-',-1,0)) cantidad, sum(dmitcant*dmitcoun*decode(mmitnatu,'+',1,'-',-1,0)) costo, 'N'
from open.ldci_intemmit, open.ldci_dmitmmit
where mmitnupe is not null
  and mmitdsap is not null 
  and mmitcodi=dmitmmit
  --and mmitfecr<'18/12/2018'
  and exists(select null from open.ldci_seridmit where serimmit=mmitcodi and seridmit=dmitcodi)
  --AND DMITITEM=10004590
group by dmititem
union all
 SELECT 'MIGRACION',i.items_id, sum(a.eixbdisu), sum(a.eixbvlor),'N'
FROM MIGRA.LDC_TEMP_EXITEBOD_SGE A, MIGRA.LDC_MIG_CUADCONT B, open.ge_items i
WHERE A.EIXBBCUA = B.CUADCODI
  AND A.BASEDATO = B.BASEDATO
  --AND I.ITEMS_ID=10004590
  and nvl(migra.FNUGETITEMOSF_ROLLOUT(eixbitem, a.BASEDATO),0)=i.items_id
group by i.items_id
union all
select 'LEGALIZATION',oi.items_id, sum(legal_item_amount)* decode(nvl(OI.OUT_,'N'),'Y',-1,1), sum(value)* decode(nvl(OI.OUT_,'N'),'Y',-1,1), OI.OUT_
from open.or_order_items oi, open.ge_items i, open.or_order o
where oi.items_id=i.items_id
  and i.item_classif_id in (3,8,21)
  and o.order_id=oi.order_id
  and o.order_status_id=8
  and o.task_type_id!=0
  --and o.legalization_date<'18/12/2018'
  --AND OI.ITEMS_ID=10004590
  and OI.out_ in ('Y','N')
  group by oi.items_id, oi.out_
  union
  select 'AJUSTE', items_id, sum(decode(m.movement_type,'D',-1,'I',1,0)*amount), sum(decode(m.movement_type,'D',-1,'I',1,0)*total_value),'N'
from open.ge_document_type t, open.or_uni_item_bala_mov m, open.ge_items_documento d
where m.id_items_documento=d.id_items_documento
  and d.document_type_id=t.document_type_id
  and d.document_type_id in (112,113)
 -- AND ITEMS_ID=10004590
  group by ITEMS_ID 
  ),
 base2 as
 (select items_id, sum(balance) balance, sum(total_costs) total_costs
 from open.or_ope_uni_item_bala
 group by items_id
 )
select base.items_id, sum(cantidad),sum(costo), balance, total_costs
from base, base2
where base2.items_id=base.items_id
group by base.items_id, balance, total_costs;
