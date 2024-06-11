select *
from OPEN.or_order
where order_id=142327958;
update or_order
   set causal_id=null,
       legalization_date=null,
       order_status_id=5,
       saved_data_values=null,
       exec_initial_date=null,
       execution_final_date=null
where order_id=142327958;

SELECT *
FROM OPEN.OR_ORDER_ACTIVITY
WHERE ORDER_ID=142327958;


update or_order_activity
   set status='R',
       value1=null,
       value2=null
where order_id=142327958;
--itms
select *
from OPEN.or_order_items
where order_id=142327958;
update or_order_items
   set legal_item_amount=0
 where order_id=142327958;
 
select *
from OPEN.or_order_stat_change
where order_id=142327958;
delete  or_order_stat_change
   where order_id=142327958
     and initial_status_id=5
     and final_status_id=8;


select *
from OPEN.or_order_person
where order_id=142327958;
delete or_order_person
where order_id=142327958;

UPDATE LDC_OTLEGALIZAR
    SET LEGALIZADO='N'
WHERE ORDER_ID=142327958;

SELECT *
FROM LDC_DOCUORDER
WHERE ORDER_ID=142327958;

SELECT *
FROM GE_ITEMS_DOCUMENTO
WHERE DOCUMENTO_EXTERNO='142327958'
FOR UPDATE;
  
SELECT *
FROM LDC_OTLEGALIZAR
WHERE ORDER_ID=142327958
for update;
delete ldc_docuorder where order_id=142327958;
delete or_requ_data_value where order_id=142327958;
