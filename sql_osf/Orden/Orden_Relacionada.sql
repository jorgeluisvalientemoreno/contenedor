select oro.order_id Orden_Legalizada,
       oro.related_order_id Orden_Generada,
       oo_generada.task_type_id ||' - '|| ott_generada.description Tipo_Trabajo,
       oo_generada.order_status_id Estado,
       oo_generada.operating_unit_id || ' - ' || oou.name Unidad_operativa
  from open.or_related_order oro
  left join open.or_order oo_generada
    on oo_generada.order_id = oro.related_order_id
  left join open.or_operating_unit oou
    on oou.operating_unit_id = oo_generada.operating_unit_id
  left join open.or_task_type ott_generada
    on ott_generada.task_type_id =  oo_generada.task_type_id
 where oro.order_id in (264369138)
