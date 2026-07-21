select gi.items_id Item,
       gi.description Descripcion,
       gic.item_classif_id || ' - ' || gic.description Calsificaicon,
       git.id_items_tipo || ' - ' || git.descripcion Tipo
  from open.ge_items gi
  left join open.ge_item_classif gic
    on gic.item_classif_id = gi.item_classif_id
  left join open.ge_items_tipo git
    on git.id_items_tipo = gi.id_items_tipo
 where 1 = 1
   and gi.items_id in (100007444, 100007440, 100007442)
  -- and gi.item_classif_id not in (2)
--and upper(gi.description) like 'REJ%'
