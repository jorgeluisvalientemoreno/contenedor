
select  null tipo_documento,'RESERVA' description,  d.operating_unit_id, dmitcoin, decode(MMITTIMO,'Z14','A','Z13','A','Z01','I','Z02','I','Z03','I','Z04','I') TIPO, sum(decode( mmitnatu,'+',1,'-',-1,0)*dmitcant) cantidad
from open.ldci_intemmit, open.ldci_dmitmmit, open.ge_items_documento d
where mmitcodi=dmitmmit
  and mmitnudo=to_char(d.id_items_documento)
  and dmitcoin=&item
  and d.operating_unit_id=&nuunidad
  and mmitdsap is not null
  and mmitesta=2
  and d.document_type_id!=105
 group by  d.operating_unit_id, dmitcoin, decode(MMITTIMO,'Z14','A','Z13','A','Z01','I','Z02','I','Z03','I','Z04','I')
 union all

select  null tipo_documento,'PEDIDO' description,  d.trsmunop, dmitcoin, 'I' TIPO, sum(decode( mmitnatu,'+',1,'-',-1,0)*dmitcant) cantidad
from open.ldci_intemmit, open.ldci_dmitmmit, open.ldci_transoma d
where mmitcodi=dmitmmit
  and mmitnupe ='GDC-'||to_char(d.trsmcodi)
  and dmitcoin=&item
  and d.trsmunop=&nuunidad
  and mmitdsap is not null
  and mmitesta=2
 group by  d.trsmunop, dmitcoin, 'I'

 union all
   SELECT  null tipo_documento, 'MIGRACION' description,  B.CUADHOMO, nvl(migra.FNUGETITEMOSF_ROLLOUT(eixbitem, a.BASEDATO),0) item, eixbtipo, sum(eixbdisu)
       FROM MIGRA.LDC_TEMP_EXITEBOD_SGE A, MIGRA.LDC_MIG_CUADCONT B
      WHERE A.EIXBBCUA = B.CUADCODI
        AND A.BASEDATO = B.BASEDATO
        and nvl(migra.FNUGETITEMOSF_ROLLOUT(eixbitem, a.BASEDATO),0)=&item
        and B.CUADHOMO=&nuunidad
        group by B.CUADHOMO, nvl(migra.FNUGETITEMOSF_ROLLOUT(eixbitem, a.BASEDATO),0) , eixbtipo

 union all        

select o.task_type_id tipo_documento, null description, o.operating_unit_id unidad, oi.items_id,  tb.warehouse_type,  sum(DECODE(NVL(oi.out_,'Y'),'Y',-1,0)*oi.legal_item_amount)
from open.or_order o, open.or_order_items oi, open.LDC_TT_TB tb
where o.operating_unit_id=&nuunidad
  and oi.order_id=o.order_id
  and oi.items_id= &item     
  and tb.task_type_id=o.task_type_id
  AND NOT EXISTS(SELECT NULL FROM OPEN.GE_ITEMS_DOCUMENTO D, OPEN.OR_UNI_ITEM_BALA_MOV MOV WHERE DOCUMENTO_EXTERNO=TO_CHAR(O.ORDER_ID) AND MOV.ID_ITEMS_DOCUMENTO=D.ID_ITEMS_DOCUMENTO AND D.DOCUMENT_TYPE_ID=118 AND MOVEMENT_TYPE!='N' and MOV.ITEMS_ID=OI.ITEMS_ID)
  and not exists(select null from open.or_order_activity a where a.order_id=oi.order_id and a.activity_id=102400)
  group by  o.task_type_id,oi.out_, tb.warehouse_type, o.operating_unit_id , oi.items_id
  
  union all
  
  
  select  D.document_type_id, t.description, d.operating_unit_id, m.items_id,
      CASE WHEN M.ITEMS_ID=10004070 THEN 'I'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103,115) AND D.CAUSAL_ID=3369 THEN 'I'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103,115) AND D.CAUSAL_ID=3368 THEN 'A'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103,115) AND D.CAUSAL_ID NOT IN (3368,3369) THEN 'N/A'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103,115) AND D.CAUSAL_ID IS NULL THEN 'X'
           WHEN D.DOCUMENT_TYPE_ID = 113 THEN 'AJUSTE'
           WHEN OPEN.DAOR_OPERATING_UNIT.FNUGETOPER_UNIT_CLASSIF_ID(M.TARGET_OPER_UNIT_ID,NULL) =11 AND M.TARGET_OPER_UNIT_ID IN (1773,1774,1775) THEN 'I'
           WHEN OPEN.DAOR_OPERATING_UNIT.FNUGETOPER_UNIT_CLASSIF_ID(M.TARGET_OPER_UNIT_ID,NULL) =11 AND M.TARGET_OPER_UNIT_ID IN (1931,1932,1933) THEN 'A'
           WHEN D.DOCUMENT_TYPE_ID=118 THEN (SELECT TB.WAREHOUSE_TYPE FROM OPEN.OR_ORDER O, OPEN.LDC_TT_TB tb WHERE TB.TASK_TYPE_ID=O.TASK_TYPE_ID AND O.ORDEr_ID=D.DOCUMENTO_EXTERNO)
           ELSE 'X' END TIPO,
      SUM(DECODE(MOVEMENT_TYPE,'D',-1,1)*AMOUNT) CANTIDAD
