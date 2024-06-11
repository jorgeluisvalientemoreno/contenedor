DECLARE
  v_liquidacion or_order.is_pending_liq%TYPE; 
  v_fechleg     or_order.legalization_date%TYPE; 

BEGIN
  
  v_liquidacion := 'Y';
  v_fechleg     := '22/05/2024';



  UPDATE or_order o
     SET o.is_pending_liq    = v_liquidacion,
         o.legalization_date = v_fechleg
   WHERE o.task_type_id IN (12626, 12617, 12626, 10043)
     and o.order_status_id = 8
     and trunc(o.legalization_date) >= '21/05/2024'
     and trunc(o.legalization_date) <= '21/05/2024'
     and (saved_data_values is null or  saved_data_values != 'ORDER_GROUPED')
     and not exists
     (select null
     from or_order_items oi,
          ct_item_novelty n
     where oi.order_id = o.order_id
     and   n.items_id = oi.items_id); 

  COMMIT;
END;
/
