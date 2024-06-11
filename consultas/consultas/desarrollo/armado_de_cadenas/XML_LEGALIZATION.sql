WITH BASE AS(
SELECT O.ORDER_ID,
       O.TASK_TYPE_ID,
       LEGO.CAUSAL_ID,
       LEGO.ORDER_COMMENT,
       LEGO.EXEC_INITIAL_DATE,
       LEGO.EXEC_FINAL_DATE,
       DECODE(C.CLASS_CAUSAL_ID,1,1,0) CANTIDAD,
       A.ORDER_ACTIVITY_ID,
       A.ACTIVITY_ID
FROM OPEN.LDC_OTLEGALIZAR LEGO
INNER JOIN OPEN.OR_ORDER O ON O.ORDER_ID=LEGO.ORDER_ID AND O.ORDER_STATUS_ID IN (5,6,7)
INNER JOIN OPEN.GE_CAUSAL C ON C.CAUSAL_ID=LEGO.CAUSAL_ID
INNER JOIN OPEN.OR_ORDER_ACTIVITY A ON A.ORDER_ID=O.ORDER_ID AND A.STATUS='R' AND A.TASK_TYPE_ID = O.TASK_TYPE_ID
WHERE LEGO.LEGALIZADO='N'
  and O.TASK_TYPE_ID IN (/*12150,12152,12153*/10075,10074)
 and not exists(select 1 from open.ct_item_novelty n where n.items_id=a.activity_id)
)
,atributos_actividad as(
select itatr.items_id,
       1 position,
       itatr.attribute_1_id attribute_id,
       itatr.component_1_id component_id
 from ge_items_attributes itatr
 where /*itatr.component_1_id in (2,9)
   and */itatr.attribute_1_id is not null
 union all
select itatr.items_id,
       2 position,
       itatr.attribute_2_id attribute_id,
       itatr.component_2_id component_id
 from ge_items_attributes itatr
 where /*itatr.component_2_id in (2,9)
   and */itatr.attribute_2_id is not null
 union all
 select itatr.items_id,
       3 position,
       itatr.attribute_3_id attribute_id,
       itatr.component_3_id component_id
 from ge_items_attributes itatr
 where /*itatr.component_3_id in (2,9)
   and */itatr.attribute_3_id is not null
 union all
 select itatr.items_id,
       4 position,
       itatr.attribute_4_id attribute_id,
       itatr.component_4_id component_id
 from ge_items_attributes itatr
 where /*itatr.component_4_id in (2,9)  
   and */itatr.attribute_4_id is not null
)
,lecturas as(
select al.items_id,
       al.position,
       al.attribute_id,
       al.component_id,
       att.name_attribute,
       CASE
         WHEN att.name_attribute =
              'INSTALAR_UTILITIES' AND
              al.component_id IN (2, 9) THEN
          'I'
         WHEN att.name_attribute =
              'RETIRAR_UTILITIES' AND
              al.component_id IN (2, 9) THEN
          'R'
         WHEN al.items_id IN
              (4294337, 102008) AND
              att.name_attribute = 'READING' THEN
          'F'
         WHEN al.component_id IN (2, 9) THEN
          'T'
       END as cause
from atributos_actividad  al
inner join ge_attributes att on att.attribute_id=al.attribute_id)
select base.order_id,
       base.causal_id,
       ag.tecnico_unidad,
       cursor (select atr.name_attribute name_attribute,
             (select lo.value
                from ldc_otdalegalizar lo
               where lo.order_id = base.order_id
                 and lo.name_attribute =
                     atgr.attribute_set_id || '_' || atr.name_attribute
                 and lo.task_type_id = base.task_type_id
                 and lo.causal_id = base.causal_id) value
        from or_tasktype_add_data datt
        inner join ge_attrib_set_attrib atgr on atgr.attribute_set_id = datt.attribute_set_id
        inner join ge_attributes atr on atr.attribute_id = atgr.attribute_id
       where datt.active = 'Y'
         and datt.task_type_id = base.task_type_id
         and (datt.use_ = decode(base.cantidad,1,'C',0,'I') or datt.use_ = 'B')
       order by atgr.attribute_set_id, atr.attribute_id) datos_adicionales,
       CURSOR (SELECT base.ORDER_ACTIVITY_ID ,
                      base.CANTIDAD,
                      cursor (select lecturas.*,
                      cursor(SELECT ATR.NAME_ATTRIBUTE_VALUE, 
                                    ATR.COMPONENT_ID,
                                    COMPONENT_ID_VALUE
                        FROM LDC_OTDATOACTIVIDAD ATR
                        WHERE ATR.ORDER_ID=BASE.ORDER_ID
                          AND SUBSTR(ATR.NAME_ATTRIBUTE,LENGTH(ATR.NAME_ATTRIBUTE))=lecturas.position
                          and SUBSTR(ATR.NAME_ATTRIBUTE,1,LENGTH(ATR.NAME_ATTRIBUTE)-2)=lecturas.name_attribute
                          AND base.CANTIDAD=1)
                          from  lecturas 
                          where lecturas.items_id = base.activity_id 
                           and base.CANTIDAD=1) atributos
         FROM dual
         ) ACTIVIDAD,
         
         CURSOR(SELECT IT.ITEM, IT.CANTIDAD 
                  FROM OPEN.LDC_OTITEM IT 
                 WHERE IT.ORDER_ID=BASE.ORDER_ID
                   AND BASE.CANTIDAD=1 ) ITEMS,

       BASE.ORDER_COMMENT,
       BASE.EXEC_INITIAL_DATE,
       BASE.EXEC_FINAL_DATE
