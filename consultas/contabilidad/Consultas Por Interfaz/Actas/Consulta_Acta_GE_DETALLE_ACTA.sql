select a.id_acta, A.REFERENCE_ITEM_ID, (select it.description from open.ge_items it where it.items_id = A.REFERENCE_ITEM_ID) des_items,
       (select at.task_type_id from open.or_order_activity at where at.order_id = id_orden) titr,
       (select ot.clctclco from open.ic_clascott ot 
         where ot.clcttitr in (select at.task_type_id from open.or_order_activity at where at.order_id = id_orden)) Clasi,
       valor_total
  from open.ge_detalle_acta a 
 where a.id_acta = 31570;
select * from open.ge_acta a where a.id_acta = 31570
