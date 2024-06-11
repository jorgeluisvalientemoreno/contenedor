select /*+ index (o1 PK_OR_OPE_UNI_ITEM_BALA) index (o2 PK_LDC_ACT_OUIB) index (o3 PK_LDC_INV_OUIB)*/
 o1.operating_unit_id CODIGO_UNIDAD_OPERATIVA,
 open.daor_operating_unit.fsbgetname(o1.operating_unit_id, null) DESCRIPCION_UNIDAD_OPERATIVA,
 o1.items_id CODIGO_ITEM,
 open.dage_items.fsbgetdescription(o1.items_id, null) DESCRIPCION_ITEM,
 o1.balance CANTIDAD_EXISTENTE_BODEGA,
 o1.total_costs COSTO_BODEGA,
 (select o2.balance
    from open.ldc_act_ouib o2
   where o2.items_id = o1.items_id
     and o1.operating_unit_id = o2.operating_unit_id) CANTIDAD_EXISTENTE_ACTIVO,
 (select o2.total_costs
    from open.ldc_act_ouib o2
   where o2.items_id = o1.items_id
     and o1.operating_unit_id = o2.operating_unit_id) COSTO_PROMEDIO_ACTIVO,
 (select o3.balance
    from open.ldc_INV_ouib o3
   where o3.items_id = o1.items_id
     and o1.operating_unit_id = o3.operating_unit_id) CANTIDAD_EXISTENTE_INVENTARIO,
 (select o3.total_costs
    from open.ldc_INV_ouib o3
   where o3.items_id = o1.items_id
     and o1.operating_unit_id = o3.operating_unit_id) COSTO_PROMEDIO_INVENTARIO
  from open.OR_OPE_UNI_ITEM_BALA o1
 order by o1.operating_unit_id