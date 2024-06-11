select ldc_otlegalizar.order_id,
       ldc_otlegalizar.task_type_id,
       ldc_otlegalizar.causal_id,
       ge_causal.description            desc_causal,
       ge_causal.class_causal_id        clase_causal,
       ge_class_causal.description           desc_clase_causal,
       ldc_otlegalizar.order_comment,
       ldc_otlegalizar.exec_initial_date,
       ldc_otlegalizar.exec_final_date,
       ldc_otlegalizar.legalizado,
       ldc_otlegalizar.fecha_registro,
       ldc_otlegalizar.mensaje_legalizado     mensaje,
       ldc_otdalegalizar.name_attribute,
       ldc_otdalegalizar.value,
       ldc_otdatoactividad.name_attribute,
       ldc_otdatoactividad.name_attribute_value,
       ldc_otdatoactividad.component_id,
       ldc_otdatoactividad.component_id_value,
       ldc_otadicional.task_type_id,
       ldc_otadicional.causal_id,
       ldc_datoactividadotadicional.material,
       ldc_datoactividadotadicional.name_attribute,
       ldc_datoactividadotadicional.name_attribute_value,
       ldc_datoactividadotadicional.component_id,
       ldc_datoactividadotadicional.component_id_value,
       ldc_otadicionalda.name_attribute,
       ldc_otadicionalda.value
  from open.ldc_otlegalizar
 left join Open.ldc_otadicional on ldc_otadicional.order_id = ldc_otlegalizar.order_id
 left join open.ldc_datoactividadotadicional on ldc_datoactividadotadicional.order_id = ldc_otadicional.order_id
 left join open.ldc_otdalegalizar on ldc_otdalegalizar.order_id = ldc_otlegalizar.order_id
 left join open.ldc_otadicionalda on ldc_otadicionalda.order_id = ldc_otlegalizar.order_id
 left join OPEN.ldc_otdatoactividad on ldc_otdatoactividad.order_id = ldc_otlegalizar.order_id
 left join open.ge_causal on ge_causal.causal_id = ldc_otlegalizar.causal_id
 left join open.ge_class_causal on ge_class_causal.class_causal_id = ge_causal.class_causal_id  
 group by (ldc_otlegalizar.order_id, ldc_otlegalizar.task_type_id, ldc_otlegalizar.causal_id, ge_causal.description,
           ge_causal.class_causal_id, ge_class_causal.description, ldc_otlegalizar.order_comment,
           ldc_otlegalizar.exec_initial_date, ldc_otlegalizar.exec_final_date, ldc_otlegalizar.legalizado,
           ldc_otlegalizar.fecha_registro, ldc_otlegalizar.mensaje_legalizado, ldc_otdalegalizar.name_attribute,
           ldc_otdalegalizar.value, ldc_otdatoactividad.name_attribute, ldc_otdatoactividad.name_attribute_value,
           ldc_otdatoactividad.component_id, ldc_otdatoactividad.component_id_value, ldc_otadicional.task_type_id,
           ldc_otadicional.causal_id, ldc_datoactividadotadicional.material, ldc_datoactividadotadicional.name_attribute,
           ldc_datoactividadotadicional.name_attribute_value, ldc_datoactividadotadicional.component_id,
           ldc_datoactividadotadicional.component_id_value, ldc_otadicionalda.name_attribute, ldc_otadicionalda.value)
 order by fecha_registro desc;
 --VALIDAR SI LA PERSONA ESTA ASOCIADA A LA UNIDAD
 SELECT *
 FROM OPEN.OR_OPER_UNIT_PERSONS
 WHERE OPERATING_UNIT_ID=1886
   AND PERSON_ID IN (
 SELECT PERSON_ID
 FROM OPEN.SA_USER SA, OPEN.GE_PERSON P
 WHERE P.USER_ID=SA.USER_ID
  AND MASK='ANADEL');


-- VALIDAR SI FUE GESTIONADA
SELECt a.product_id, O.ORDER_ID, OT.OPERATING_UNIT_ID,open.daor_operating_unit.fsbgetname(ot.operating_unit_id) nombre,
    O.TASK_TYPE_ID, O.CAUSAL_ID, OT.ORDER_STATUS_ID, FECHA_REGISTRO,A.PACKAGE_ID, a.product_id,
     mensaje_legalizado, ORDER_COMMENT
FROM OPEN.Ldc_Otlegalizar O, OPEN. OR_ORDER OT, open.or_order_activity a
where --mensaje_legalizado is not null
1=1
AND O.ORDER_ID=OT.ORDER_ID
and a.order_id=o.order_id
and ot.order_status_id not in (8,12)
and ot.order_id=232777187  
--and a.product_id=50100065
 ;




select *
from open.ldc_otadicionalda
where order_id=141800828;

SELECT *
FROM OPEN.LDC_ANEXOLEGALIZA
where order_id=207478110;
SELECT *
FROM OPEN.LDC_AGENLEGO
WHERE AGENTE_ID=63;

SELECT *
FROM OPEN.LDC_USUALEGO L
INNER  JOIN OPEN.GE_PERSON P ON P.PERSON_ID=L.PERSON_ID 
INNER JOIN OPEN.SA_USER S ON S.USER_ID=P.USER_ID AND MASK=UPPER('DIASAL')
--WHERE L.AGENTE_ID=16

--WHERE AGENTE_ID=16;
WHERE PERSON_ID IN ( 
SELECT PERSON_ID
 FROM OPEN.SA_USER SA, OPEN.GE_PERSON P
 WHERE P.USER_ID=SA.USER_ID
  AND MASK=upper('DIASAL'));
SELECT *
FROM OPEN.LDC_TIPOTRABLEGO;

