select items_id, sum(balance), sum(total_costs), (SELECT SUM(B.BALANCE) FROM OPEN.OR_OPE_UNI_ITEM_BALA B WHERE B.ITEMS_ID=M.ITEMS_ID) BALANCE, (SELECT SUM(B.TOTAL_COSTS) FROM OPEN.OR_OPE_UNI_ITEM_BALA B WHERE B.ITEMS_ID=M.ITEMS_ID) VALOR
from (
select 'CIERRE ENERO 2019' TIPO, operating_unit_id, items_id, balance, total_costs
from open.ldc_osf_salbitemp s 
where s.nuano=2019
  and s.numes=1
--  and s.operating_unit_id=&unidad
 -- and s.items_id=10000925
  
UNION ALL  
select  'TRANSITO CIERRE ENERO', OR_UNI_ITEM_BALA_MOV.OPERATING_UNIT_ID, OR_UNI_ITEM_BALA_MOV.ITEMS_ID,OR_UNI_ITEM_BALA_MOV.AMOUNT, OR_UNI_ITEM_BALA_MOV.TOTAL_VALUE
  from  OPEN.OR_UNI_ITEM_BALA_MOV,
        OPEN.OR_OPE_UNI_ITEM_BALA,
        OPEN.GE_ITEMS_SERIADO,
        OPEN.GE_ITEMS,
        OPEN.GE_ITEMS_DOCUMENTO
 where  OR_UNI_ITEM_BALA_MOV.ITEMS_ID = GE_ITEMS.ITEMS_ID
   and  OR_UNI_ITEM_BALA_MOV.ITEMS_ID = OR_OPE_UNI_ITEM_BALA.ITEMS_ID
   and  OR_UNI_ITEM_BALA_MOV.OPERATING_UNIT_ID = OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID
   and  OR_UNI_ITEM_BALA_MOV.MOVEMENT_TYPE = 'N' 
   and  OR_UNI_ITEM_BALA_MOV.ID_ITEMS_DOCUMENTO = GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO
   and  OR_UNI_ITEM_BALA_MOV.SUPPORT_DOCUMENT = ' '
   and  OR_UNI_ITEM_BALA_MOV.ID_ITEMS_SERIADO = GE_ITEMS_SERIADO.ID_ITEMS_SERIADO (+)
   AND GE_ITEMS_DOCUMENTO.FECHA<TO_DATE('31/01/2019','DD/MM/YYYY') + 1
   --and ge_items.items_id=10000925
   AND  OR_uni_item_bala_mov.item_moveme_caus_id in (15, --ge_boItemsConstants.cnuCausalEntFactCompra
                                                     6,  --ge_boItemsConstants.cnuCausalTranslate,
                                                     20) --ge_boItemsConstants.cnuMovCauseTrans)
