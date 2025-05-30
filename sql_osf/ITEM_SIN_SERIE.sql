select GI.ITEMS_ID || ' - ' || GI.DESCRIPTION Item,
       gi.item_classif_id || ' - ' || gic.description Clasificacion,
       gi.concept || ' - ' || c.concdesc Concepto,
       gi.object_id || ' - ' || go.description Objeto,
       decode(gi.use_,
              'IC',
              'IC: [INSTALACION EN CLIENTE]',
              'MC',
              'MC: [MANTENIMIENTO EN CLIENTE]',
              'IR',
              'IR: [INSTALACION DE RED]',
              'MR',
              'MR: [MANTENIMIENTO DE RED]',
              'RC',
              'RC: [RETIRO EN CLIENTE]',
              'RR',
              'RR: [RETIRO EN RED]',
              'CR',
              'CR: [REVISION EN CLIENTE]',
              'CF',
              'CF: [REPARACION EN CLIENTE]',
              'CW',
              'CW: [Trabajo en Cliente]',
              gi.use_) USO,
       gi.init_inv_status_id || ' - ' || giei.descripcion ESTADO_INICIAL
  from open.GE_ITEMS GI
  left join open.GE_ITEM_CLASSIF gic
    on gic.item_classif_id = gi.item_classif_id
  left join open.CONCEPTO c
    on c.conccodi = gi.concept
  left join open.GE_OBJECT go
    on go.object_id = gi.object_id
  left join open.GE_ITEMS_ESTADO_INV giei
    on giei.id_items_estado_inv = gi.init_inv_status_id
 where not exists (select gis.serie
          from open.ge_items_seriado gis
         where gis.items_id = GI.items_id);