SELECT *
FROM OPEN.LDC_TIPOTRABADICLEGO;

SELECT *
FROM OPEN.LDC_OTITEM
where order_id=232777187;

SELECT *
FROM OPEN.LDC_OTDALEGALIZAR
where order_id=232777187;

SELECT *
FROM OPEN.LDC_OTADICIONAL
where order_id=232777187;

SELECT *
FROM OPEN.LDC_OTDATOACTIVIDAD
where order_id=232777187;

select *
from open.LDC_DATOACTIVIDADOTADICIONAL a
where a.order_id=232777187;

---NO Ofertados
SELECT CODIGO_MATERIAL CODIGO, DESCRIPCION_MATERIAL DESCRIPCION
  FROM LDC_OR_TASK_TYPES_MATERIALES
 WHERE TIPO_TRABAJO = &tipotrabajo
   and (select count(LIUL.ITEM)
          from LDC_ITEM_UO_LR LIUL
         where LIUL.ITEM = CODIGO_MATERIAL) = 0
 ORDER BY CODIGO_MATERIAL ASC;


---Ofertados 
SELECT GI.ITEMS_ID CODIGO, GI.DESCRIPTION DESCRIPCION
  FROM GE_ITEMS GI
 WHERE GI.ITEMS_ID in
       (select *
          from open.LDC_ITEM_UO_LR LIUOL , OPEN.GE_ITEMS I
          WHERE ITEM=ITEMS_ID
          AND  LIUOL.UNIDAD_OPERATIVA = 2630
           AND LIUOL.ACTIVIDAD = 4000044
           AND I.ITEMS_ID=10004070)
 ORDER BY GI.ITEMS_ID ASC;
 
 
WITH BASE AS(
SELECT O.ORDER_ID, R.EXEC_FINAL_DATE, O.OPERATING_UNIT_ID, O.EXECUTION_FINAL_DATE, I.ITEM, OPEN.DAGE_ITEMS.FSBGETDESCRIPTION(I.ITEM, NULL) DESC_ITEM, I.CANTIDAD
FROM OPEN.LDC_OTLEGALIZAR R, OPEN.LDC_OTITEM I, OPEN.OR_ORDER O 
where O.order_id=232777187
  AND R.ORDER_ID=I.ORDER_ID
  AND R.ORDER_ID=O.ORDER_ID
)
SELECT *
FROM BASE LEFT JOIN OPEN.GE_LIST_UNITARY_COST C ON TRUNC(BASE.EXEC_FINAL_DATE) BETWEEN C.VALIDITY_START_DATE AND C.VALIDITY_FINAL_DATE AND BASE.OPERATING_UNIT_ID=C.OPERATING_UNIT_ID
  ;
 


WITH BASE AS(
SELECT O.ORDER_ID, R.EXEC_FINAL_DATE, O.OPERATING_UNIT_ID, O.EXECUTION_FINAL_DATE, I.TASK_TYPE_ID, I.ACTIVIDAD, I.MATERIAL, OPEN.DAGE_ITEMS.FSBGETDESCRIPTION(I.MATERIAL, NULL) DESC_ITEM, I.CANTIDAD
FROM OPEN.LDC_OTLEGALIZAR R, OPEN.LDC_OTADICIONAL I, OPEN.OR_ORDER O 
where O.order_id=232777187
  AND R.ORDER_ID=I.ORDER_ID
  AND R.ORDER_ID=O.ORDER_ID
)
SELECT *
FROM BASE 
LEFT JOIN OPEN.GE_LIST_UNITARY_COST C ON TRUNC(BASE.EXEC_FINAL_DATE) BETWEEN C.VALIDITY_START_DATE AND C.VALIDITY_FINAL_DATE AND BASE.OPERATING_UNIT_ID=C.OPERATING_UNIT_ID
LEFT JOIN OPEN.GE_UNIT_COST_ITE_LIS LI ON LI.LIST_UNITARY_COST_ID=C.LIST_UNITARY_COST_ID AND LI.ITEMS_ID=BASE.MATERIAL
  ;
 

      
 


--tabla principal
select *
from open.ldc_otlegalizar
where order_id=232777187;
--datos adiconales orden padre
SELECT *
FROM OPEN.LDC_OTDALEGALIZAR
where order_id=232777187;
--atributos orden padre
SELECT *
FROM OPEN.LDC_OTDATOACTIVIDAD
where order_id=232777187;
--atributos orden hija
select *
from open.LDC_DATOACTIVIDADOTADICIONAL a
where a.order_id=232777187;
--Trabajos adicionales
--LDC_TIPOTRABADICLEGO(configuracion)
--ordenes adicionales
SELECT *
FROM OPEN.LDC_OTADICIONAL
where order_id=232777187;
--items legalizados en la orden padre
SELECT *
FROM OPEN.LDC_OTITEM
--datos adicionales ordenes adicionales
select *
from ldc_otadicionalda



--tabla principal
select *
from open.ldc_otlegalizar
where order_id=232777187;
--datos adiconales orden padre
SELECT *
FROM OPEN.LDC_OTDALEGALIZAR
where order_id=232777187;
--atributos orden padre
SELECT *
FROM OPEN.LDC_OTDATOACTIVIDAD
where order_id=232777187;
--atributos orden hija
select *
from open.LDC_DATOACTIVIDADOTADICIONAL a
where a.order_id=232777187;
--Trabajos adicionales
--LDC_TIPOTRABADICLEGO(configuracion)
--ordenes adicionales
SELECT *
FROM OPEN.LDC_OTADICIONAL
where order_id=232777187;
--items legalizados en la orden padre
SELECT *
FROM OPEN.LDC_OTITEM
--datos adicionales ordenes adicionales
select *
from ldc_otadicionalda