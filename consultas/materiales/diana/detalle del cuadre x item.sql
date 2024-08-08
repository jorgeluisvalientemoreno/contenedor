select 'SAP', to_number(dmititem) items_id, sum(dmitcant*decode(mmitnatu,'+',1,'-',-1,0)) cantidad, sum(dmitcant*dmitcoun*decode(mmitnatu,'+',1,'-',-1,0)) costo, 'N', mmitesta, mmitnudo
from open.ldci_intemmit, open.ldci_dmitmmit
where mmitnudo is not null
  and mmitdsap is not null 
  and mmitcodi=dmitmmit
  --and mmitfecr<'18/12/2018'
  AND DMITITEM=10004257


group by dmititem, mmitesta, mmitnudo
;
select 'VENTA', to_number(dmititem) items_id, sum(dmitcant*decode(mmitnatu,'+',1,'-',-1,0)) cantidad, sum(dmitcant*dmitcoun*decode(mmitnatu,'+',1,'-',-1,0)) costo, 'N'
from open.ldci_intemmit, open.ldci_dmitmmit
where mmitnupe is not null
  and mmitdsap is not null 
  and mmitcodi=dmitmmit
  --and mmitfecr<'18/12/2018'
  and exists(select null from open.ldci_seridmit where serimmit=mmitcodi and seridmit=dmitcodi)
  AND DMITITEM=10004257

group by dmititem
;
 SELECT 'MIGRACION',i.items_id, sum(a.eixbdisu), sum(a.eixbvlor),'N'
FROM MIGRA.LDC_TEMP_EXITEBOD_SGE A, MIGRA.LDC_MIG_CUADCONT B, open.ge_items i
WHERE A.EIXBBCUA = B.CUADCODI
  AND A.BASEDATO = B.BASEDATO
  AND I.ITEMS_ID=10004257

  and nvl(migra.FNUGETITEMOSF_ROLLOUT(eixbitem, a.BASEDATO),0)=i.items_id
group by i.items_id
;
select 'LEGALIZATION',oi.order_id, oi.items_id, sum(legal_item_amount)* decode(nvl(OI.OUT_,'N'),'Y',-1,1) cantidad, sum(value)* decode(nvl(OI.OUT_,'N'),'Y',-1,1) valor, o.task_type_id, t.description,
       i2.items_id, i2.description, o.operating_unit_id, o.legalization_Date, oi.serial_items_id
from open.or_order_items oi, open.ge_items i, open.or_order o, open.or_task_type t, open.or_order_activity a, open.ge_items i2
where oi.items_id=i.items_id
  and i.item_classif_id in (3,8,21)
  and o.task_type_id!=0
  and o.order_id=oi.order_id
  and o.order_status_id=8
  --and o.legalization_date<'18/12/2018'
  AND OI.ITEMS_ID=10004257

  and o.order_id=a.order_id
  and a.activity_id=i2.items_id
  and nvl(OI.out_,'N') is not null
  and o.task_type_id=t.task_type_id
  group by oi.items_id, oi.out_, oi.order_id, o.task_type_id, t.description, i2.items_id, i2.description, o.operating_unit_id, o.legalization_Date,oi.serial_items_id
;
  select 'AJUSTE', items_id, sum(decode(m.movement_type,'D',-1,'I',1,0)*amount), sum(decode(m.movement_type,'D',-1,'I',1,0)*total_value),'N'
from open.ge_document_type t, open.or_uni_item_bala_mov m, open.ge_items_documento d
where m.id_items_documento=d.id_items_documento
  and d.document_type_id=t.document_type_id
  and d.document_type_id in (112,113)
  AND ITEMS_ID=10004257

  group by ITEMS_ID ;
  
    
