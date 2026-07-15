select  difesusc , difenuse ,policy_id ,policy_number,a.policy_type_id ||' ' ||t.description tipo_poliza,
state_policy ||' '||s.description as state,  value_policy ,dtcreate_policy ,difecodi,difeconc ,difesape,
 difepldi || ' ' || pldidesc as plan_diferido
from ld_policy a
left join diferido on difecodi = deferred_policy_id
left join plandife on pldicodi = difepldi
left join ld_policy_state  s on policy_state_id = state_policy
left join ld_policy_type t  on a.policy_type_id = t.policy_type_id
where product_id =51576613
and s.description like '%CANCELADA%'
order by dtcreate_policy desc
and s.description like '%ACTIVA%'



select *
from ldc_migrapoliza  
where  poliza_renov = 914044

select *
from ld_policy
where product_id = 51122259
order by dt_in_policy asc
