select * from OPEN.or_order where order_id = 332889863;
SELECT * FROM OPEN.OR_ORDER_ACTIVITY WHERE ORDER_ID = 332889863;
select * from OPEN.or_order_items where order_id = 332889863;
select * from OPEN.or_order_stat_change where order_id = 332889863;
select * from OPEN.or_order_person where order_id = 332889863;
select * from or_order_comment where order_id = 332889863;
SELECT * FROM LDC_DOCUORDER WHERE ORDER_ID = 332889863;
SELECT * FROM GE_ITEMS_DOCUMENTO WHERE DOCUMENTO_EXTERNO = '332889863'; --FOR UPDATE;
SELECT * FROM LDC_OTLEGALIZAR WHERE ORDER_ID = 332889863; -- for update;
SELECT * FROM or_requ_data_value where order_id = 332889863;

--Eliminar comentario de legalizaicon
delete or_order_comment where order_id = 332889863;

--Reversar DATA de legalizacion
update or_order
   set causal_id            = null,
       legalization_date    = null,
       order_status_id      = 5,
       saved_data_values    = null,
       exec_initial_date    = null,
       execution_final_date = null
 where order_id = 332889863;

--Reversar DATA de legalizacion
update or_order_activity
   set status = 'R', value1 = null, value2 = null
 where order_id = 332889863;

--inicializar actividad 
update or_order_items set legal_item_amount = 0 where order_id = 332889863;

delete or_order_stat_change
 where order_id = 332889863
   and initial_status_id = 5
   and final_status_id = 8;

delete or_order_person where order_id = 332889863;

UPDATE LDC_OTLEGALIZAR SET LEGALIZADO = 'N' WHERE ORDER_ID = 332889863;

delete ldc_docuorder where order_id = 332889863;
delete or_requ_data_value where order_id = 332889863;