from base
inner join ldc_anexolegaliza ag on ag.order_id=base.order_id






               /*CURSOR(SELECT ATR.NAME_ATTRIBUTE, ATR.NAME_ATTRIBUTE_VALUE, ATR.COMPONENT_ID
                        FROM LDC_OTDATOACTIVIDAD ATR
                        WHERE ATR.ORDER_ID=BASE.ORDER_ID
                          AND SUBSTR(ATR.NAME_ATTRIBUTE,LENGTH(ATR.NAME_ATTRIBUTE))='1'
                          AND base.CANTIDAD=1) ATRIBUTO1,
               CURSOR(SELECT ATR.NAME_ATTRIBUTE, ATR.NAME_ATTRIBUTE_VALUE, ATR.COMPONENT_ID
                        FROM LDC_OTDATOACTIVIDAD ATR
                        WHERE ATR.ORDER_ID=BASE.ORDER_ID
                          AND base.CANTIDAD=1
                          AND SUBSTR(ATR.NAME_ATTRIBUTE,LENGTH(ATR.NAME_ATTRIBUTE))='2') ATRIBUTO2,
               CURSOR (SELECT ATR.NAME_ATTRIBUTE, ATR.NAME_ATTRIBUTE_VALUE, ATR.COMPONENT_ID
                        FROM LDC_OTDATOACTIVIDAD ATR
                        WHERE ATR.ORDER_ID=BASE.ORDER_ID
                        AND base.CANTIDAD=1
                          AND SUBSTR(ATR.NAME_ATTRIBUTE,LENGTH(ATR.NAME_ATTRIBUTE))='3') ATRIBUTO3,
               CURSOR (SELECT ATR.NAME_ATTRIBUTE, ATR.NAME_ATTRIBUTE_VALUE, ATR.COMPONENT_ID
                        FROM LDC_OTDATOACTIVIDAD ATR
                        WHERE ATR.ORDER_ID=BASE.ORDER_ID
                        AND base.CANTIDAD=1
                          AND SUBSTR(ATR.NAME_ATTRIBUTE,LENGTH(ATR.NAME_ATTRIBUTE))='4') ATRIBUTO4 */                         
