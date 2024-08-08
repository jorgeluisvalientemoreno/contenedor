WITH CALIBRADOS AS(
select 
distinct 
       t.id_items_tipo id_tipo_instrumento,
       t.DESCRIPCION tipo_instrumento,
       i.items_id id_item,
       i.description item_descripcion,
       dac.items_id id_actividad,
       dac.description actividad,
       o.order_id certificado,
       ob.id_items_estado_inv || ' - ' || es.descripcion estado_equipo,
       (SELECT VALOR FROM OPEN.GE_ITEMS_TIPO_AT_VAL ATR WHERE ATR.ID_ITEMS_SERIADO = OB.ID_ITEMS_SERIADO AND ATR.ID_ITEMS_TIPO_ATR = (SELECT A1.ID_ITEMS_TIPO_ATR FROM OPEN.GE_ITEMS_TIPO_ATR A1 WHERE ID_ITEMS_TIPO=I.ID_ITEMS_TIPO AND ENTITY_ATTRIBUTE_ID=90008877) and rownum = 1) CODIGO,
       ob.serie serie_item,
       (SELECT VALOR FROM OPEN.GE_ITEMS_TIPO_AT_VAL ATR WHERE ATR.ID_ITEMS_SERIADO = OB.ID_ITEMS_SERIADO AND ATR.ID_ITEMS_TIPO_ATR = (SELECT A1.ID_ITEMS_TIPO_ATR FROM OPEN.GE_ITEMS_TIPO_ATR A1 WHERE ID_ITEMS_TIPO=I.ID_ITEMS_TIPO AND ENTITY_ATTRIBUTE_ID=90008878) and rownum = 1) UNIDAD_MEDIDA,
       (SELECT VALOR FROM OPEN.GE_ITEMS_TIPO_AT_VAL ATR WHERE ATR.ID_ITEMS_SERIADO = OB.ID_ITEMS_SERIADO AND ATR.ID_ITEMS_TIPO_ATR = (SELECT A1.ID_ITEMS_TIPO_ATR FROM OPEN.GE_ITEMS_TIPO_ATR A1 WHERE ID_ITEMS_TIPO=I.ID_ITEMS_TIPO AND ENTITY_ATTRIBUTE_ID=90019482) and rownum = 1) FABRICANTE,
       (SELECT VALOR FROM OPEN.GE_ITEMS_TIPO_AT_VAL ATR WHERE ATR.ID_ITEMS_SERIADO = OB.ID_ITEMS_SERIADO AND ATR.ID_ITEMS_TIPO_ATR = (SELECT A1.ID_ITEMS_TIPO_ATR FROM OPEN.GE_ITEMS_TIPO_ATR A1 WHERE ID_ITEMS_TIPO=I.ID_ITEMS_TIPO AND ENTITY_ATTRIBUTE_ID=90008876) and rownum = 1) RANGO,
       case
         when ob.propiedad in ('E','T') then
              ob.operating_unit_id | | ' - ' || ou.name 
         else
              (select su1.subscriber_name || ' ' || su1.subs_last_name from open.mo_packages pa1, open.or_order_activity oa1, open.ge_subscriber su1 where su1.subscriber_id = pa1.subscriber_id and pa1.package_id = oa1.package_id and oa1.order_id = o.order_id  and rownum = 1)
       end desc_unidad_op,
         
       (SELECT VALOR FROM OPEN.GE_ITEMS_TIPO_AT_VAL ATR WHERE ATR.ID_ITEMS_SERIADO = OB.ID_ITEMS_SERIADO AND ATR.ID_ITEMS_TIPO_ATR = (SELECT A1.ID_ITEMS_TIPO_ATR FROM OPEN.GE_ITEMS_TIPO_ATR A1 WHERE ID_ITEMS_TIPO=I.ID_ITEMS_TIPO AND ENTITY_ATTRIBUTE_ID=90028862) and rownum = 1) UBICACION,
       ob.propiedad,
       o.created_date fecha_creacion,
       --(select max(mov.move_date) from open.or_uni_item_bala_mov mov where mov.id_items_seriado = ob.id_items_seriado and mov.item_moveme_caus_id in (7,16,28)) fecha_recepcion,
       o.assigned_date fecha_recepcion,
       o.legalization_date fecha_calibracion,
       --cert.cemefece + ma.exec_frecuency fecha_certificacion,
       ch.valid_until fecha_certificacion,
       decode(cert.cemereaj,'Y','N','N','Y','-') acreditado,
       open.ldc_reportesconsulta.fsbNombreGe_Person((select ca.person_id from open.or_order_person ca where ca.order_id = o.order_id  and rownum = 1)) Calibrado_por,
       o.order_status_id || ' - ' || open.ldc_reportesconsulta.DescriptionOrderStatus (o.order_status_id) estado_ot,
       o.causal_id || ' - ' || open.ldc_reportesconsulta.DescriptionCausal(o.causal_id) causal
from   OPEN.OR_ORDER_ACTIVITY ac,
       open.ge_items dac,
       open.or_order o, 
       open.or_order_items io ,
       OPEN.GE_ITEMS_SERIADO ob,
       open.ge_items i,
       OPEN.GE_ITEMS_TIPO t,
       open.or_operating_unit ou,   
       OPEN.OR_TASK_TYPE tt , 
       open.LDC_CERTMETR cert,
       open.ge_items_estado_inv es,
       OPEN.IF_MAINT_ITEMSER ma,
       open.or_item_pattern ch
       
where ac.activity_id = dac.items_id
  and ac.order_id = o.order_id
  and o.order_id = io.order_id
  and ac.serial_items_id = ob.id_items_seriado(+)
  and ob.items_id = i.items_id(+)
  and i.ID_ITEMS_TIPO = t.ID_ITEMS_TIPO(+)
  and ob.operating_unit_id = ou.operating_unit_id(+)
  and o.ORDER_STATUS_ID in (8)
  and ob.id_items_estado_inv = es.id_items_estado_inv(+)
  and ((ac.ACTIVITY_ID = ma.ACTIVITY
  and io.items_id = ma.item_id) 
  or (o.task_type_id in (12843  ,10349  ,10350  ,10351  ,12666  ,12488  ,12489  ,12490  ,12491  ,12492  ,12493  ,12494  ,12495  ,12496  ,12497  ,12498  ,12499  ,12500  ,12501  ,12502  ,12503  ,12504  ,12505  ,12506  ,12507  ,12508  ,12509  ,12510  ,12511  ,12512  ,12513  ,12514  ,10231  ,10218  ,10229  ,10230  ,10232  ,10233  ,10234  ,10335)))
  and ac.TASK_TYPE_ID = tt.TASK_TYPE_ID
  and o.order_id = cert.cemeorde(+)
  and ob.id_items_seriado = ch.id_items_seriado(+)
  and o.legalization_date >= {?fecha_ini} 
  and o.legalization_date <= to_date(to_char({?fecha_fin},'dd/mm/yyyy')||' 23:59:59','dd/mm/yyyy HH24:mi:ss')
  and nvl(cert.cemereaj,'-1') = decode({?tipo_calibracion},'-1',nvl(cert.cemereaj,'-1'),'Y','N','Y') 
  and nvl(t.id_items_tipo,-1) = decode({?tipo_item},-1,nvl(t.id_items_tipo,-1),{?tipo_item})
  and ac.activity_id = decode({?actividad},-1,ac.activity_id,{?actividad})
  )
  SELECT C.ID_TIPO_INSTRUMENTO,
         C.TIPO_INSTRUMENTO,
         C.ID_ITEM,
         C.ITEM_DESCRIPCION,
         C.ID_ACTIVIDAD,
         C.ACTIVIDAD,
         C.CERTIFICADO,
         C.ESTADO_EQUIPO,
         C.CODIGO,
         C.SERIE_ITEM,
         C.UNIDAD_MEDIDA,
         C.FABRICANTE,
         C.RANGO,
         C.DESC_UNIDAD_OP,
         C.UBICACION,
         C.PROPIEDAD,
         C.FECHA_CREACION,
         C.FECHA_RECEPCION,
         C.FECHA_CALIBRACION,
         C.FECHA_CERTIFICACION,
         C.ACREDITADO,
         C.CALIBRADO_POR,
         C.ESTADO_OT,
         C.CAUSAL
  FROM CALIBRADOS C
  WHERE (C.ESTADO_EQUIPO = ' - ' AND (SELECT COUNT(*) FROM CALIBRADOS CC WHERE CC.CERTIFICADO = C.CERTIFICADO) <= 1) OR
        (C.ESTADO_EQUIPO <> ' - ')