UNION ALL
SELECT 'TRANSITO CIERRE ENERO', OR_UNI_ITEM_BALA_MOV.OPERATING_UNIT_ID, OR_UNI_ITEM_BALA_MOV.ITEMS_ID,OR_UNI_ITEM_BALA_MOV.AMOUNT, OR_UNI_ITEM_BALA_MOV.TOTAL_VALUE
  from  OPEN.OR_UNI_ITEM_BALA_MOV,
        OPEN.OR_OPE_UNI_ITEM_BALA,
        OPEN.GE_ITEMS_SERIADO,
        OPEN.GE_ITEMS,
        OPEN.GE_ITEMS_DOCUMENTO,
        OPEN.GE_ITEMS_DOCUMENTO D2
 where  OR_UNI_ITEM_BALA_MOV.ITEMS_ID = GE_ITEMS.ITEMS_ID
   and  OR_UNI_ITEM_BALA_MOV.ITEMS_ID = OR_OPE_UNI_ITEM_BALA.ITEMS_ID
   and  OR_UNI_ITEM_BALA_MOV.OPERATING_UNIT_ID = OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID
   and  OR_UNI_ITEM_BALA_MOV.MOVEMENT_TYPE = 'N' 
   and  OR_UNI_ITEM_BALA_MOV.ID_ITEMS_DOCUMENTO = GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO
   and  OR_UNI_ITEM_BALA_MOV.SUPPORT_DOCUMENT !=' '
   and  OR_UNI_ITEM_BALA_MOV.ID_ITEMS_SERIADO = GE_ITEMS_SERIADO.ID_ITEMS_SERIADO (+)
   AND GE_ITEMS_DOCUMENTO.FECHA< TO_DATE('31/01/2019','DD/MM/YYYY') + 1
   AND D2.ID_ITEMS_DOCUMENTO=OR_UNI_ITEM_BALA_MOV.SUPPORT_DOCUMENT
   AND D2.FECHA>=TO_DATE('31/01/2019','DD/MM/YYYY') + 1
    --  and ge_items.items_id=10000925
   AND  OR_uni_item_bala_mov.item_moveme_caus_id in (15, --ge_boItemsConstants.cnuCausalEntFactCompra
                                                     6,  --ge_boItemsConstants.cnuCausalTranslate,
                                                     20) --ge_boItemsConstants.cnuMovCauseTrans)
                                                     
UNION ALL
SELECT 'TRANSITO CIERRE ENERO', OR_UNI_ITEM_BALA_MOV.OPERATING_UNIT_ID, OR_UNI_ITEM_BALA_MOV.ITEMS_ID,OR_UNI_ITEM_BALA_MOV.AMOUNT, OR_UNI_ITEM_BALA_MOV.TOTAL_VALUE
  from  OPEN.OR_UNI_ITEM_BALA_MOV,
        OPEN.OR_OPE_UNI_ITEM_BALA,
        OPEN.GE_ITEMS_SERIADO,
        OPEN.GE_ITEMS,
        OPEN.GE_ITEMS_DOCUMENTO,
        OPEN.GE_ITEMS_DOCUMENTO D2,
        OPEN.ge_items_doc_rel R
 where  OR_UNI_ITEM_BALA_MOV.ITEMS_ID = GE_ITEMS.ITEMS_ID
   and  OR_UNI_ITEM_BALA_MOV.ITEMS_ID = OR_OPE_UNI_ITEM_BALA.ITEMS_ID
   and  OR_UNI_ITEM_BALA_MOV.OPERATING_UNIT_ID = OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID
   and  OR_UNI_ITEM_BALA_MOV.MOVEMENT_TYPE = 'N' 
   and  OR_UNI_ITEM_BALA_MOV.ID_ITEMS_DOCUMENTO = GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO
   and  OR_UNI_ITEM_BALA_MOV.SUPPORT_DOCUMENT ='0'
   and  OR_UNI_ITEM_BALA_MOV.ID_ITEMS_SERIADO = GE_ITEMS_SERIADO.ID_ITEMS_SERIADO (+)
   AND  GE_ITEMS_DOCUMENTO.FECHA< TO_DATE('31/01/2019','DD/MM/YYYY') + 1
   AND  D2.FECHA>=TO_DATE('31/01/2019','DD/MM/YYYY') + 1
   AND  D2.ID_ITEMS_DOCUMENTO=R.ID_ITEMS_DOC_ORIGEN
   AND  GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO=R.ID_ITEMS_DOC_DESTINO
   AND  R.ID_ITEMS_DOC_ORIGEN!=R.ID_ITEMS_DOC_DESTINO
   AND  OR_uni_item_bala_mov.item_moveme_caus_id in (15, --ge_boItemsConstants.cnuCausalEntFactCompra
                                                     6,  --ge_boItemsConstants.cnuCausalTranslate,
                                                     20) --ge_boItemsConstants.cnuMovCauseTrans)                                                        


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
  and oi.out_='Y'
  and oi.rowid not in ('AACI5dAETAAJgvEAAF')
  --and oi.items_id=10000925
