select * from open.or_requ_data_value
 where order_id in (select d.id_orden from open.ge_detalle_acta d where d.id_acta = 14583)
   and name_1 = 'NUM_COD_ACTIVO';

select * from open.ge_detalle_acta d where d.id_acta = 14583 and d.id_orden in (26320902);
   
select value_1 from open.or_requ_data_value
 where order_id in (select d.id_orden from open.ge_detalle_acta d where d.id_acta = 14583)
   and name_1 = 'NUM_COD_ACTIVO';

select * from open.ge_detalle_acta d where d.id_acta = 14583 and d.id_orden in (26320902);
select * from open.or_order_activity a where a.order_id = 26320902;
select * from open.ldci_actiubgttra a where a.acbgtitr = 12438
