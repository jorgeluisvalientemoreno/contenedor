select gi.items_id Item,
       gi.description Descripcion,
       gi.item_classif_id || ' - ' || gic.description Clasificacion,
       (select decode(count(1), 0, 'No', 'Si')
          from open.ct_item_novelty cin
         where cin.items_id = gi.items_id) Item_Novedad,
       gi.measure_unit_id,
       gi.tech_card_item_id,
       gi.concept || ' - ' || c.concdesc Concepto,
       gi.object_id,
       decode(gi.use_,
              'IC',
              'IC [INSTALACION EN CLIENTE]',
              'MC',
              'MC [MANTENIMIENTO EN CLIENTE]',
              'IR',
              'IR [INSTALACION DE RED]',
              'MR',
              'MR [MANTENIMIENTO DE RED]',
              'RC',
              'RC [RETIRO EN CLIENTE]',
              'RR',
              'RR [RETIRO EN RED]',
              'CR',
              'CR [REVISION EN CLIENTE]',
              'CF',
              'CF [REPARACION EN CLIENTE]',
              'CW',
              'CW [Trabajo en Cliente]',
              gi.use_) Uso,
       gi.element_type_id,
       gi.element_class_id,
       gi.standard_time,
       gi.warranty_days,
       gi.discount_concept,
       gi.id_items_tipo || ' - ' || git.descripcion Tipo,
       gi.obsoleto,
       decode(gi.provisioning_type,
              'N',
              '[N] NO APLICA',
              'A',
              '[A] AUTOMATICO',
              'M',
              '[M] MANUAL',
              'INDEFINIDO') Tipo_Aprovisionamiento,
       gi.platform,
       DECODE(gi.recovery, 'N', 'No', 'Si') RECUPERABLE,
       gi.recovery_item_id,
       gi.init_inv_status_id,
       gi.shared,
       gi.code Codigo
  from open.ge_items gi
  left join ge_item_classif gic
    on gic.item_classif_id = gi.item_classif_id
  left join ge_items_tipo git
    on git.id_items_tipo = gi.id_items_tipo
  left join concepto c
    on c.conccodi = gi.concept
-- where gi.items_id in (10004070)
