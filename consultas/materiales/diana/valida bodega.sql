select operating_unit_id, items_id, sum(balance) balance, sum(total_costs) total_costs,  (SELECT B.BALANCE FROM OPEN.OR_OPE_UNI_ITEM_BALA B WHERE B.OPERATING_UNIT_ID=M.OPERATING_UNIT_ID AND M.ITEMS_ID=B.ITEMS_ID) BALANCE_BODEGA,(SELECT B.TOTAL_COSTS FROM OPEN.OR_OPE_UNI_ITEM_BALA B WHERE B.OPERATING_UNIT_ID=M.OPERATING_UNIT_ID AND M.ITEMS_ID=B.ITEMS_ID) VALOR_BODEGA
from (
select 'CIERRE ENERO 2019' TIPO, operating_unit_id, items_id, balance, total_costs
from open.ldc_osf_salbitemp s 
where s.nuano=2019
  and s.numes=1
--  and s.operating_unit_id=&unidad
  and s.items_id=10004697

union all
select 'LEGALIZACION', o.operating_unit_id, oi.items_id, decode(oi.out_,'Y',-1,1)*oi.legal_item_amount, decode(oi.out_,'Y',-1,1)*oi.value
from open.or_order o
inner join open.or_order_items oi on oi.order_id=o.order_id
inner join open.ge_items i on i.items_id=oi.items_id
where o.order_id=oi.order_id
  and i.items_id=oi.items_id
  and i.item_classif_id in (3,8,21)
  and o.order_status_id=8
  and o.legalization_Date>='01/02/2019'
--  and o.operating_unit_id=&unidad
  and o.task_type_id!=0
and oi.items_id=10004697

union all
select 'TRASLADO',m.operating_unit_id, m.items_id, m.amount*-1 ,m.total_value*-1 
from open.or_uni_item_bala_mov m
where m.move_date>='01/02/2019'
  and m.movement_type='D'
  and m.item_moveme_caus_id=20
--  and m.operating_unit_id=&unidad
  and m.items_id=10004697
union all
select 'RECHAZO',m.operating_unit_id, m.items_id, m.amount ,m.total_value
from open.or_uni_item_bala_mov m, open.or_uni_item_bala_mov m2
where m.move_date>='01/02/2019'
  and m.movement_type='I'
  and m.item_moveme_caus_id=17
--  and m.operating_unit_id=&unidad  
  and m2.support_document=to_char(m.id_items_documento)
  and m2.items_id=m.items_id
  and nvl(m2.id_items_seriado,0)=nvl(m.id_items_Seriado,0)
  and m2.movement_type='N'
  and m2.item_moveme_caus_id=20
  and m.items_id=10004697

union all
select 'ACEPTACION',m.operating_unit_id, m.items_id, m.amount ,m.total_value
from open.or_uni_item_bala_mov m, open.or_uni_item_bala_mov m2
where m.move_date>='01/02/2019'
  and m.movement_type='I'
  and m.item_moveme_caus_id=16
  --and m.operating_unit_id=&unidad  
  and m2.support_document=to_char(m.id_items_documento)
  and m2.items_id=m.items_id
  and nvl(m2.id_items_seriado,0)=nvl(m.id_items_Seriado,0)
  and m2.movement_type='N'
  and m2.item_moveme_caus_id=20
  and m.items_id=10004697
union all
select 'DESCONOCIDO',m.operating_unit_id, m.items_id, m.amount, m.total_value
from open.or_uni_item_bala_mov m
where m.item_moveme_caus_id=15
  and m.movement_type='I'
  and m.id_items_documento is null
  -- and m.operating_unit_id=&unidad     
  and m.items_id=10004697
union all   
select 'DESPACHO SAP', m.operating_unit_id, m.items_id, m.amount, m.total_value
from open.or_uni_item_bala_mov m, open.ge_items_documento d
where m.item_moveme_caus_id=15
  and m.movement_type='I'
  and m.id_items_documento=d.id_items_documento   
  ---and m.operating_unit_id=&unidad       
  and m.items_id=10004697
  ) M
group by operating_unit_id, items_id    