from open.ge_items_documento d, open.ge_document_type t, open.or_uni_item_bala_mov m
where m.operating_unit_id=&nuunidad
  and d.document_type_id=t.document_type_id
  and m.id_items_documento=d.id_items_documento
  and not exists(select null from open.ldci_intemmit where documento_externo like '%'||mmitdsap and documento_externo is not null and mmitdsap is not null)
  and (move_date<'26/12/2017 11:17:33' or move_date>'28/12/2017 09:10:25')
  and movement_type!='N'
  and items_id=&item
  
  GROUP BY D.document_type_id, t.description, d.operating_unit_id, m.items_id, D.CAUSAL_ID,M.TARGET_OPER_UNIT_ID,D.DOCUMENTO_EXTERNO,
      CASE WHEN M.ITEMS_ID=10004070 THEN 'I'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103) AND D.CAUSAL_ID=3369 THEN 'I'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103) AND D.CAUSAL_ID=3368 THEN 'A'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103) AND D.CAUSAL_ID NOT IN (3368,3369) THEN 'N/A'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103) AND D.CAUSAL_ID IS NULL THEN 'X'
           WHEN D.DOCUMENT_TYPE_ID = 113 THEN 'AJUSTE'
           WHEN OPEN.DAOR_OPERATING_UNIT.FNUGETOPER_UNIT_CLASSIF_ID(M.TARGET_OPER_UNIT_ID,NULL) =11 AND M.TARGET_OPER_UNIT_ID IN (1773,1774,1775) THEN 'I'
           WHEN OPEN.DAOR_OPERATING_UNIT.FNUGETOPER_UNIT_CLASSIF_ID(M.TARGET_OPER_UNIT_ID,NULL) =11 AND M.TARGET_OPER_UNIT_ID IN (1931,1932,1933) THEN 'A'  
           ELSE 'X' END 
  union all
  
  
  
    select   D.document_type_id, t.description, d.operating_unit_id, m.items_id,
      CASE WHEN M.ITEMS_ID=10004070 THEN 'I'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103,115) AND D.CAUSAL_ID=3369 THEN 'I'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103,115) AND D.CAUSAL_ID=3368 THEN 'A'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103,115) AND D.CAUSAL_ID NOT IN (3368,3369) THEN 'N/A'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103,115) AND D.CAUSAL_ID IS NULL THEN 'X'
           WHEN D.DOCUMENT_TYPE_ID = 113 THEN 'AJUSTE'
           WHEN OPEN.DAOR_OPERATING_UNIT.FNUGETOPER_UNIT_CLASSIF_ID(M.TARGET_OPER_UNIT_ID,NULL) =11 AND M.TARGET_OPER_UNIT_ID IN (1773,1774,1775) THEN 'I'
           WHEN OPEN.DAOR_OPERATING_UNIT.FNUGETOPER_UNIT_CLASSIF_ID(M.TARGET_OPER_UNIT_ID,NULL) =11 AND M.TARGET_OPER_UNIT_ID IN (1931,1932,1933) THEN 'A'
           ELSE 'X' END TIPO,
      SUM(DECODE(D.OPERATING_UNIT_ID,&nuunidad,-1,DECODE(D.DESTINO_OPER_UNI_ID,&nuunidad,1,0))*AMOUNT) CANTIDAD
