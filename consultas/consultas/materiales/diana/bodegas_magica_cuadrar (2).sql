SELECT OPERATING_UNIT_ID, ITEMS_ID, CLASIFICACION, SUM(CANTIDAD), SUM(VALOR)
FROM (
SELECT o.uni_item_bala_mov_id, O.OPERATING_UNIT_ID, ITEMS_ID, (CASE WHEN o.movement_type = 'D' 
                        AND o.item_moveme_caus_id = 4 
                        THEN
                        (SELECT tt.warehouse_type
                           FROM open.ldc_tt_tb tt, open.or_order oo
                          WHERE oo.order_id = d.documento_externo
                            AND oo.task_type_id =tt.task_type_id 
                        )
                        
                        WHEN open.daor_operating_unit.fnugetoper_unit_classif_id(o.target_oper_unit_id)=11 
                         AND open.daor_operating_unit.fsbgetname(o.target_oper_unit_id) like '%ACTIVO%' THEN 'A'
                       --
                        WHEN open.daor_operating_unit.fnugetoper_unit_classif_id(o.target_oper_unit_id)=11 
                         AND open.daor_operating_unit.fsbgetname(o.target_oper_unit_id) like '%INVENTARIO%' THEN 'I'
                        --
                        WHEN d.causal_id=3368 THEN 'A'  
                        WHEN d.causal_id=3369 THEN 'I'
                        WHEN ITEMS_ID=10004070 THEN 'I'
                        WHEN O.MOVEMENT_TYPE='I' AND ITEM_MOVEME_CAUS_ID=16 THEN
                        (SELECT to_char(count(DISTINCT (DECODE(DT.CAUSAL_ID,3368,'A',3369,'I','X' )))) FROM OPEN.ge_items_doc_rel R, OPEN.GE_ITEMS_DOCUMENTO DT WHERE R.ID_ITEMS_DOC_ORIGEN=O.ID_ITEMS_DOCUMENTO AND R.ID_ITEMS_DOC_DESTINO=DT.ID_ITEMS_DOCUMENTO)
                          
                   ELSE 'X' END   
                  ) clasificacion , sum(decode(movement_type,'D',-1,1)*o.amount) CANTIDAD, sum(decode(movement_type,'D',-1,1)*o.total_value ) VALOR
             FROM open.or_uni_item_bala_mov o  left join 
                  open.ge_items_documento   d  on (o.id_items_documento = d.id_items_documento)
            WHERE items_id not like '4%'
              AND ITEMS_ID NOT IN (100003008, 100003011)
              and items_id=10002011 
              and o.operating_unit_id=3120
              and o.movement_type in ('I','D')
/*             

616059*/

group by o.uni_item_bala_mov_id, O.OPERATING_UNIT_ID, ITEMS_ID, o.movement_type, o.item_moveme_caus_id , d.causal_id,o.target_oper_unit_id, d.documento_externo, O.ID_ITEMS_DOCUMENTO
)
GROUP BY OPERATING_UNIT_ID, ITEMS_ID, CLASIFICACION;

/*select *
from open.ge_items_documento d, open.sa_user u
where  document_type_id=105
  and causal_id is null
  and d.user_id=u.user_id
select *
from open.ge_items_documento
where id_items_documento=176014;
select mmitcodi, sum(dmitcoun)
from open.ldci_intemmit, open.ldci_dmitmmit
where mmitnudo='176014'
  and mmitcodi=dmitmmit
  group by mmitcodi;
  
select *
from open.or_related_order
where order_id in (35491674);
select *
from open.or_order_items
where order_id in (35491674, 43506410);
SELECT *
FROM OPEN.SA_EXECUTABLE
WHERE NAME='GEPLA';

SELECT S.SERIE, S.ITEMS_ID, B.*
FROM OPEN.GE_ITEMS_SERIADO S,OPEN.OR_OPE_UNI_ITEM_BALA B
WHERE ID_ITEMS_ESTADO_INV=12
  AND S.ITEMS_ID=B.ITEMS_ID
  AND S.OPERATING_UNIT_ID=B.OPERATING_UNIT_ID;
  
SELECT *
FROM OPEN.OR_UNI_ITEM_BALA_MOV
WHERE ID_ITEMS_SERIADO=2021567;



select *
from open.mo_packages p, open.mo_motive m
where m.product_id=1114547
  and m.package_id=p.package_id
  and p.package_type_id=100101; 
*/
