select last_number from all_sequences s 
where upper(sequence_name) like  '%SEQ_OR_ORDER_ACTIVITY%'; 


select max(order_activity_id) 
from or_order_activity ;-- 257057654
