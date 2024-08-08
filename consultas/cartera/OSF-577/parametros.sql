select p.parameter_id, 
       p.numeric_value, 
       p.value_chain, 
       p.description
  from open.ld_parameter p
  where p.parameter_id in ('LDC_CAUSAL_SUSP_CART','LDC_MENS_SUSP_CART','LDC_USUARIOS_SUSP_CART')
  
  
