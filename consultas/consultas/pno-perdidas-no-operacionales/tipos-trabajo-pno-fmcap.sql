SELECT O.ORDER_ID OT, 
lo.geo_loca_father_id depa,
(select de.description from open.ge_geogra_location de where de.geograp_location_id=lo.geo_loca_father_id) desc_depa,
--open.dage_geogra_location.fsbgetdescription(lo.geo_loca_father_id, null) desc_depa,
LO.GEOGRAP_LOCATION_ID LOCA, LO.DESCRIPTION DESC_LOCA, 
U.OPERATING_UNIT_ID UNI, U.NAME NOMBRE, 
cl.subscriber_name ||' - '||cl.subs_last_name,
(select r.value_1
   from open.or_requ_data_value r
   where r.order_id = o.order_id
   and   r.name_1='NUM_COD_ACTIVO') CODIGO_ACTIVO,
O.ORDER_STATUS_ID ESTA_OT, 
A.STATUS
,NVL((SELECT 'S' FROM OPEN.LDC_ORDER R WHERE R.ORDER_ID=O.ORDER_ID),'N') UOBYSL
, O.TASK_TYPE_ID TITR, T.DESCRIPTION DESC_TITR
, OI.ITEMS_ID ITEM,I.DESCRIPTION DESC_ITEM, OI.LEGAL_ITEM_AMOUNT, OI.VALUE, OI.TOTAL_PRICE
, A.ACTIVITY_ID
,(SELECT I.DESCRIPTION FROM OPEN.GE_ITEMS I WHERE I.ITEMS_ID=A.ACTIVITY_ID) DESC_ACTIVIDAD
, A.PACKAGE_ID
, A.INSTANCE_ID
,A.ORDER_ACTIVITY_ID
,O.IS_PENDING_LIQ
,O.CREATED_DATE
,O.ASSIGNED_DATE
,O.EXEC_INITIAL_DATE
,O.EXECUTION_FINAL_DATE
,case when o.order_status_id=8 then O.LEGALIZATION_dATE when o.order_Status_id=12 then (select stat_chg_date from open.or_order_stat_change ch where ch.order_id=o.order_id and ch.final_status_id=12) end  fecha_lega_anula
,A.PRODUCT_ID
,A.SUBSCRIPTION_ID
,a.subscriber_id
,I.ITEM_CLASSIF_ID
,DEFINED_CONTRACT_ID
,O.CAUSAL_ID
,(select c.description from open.ge_causal c where c.causal_id=o.causal_id) DESC_CAUSAL

,(select c.class_causal_id from open.ge_causal c where c.causal_id=o.causal_id) CLASIFICACION 
,(select count(1) from open.or_order_activity a2 where a2.product_id=a.product_id and a.task_type_id in (10450,10833,10835,10834,12457, 10444,10723,10833,10795,12460) and status!='F') OT
,(SELECT R.ORDER_ID FROM OPEN.OR_RELATED_ORDER R WHERE R.RELATED_ORDER_ID=O.ORDER_ID AND ROWNUM=1) OT_PADRE
,certificate_id acta
,A.OPERATING_SECTOR_ID
,O.OPERATING_SECTOR_ID
,P.PACKAGE_TYPE_ID
,P.COMMENT_
,A.ADDRESS_ID
,DI.ADDRESS
,NVL((SELECT 'S' FROM OPEN.CT_ITEM_NOVELTY N WHERE N.ITEMS_ID=A.ACTIVITY_ID),'N') ES_NOVEDAD
,O.ESTIMATED_COST
--, (select status_docu from open.ldc_docuorder d where d.order_id=o.order_id) estado_documento
--,(SELECT CE.FINAL_EXCLUSION_DATE FROM OPEN.CT_EXCLUDED_ORDER CE WHERE CE.ORDER_ID=O.ORDER_ID) FECHA_HASTA_EXCLUSION
,(SELECT OC.ORDER_COMMENT FROM OPEN.CT_EXCLUDED_ORDER CE,OPEN.OR_ORDER_COMMENT OC WHERE CE.ORDER_ID=O.ORDER_ID AND OC.ORDER_COMMENT_ID=CE.ORDER_COMMENT_ID) COMENTARIO_EXCLUSION
,(SELECT OC.REGISTER_DATE FROM OPEN.CT_EXCLUDED_ORDER CE,OPEN.OR_ORDER_COMMENT OC WHERE CE.ORDER_ID=O.ORDER_ID AND OC.ORDER_COMMENT_ID=CE.ORDER_COMMENT_ID) FECHA_EXCLUSION
,(SELECT PE.PERSON_ID FROM OPEN.OR_ORDER_PERSON PE WHERE PE.ORDER_ID=O.ORDER_ID)
,A.COMMENT_
,a.value_reference
,( select tt.clctclco||'-'||co.clcodesc   from open.ic_clascott tt, open.ic_clascont co where tt.clcttitr=o.task_type_id and co.clcocodi=tt.clctclco) clasificador
,a.legalize_try_times
,o.charge_status
,o.order_value
, (select co.order_comment from open.or_order_comment co where co.order_id=o.order_id /*and co.legalize_comment='Y'*/ AND ROWNUM=1) comentario_lega
, o.saved_data_values
FROM OPEN.OR_ORDER O
LEFT JOIN OPEN.AB_ADDRESS DI ON DI.ADDRESS_ID=EXTERNAL_ADDRESS_ID
LEFT JOIN OPEN.GE_GEOGRA_LOCATION LO ON LO.GEOGRAP_LOCATION_ID=DI.GEOGRAP_LOCATION_ID
LEFT JOIN OPEN.OR_OPERATING_UNIT U ON U.OPERATING_UNIT_ID=O.OPERATING_UNIT_ID
LEFT JOIN OPEN.OR_ORDER_ITEMS OI ON OI.ORDER_ID=O.ORDER_ID AND nvl(upper(&ITEMS),'S')='S'
LEFT JOIN OPEN.OR_ORDER_ACTIVITY A ON A.ORDER_ID=O.ORDER_ID
LEFT JOIN OPEN.OR_TASK_TYPE T ON T.TASK_TYPE_ID=O.TASK_TYPE_ID
LEFT JOIN OPEN.GE_ITEMS I ON I.ITEMS_ID=OI.ITEMS_ID
LEFT JOIN OPEN.MO_PACKAGES P ON P.PACKAGE_ID=A.PACKAGE_ID
LEFT JOIN OPEN.CT_ORDER_CERTIFICA CT ON CT.ORDER_ID=O.ORDER_ID
left join open.pr_product p on p.product_id=a.product_id
left join open.suscripc s on s.susccodi=p.subscription_id
left join open.ge_subscriber cl on cl.subscriber_id=suscclie
WHERE --a.package_id=119871395   
      /*o.order_id=50719022
  AND */ a.subscription_id in (66903193)
  and o.task_type_id in (12669, 11240, 12673, 10312,10059, 11302)
  and NVL((SELECT 'S' FROM OPEN.CT_ITEM_NOVELTY N WHERE N.ITEMS_ID=A.ACTIVITY_ID),'N')='N'
 
;