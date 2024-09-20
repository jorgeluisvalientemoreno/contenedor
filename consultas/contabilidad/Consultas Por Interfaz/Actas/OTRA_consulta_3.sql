select t.idacta acta, dt.cod_interfazldc, dt.clavcont, dt.clasecta, dt.impomtrx, u.id_orden, activo, total
  from open.ldci_detaintesap dt, open.ldci_encaintesap c, open.ldci_actacont t,
      (select d.id_acta, d.id_orden, u.value_1 activo, sum(d.valor_total) total
        from open.ge_detalle_acta d, open.ge_items it,
             (select order_id, value_1 from open.or_requ_data_value v
               where order_id in (select d.id_orden from open.ge_detalle_acta d 
                                   where d.id_acta in (select l.idacta from open.ldci_actacont l where l.actcontabiliza = 'S'))
                 and name_1 = 'NUM_COD_ACTIVO') u
       where d.id_orden = u.order_id
         and d.id_items = it.items_id
         and (it.item_classif_id != 23 or it.items_id = 4001293)
         and d.id_orden = u.order_id
      group by d.id_acta, d.id_orden, u.value_1) u
 where c.cod_interfazldc = t.codocont
   and dt.cod_interfazldc = c.cod_interfazldc
   and length(dt.clasecta) > 10
   and txtposcn like 'A%'
   and t.idacta = u.id_acta
   and dt.impomtrx = total;
