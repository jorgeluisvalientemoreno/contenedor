select  policy_number,a.policy_id ,a.policy_type_id ||' ' ||t.description tipo_poliza,  a.product_line_id  || ' ' || ld_product_line.description linea_poliza  , 
state_policy ||' '||s.description as state,  value_policy
from open.ld_policy a
left join open.ld_policy_state  s on policy_state_id = state_policy
left join open.ld_policy_type t  on a.policy_type_id = t.policy_type_id
left join ld_product_line on a.product_line_id = ld_product_line.product_line_id 
where  suscription_id = 2179350
and state_policy = 1