union all
select 'MOVIMIENTOS SAP SUMINSTRO', d.operating_unit_id, to_number(dmititem), decode(mmitnatu,'+',1,'-',-1,0)*dmitcant, decode(mmitnatu,'+',1,'-',-1,0)*dmitcant*dmitcoun
from open.ldci_intemmit, open.ldci_dmitmmit di, open.ge_items_documento d
where mmitcodi=dmitmmit
 and mmitnudo=to_char(d.id_items_documento)
 and mmitdsap is not null
 and mmitfecr>='01/02/2019'
 and di.rowid not in ('AACI0AAFdAABiy9AAR','AACI0AAFcAABcvwAAb','AACI0AAFcAABcvwAAa') --AJUSTES EN EL MEMORANDO POR MAL PROCEDIMIENTO DE ALMACEN Y NANCY LUGO
-- and dmititem='10000925'
 
union all
select 'MOVIMIENTOS SAP VENTA', t.trsmunop, to_number(dmititem), decode(mmitnatu,'+',1,'-',-1,0)*dmitcant, decode(mmitnatu,'+',1,'-',-1,0)*dmitcant*dmitcoun
from open.ldci_intemmit, open.ldci_dmitmmit, open.ldci_transoma t,open.ge_items i
where mmitcodi=dmitmmit
 and mmitnupe='GDC-'||T.TRSMCODI
 and mmitdsap is not null
 and mmitfecr>='01/02/2019'
 and i.items_id=dmititem
 and i.item_classif_id=21
-- and dmititem='10000925'
 
union all
select 'TRANSITO',m.operating_unit_id, m.items_id, -1*amount, -1*m.total_value
FROM OPEN.OR_UNI_ITEM_BALA_MOV M
WHERE M.MOVEMENT_TYPE='N'
  and M.ITEM_MOVEME_CAUS_ID IN (6,15,20)
  AND M.SUPPORT_DOCUMENT=' ' 
  --AND M.MOVE_DATE>='01/02/2019'
  --and m.items_id=10000925
  
union all
select 'SOPORTE TECNICO', M.OPERATING_UNIT_ID, M.ITEMS_ID, DECODE(M.MOVEMENT_TYPE,'D',-1,'I',1,0)* AMOUNT, DECODE(M.MOVEMENT_TYPE,'D',-1,'I',1,0)* DECODE(M.UNI_ITEM_BALA_MOV_ID,3322424, 515032 ,TOTAL_VALUE) total_value
from open.or_uni_item_bala_mov m
where m.movement_type in ('I','D')  
  and m.item_moveme_caus_id in (28,29)
  AND M.MOVE_DATE>='01/02/2019'
--  and m.items_id=10000925
UNION ALL
select 'AJUSTE', M.OPERATING_UNIT_ID, M.ITEMS_ID, DECODE(M.MOVEMENT_TYPE,'D',-1,'I',1,0)* AMOUNT, DECODE(M.MOVEMENT_TYPE,'D',-1,'I',1,0)* TOTAL_VALUE
from open.or_uni_item_bala_mov m
where m.movement_type in ('I','D')  
  and m.item_moveme_caus_id=19
  AND M.MOVE_DATE>='01/02/2019'
 -- and m.items_id=10000925
 
UNION ALL
select 'DATAFIX', M.OPERATING_UNIT_ID, M.ITEMS_ID, DECODE(M.MOVEMENT_TYPE,'D',-1,'I',1,0)* AMOUNT, DECODE(M.MOVEMENT_TYPE,'D',-1,'I',1,0)* TOTAL_VALUE
from open.or_uni_item_bala_mov m
where m.movement_type in ('I','D')  
  and m.item_moveme_caus_id=-1
  AND M.MOVE_DATE>='01/02/2019'
 -- and m.items_id=10000925 
 ) M
 group by items_id
