select p.parameter_id, 
       p.numeric_value, 
       p.value_chain, 
       p.description
  from open.ld_parameter p
 where p.parameter_id = 'LDC_EMAIFUNO'
for update
  
--mariza@gascaribe.com
