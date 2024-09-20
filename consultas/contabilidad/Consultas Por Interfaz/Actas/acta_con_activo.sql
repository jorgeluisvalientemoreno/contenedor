select g.id_acta, g.id_orden, g.id_items, (select i.description from open.ge_items i where i.items_id = g.id_items) des_item,
       (select value_1 from open.or_requ_data_value where order_id = g.id_orden and name_1 = 'NUM_COD_ACTIVO') Activo,
       sum(g.valor_total) total
  from open.ge_detalle_acta g
 where g.id_acta = 26086
group by g.id_acta, g.id_orden, g.id_items
