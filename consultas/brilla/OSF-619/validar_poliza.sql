select  difesusc , difenuse ,policy_number,a.policy_type_id ||' ' ||t.description tipo_poliza,
state_policy ||' '||s.description as state ,difecodi,difeconc , difevatd ,difesape,
difeprog , difepldi || ' ' || pldidesc as plan_diferido , difefein , value_policy , year_policy 
from open.ld_policy a
left join open.diferido on difecodi = deferred_policy_id
left join open.plandife on pldicodi = difepldi
left join open.ld_policy_state  s on policy_state_id = state_policy
left join open.ld_policy_type t  on a.policy_type_id = t.policy_type_id
where product_id = 50216360
