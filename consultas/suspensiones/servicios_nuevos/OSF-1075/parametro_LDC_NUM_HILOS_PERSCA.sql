select p.parameter_id, 
       p.numeric_value, 
       p.value_chain, 
       p.description
  from open.ld_parameter p
 where p.parameter_id = 'LDC_NUM_HILOS_PERSCA'

--update ld_parameter p1  set p1.numeric_value = 6 where p1.parameter_id = 'LDC_NUM_HILOS_PERSCA'