from open.ge_items_documento d, open.ge_document_type t, open.or_uni_item_bala_mov m
where (d.operating_unit_id=&nuunidad or d.destino_oper_uni_id=&nuunidad)
  and d.document_type_id=t.document_type_id
  and m.id_items_documento=d.id_items_documento
  and not exists(select null from open.ldci_intemmit where documento_externo like '%'||mmitdsap)
  and (move_date>='26/12/2017 11:17:33' and move_date<'28/12/2017 09:10:25')
  and movement_type='N'
  and d.document_type_id!=118
  and items_id=&item
  GROUP BY D.document_type_id, t.description, d.operating_unit_id, m.items_id,D.CAUSAL_ID,M.TARGET_OPER_UNIT_ID,
      CASE WHEN M.ITEMS_ID=10004070 THEN 'I'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103) AND D.CAUSAL_ID=3369 THEN 'I'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103) AND D.CAUSAL_ID=3368 THEN 'A'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103) AND D.CAUSAL_ID NOT IN (3368,3369) THEN 'N/A'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103) AND D.CAUSAL_ID IS NULL THEN 'X'
           WHEN D.DOCUMENT_TYPE_ID = 113 THEN 'AJUSTE'
           WHEN OPEN.DAOR_OPERATING_UNIT.FNUGETOPER_UNIT_CLASSIF_ID(M.TARGET_OPER_UNIT_ID,NULL) =11 AND M.TARGET_OPER_UNIT_ID IN (1773,1774,1775) THEN 'I'
           WHEN OPEN.DAOR_OPERATING_UNIT.FNUGETOPER_UNIT_CLASSIF_ID(M.TARGET_OPER_UNIT_ID,NULL) =11 AND M.TARGET_OPER_UNIT_ID IN (1931,1932,1933) THEN 'A'
           ELSE 'X' END 
   union all
  
    select   D.document_type_id, t.description, d.operating_unit_id, m.items_id,
      CASE WHEN M.ITEMS_ID=10004070 THEN 'I'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103,115) AND D.CAUSAL_ID=3369 THEN 'I'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103,115) AND D.CAUSAL_ID=3368 THEN 'A'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103,115) AND D.CAUSAL_ID NOT IN (3368,3369) THEN 'N/A'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103,115) AND D.CAUSAL_ID IS NULL THEN 'X'
           WHEN D.DOCUMENT_TYPE_ID = 113 THEN 'AJUSTE'
           WHEN OPEN.DAOR_OPERATING_UNIT.FNUGETOPER_UNIT_CLASSIF_ID(M.TARGET_OPER_UNIT_ID,NULL) =11 AND M.TARGET_OPER_UNIT_ID IN (1773,1774,1775) THEN 'I'
           WHEN OPEN.DAOR_OPERATING_UNIT.FNUGETOPER_UNIT_CLASSIF_ID(M.TARGET_OPER_UNIT_ID,NULL) =11 AND M.TARGET_OPER_UNIT_ID IN (1931,1932,1933) THEN 'A'
           ELSE 'X' END TIPO,
      SUM(DECODE(D.OPERATING_UNIT_ID,&nuunidad,-1,DECODE(D.DESTINO_OPER_UNI_ID,&nuunidad,1,0))*AMOUNT) CANTIDAD
from open.ge_items_documento d, open.ge_document_type t, open.or_uni_item_bala_mov m
where (d.operating_unit_id=&nuunidad or d.destino_oper_uni_id=&nuunidad)
  and d.document_type_id=t.document_type_id
  and m.id_items_documento=d.id_items_documento
 -- and not exists(select null from open.ldci_intemmit where documento_externo like '%'||mmitdsap)
  and (move_date>='26/12/2017 11:17:33' and move_date<'28/12/2017 09:10:25')
  and movement_type!='N'
  and d.document_type_id=118
  and items_id=&item
  GROUP BY D.document_type_id, t.description, d.operating_unit_id, m.items_id,D.CAUSAL_ID,M.TARGET_OPER_UNIT_ID,
      CASE WHEN D.DOCUMENT_TYPE_ID IN (105,103) AND D.CAUSAL_ID=3369 THEN 'I'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103) AND D.CAUSAL_ID=3368 THEN 'A'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103) AND D.CAUSAL_ID NOT IN (3368,3369) THEN 'N/A'
           WHEN D.DOCUMENT_TYPE_ID IN (105,103) AND D.CAUSAL_ID IS NULL THEN 'X'
           WHEN D.DOCUMENT_TYPE_ID = 113 THEN 'AJUSTE'
           WHEN OPEN.DAOR_OPERATING_UNIT.FNUGETOPER_UNIT_CLASSIF_ID(M.TARGET_OPER_UNIT_ID,NULL) =11 AND M.TARGET_OPER_UNIT_ID IN (1773,1774,1775) THEN 'I'
           WHEN OPEN.DAOR_OPERATING_UNIT.FNUGETOPER_UNIT_CLASSIF_ID(M.TARGET_OPER_UNIT_ID,NULL) =11 AND M.TARGET_OPER_UNIT_ID IN (1931,1932,1933) THEN 'A'
           ELSE 'X' END 
union all
select null tipo_documento, 'DATAFIX' description,  m.operating_unit_id, items_id item, 'NA', SUM(DECODE(MOVEMENT_TYPE,'D',-1,'I',1,0)* AMOUNt)
from open.or_uni_item_bala_mov m
where operating_unit_id= &nuunidad
and items_id=&item
and id_items_documento is  null
and M.Item_Moveme_Caus_Id=-1
GROUP BY   m.operating_unit_id, items_id   ;
