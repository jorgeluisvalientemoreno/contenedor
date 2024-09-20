-- select * from open.ldci_actacont l where l.actcontabiliza = 'S';
select t.idacta acta, d.*  from open.ldci_detaintesap d, open.ldci_encaintesap c, open.ldci_actacont t
 where c.cod_interfazldc = t.codocont
   and d.cod_interfazldc = c.cod_interfazldc
   and d.cod_interfazldc = 5337
   and length(d.clasecta) > 10
   and txtposcn like 'A%';
   
select d.id_acta, d.id_orden, u.value_1 activo, sum(d.valor_total) total, y.task_type_id
  from open.ge_detalle_acta d, open.ge_items it, open.or_order_activity y,
       (select order_id, value_1 from open.or_requ_data_value v
         where order_id in (select d.id_orden from open.ge_detalle_acta d 
                             where d.id_acta in (select l.idacta from open.ldci_actacont l 
                                                  where l.idacta = 14860 /*and l.actcontabiliza = 'S'*/))
           and name_1 = 'NUM_COD_ACTIVO') u
 where d.id_orden = u.order_id
   and d.id_items = it.items_id
   and (it.item_classif_id != 23 or it.items_id = 4001293)
   and d.id_orden = u.order_id and d.id_orden = y.order_id
group by d.id_acta, d.id_orden, u.value_1, y.task_type_id;
