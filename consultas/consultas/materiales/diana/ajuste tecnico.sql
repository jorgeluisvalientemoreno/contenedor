with base as
(select d.operating_unit_id,m.id_items_documento, m.items_id, m.amount amount_neutro, m.total_value valor_neutro, m2.amount amount_decremento, m2.total_value valor_decremento, m.support_document,
       d2.documento_externo, mmitnudo,
       case when m.id_items_seriado is not null then 1  else dmitcant end *decode(mmitnatu,'+',1,'-',-1) cantidad_Sap,
       dmitcoun*decode(mmitnatu,'+',1,'-',-1) costo_unitario_Sap,
       case when m.id_items_seriado is not null then 1  else dmitcant end *dmitcoun*decode(mmitnatu,'+',1,'-',-1) costo_sap,
       m2.id_items_Seriado
from open.ge_items_documento d, open.or_uni_item_bala_mov m, open.or_operating_unit u, open.or_uni_item_bala_mov m2,
     open.ge_items_documento d2, open.ldci_intemmit, open.ldci_dmitmmit
where d.id_items_documento=m.id_items_documento
  and d.document_type_id=105
  --and m.move_date>='01/07/2017'
  and m.movement_type='N'
  and m2.movement_type='D'
  and u.operating_unit_id=d.destino_oper_uni_id
  and u.oper_unit_classif_id=11
  and m2.id_items_documento=m.id_items_documento
  and m2.items_id=m.items_id
 -- and m.id_items_documento=418997
  and nvl(m2.id_items_seriado,0)=nvl(m.id_items_seriado,0)
  --and m.total_value/m.amount!=m2.total_value/m2.amount
  and m.support_document!=' '
  and m.support_document!='0'
  and d2.id_items_documento=to_number(m.support_document)
  and d2.documento_externo=mmitdsap
  and mmitcodi=dmitmmit
  and dmititem=m.items_id
  --AND MMITFECR<'01/01/2019'
 -- and not exists(select null from open.or_uni_item_bala_mov_copia2 c where c.uni_item_bala_mov_id=m2.uni_item_bala_mov_id)
 -- and mmitnudo='418997'
  --and m.items_id=10003861
  --and round(dmitcoun*m2.amount)!=round(m2.total_value)
  --group by  m.id_items_documento, m.items_id
  /*union all
  select d.operating_unit_id,m.id_items_documento, m.items_id, m.amount amount_neutro, m.total_value valor_neutro, m2.amount amount_decremento, m2.total_value valor_decremento, m.support_document,
       d2.documento_externo, mmitnudo,
       case when m.id_items_seriado is not null then 1  else dmitcant end *decode(mmitnatu,'+',1,'-',-1) cantidad_Sap,
       dmitcoun*decode(mmitnatu,'+',1,'-',-1) costo_unitario_Sap,
       case when m.id_items_seriado is not null then 1  else dmitcant end *dmitcoun*decode(mmitnatu,'+',1,'-',-1) costo_sap,
       m2.id_items_Seriado
from open.ge_items_documento d, open.or_uni_item_bala_mov m, open.or_operating_unit u, open.or_uni_item_bala_mov_copia2 m2,
     open.ge_items_documento d2, open.ldci_intemmit, open.ldci_dmitmmit
where d.id_items_documento=m.id_items_documento
  and d.document_type_id=105
  --and m.move_date>='01/07/2017'
  and m.movement_type='N'
  and m2.movement_type='D'
  and u.operating_unit_id=d.destino_oper_uni_id
  and u.oper_unit_classif_id=11
  and m2.id_items_documento=m.id_items_documento
  and m2.items_id=m.items_id
  --and m.id_items_documento=418997
  and nvl(m2.id_items_seriado,0)=nvl(m.id_items_seriado,0)
  --and m.total_value/m.amount!=m2.total_value/m2.amount
  and m.support_document!=' '
  and m.support_document!='0'
  and d2.id_items_documento=to_number(m.support_document)
  and d2.documento_externo=mmitdsap
  and mmitcodi=dmitmmit
  and dmititem=m.items_id*/
  )
  select operating_unit_id, items_id, id_items_documento,id_items_Seriado, sum(amount_neutro), amount_decremento, sum(cantidad_Sap),
         sum(valor_neutro),valor_decremento, sum(costo_sap)
  from base
  group by operating_unit_id, items_id, id_items_documento, amount_decremento, valor_decremento, id_items_Seriado
