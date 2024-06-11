select p.parameter_id, 
       p.numeric_value, 
       p.value_chain, 
       p.description
  from open.ld_parameter p
 where p.parameter_id = 'TITR_VPM_NOTI_SUSP'
 
--11185,11183
