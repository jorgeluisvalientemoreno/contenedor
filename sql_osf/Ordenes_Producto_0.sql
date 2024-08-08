select OO.ORDER_ID Orden,
       OO.TASK_TYPE_ID || '-' || OTT.DESCRIPTION Tipo_Trabajo,
       OO.CAUSAL_ID ||'-'|| OPEN.DAGE_CAUSAL.FSBGETDESCRIPTION(OO.CAUSAL_ID,null) Causal_Legalizacion,
       OOA.ACTIVITY_ID || '-' || GI.DESCRIPTION Actividad,       
       OO.CREATED_DATE Fecha_Creacion, OO.LEGALIZATION_DATE Fecha_Legalizacion
  from open.Or_Order_Activity ooa,
       open.or_order          oo,
       open.or_task_type      ott,
       open.ge_items          gi
 where ooa.order_id = OO.ORDER_ID
   and ooa.product_id = 50758249
   AND OO.TASK_TYPE_ID = OTT.TASK_TYPE_ID
   AND OOA.ACTIVITY_ID = GI.ITEMS_ID
   --AND OO.TASK_TYPE_ID = 12690
   --AND OO.ORDER_ID IN (66168024, 67532357)
   ORDER BY OO.CREATED_DATE DESC;
