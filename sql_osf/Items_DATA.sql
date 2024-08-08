select gi.items_id Codigo,
       gi.description Descripcion,
       (select a.item_classif_id || ' - ' || a.description
          from open.GE_ITEM_CLASSIF a
         where a.item_classif_id = gi.item_classif_id) Clasificacion,
       (select b.measure_unit_id || ' - ' || b.description
          from open.GE_MEASURE_UNIT b
         where b.measure_unit_id = gi.measure_unit_id) Unidad_Medida,
       decode(gi.provisioning_type,
              'N',
              'No Aplica',
              'A',
              'Automatico',
              'M',
              'Manual') Tipo_Aprovicion,
       (select c.id_items_estado_inv || ' - ' || c.descripcion
          from open.GE_ITEMS_ESTADO_INV c
         where c.id_items_estado_inv = gi.init_inv_status_id) Estado
  from open.ge_items gi
 where gi.items_id = 100005129;
