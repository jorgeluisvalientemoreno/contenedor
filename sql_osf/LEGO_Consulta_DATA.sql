select o0.*, rowid from open.ldc_agenlego o0;
select o1.*, rowid from open.LDC_OTLEGALIZAR o1 where o1.ORDER_ID=&v_order_id;
select o2.*, rowid from open.LDC_ANEXOLEGALIZA o2 where o2.ORDER_ID=&v_order_id;
select o3.*, rowid from open.LDC_OTDALEGALIZAR o3 where o3.ORDER_ID=&v_order_id;
select o4.*, rowid from open.LDC_OTADICIONAL o4 where o4.ORDER_ID=&v_order_id;
select o5.*, rowid from open.LDC_OTADICIONALDA o5 where o5.ORDER_ID=&v_order_id;
