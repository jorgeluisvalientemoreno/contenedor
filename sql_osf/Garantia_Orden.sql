with Ordenes_LEGO as
 (select oo.*
    from open.or_order oo
   where oo.order_id in (330833569,
                         334088818,
                         336010356,
                         341267680,
                         330487668,
                         335855658,
                         334712862,
                         335854239,
                         336538112))
select a.product_id Producto,
       ol.order_id Orden_LEGO,
       ol.execution_final_date Fecha_Final_ejecucion,
       a.order_id Orden_Garantia,
       a.item_id || ' - ' || (select gi.description
                                from open.ge_items gi
                               where gi.items_id = A.ITEM_ID
                                 and rownum = 1) Item_Garantia,
       a.final_warranty_date Fecha_final_Garantia,
       ot.legalization_date Fecha_Lega_Orden_Garantia --,
--(SELECT open.daor_operating_unit.fsbgetname(ot.operating_unit_id,null) from dual ) UNIDADOPERATIVA,
--ooa.package_id
  from open.ge_item_warranty A
  join open.or_order_activity ooa
    on ooa.order_id = a.order_id
  join open.or_order ot
    on ot.order_id = a.order_id
  join Ordenes_LEGO ol
    on ol.created_date > '01/01/2000'
  join open.Or_Order_Activity ooa1
    on ooa1.order_id = ol.order_id
 where --and a.final_warranty_date >= '16-09-2024'--IdtExcutdate--caso:146
 a.product_id = ooa1.product_id
 and ot.task_type_id in (select b.task_type_id
                       from open.LDC_GRUPTITRGARA B
                      where b.cod_group_warranty_id in
                            (select b1.cod_group_warranty_id
                               from open.LDC_GRUPTITRGARA B1
                              where B1.TASK_TYPE_ID = 10952
                                and rownum = 1));


select b.*
                       from open.LDC_GRUPTITRGARA B
                      where b.cod_group_warranty_id in
                            (select b1.cod_group_warranty_id
                               from open.LDC_GRUPTITRGARA B1
                              where B1.TASK_TYPE_ID = 10952
                                and rownum = 1)
